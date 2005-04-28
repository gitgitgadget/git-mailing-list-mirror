From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff.c: clean temporary files
Date: Wed, 27 Apr 2005 21:51:20 -0700
Message-ID: <7v7jinbj1z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 06:46:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR0uf-000645-PA
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 06:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVD1Evd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 00:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVD1Evd
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 00:51:33 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:22153 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261961AbVD1EvW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 00:51:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050428045120.QGPR22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Apr 2005 00:51:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When diff-cache -p and friends are interrupted, they can leave
their temporary files behind.  Also when the external diff
program is killed instead of exiting (this usually happens when
piping the output to a pager, which can cause SIGPIPE when the
user quits viewing the diff early), they incorrectly died
without cleaning their temporary file.  This patch fixes these
problems.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff.c |   29 ++++++++++++++++++++++++-----
1 files changed, 24 insertions(+), 5 deletions(-)

# - [PATCH] diff-tree -p implies diff-tree -p -r
# + 04/27 21:50 diff.c clean up temporary file.
--- k/diff.c
+++ l/diff.c
@@ -3,6 +3,7 @@
  */
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <signal.h>
 #include "cache.h"
 #include "diff.h"
 
@@ -119,6 +120,9 @@ static void prepare_temp_file(const char
 
 	if (!one->file_valid) {
 	not_a_valid_file:
+		/* A '-' entry produces this for file-2, and
+		 * a '+' entry produces this for file-1.
+		 */
 		temp->name = "/dev/null";
 		strcpy(temp->hex, ".");
 		strcpy(temp->mode, ".");
@@ -139,7 +143,7 @@ static void prepare_temp_file(const char
 				goto not_a_valid_file;
 			die("stat(%s): %s", temp->name, strerror(errno));
 		}
-		strcpy(temp->hex, ".");
+		strcpy(temp->hex, sha1_to_hex(null_sha1));
 		sprintf(temp->mode, "%06o",
 			S_IFREG |ce_permissions(st.st_mode));
 	}
@@ -180,6 +184,11 @@ static void remove_tempfile(void)
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
@@ -191,7 +200,8 @@ void run_external_diff(const char *name,
 		       struct diff_spec *two)
 {
 	struct diff_tempfile *temp = diff_temp;
-	int pid, status;
+	pid_t pid;
+	int status;
 	static int atexit_asked = 0;
 
 	if (one && two) {
@@ -203,6 +213,7 @@ void run_external_diff(const char *name,
 			atexit_asked = 1;
 			atexit(remove_tempfile);
 		}
+		signal(SIGINT, remove_tempfile_on_signal);
 	}
 
 	fflush(NULL);
@@ -230,9 +241,17 @@ void run_external_diff(const char *name,
 			printf("* Unmerged path %s\n", name);
 		exit(0);
 	}
-	if (waitpid(pid, &status, 0) < 0 || !WIFEXITED(status))
-		die("diff program failed");
-
+	if (waitpid(pid, &status, 0) < 0 || !WIFEXITED(status)) {
+		/* We do not check the exit status because typically
+		 * diff exits non-zero if files are different, and
+		 * we are not interested in knowing that.  We *knew*
+		 * they are different and that's why we ran diff
+		 * in the first place!  However if it dies by a signal,
+		 * we stop processing immediately.
+		 */
+		remove_tempfile();
+		die("external diff died unexpectedly.\n");
+	}
 	remove_tempfile();
 }
 

