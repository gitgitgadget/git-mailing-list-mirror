From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5/5] make "index-pack" a built-in
Date: Fri, 22 Jan 2010 08:31:52 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001220828310.13231@localhost.localdomain>
References: <alpine.LFD.2.00.1001220804550.13231@localhost.localdomain> <alpine.LFD.2.00.1001220822560.13231@localhost.localdomain> <alpine.LFD.2.00.1001220825190.13231@localhost.localdomain> <alpine.LFD.2.00.1001220826230.13231@localhost.localdomain>
 <alpine.LFD.2.00.1001220827140.13231@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 17:32:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYMQp-00089X-MO
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 17:32:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755723Ab0AVQcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 11:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755669Ab0AVQcT
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 11:32:19 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53642 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755123Ab0AVQcS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2010 11:32:18 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0MGVrGt017073
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Jan 2010 08:31:54 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0MGVqHO015414;
	Fri, 22 Jan 2010 08:31:53 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.1001220827140.13231@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.948 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137762>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Jan 2010 07:55:19 -0800

This required some fairly trivial packfile function 'const' cleanup,
since the builtin commands get a const char *argv[] array.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

I say "fairly trivial", but I have to admit to hating the moron people who 
decided that 'free()' takes a "void *", not a "const void *". So now we 
have three new casts like this

	free((void *)ptr)

just to avoid a compiler warning due to incompetent standards people.

Oh well. I didn't feel it was worth an 'xfree()'.

 Makefile                             |    2 +-
 index-pack.c => builtin-index-pack.c |   16 +++++++---------
 builtin-pack-objects.c               |    5 +++--
 builtin.h                            |    1 +
 git.c                                |    1 +
 pack-write.c                         |    4 ++--
 pack.h                               |    2 +-
 7 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index 33f9870..c0dbee2 100644
--- a/Makefile
+++ b/Makefile
@@ -388,7 +388,6 @@ EXTRA_PROGRAMS =
 PROGRAMS += $(EXTRA_PROGRAMS)
 PROGRAMS += git-fast-import$X
 PROGRAMS += git-imap-send$X
-PROGRAMS += git-index-pack$X
 PROGRAMS += git-shell$X
 PROGRAMS += git-show-index$X
 PROGRAMS += git-upload-pack$X
@@ -653,6 +652,7 @@ BUILTIN_OBJS += builtin-gc.o
 BUILTIN_OBJS += builtin-grep.o
 BUILTIN_OBJS += builtin-hash-object.o
 BUILTIN_OBJS += builtin-help.o
+BUILTIN_OBJS += builtin-index-pack.o
 BUILTIN_OBJS += builtin-init-db.o
 BUILTIN_OBJS += builtin-log.o
 BUILTIN_OBJS += builtin-ls-files.o
diff --git a/index-pack.c b/builtin-index-pack.c
similarity index 98%
rename from index-pack.c
rename to builtin-index-pack.c
index 190f372..b4cf8c5 100644
--- a/index-pack.c
+++ b/builtin-index-pack.c
@@ -166,7 +166,7 @@ static void use(int bytes)
 	consumed_bytes += bytes;
 }
 
-static char *open_pack_file(char *pack_name)
+static const char *open_pack_file(const char *pack_name)
 {
 	if (from_stdin) {
 		input_fd = 0;
@@ -870,18 +870,16 @@ static int git_index_pack_config(const char *k, const char *v, void *cb)
 	return git_default_config(k, v, cb);
 }
 
-int main(int argc, char **argv)
+int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, fix_thin_pack = 0;
-	char *curr_pack, *pack_name = NULL;
-	char *curr_index, *index_name = NULL;
+	const char *curr_pack, *curr_index;
+	const char *index_name = NULL, *pack_name = NULL;
 	const char *keep_name = NULL, *keep_msg = NULL;
 	char *index_name_buf = NULL, *keep_name_buf = NULL;
 	struct pack_idx_entry **idx_objects;
 	unsigned char pack_sha1[20];
 
-	git_extract_argv0_path(argv[0]);
-
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(index_pack_usage);
 
@@ -906,7 +904,7 @@ int main(int argc, char **argv)
 	}
 
 	for (i = 1; i < argc; i++) {
-		char *arg = argv[i];
+		const char *arg = argv[i];
 
 		if (*arg == '-') {
 			if (!strcmp(arg, "--stdin")) {
@@ -1039,9 +1037,9 @@ int main(int argc, char **argv)
 	free(index_name_buf);
 	free(keep_name_buf);
 	if (pack_name == NULL)
-		free(curr_pack);
+		free((void *) curr_pack);
 	if (index_name == NULL)
-		free(curr_index);
+		free((void *) curr_index);
 
 	return 0;
 }
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 59b07fe..b0887d7 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -525,7 +525,8 @@ static void write_pack_file(void)
 		if (!pack_to_stdout) {
 			mode_t mode = umask(0);
 			struct stat st;
-			char *idx_tmp_name, tmpname[PATH_MAX];
+			const char *idx_tmp_name;
+			char tmpname[PATH_MAX];
 
 			umask(mode);
 			mode = 0444 & ~mode;
@@ -569,7 +570,7 @@ static void write_pack_file(void)
 			if (rename(idx_tmp_name, tmpname))
 				die_errno("unable to rename temporary index file");
 
-			free(idx_tmp_name);
+			free((void *) idx_tmp_name);
 			free(pack_tmp_name);
 			puts(sha1_to_hex(sha1));
 		}
diff --git a/builtin.h b/builtin.h
index bd7f737..e8202f3 100644
--- a/builtin.h
+++ b/builtin.h
@@ -58,6 +58,7 @@ extern int cmd_grep(int argc, const char **argv, const char *prefix);
 extern int cmd_hash_object(int argc, const char **argv, const char *prefix);
 extern int cmd_help(int argc, const char **argv, const char *prefix);
 extern int cmd_http_fetch(int argc, const char **argv, const char *prefix);
+extern int cmd_index_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_init_db(int argc, const char **argv, const char *prefix);
 extern int cmd_log(int argc, const char **argv, const char *prefix);
 extern int cmd_log_reflog(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 6cc1eba..b3e23f1 100644
--- a/git.c
+++ b/git.c
@@ -320,6 +320,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "grep", cmd_grep, USE_PAGER },
 		{ "hash-object", cmd_hash_object },
 		{ "help", cmd_help },
+		{ "index-pack", cmd_index_pack },
 		{ "init", cmd_init_db },
 		{ "init-db", cmd_init_db },
 		{ "log", cmd_log, RUN_SETUP | USE_PAGER },
diff --git a/pack-write.c b/pack-write.c
index 741efcd..9f47cf9 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -17,8 +17,8 @@ static int sha1_compare(const void *_a, const void *_b)
  * the SHA1 hash of sorted object names. The objects array passed in
  * will be sorted by SHA1 on exit.
  */
-char *write_idx_file(char *index_name, struct pack_idx_entry **objects,
-		     int nr_objects, unsigned char *sha1)
+const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects,
+			   int nr_objects, unsigned char *sha1)
 {
 	struct sha1file *f;
 	struct pack_idx_entry **sorted_by_sha, **list, **last;
diff --git a/pack.h b/pack.h
index a883334..b759a23 100644
--- a/pack.h
+++ b/pack.h
@@ -55,7 +55,7 @@ struct pack_idx_entry {
 	off_t offset;
 };
 
-extern char *write_idx_file(char *index_name, struct pack_idx_entry **objects, int nr_objects, unsigned char *sha1);
+extern const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, unsigned char *sha1);
 extern int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
 extern int verify_pack(struct packed_git *);
 extern void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t, unsigned char *, off_t);
-- 
1.6.6.1.399.g73128
