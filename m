Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE2931F4B6
	for <e@80x24.org>; Mon, 13 May 2019 23:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfEMXRK (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 19:17:10 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56224 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfEMXRK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 19:17:10 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id EF1681F461;
        Mon, 13 May 2019 23:17:08 +0000 (UTC)
Date:   Mon, 13 May 2019 23:17:08 +0000
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3] update-server-info: avoid needless overwrites
Message-ID: <20190513231708.sdxs3krilrer4fga@dcvr>
References: <20190511013455.5886-1-e@80x24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190511013455.5886-1-e@80x24.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do not change the existing info/refs and objects/info/packs
files if they match the existing content on the filesystem.
This is intended to preserve mtime and make it easier for dumb
HTTP pollers to rely on the If-Modified-Since header.

Combined with stdio and kernel buffering; the kernel should be
able to avoid block layer writes and reduce wear for small files.

As a result, the --force option is no longer needed.  So stop
documenting it, but let it remain for compatibility (and
debugging, if necessary).

v3: perform incremental comparison while generating to avoid
    OOM with giant files.  Remove documentation for --force.

Signed-off-by: Eric Wong <e@80x24.org>
---
  OK, performing the incremental comparison wasn't nearly as
  bad as thought it'd be.  I might be suffering from
  compiler-linker-slowness PTSD :x

Interdiff:
  diff --git a/Documentation/git-update-server-info.txt b/Documentation/git-update-server-info.txt
  index bd0e36492f..969bb2e15f 100644
  --- a/Documentation/git-update-server-info.txt
  +++ b/Documentation/git-update-server-info.txt
  @@ -9,7 +9,7 @@ git-update-server-info - Update auxiliary info file to help dumb servers
   SYNOPSIS
   --------
   [verse]
  -'git update-server-info' [--force]
  +'git update-server-info'
   
   DESCRIPTION
   -----------
  @@ -19,15 +19,6 @@ $GIT_OBJECT_DIRECTORY/info directories to help clients discover
   what references and packs the server has.  This command
   generates such auxiliary files.
   
  -
  -OPTIONS
  --------
  -
  --f::
  ---force::
  -	Update the info files from scratch.
  -
  -
   OUTPUT
   ------
   
  diff --git a/server-info.c b/server-info.c
  index 11515804d4..e68f785c2f 100644
  --- a/server-info.c
  +++ b/server-info.c
  @@ -8,41 +8,54 @@
   #include "object-store.h"
   #include "strbuf.h"
   
  -static int files_differ(FILE *fp, const char *path)
  +struct update_info_ctx {
  +	FILE *cur_fp;
  +	FILE *old_fp; /* becomes NULL if it differs from cur_fp */
  +	struct strbuf cur_sb;
  +	struct strbuf old_sb;
  +};
  +
  +static void uic_mark_stale(struct update_info_ctx *uic)
   {
  -	struct stat st;
  -	git_hash_ctx c;
  -	struct object_id oid_old, oid_new;
  -	struct strbuf tmp = STRBUF_INIT;
  -	long new_len = ftell(fp);
  +	fclose(uic->old_fp);
  +	uic->old_fp = NULL;
  +}
   
  -	if (new_len < 0 || stat(path, &st) < 0)
  -		return 1;
  -	if (!S_ISREG(st.st_mode))
  -		return 1;
  -	if ((off_t)new_len != st.st_size)
  -		return 1;
  +static int uic_is_stale(const struct update_info_ctx *uic)
  +{
  +	return uic->old_fp == NULL;
  +}
   
  -	rewind(fp);
  -	if (strbuf_fread(&tmp, (size_t)new_len, fp) != (size_t)new_len) {
  -		strbuf_release(&tmp);
  -		return 1;
  -	}
  -	the_hash_algo->init_fn(&c);
  -	the_hash_algo->update_fn(&c, tmp.buf, tmp.len);
  -	the_hash_algo->final_fn(oid_new.hash, &c);
  -	strbuf_release(&tmp);
  +static int uic_printf(struct update_info_ctx *uic, const char *fmt, ...)
  +{
  +	va_list ap;
  +	int ret = -1;
   
  -	if (strbuf_read_file(&tmp, path, (size_t)st.st_size) < 0) {
  -		strbuf_release(&tmp);
  -		return 1;
  +	va_start(ap, fmt);
  +
  +	if (uic_is_stale(uic)) {
  +		ret = vfprintf(uic->cur_fp, fmt, ap);
  +	} else {
  +		ssize_t r;
  +		struct strbuf *cur = &uic->cur_sb;
  +		struct strbuf *old = &uic->old_sb;
  +
  +		strbuf_reset(cur);
  +		strbuf_vinsertf(cur, 0, fmt, ap);
  +
  +		strbuf_reset(old);
  +		strbuf_grow(old, cur->len);
  +		r = fread(old->buf, 1, cur->len, uic->old_fp);
  +		if (r != cur->len || memcmp(old->buf, cur->buf, r))
  +			uic_mark_stale(uic);
  +
  +		if (fwrite(cur->buf, 1, cur->len, uic->cur_fp) == cur->len)
  +			ret = 0;
   	}
  -	the_hash_algo->init_fn(&c);
  -	the_hash_algo->update_fn(&c, tmp.buf, tmp.len);
  -	the_hash_algo->final_fn(oid_old.hash, &c);
  -	strbuf_release(&tmp);
   
  -	return hashcmp(oid_old.hash, oid_new.hash);
  +	va_end(ap);
  +
  +	return ret;
   }
   
   /*
  @@ -50,31 +63,61 @@ static int files_differ(FILE *fp, const char *path)
    * it into place. The contents of the file come from "generate", which
    * should return non-zero if it encounters an error.
    */
  -static int update_info_file(char *path, int (*generate)(FILE *), int force)
  +static int update_info_file(char *path,
  +			int (*generate)(struct update_info_ctx *),
  +			int force)
   {
   	char *tmp = mkpathdup("%s_XXXXXX", path);
   	int ret = -1;
   	int fd = -1;
  -	FILE *fp = NULL, *to_close;
  -	int do_update;
  +	FILE *to_close;
  +	struct update_info_ctx uic = {
  +		.cur_fp = NULL,
  +		.old_fp = NULL,
  +		.cur_sb = STRBUF_INIT,
  +		.old_sb = STRBUF_INIT
  +	};
   
   	safe_create_leading_directories(path);
   	fd = git_mkstemp_mode(tmp, 0666);
   	if (fd < 0)
   		goto out;
  -	to_close = fp = fdopen(fd, "w+");
  -	if (!fp)
  +	to_close = uic.cur_fp = fdopen(fd, "w");
  +	if (!uic.cur_fp)
   		goto out;
   	fd = -1;
  -	ret = generate(fp);
  +
  +	/* no problem on ENOENT and old_fp == NULL, it's stale, now */
  +	if (!force)
  +		uic.old_fp = fopen_or_warn(path, "r");
  +
  +	/*
  +	 * uic_printf will compare incremental comparison aginst old_fp
  +	 * and mark uic as stale if needed
  +	 */
  +	ret = generate(&uic);
   	if (ret)
   		goto out;
   
  -	do_update = force || files_differ(fp, path);
  -	fp = NULL;
  +	/* new file may be shorter than the old one, check here */
  +	if (!uic_is_stale(&uic)) {
  +		struct stat st;
  +		long new_len = ftell(uic.cur_fp);
  +		int old_fd = fileno(uic.old_fp);
  +
  +		if (new_len < 0) {
  +			ret = -1;
  +			goto out;
  +		}
  +		if (fstat(old_fd, &st) || (st.st_size != (size_t)new_len))
  +			uic_mark_stale(&uic);
  +	}
  +
  +	uic.cur_fp = NULL;
   	if (fclose(to_close))
   		goto out;
  -	if (do_update) {
  +
  +	if (uic_is_stale(&uic)) {
   		if (adjust_shared_perm(tmp) < 0)
   			goto out;
   		if (rename(tmp, path) < 0)
  @@ -87,40 +130,44 @@ static int update_info_file(char *path, int (*generate)(FILE *), int force)
   out:
   	if (ret) {
   		error_errno("unable to update %s", path);
  -		if (fp)
  -			fclose(fp);
  +		if (uic.cur_fp)
  +			fclose(uic.cur_fp);
   		else if (fd >= 0)
   			close(fd);
   		unlink(tmp);
   	}
   	free(tmp);
  +	if (uic.old_fp)
  +		fclose(uic.old_fp);
  +	strbuf_release(&uic.old_sb);
  +	strbuf_release(&uic.cur_sb);
   	return ret;
   }
   
   static int add_info_ref(const char *path, const struct object_id *oid,
   			int flag, void *cb_data)
   {
  -	FILE *fp = cb_data;
  +	struct update_info_ctx *uic = cb_data;
   	struct object *o = parse_object(the_repository, oid);
   	if (!o)
   		return -1;
   
  -	if (fprintf(fp, "%s	%s\n", oid_to_hex(oid), path) < 0)
  +	if (uic_printf(uic, "%s	%s\n", oid_to_hex(oid), path) < 0)
   		return -1;
   
   	if (o->type == OBJ_TAG) {
   		o = deref_tag(the_repository, o, path, 0);
   		if (o)
  -			if (fprintf(fp, "%s	%s^{}\n",
  +			if (uic_printf(uic, "%s	%s^{}\n",
   				oid_to_hex(&o->oid), path) < 0)
   				return -1;
   	}
   	return 0;
   }
   
  -static int generate_info_refs(FILE *fp)
  +static int generate_info_refs(struct update_info_ctx *uic)
   {
  -	return for_each_ref(add_info_ref, fp);
  +	return for_each_ref(add_info_ref, uic);
   }
   
   static int update_info_refs(int force)
  @@ -281,14 +328,14 @@ static void free_pack_info(void)
   	free(info);
   }
   
  -static int write_pack_info_file(FILE *fp)
  +static int write_pack_info_file(struct update_info_ctx *uic)
   {
   	int i;
   	for (i = 0; i < num_pack; i++) {
  -		if (fprintf(fp, "P %s\n", pack_basename(info[i]->p)) < 0)
  +		if (uic_printf(uic, "P %s\n", pack_basename(info[i]->p)) < 0)
   			return -1;
   	}
  -	if (fputc('\n', fp) == EOF)
  +	if (uic_printf(uic, "\n") < 0)
   		return -1;
   	return 0;
   }

 Documentation/git-update-server-info.txt |  11 +-
 server-info.c                            | 140 +++++++++++++++++++----
 t/t5200-update-server-info.sh            |  41 +++++++
 3 files changed, 158 insertions(+), 34 deletions(-)
 create mode 100755 t/t5200-update-server-info.sh

diff --git a/Documentation/git-update-server-info.txt b/Documentation/git-update-server-info.txt
index bd0e36492f..969bb2e15f 100644
--- a/Documentation/git-update-server-info.txt
+++ b/Documentation/git-update-server-info.txt
@@ -9,7 +9,7 @@ git-update-server-info - Update auxiliary info file to help dumb servers
 SYNOPSIS
 --------
 [verse]
-'git update-server-info' [--force]
+'git update-server-info'
 
 DESCRIPTION
 -----------
@@ -19,15 +19,6 @@ $GIT_OBJECT_DIRECTORY/info directories to help clients discover
 what references and packs the server has.  This command
 generates such auxiliary files.
 
-
-OPTIONS
--------
-
--f::
---force::
-	Update the info files from scratch.
-
-
 OUTPUT
 ------
 
diff --git a/server-info.c b/server-info.c
index 41274d098b..e68f785c2f 100644
--- a/server-info.c
+++ b/server-info.c
@@ -6,82 +6,174 @@
 #include "tag.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "strbuf.h"
+
+struct update_info_ctx {
+	FILE *cur_fp;
+	FILE *old_fp; /* becomes NULL if it differs from cur_fp */
+	struct strbuf cur_sb;
+	struct strbuf old_sb;
+};
+
+static void uic_mark_stale(struct update_info_ctx *uic)
+{
+	fclose(uic->old_fp);
+	uic->old_fp = NULL;
+}
+
+static int uic_is_stale(const struct update_info_ctx *uic)
+{
+	return uic->old_fp == NULL;
+}
+
+static int uic_printf(struct update_info_ctx *uic, const char *fmt, ...)
+{
+	va_list ap;
+	int ret = -1;
+
+	va_start(ap, fmt);
+
+	if (uic_is_stale(uic)) {
+		ret = vfprintf(uic->cur_fp, fmt, ap);
+	} else {
+		ssize_t r;
+		struct strbuf *cur = &uic->cur_sb;
+		struct strbuf *old = &uic->old_sb;
+
+		strbuf_reset(cur);
+		strbuf_vinsertf(cur, 0, fmt, ap);
+
+		strbuf_reset(old);
+		strbuf_grow(old, cur->len);
+		r = fread(old->buf, 1, cur->len, uic->old_fp);
+		if (r != cur->len || memcmp(old->buf, cur->buf, r))
+			uic_mark_stale(uic);
+
+		if (fwrite(cur->buf, 1, cur->len, uic->cur_fp) == cur->len)
+			ret = 0;
+	}
+
+	va_end(ap);
+
+	return ret;
+}
 
 /*
  * Create the file "path" by writing to a temporary file and renaming
  * it into place. The contents of the file come from "generate", which
  * should return non-zero if it encounters an error.
  */
-static int update_info_file(char *path, int (*generate)(FILE *))
+static int update_info_file(char *path,
+			int (*generate)(struct update_info_ctx *),
+			int force)
 {
 	char *tmp = mkpathdup("%s_XXXXXX", path);
 	int ret = -1;
 	int fd = -1;
-	FILE *fp = NULL, *to_close;
+	FILE *to_close;
+	struct update_info_ctx uic = {
+		.cur_fp = NULL,
+		.old_fp = NULL,
+		.cur_sb = STRBUF_INIT,
+		.old_sb = STRBUF_INIT
+	};
 
 	safe_create_leading_directories(path);
 	fd = git_mkstemp_mode(tmp, 0666);
 	if (fd < 0)
 		goto out;
-	to_close = fp = fdopen(fd, "w");
-	if (!fp)
+	to_close = uic.cur_fp = fdopen(fd, "w");
+	if (!uic.cur_fp)
 		goto out;
 	fd = -1;
-	ret = generate(fp);
+
+	/* no problem on ENOENT and old_fp == NULL, it's stale, now */
+	if (!force)
+		uic.old_fp = fopen_or_warn(path, "r");
+
+	/*
+	 * uic_printf will compare incremental comparison aginst old_fp
+	 * and mark uic as stale if needed
+	 */
+	ret = generate(&uic);
 	if (ret)
 		goto out;
-	fp = NULL;
+
+	/* new file may be shorter than the old one, check here */
+	if (!uic_is_stale(&uic)) {
+		struct stat st;
+		long new_len = ftell(uic.cur_fp);
+		int old_fd = fileno(uic.old_fp);
+
+		if (new_len < 0) {
+			ret = -1;
+			goto out;
+		}
+		if (fstat(old_fd, &st) || (st.st_size != (size_t)new_len))
+			uic_mark_stale(&uic);
+	}
+
+	uic.cur_fp = NULL;
 	if (fclose(to_close))
 		goto out;
-	if (adjust_shared_perm(tmp) < 0)
-		goto out;
-	if (rename(tmp, path) < 0)
-		goto out;
+
+	if (uic_is_stale(&uic)) {
+		if (adjust_shared_perm(tmp) < 0)
+			goto out;
+		if (rename(tmp, path) < 0)
+			goto out;
+	} else {
+		unlink(tmp);
+	}
 	ret = 0;
 
 out:
 	if (ret) {
 		error_errno("unable to update %s", path);
-		if (fp)
-			fclose(fp);
+		if (uic.cur_fp)
+			fclose(uic.cur_fp);
 		else if (fd >= 0)
 			close(fd);
 		unlink(tmp);
 	}
 	free(tmp);
+	if (uic.old_fp)
+		fclose(uic.old_fp);
+	strbuf_release(&uic.old_sb);
+	strbuf_release(&uic.cur_sb);
 	return ret;
 }
 
 static int add_info_ref(const char *path, const struct object_id *oid,
 			int flag, void *cb_data)
 {
-	FILE *fp = cb_data;
+	struct update_info_ctx *uic = cb_data;
 	struct object *o = parse_object(the_repository, oid);
 	if (!o)
 		return -1;
 
-	if (fprintf(fp, "%s	%s\n", oid_to_hex(oid), path) < 0)
+	if (uic_printf(uic, "%s	%s\n", oid_to_hex(oid), path) < 0)
 		return -1;
 
 	if (o->type == OBJ_TAG) {
 		o = deref_tag(the_repository, o, path, 0);
 		if (o)
-			if (fprintf(fp, "%s	%s^{}\n",
+			if (uic_printf(uic, "%s	%s^{}\n",
 				oid_to_hex(&o->oid), path) < 0)
 				return -1;
 	}
 	return 0;
 }
 
-static int generate_info_refs(FILE *fp)
+static int generate_info_refs(struct update_info_ctx *uic)
 {
-	return for_each_ref(add_info_ref, fp);
+	return for_each_ref(add_info_ref, uic);
 }
 
-static int update_info_refs(void)
+static int update_info_refs(int force)
 {
 	char *path = git_pathdup("info/refs");
-	int ret = update_info_file(path, generate_info_refs);
+	int ret = update_info_file(path, generate_info_refs, force);
 	free(path);
 	return ret;
 }
@@ -236,14 +328,14 @@ static void free_pack_info(void)
 	free(info);
 }
 
-static int write_pack_info_file(FILE *fp)
+static int write_pack_info_file(struct update_info_ctx *uic)
 {
 	int i;
 	for (i = 0; i < num_pack; i++) {
-		if (fprintf(fp, "P %s\n", pack_basename(info[i]->p)) < 0)
+		if (uic_printf(uic, "P %s\n", pack_basename(info[i]->p)) < 0)
 			return -1;
 	}
-	if (fputc('\n', fp) == EOF)
+	if (uic_printf(uic, "\n") < 0)
 		return -1;
 	return 0;
 }
@@ -254,7 +346,7 @@ static int update_info_packs(int force)
 	int ret;
 
 	init_pack_info(infofile, force);
-	ret = update_info_file(infofile, write_pack_info_file);
+	ret = update_info_file(infofile, write_pack_info_file, force);
 	free_pack_info();
 	free(infofile);
 	return ret;
@@ -269,7 +361,7 @@ int update_server_info(int force)
 	 */
 	int errs = 0;
 
-	errs = errs | update_info_refs();
+	errs = errs | update_info_refs(force);
 	errs = errs | update_info_packs(force);
 
 	/* remove leftover rev-cache file if there is any */
diff --git a/t/t5200-update-server-info.sh b/t/t5200-update-server-info.sh
new file mode 100755
index 0000000000..21a58eecb9
--- /dev/null
+++ b/t/t5200-update-server-info.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description='Test git update-server-info'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' 'test_commit file'
+
+test_expect_success 'create info/refs' '
+	git update-server-info &&
+	test_path_is_file .git/info/refs
+'
+
+test_expect_success 'modify and store mtime' '
+	test-tool chmtime =0 .git/info/refs &&
+	test-tool chmtime --get .git/info/refs >a
+'
+
+test_expect_success 'info/refs is not needlessly overwritten' '
+	git update-server-info &&
+	test-tool chmtime --get .git/info/refs >b &&
+	test_cmp a b
+'
+
+test_expect_success 'info/refs can be forced to update' '
+	git update-server-info -f &&
+	test-tool chmtime --get .git/info/refs >b &&
+	! test_cmp a b
+'
+
+test_expect_success 'info/refs updates when changes are made' '
+	test-tool chmtime =0 .git/info/refs &&
+	test-tool chmtime --get .git/info/refs >b &&
+	test_cmp a b &&
+	git update-ref refs/heads/foo HEAD &&
+	git update-server-info &&
+	test-tool chmtime --get .git/info/refs >b &&
+	! test_cmp a b
+'
+
+test_done
-- 
EW
