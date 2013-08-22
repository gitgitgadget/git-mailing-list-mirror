From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] repack: rewrite the shell script in C (squashing proposal)
Date: Thu, 22 Aug 2013 22:06:36 +0200
Message-ID: <1377201996-27296-1-git-send-email-stefanbeller@googlemail.com>
References: <5215EC1A.7060004@kdbg.org>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, mfick@codeaurora.org, apelisse@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, pclouds@gmail.com, iveqy@iveqy.com,
	gitster@pobox.com, mackyle@gmail.com, j6t@kdbg.org
X-From: git-owner@vger.kernel.org Thu Aug 22 22:06:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCb9P-00058n-Mp
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 22:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309Ab3HVUGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 16:06:31 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:57732 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754303Ab3HVUGa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 16:06:30 -0400
Received: by mail-ee0-f54.google.com with SMTP id e53so1161503eek.13
        for <git@vger.kernel.org>; Thu, 22 Aug 2013 13:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nMmASIm8sfqjt71DLLCcdJJskDXyDJ3jSesCO0PHAdU=;
        b=pDNeThQFiU0Xwf5pztM5VfCiUzHmXoMGjS8kd62Xc11XujsI0l1t6NFHmqDnUVtO0p
         98LDjtusM1fJCDYZo0n2hWmuML1gNFOlbpzKjwLX+TTPldJGWBZ6rfP/CqPVv+yhZC/8
         ABMx/IELnjQBx9sqZTaoDKaT058JllBm830nhWzIMc5vnN3UJzOUa30ZsLvcMvjnC0UV
         hcoJRyQ9zsgmfj3MVtDNMNTpJtCnN2bJlfHfs1p+7jHhK4OZIou1YV6DVdWj/mDz2e2y
         J5rVlywxlIO0cU8ql3Ex8XoF1cxYSEjrwalkcmP2jWNUD3ZGr6/HmUuWTEXLfwFCxO44
         WnAA==
X-Received: by 10.14.225.199 with SMTP id z47mr21020947eep.24.1377201989159;
        Thu, 22 Aug 2013 13:06:29 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id a1sm19801293eem.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 Aug 2013 13:06:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.1.gc1ebd90
In-Reply-To: <5215EC1A.7060004@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232772>

This patch is meant to be squashed into bb4335a21441a0
(repack: rewrite the shell script in C), I'll do so when rerolling
the series. For reviewing I'll just send this patch.

* Remove comments, which likely get out of date (authorship is kept in
  git anyway)
* rename get_pack_filenames to get_non_kept_pack_filenames
* catch return value of unlink and fail as the shell version did
* beauty fixes to remove_temporary_files as Junio proposed
* install signal handling after static variables packdir, packtmp are set
* remove adding the empty string to the buffer.
* fix the rollback mechanism (wrong variable name)

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/repack.c | 78 ++++++++++++++++++++++++++------------------------------
 1 file changed, 36 insertions(+), 42 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 1f13e0d..e0d1f17 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1,8 +1,3 @@
-/*
- * The shell version was written by Linus Torvalds (2005) and many others.
- * This is a translation into C by Stefan Beller (2013)
- */
-
 #include "builtin.h"
 #include "cache.h"
 #include "dir.h"
@@ -13,9 +8,8 @@
 #include "string-list.h"
 #include "argv-array.h"
 
-/* enabled by default since 22c79eab (2008-06-25) */
 static int delta_base_offset = 1;
-char *packdir;
+static char *packdir, *packtmp;
 
 static const char *const git_repack_usage[] = {
 	N_("git repack [options]"),
@@ -41,18 +35,16 @@ static void remove_temporary_files(void)
 	DIR *dir;
 	struct dirent *e;
 
-	/* .git/objects/pack */
-	strbuf_addstr(&buf, get_object_directory());
-	strbuf_addstr(&buf, "/pack");
-	dir = opendir(buf.buf);
-	if (!dir) {
-		strbuf_release(&buf);
+	dir = opendir(packdir);
+	if (!dir)
 		return;
-	}
 
-	/* .git/objects/pack/.tmp-$$-pack-* */
+	strbuf_addstr(&buf, packdir);
+
+	/* dirlen holds the length of the path before the file name */
 	dirlen = buf.len + 1;
-	strbuf_addf(&buf, "/.tmp-%d-pack-", (int)getpid());
+	strbuf_addf(&buf, "%s", packtmp);
+	/* prefixlen holds the length of the prefix */
 	prefixlen = buf.len - dirlen;
 
 	while ((e = readdir(dir))) {
@@ -73,11 +65,16 @@ static void remove_pack_on_signal(int signo)
 	raise(signo);
 }
 
-static void get_pack_filenames(struct string_list *fname_list)
+/*
+ * Adds all packs hex strings to the fname list, which do not
+ * have a corresponding .keep file.
+ */
+static void get_non_kept_pack_filenames(struct string_list *fname_list)
 {
 	DIR *dir;
 	struct dirent *e;
 	char *fname;
+	size_t len;
 
 	if (!(dir = opendir(packdir)))
 		return;
@@ -86,7 +83,7 @@ static void get_pack_filenames(struct string_list *fname_list)
 		if (suffixcmp(e->d_name, ".pack"))
 			continue;
 
-		size_t len = strlen(e->d_name) - strlen(".pack");
+		len = strlen(e->d_name) - strlen(".pack");
 		fname = xmemdupz(e->d_name, len);
 
 		if (!file_exists(mkpath("%s/%s.keep", packdir, fname)))
@@ -95,14 +92,14 @@ static void get_pack_filenames(struct string_list *fname_list)
 	closedir(dir);
 }
 
-static void remove_redundant_pack(const char *path, const char *sha1)
+static void remove_redundant_pack(const char *path_prefix, const char *hex)
 {
 	const char *exts[] = {".pack", ".idx", ".keep"};
 	int i;
 	struct strbuf buf = STRBUF_INIT;
 	size_t plen;
 
-	strbuf_addf(&buf, "%s/%s", path, sha1);
+	strbuf_addf(&buf, "%s/%s", path_prefix, hex);
 	plen = buf.len;
 
 	for (i = 0; i < ARRAY_SIZE(exts); i++) {
@@ -115,15 +112,14 @@ static void remove_redundant_pack(const char *path, const char *sha1)
 int cmd_repack(int argc, const char **argv, const char *prefix)
 {
 	const char *exts[2] = {".idx", ".pack"};
-	char *packtmp;
 	struct child_process cmd;
 	struct string_list_item *item;
 	struct argv_array cmd_args = ARGV_ARRAY_INIT;
 	struct string_list names = STRING_LIST_INIT_DUP;
-	struct string_list rollback = STRING_LIST_INIT_DUP;
+	struct string_list rollback = STRING_LIST_INIT_NODUP;
 	struct string_list existing_packs = STRING_LIST_INIT_DUP;
 	struct strbuf line = STRBUF_INIT;
-	int count_packs, ext, ret;
+	int nr_packs, ext, ret, failed;
 	FILE *out;
 
 	/* variables to be filled by option parsing */
@@ -173,11 +169,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, builtin_repack_options,
 				git_repack_usage, 0);
 
-	sigchain_push_common(remove_pack_on_signal);
-
 	packdir = mkpathdup("%s/pack", get_object_directory());
 	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
 
+	sigchain_push_common(remove_pack_on_signal);
+
 	argv_array_push(&cmd_args, "pack-objects");
 	argv_array_push(&cmd_args, "--keep-true-parents");
 	argv_array_push(&cmd_args, "--honor-pack-keep");
@@ -201,7 +197,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		argv_array_push(&cmd_args, "--unpacked");
 		argv_array_push(&cmd_args, "--incremental");
 	} else {
-		get_pack_filenames(&existing_packs);
+		get_non_kept_pack_filenames(&existing_packs);
 
 		if (existing_packs.nr && delete_redundant) {
 			if (unpack_unreachable)
@@ -233,14 +229,13 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (ret)
 		return ret;
 
-	count_packs = 0;
+	nr_packs = 0;
 	out = xfdopen(cmd.out, "r");
 	while (strbuf_getline(&line, out, '\n') != EOF) {
 		if (line.len != 40)
 			die("repack: Expecting 40 character sha1 lines only from pack-objects.");
-		strbuf_addstr(&line, "");
 		string_list_append(&names, line.buf);
-		count_packs++;
+		nr_packs++;
 	}
 	fclose(out);
 	ret = finish_command(&cmd);
@@ -248,10 +243,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		return ret;
 	argv_array_clear(&cmd_args);
 
-	if (!count_packs && !quiet)
+	if (!nr_packs && !quiet)
 		printf("Nothing new to pack.\n");
 
-	int failed = 0;
+	failed = 0;
 	for_each_string_list_item(item, &names) {
 		for (ext = 0; ext < 2; ext++) {
 			char *fname, *fname_old;
@@ -262,24 +257,23 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 
-			fname_old = mkpathdup("%s/old-%s%s", packdir,
+			fname_old = mkpath("%s/old-%s%s", packdir,
 						item->string, exts[ext]);
 			if (file_exists(fname_old))
-				unlink(fname_old);
+				if (unlink(fname_old))
+					failed = 1;
 
-			if (rename(fname, fname_old)) {
+			if (!failed && rename(fname, fname_old)) {
 				failed = 1;
 				break;
 			}
-			string_list_append_nodup(&rollback, fname);
-			free(fname);
-			free(fname_old);
+			string_list_append(&rollback, fname);
 		}
 		if (failed)
 			break;
 	}
 	if (failed) {
-		struct string_list rollback_failure;
+		struct string_list rollback_failure = STRING_LIST_INIT_DUP;
 		for_each_string_list_item(item, &rollback) {
 			char *fname, *fname_old;
 			fname = mkpathdup("%s/%s", packdir, item->string);
@@ -289,7 +283,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			free(fname);
 		}
 
-		if (rollback.nr) {
+		if (rollback_failure.nr) {
 			int i;
 			fprintf(stderr,
 				"WARNING: Some packs in use have been renamed by\n"
@@ -299,10 +293,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				"WARNING: attempt to rename them back to their\n"
 				"WARNING: original names also failed.\n"
 				"WARNING: Please rename them in %s manually:\n", packdir);
-			for (i = 0; i < rollback.nr; i++)
+			for (i = 0; i < rollback_failure.nr; i++)
 				fprintf(stderr, "WARNING:   old-%s -> %s\n",
-					rollback.items[i].string,
-					rollback.items[i].string);
+					rollback_failure.items[i].string,
+					rollback_failure.items[i].string);
 		}
 		exit(1);
 	}
-- 
1.8.4.rc3.1.gc1ebd90
