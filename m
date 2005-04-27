From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 7/6] Leftover bits.
Date: Wed, 27 Apr 2005 01:17:14 -0700
Message-ID: <7v4qdsiqgl.fsf@assigned-by-dhcp.cox.net>
References: <7vekcwkagr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 10:13:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQhem-00037H-0x
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 10:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVD0IRr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 04:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVD0IRr
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 04:17:47 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:48846 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261178AbVD0IRl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 04:17:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050427081714.WKUA16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 27 Apr 2005 04:17:14 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vekcwkagr.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 26 Apr 2005 23:19:48 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a minor cleanup to be applied on top of the last 6
patches (the 6th is an alternate so the count actually is five).

It makes sure that external diff interface functions are called
even when diff-tree detects directory changes.  Since it is not
clear what to pass GIT_EXTERNAL_DIFF when we do see directory
changes, such calls are still currently dropped at the diff.c
interface function level, but whatever we will decide to do
later, the interface users should be cleaned up first anyway,
and that is primarily what this patch is about.

It also adds code to unlink temporary files used to call the
external diff command upon SIGNIT.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-tree.c |    9 +++------
diff.c      |   14 ++++++++++++++
2 files changed, 17 insertions(+), 6 deletions(-)

# - 04/26 23:58 Mark the last of '-p' (patch) work.
# + working tree
--- k/diff-tree.c
+++ l/diff-tree.c
@@ -82,8 +82,7 @@ static void show_file(const char *prefix
 	}
 
 	if (generate_patch) {
-		if (!S_ISDIR(mode))
-			diff_addremove(prefix[0], mode, sha1, base, path);
+		diff_addremove(prefix[0], mode, sha1, base, path);
 	}
 	else
 		printf("%s%06o\t%s\t%s\t%s%s%c", prefix, mode,
@@ -135,10 +134,8 @@ static int compare_tree_entry(void *tree
 		return retval;
 	}
 
-	if (generate_patch) {
-		if (!S_ISDIR(mode1))
-			diff_change(mode1, mode2, sha1, sha2, base, path1);
-	}
+	if (generate_patch)
+		diff_change(mode1, mode2, sha1, sha2, base, path1);
 	else {
 		strcpy(old_sha1_hex, sha1_to_hex(sha1));
 		printf("*%06o->%06o\t%s\t%s->%s\t%s%s%c", mode1, mode2,
--- k/diff.c
+++ l/diff.c
@@ -127,6 +127,7 @@ static void prepare_temp_file(const char
 
 	if (one->sha1_valid &&
 	    !memcmp(one->u.sha1, null_sha1, sizeof(null_sha1))) {
+		/* "It is valid but please go to the filesystem." */
 		one->sha1_valid = 0;
 		one->u.name = name;
 	}
@@ -180,6 +181,11 @@ static void remove_tempfile(void)
 		}
 }
 
+static void remove_tempfile_on_signal(int signo)
+{
+	remove_tempfile();
+}
+
 /* An external diff command takes:
  *
  * diff-cmd name infile1 infile1-sha1 infile1-mode \
@@ -202,6 +208,7 @@ void run_external_diff(const char *name,
 		     temp[1].name == temp[1].tmp_path)) {
 			atexit_asked = 1;
 			atexit(remove_tempfile);
+			signal(SIGINT, remove_tempfile_on_signal);
 		}
 	}
 
@@ -211,6 +218,7 @@ void run_external_diff(const char *name,
 		die("unable to fork");
 	if (!pid) {
 		const char *pgm = external_diff();
+
 		if (pgm) {
 			if (one && two)
 				execlp(pgm, pgm,
@@ -243,6 +251,9 @@ void diff_addremove(int addremove, unsig
 	char concatpath[PATH_MAX];
 	struct diff_spec spec[2], *one, *two;
 
+	if (S_ISDIR(mode))
+		return;
+
 	memcpy(spec[0].u.sha1, sha1, 20);
 	spec[0].mode = mode;
 	spec[0].sha1_valid = spec[0].file_valid = 1;
@@ -269,6 +280,9 @@ void diff_change(unsigned old_mode, unsi
 	char concatpath[PATH_MAX];
 	struct diff_spec spec[2];
 
+	if (S_ISDIR(old_mode) || S_ISDIR(new_mode))
+		return;
+
 	memcpy(spec[0].u.sha1, old_sha1, 20);
 	spec[0].mode = old_mode;
 	memcpy(spec[1].u.sha1, new_sha1, 20);

