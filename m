From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH/RFC 1/3] rerere: keep a list of resolved files in MERGE_RR
Date: Sat, 21 Nov 2009 20:00:19 +0100
Message-ID: <200911212000.19326.j6t@kdbg.org>
References: <200911211958.40872.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 21 21:51:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBwsH-00041R-Pw
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 21:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027AbZKUTAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 14:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753967AbZKUTAY
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 14:00:24 -0500
Received: from [93.83.142.38] ([93.83.142.38]:62842 "EHLO dx.sixt.local"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753964AbZKUTAX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2009 14:00:23 -0500
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 5C06619F6A2;
	Sat, 21 Nov 2009 20:00:19 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <200911211958.40872.j6t@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133401>

Previously, MERGE_RR entries that rerere detected as resolved were removed
from MERGE_RR so that it contained only entries for files that still had
conflicts.

This changes the "database" format to also keep the entries about files
for which resolutions have been recorded. The purpose is to allow that
resolved conflicts can be unresolved. To do that it is necessary to have
a mapping from the file name to the conflict hash.

The new format of MERGE_RR is:

1. Entries about unresolved conflicts.
2. An all-zeros SHA1 as boundary marker.
3. Entries about resolved conflicts.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 builtin-rerere.c |    4 +++-
 rerere.c         |   49 ++++++++++++++++++++++++++++++++++++++++---------
 rerere.h         |    2 +-
 3 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/builtin-rerere.c b/builtin-rerere.c
index adfb7b5..275827d 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -101,12 +101,13 @@ static int diff_two(const char *file1, const char *label1,
 int cmd_rerere(int argc, const char **argv, const char *prefix)
 {
 	struct string_list merge_rr = { NULL, 0, 0, 1 };
+	struct string_list merge_rr_done = { NULL, 0, 0, 1 };
 	int i, fd;
 
 	if (argc < 2)
 		return rerere();
 
-	fd = setup_rerere(&merge_rr);
+	fd = setup_rerere(&merge_rr, &merge_rr_done);
 	if (fd < 0)
 		return 0;
 
@@ -132,5 +133,6 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 		usage(git_rerere_usage);
 
 	string_list_clear(&merge_rr, 1);
+	string_list_clear(&merge_rr_done, 1);
 	return 0;
 }
diff --git a/rerere.c b/rerere.c
index 29f95f6..84d0bb7 100644
--- a/rerere.c
+++ b/rerere.c
@@ -23,8 +23,20 @@ int has_rerere_resolution(const char *hex)
 	return !stat(rerere_path(hex, "postimage"), &st);
 }
 
-static void read_rr(struct string_list *rr)
+/*
+ * If MERGE_RR is read and rewritten by an old version, the section bound
+ * would not be preserved, and file names from both sections would be
+ * interleaved. We must make sure that the section marker does not end up
+ * in an arbitrary position. In particular, the safest result is that all
+ * paths are now in the first ("not done") section. Therefore, we choose
+ * a file name that sorts last (for all practical purposes).
+ */
+static const char section_mark[] =
+	"0000000000000000000000000000000000000000\t\377\377\377\377";
+
+static void read_rr(struct string_list *rr, struct string_list *rr_done)
 {
+	struct string_list *section = rr;
 	unsigned char sha1[20];
 	char buf[PATH_MAX];
 	FILE *in = fopen(merge_rr_path, "r");
@@ -43,14 +55,19 @@ static void read_rr(struct string_list *rr)
 			; /* do nothing */
 		if (i == sizeof(buf))
 			die("filename too long");
-		string_list_insert(buf, rr)->util = name;
+		if (prefixcmp(section_mark, name)) {
+			string_list_insert(buf, section)->util = name;
+		} else {
+			free(name);
+			section = rr_done;
+		}
 	}
 	fclose(in);
 }
 
 static struct lock_file write_lock;
 
-static int write_rr(struct string_list *rr, int out_fd)
+static void write_rr_section(struct string_list *rr, int out_fd)
 {
 	int i;
 	for (i = 0; i < rr->nr; i++) {
@@ -65,6 +82,17 @@ static int write_rr(struct string_list *rr, int out_fd)
 		    write_in_full(out_fd, path, length) != length)
 			die("unable to write rerere record");
 	}
+}
+
+static int write_rr(struct string_list *rr,
+		    struct string_list *rr_done, int out_fd)
+{
+	int length = strlen(section_mark)+1;
+
+	write_rr_section(rr, out_fd);
+	if (write_in_full(out_fd, section_mark, length) != length)
+		die("unable to write rerere record");
+	write_rr_section(rr_done, out_fd);
 	if (commit_lock_file(&write_lock) != 0)
 		die("unable to write rerere record");
 	return 0;
@@ -263,7 +291,8 @@ static int update_paths(struct string_list *update)
 	return status;
 }
 
-static int do_plain_rerere(struct string_list *rr, int fd)
+static int do_plain_rerere(struct string_list *rr,
+			   struct string_list *rr_done, int fd)
 {
 	struct string_list conflict = { NULL, 0, 0, 1 };
 	struct string_list update = { NULL, 0, 0, 1 };
@@ -328,13 +357,14 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		fprintf(stderr, "Recorded resolution for '%s'.\n", path);
 		copy_file(rerere_path(name, "postimage"), path, 0666);
 	mark_resolved:
+		string_list_insert(path, rr_done)->util = rr->items[i].util;
 		rr->items[i].util = NULL;
 	}
 
 	if (update.nr)
 		update_paths(&update);
 
-	return write_rr(rr, fd);
+	return write_rr(rr, rr_done, fd);
 }
 
 static int git_rerere_config(const char *var, const char *value, void *cb)
@@ -367,7 +397,7 @@ static int is_rerere_enabled(void)
 	return 1;
 }
 
-int setup_rerere(struct string_list *merge_rr)
+int setup_rerere(struct string_list *merge_rr, struct string_list *merge_rr_done)
 {
 	int fd;
 
@@ -378,17 +408,18 @@ int setup_rerere(struct string_list *merge_rr)
 	merge_rr_path = git_pathdup("MERGE_RR");
 	fd = hold_lock_file_for_update(&write_lock, merge_rr_path,
 				       LOCK_DIE_ON_ERROR);
-	read_rr(merge_rr);
+	read_rr(merge_rr, merge_rr_done);
 	return fd;
 }
 
 int rerere(void)
 {
 	struct string_list merge_rr = { NULL, 0, 0, 1 };
+	struct string_list merge_rr_done = { NULL, 0, 0, 1 };
 	int fd;
 
-	fd = setup_rerere(&merge_rr);
+	fd = setup_rerere(&merge_rr, &merge_rr_done);
 	if (fd < 0)
 		return 0;
-	return do_plain_rerere(&merge_rr, fd);
+	return do_plain_rerere(&merge_rr, &merge_rr_done, fd);
 }
diff --git a/rerere.h b/rerere.h
index 13313f3..9bb2f13 100644
--- a/rerere.h
+++ b/rerere.h
@@ -3,7 +3,7 @@
 
 #include "string-list.h"
 
-extern int setup_rerere(struct string_list *);
+extern int setup_rerere(struct string_list *, struct string_list *);
 extern int rerere(void);
 extern const char *rerere_path(const char *hex, const char *file);
 extern int has_rerere_resolution(const char *hex);
-- 
1.6.5.2.182.ge039a
