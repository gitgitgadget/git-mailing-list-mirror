From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/6] Reworked external diff interface.
Date: Tue, 26 Apr 2005 23:24:23 -0700
Message-ID: <7vacnkka94.fsf@assigned-by-dhcp.cox.net>
References: <7vekcwkagr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 08:20:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQftQ-0008Us-Rr
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 08:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVD0GYp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 02:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVD0GYp
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 02:24:45 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:32498 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261610AbVD0GYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 02:24:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050427062423.JAIZ550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 27 Apr 2005 02:24:23 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vekcwkagr.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 26 Apr 2005 23:19:48 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch introduces three public functions for diff-cache and
friends can use to call out to the GIT_EXTERNAL_DIFF program
when they wish to.  A normal "add/remove/change" entry is turned
into 7-parameter process invocation of GIT_EXTERNAL_DIFF program
as before.  In addition, the program can now be called with a
single parameter when diff-cache and friends want to report an
unmerged path.


Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff.c |   93 ++++++++++++++++++++++++++++++++++++++++-------------------------
diff.h |   19 +++++++++----
2 files changed, 72 insertions(+), 40 deletions(-)

To be tested with the following:

    GIT_INDEX_FILE=junk
    export GIT_INDEX_FILE
    read-tree $(cat .git/HEAD)
    t1=$(write-tree)
    date >trash ; update-cache --add trash
    t2=$(write-tree)
    read-tree -m $(cat .git/HEAD) $t1 $t2
    update-cache --refresh
    ./show-diff | GIT_EXTERNAL_DIFF=echo ./diff-tree-helper

--- k/diff.c
+++ l/diff.c
@@ -194,13 +194,15 @@ void run_external_diff(const char *name,
 	int pid, status;
 	static int atexit_asked = 0;
 
-	prepare_temp_file(name, &temp[0], one);
-	prepare_temp_file(name, &temp[1], two);
-	if (! atexit_asked &&
-	    (temp[0].name == temp[0].tmp_path ||
-	     temp[1].name == temp[1].tmp_path)) {
-		atexit_asked = 1;
-		atexit(remove_tempfile);
+	if (one && two) {
+		prepare_temp_file(name, &temp[0], one);
+		prepare_temp_file(name, &temp[1], two);
+		if (! atexit_asked &&
+		    (temp[0].name == temp[0].tmp_path ||
+		     temp[1].name == temp[1].tmp_path)) {
+			atexit_asked = 1;
+			atexit(remove_tempfile);
+		}
 	}
 
 	fflush(NULL);
@@ -209,16 +211,23 @@ void run_external_diff(const char *name,
 		die("unable to fork");
 	if (!pid) {
 		const char *pgm = external_diff();
-		if (pgm)
-			execlp(pgm, pgm,
-			       name,
-			       temp[0].name, temp[0].hex, temp[0].mode,
-			       temp[1].name, temp[1].hex, temp[1].mode,
-			       NULL);
+		if (pgm) {
+			if (one && two)
+				execlp(pgm, pgm,
+				       name,
+				       temp[0].name, temp[0].hex, temp[0].mode,
+				       temp[1].name, temp[1].hex, temp[1].mode,
+				       NULL);
+			else
+				execlp(pgm, pgm, name, NULL);
+		}
 		/*
 		 * otherwise we use the built-in one.
 		 */
-		builtin_diff(name, temp);
+		if (one && two)
+			builtin_diff(name, temp);
+		else
+			printf("* Unmerged path %s\n", name);
 		exit(0);
 	}
 	if (waitpid(pid, &status, 0) < 0 || !WIFEXITED(status))
@@ -227,41 +236,55 @@ void run_external_diff(const char *name,
 	remove_tempfile();
 }
 
-void show_diff_empty(const struct cache_entry *ce, int reverse)
+void diff_addremove(int addremove, unsigned mode,
+		    const unsigned char *sha1,
+		    const char *base, const char *path)
 {
+	char concatpath[PATH_MAX];
 	struct diff_spec spec[2], *one, *two;
 
-	memcpy(spec[0].u.sha1, ce->sha1, 20);
-	spec[0].mode = ntohl(ce->ce_mode);
+	memcpy(spec[0].u.sha1, sha1, 20);
+	spec[0].mode = mode;
 	spec[0].sha1_valid = spec[0].file_valid = 1;
 	spec[1].file_valid = 0;
 
-	if (reverse) {
+	if (addremove == '+') {
 		one = spec + 1; two = spec;
 	} else {
 		one = spec; two = one + 1;
 	}
-
-	run_external_diff(ce->name, one, two);
+	
+	if (path) {
+		strcpy(concatpath, base);
+		strcat(concatpath, "/");
+		strcat(concatpath, path);
+	}
+	run_external_diff(path ? concatpath : base, one, two);
 }
 
-void show_differences(const struct cache_entry *ce, int reverse) 
-{
-	struct diff_spec spec[2], *one, *two;
-
-	memcpy(spec[0].u.sha1, ce->sha1, 20);
-	spec[0].mode = ntohl(ce->ce_mode);
+void diff_change(unsigned old_mode, unsigned new_mode,
+		 const unsigned char *old_sha1,
+		 const unsigned char *new_sha1,
+		 const char *base, const char *path) {
+	char concatpath[PATH_MAX];
+	struct diff_spec spec[2];
+
+	memcpy(spec[0].u.sha1, old_sha1, 20);
+	spec[0].mode = old_mode;
+	memcpy(spec[1].u.sha1, new_sha1, 20);
+	spec[1].mode = new_mode;
 	spec[0].sha1_valid = spec[0].file_valid = 1;
+	spec[1].sha1_valid = spec[1].file_valid = 1;
 
-	spec[1].u.name = ce->name; /* the name we stated */
-	spec[1].sha1_valid = 0;
-	spec[1].file_valid = 1;
-
-	if (reverse) {
-		one = spec + 1; two = spec;
-	} else {
-		one = spec; two = one + 1;
+	if (path) {
+		strcpy(concatpath, base);
+		strcat(concatpath, "/");
+		strcat(concatpath, path);
 	}
+	run_external_diff(path ? concatpath : base, &spec[0], &spec[1]);
+}
 
-	run_external_diff(ce->name, one, two);
+void diff_unmerge(const char *path)
+{
+	run_external_diff(path, NULL, NULL);
 }
--- k/diff.h
+++ l/diff.h
@@ -4,11 +4,20 @@
 #ifndef DIFF_H
 #define DIFF_H
 
-/* These two are for backward compatibility with show-diff;
- * new users should not use them.
- */
-extern void show_differences(const struct cache_entry *ce, int reverse);
-extern void show_diff_empty(const struct cache_entry *ce, int reverse);
+extern void diff_addremove(int addremove,
+			   unsigned mode,
+			   const unsigned char *sha1,
+			   const char *base,
+			   const char *path);
+
+extern void diff_change(unsigned mode1, unsigned mode2,
+			     const unsigned char *sha1,
+			     const unsigned char *sha2,
+			     const char *base, const char *path);
+
+extern void diff_unmerge(const char *path);
+
+/* These are for diff-tree-helper */
 
 struct diff_spec {
 	union {

