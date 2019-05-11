Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6DE11F4B6
	for <e@80x24.org>; Sat, 11 May 2019 20:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfEKUr4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 May 2019 16:47:56 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53638 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfEKUr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 May 2019 16:47:56 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id F04381F461;
        Sat, 11 May 2019 20:47:54 +0000 (UTC)
Date:   Sat, 11 May 2019 20:47:54 +0000
From:   Eric Wong <e@80x24.org>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v2] update-server-info: avoid needless overwrites
Message-ID: <20190511204754.quj52fbwrdqxg6e7@dcvr>
References: <20190511013455.5886-1-e@80x24.org>
 <CAPig+cRZy4yM+ZuHhZK3tPV_QRvSy63aHBZZj6AcFTu+5FNG0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRZy4yM+ZuHhZK3tPV_QRvSy63aHBZZj6AcFTu+5FNG0A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, May 10, 2019 at 9:35 PM Eric Wong <e@80x24.org> wrote:
> > +       if (strbuf_fread(&tmp, (size_t)new_len, fp) != (size_t)new_len)
> > +               return 1;
> 
> Although strbuf_fread() will release 'tmp' automatically if the read
> actually fails, it won't do so otherwise. So, if it reads more or
> fewer bytes than expected, for some reason, then this early return
> will leak the strbuf, won't it?

> > +       if (strbuf_read_file(&tmp, path, (size_t)st.st_size) < 0)
> > +               return 1;
> 
> Same issue.
> 
> > diff --git a/t/t5200-update-server-info.sh b/t/t5200-update-server-info.sh
> > @@ -0,0 +1,41 @@
> > +test_description='Test git stash show configuration.'
> 
> Copy/paste error for test description?

Yup, thanks for the review.  Updated patch below

-----8<------
Subject: [PATCH] update-server-info: avoid needless overwrites

Do not change the existing info/refs and objects/info/packs
files if they match the existing content on the filesystem.
This is intended to preserve mtime and make it easier for dumb
HTTP pollers to rely on the If-Modified-Since header.

Combined with stdio and kernel buffering; the kernel should be
able to avoid block layer writes and reduce wear.

Signed-off-by: Eric Wong <e@80x24.org>
---
Interdiff:
  diff --git a/server-info.c b/server-info.c
  index 34599e4817..11515804d4 100644
  --- a/server-info.c
  +++ b/server-info.c
  @@ -24,15 +24,19 @@ static int files_differ(FILE *fp, const char *path)
   		return 1;
   
   	rewind(fp);
  -	if (strbuf_fread(&tmp, (size_t)new_len, fp) != (size_t)new_len)
  +	if (strbuf_fread(&tmp, (size_t)new_len, fp) != (size_t)new_len) {
  +		strbuf_release(&tmp);
   		return 1;
  +	}
   	the_hash_algo->init_fn(&c);
   	the_hash_algo->update_fn(&c, tmp.buf, tmp.len);
   	the_hash_algo->final_fn(oid_new.hash, &c);
   	strbuf_release(&tmp);
   
  -	if (strbuf_read_file(&tmp, path, (size_t)st.st_size) < 0)
  +	if (strbuf_read_file(&tmp, path, (size_t)st.st_size) < 0) {
  +		strbuf_release(&tmp);
   		return 1;
  +	}
   	the_hash_algo->init_fn(&c);
   	the_hash_algo->update_fn(&c, tmp.buf, tmp.len);
   	the_hash_algo->final_fn(oid_old.hash, &c);
  diff --git a/t/t5200-update-server-info.sh b/t/t5200-update-server-info.sh
  index f1cec46914..21a58eecb9 100755
  --- a/t/t5200-update-server-info.sh
  +++ b/t/t5200-update-server-info.sh
  @@ -1,6 +1,6 @@
   #!/bin/sh
   
  -test_description='Test git stash show configuration.'
  +test_description='Test git update-server-info'
   
   . ./test-lib.sh
   

 server-info.c                 | 65 +++++++++++++++++++++++++++++------
 t/t5200-update-server-info.sh | 41 ++++++++++++++++++++++
 2 files changed, 96 insertions(+), 10 deletions(-)
 create mode 100755 t/t5200-update-server-info.sh

diff --git a/server-info.c b/server-info.c
index 41274d098b..11515804d4 100644
--- a/server-info.c
+++ b/server-info.c
@@ -6,37 +6,82 @@
 #include "tag.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "strbuf.h"
+
+static int files_differ(FILE *fp, const char *path)
+{
+	struct stat st;
+	git_hash_ctx c;
+	struct object_id oid_old, oid_new;
+	struct strbuf tmp = STRBUF_INIT;
+	long new_len = ftell(fp);
+
+	if (new_len < 0 || stat(path, &st) < 0)
+		return 1;
+	if (!S_ISREG(st.st_mode))
+		return 1;
+	if ((off_t)new_len != st.st_size)
+		return 1;
+
+	rewind(fp);
+	if (strbuf_fread(&tmp, (size_t)new_len, fp) != (size_t)new_len) {
+		strbuf_release(&tmp);
+		return 1;
+	}
+	the_hash_algo->init_fn(&c);
+	the_hash_algo->update_fn(&c, tmp.buf, tmp.len);
+	the_hash_algo->final_fn(oid_new.hash, &c);
+	strbuf_release(&tmp);
+
+	if (strbuf_read_file(&tmp, path, (size_t)st.st_size) < 0) {
+		strbuf_release(&tmp);
+		return 1;
+	}
+	the_hash_algo->init_fn(&c);
+	the_hash_algo->update_fn(&c, tmp.buf, tmp.len);
+	the_hash_algo->final_fn(oid_old.hash, &c);
+	strbuf_release(&tmp);
+
+	return hashcmp(oid_old.hash, oid_new.hash);
+}
 
 /*
  * Create the file "path" by writing to a temporary file and renaming
  * it into place. The contents of the file come from "generate", which
  * should return non-zero if it encounters an error.
  */
-static int update_info_file(char *path, int (*generate)(FILE *))
+static int update_info_file(char *path, int (*generate)(FILE *), int force)
 {
 	char *tmp = mkpathdup("%s_XXXXXX", path);
 	int ret = -1;
 	int fd = -1;
 	FILE *fp = NULL, *to_close;
+	int do_update;
 
 	safe_create_leading_directories(path);
 	fd = git_mkstemp_mode(tmp, 0666);
 	if (fd < 0)
 		goto out;
-	to_close = fp = fdopen(fd, "w");
+	to_close = fp = fdopen(fd, "w+");
 	if (!fp)
 		goto out;
 	fd = -1;
 	ret = generate(fp);
 	if (ret)
 		goto out;
+
+	do_update = force || files_differ(fp, path);
 	fp = NULL;
 	if (fclose(to_close))
 		goto out;
-	if (adjust_shared_perm(tmp) < 0)
-		goto out;
-	if (rename(tmp, path) < 0)
-		goto out;
+	if (do_update) {
+		if (adjust_shared_perm(tmp) < 0)
+			goto out;
+		if (rename(tmp, path) < 0)
+			goto out;
+	} else {
+		unlink(tmp);
+	}
 	ret = 0;
 
 out:
@@ -78,10 +123,10 @@ static int generate_info_refs(FILE *fp)
 	return for_each_ref(add_info_ref, fp);
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
@@ -254,7 +299,7 @@ static int update_info_packs(int force)
 	int ret;
 
 	init_pack_info(infofile, force);
-	ret = update_info_file(infofile, write_pack_info_file);
+	ret = update_info_file(infofile, write_pack_info_file, force);
 	free_pack_info();
 	free(infofile);
 	return ret;
@@ -269,7 +314,7 @@ int update_server_info(int force)
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
