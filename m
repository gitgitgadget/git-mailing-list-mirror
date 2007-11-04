From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/5] pretty describe: de-const'ify struct commit arg of format_commit_message()
Date: Sun, 04 Nov 2007 12:48:49 +0100
Message-ID: <472DB1A1.6020208@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 12:49:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iodym-0001E7-JK
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 12:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757250AbXKDLtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 06:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756245AbXKDLtJ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 06:49:09 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:43781
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757249AbXKDLtI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2007 06:49:08 -0500
Received: from [10.0.1.201] (p57B7FCFB.dip.t-dialin.net [87.183.252.251])
	by neapel230.server4you.de (Postfix) with ESMTP id E820C873BA;
	Sun,  4 Nov 2007 12:49:06 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63391>

As a preparation to use describe_commit() in format_commit_message(),
the const attribute of the struct commit parameter must go, as
describe_commit() needs to change the name related members in order
to do its work.

This change requires changes in other places, too -- those that call
format_commit_message() with a const struct commit, and the places
calling those places.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive-tar.c     |    2 +-
 archive-zip.c     |    2 +-
 archive.h         |    4 ++--
 builtin-archive.c |    8 ++++----
 commit.c          |    4 ++--
 commit.h          |    4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index e1bced5..792462c 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -16,7 +16,7 @@ static unsigned long offset;
 static time_t archive_time;
 static int tar_umask = 002;
 static int verbose;
-static const struct commit *commit;
+static struct commit *commit;
 
 /* writes out the whole block, but only if it is full */
 static void write_if_needed(void)
diff --git a/archive-zip.c b/archive-zip.c
index 74e30f6..ed0918e 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -12,7 +12,7 @@
 static int verbose;
 static int zip_date;
 static int zip_time;
-static const struct commit *commit;
+static struct commit *commit;
 
 static unsigned char *zip_dir;
 static unsigned int zip_dir_size;
diff --git a/archive.h b/archive.h
index 5791e65..7fb69c4 100644
--- a/archive.h
+++ b/archive.h
@@ -8,7 +8,7 @@ struct archiver_args {
 	const char *base;
 	struct tree *tree;
 	const unsigned char *commit_sha1;
-	const struct commit *commit;
+	struct commit *commit;
 	time_t time;
 	const char **pathspec;
 	unsigned int verbose : 1;
@@ -43,6 +43,6 @@ extern int write_tar_archive(struct archiver_args *);
 extern int write_zip_archive(struct archiver_args *);
 extern void *parse_extra_zip_args(int argc, const char **argv);
 
-extern void *sha1_file_to_archive(const char *path, const unsigned char *sha1, unsigned int mode, enum object_type *type, unsigned long *size, const struct commit *commit);
+extern void *sha1_file_to_archive(const char *path, const unsigned char *sha1, unsigned int mode, enum object_type *type, unsigned long *size, struct commit *commit);
 
 #endif	/* ARCHIVE_H */
diff --git a/builtin-archive.c b/builtin-archive.c
index 14a1b30..759f265 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -79,7 +79,7 @@ static int run_remote_archiver(const char *remote, int argc,
 	return !!rv;
 }
 
-static void format_subst(const struct commit *commit,
+static void format_subst(struct commit *commit,
                          const char *src, size_t len,
                          struct strbuf *buf)
 {
@@ -115,7 +115,7 @@ static void format_subst(const struct commit *commit,
 static int convert_to_archive(const char *path,
                               const void *src, size_t len,
                               struct strbuf *buf,
-                              const struct commit *commit)
+                              struct commit *commit)
 {
 	static struct git_attr *attr_export_subst;
 	struct git_attr_check check[1];
@@ -139,7 +139,7 @@ static int convert_to_archive(const char *path,
 void *sha1_file_to_archive(const char *path, const unsigned char *sha1,
                            unsigned int mode, enum object_type *type,
                            unsigned long *sizep,
-                           const struct commit *commit)
+                           struct commit *commit)
 {
 	void *buffer;
 
@@ -188,7 +188,7 @@ void parse_treeish_arg(const char **argv, struct archiver_args *ar_args,
 	const unsigned char *commit_sha1;
 	time_t archive_time;
 	struct tree *tree;
-	const struct commit *commit;
+	struct commit *commit;
 	unsigned char sha1[20];
 
 	if (get_sha1(name, sha1))
diff --git a/commit.c b/commit.c
index 24b7268..2e52a2f 100644
--- a/commit.c
+++ b/commit.c
@@ -771,7 +771,7 @@ static void fill_person(struct interp *table, const char *msg, int len)
 	interp_set_entry(table, 6, show_date(date, tz, DATE_ISO8601));
 }
 
-void format_commit_message(const struct commit *commit,
+void format_commit_message(struct commit *commit,
                            const void *format, struct strbuf *sb)
 {
 	struct interp table[] = {
@@ -1064,7 +1064,7 @@ static void pp_remainder(enum cmit_fmt fmt,
 	}
 }
 
-void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
+void pretty_print_commit(enum cmit_fmt fmt, struct commit *commit,
 				  struct strbuf *sb, int abbrev,
 				  const char *subject, const char *after_subject,
 				  enum date_mode dmode)
diff --git a/commit.h b/commit.h
index 80e94b9..d74859e 100644
--- a/commit.h
+++ b/commit.h
@@ -65,9 +65,9 @@ enum cmit_fmt {
 };
 
 extern enum cmit_fmt get_commit_format(const char *arg);
-extern void format_commit_message(const struct commit *commit,
+extern void format_commit_message(struct commit *commit,
                                   const void *format, struct strbuf *sb);
-extern void pretty_print_commit(enum cmit_fmt fmt, const struct commit*,
+extern void pretty_print_commit(enum cmit_fmt fmt, struct commit*,
                                 struct strbuf *,
                                 int abbrev, const char *subject,
                                 const char *after_subject, enum date_mode);
-- 
1.5.3.5.529.ge3d6d
