From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH] Allow update hooks to update refs on their own
Date: Tue, 27 Nov 2007 13:17:30 -0800
Message-ID: <20071127211730.GA11861@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 22:17:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix7oY-0003yY-DY
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 22:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756902AbXK0VRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 16:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752305AbXK0VRc
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 16:17:32 -0500
Received: from tater.midwinter.com ([216.32.86.90]:49174 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756617AbXK0VRb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 16:17:31 -0500
Received: (qmail 12661 invoked by uid 1001); 27 Nov 2007 21:17:30 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66261>

This is useful in cases where a hook needs to modify an incoming commit
in some way, e.g., adding an annotation to the commit message, noting
the location of output from a profiling tool, or committing to an svn
repository using git-svn.

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---

	I did this to support a bridge between svn and git. The idea is
	that the people who use git can do "git push" to publish their
	changes, and if they've pushed to certain branches, the changes
	will get transparently committed to svn using git-svn.

	The git users therefore can operate in a totally git-centric
	environment.  (This is a step toward transitioning my company
	away from svn entirely: get people used to a native git environment
	with no direct svn interactions.)
	
	One problem is that git-svn wants to rewrite history to add its
	git-svn-id: lines, which means that when the update hook returns
	after doing the git-svn dcommit, HEAD is already pointed at the
	updated commit.  Without this change or something like it,
	receive-pack bombs out because HEAD has moved, and the push
	appears to fail. This patch addresses that particular problem.

	There are other issues with the history rewriting, but this
	change is hopefully useful on its own for cases like the ones
	listed in the commit message.

 Documentation/git-receive-pack.txt |    8 +++-
 receive-pack.c                     |   68 +++++++++++++++++++++++-------------
 2 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 2633d94..115ae97 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -74,8 +74,12 @@ Note that the hook is called before the refname is updated,
 so either sha1-old is 0\{40} (meaning there is no such ref yet),
 or it should match what is recorded in refname.
 
-The hook should exit with non-zero status if it wants to disallow
-updating the named ref.  Otherwise it should exit with zero.
+The hook may optionally choose to update the ref on its own, e.g.,
+if it needs to modify incoming revisions in some way. If it updates
+the ref, it should exit with a status of 100.  The hook should exit
+with a status between 1 and 99 if it wants to disallow updating the
+named ref.  Otherwise it should exit with zero, and the ref will be
+updated automatically.
 
 Successful execution (a zero exit status) of this hook does not
 ensure the ref will actually be updated, it is only a prerequisite.
diff --git a/receive-pack.c b/receive-pack.c
index 38e35c0..19162ec 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -18,6 +18,9 @@ static int report_status;
 static char capabilities[] = " report-status delete-refs ";
 static int capabilities_sent;
 
+/* Update hook exit code: hook has updated ref on its own */
+#define EXIT_CODE_REF_UPDATED 100
+
 static int receive_pack_config(const char *var, const char *value)
 {
 	if (strcmp(var, "receive.denynonfastforwards") == 0) {
@@ -70,8 +73,11 @@ static struct command *commands;
 static const char pre_receive_hook[] = "hooks/pre-receive";
 static const char post_receive_hook[] = "hooks/post-receive";
 
-static int hook_status(int code, const char *hook_name)
+static int hook_status(int code, const char *hook_name, int ok_start)
 {
+	if (ok_start && -code >= ok_start)
+		return -code;
+
 	switch (code) {
 	case 0:
 		return 0;
@@ -121,7 +127,7 @@ static int run_hook(const char *hook_name)
 
 	code = start_command(&proc);
 	if (code)
-		return hook_status(code, hook_name);
+		return hook_status(code, hook_name, 0);
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (!cmd->error_string) {
 			size_t n = snprintf(buf, sizeof(buf), "%s %s %s\n",
@@ -132,7 +138,7 @@ static int run_hook(const char *hook_name)
 				break;
 		}
 	}
-	return hook_status(finish_command(&proc), hook_name);
+	return hook_status(finish_command(&proc), hook_name, 0);
 }
 
 static int run_update_hook(struct command *cmd)
@@ -155,7 +161,8 @@ static int run_update_hook(struct command *cmd)
 	proc.no_stdin = 1;
 	proc.stdout_to_stderr = 1;
 
-	return hook_status(run_command(&proc), update_hook);
+	return hook_status(run_command(&proc), update_hook,
+			   EXIT_CODE_REF_UPDATED);
 }
 
 static const char *update(struct command *cmd)
@@ -194,32 +201,45 @@ static const char *update(struct command *cmd)
 			return "non-fast forward";
 		}
 	}
-	if (run_update_hook(cmd)) {
-		error("hook declined to update %s", name);
-		return "hook declined";
-	}
-
-	if (is_null_sha1(new_sha1)) {
-		if (delete_ref(name, old_sha1)) {
-			error("failed to delete %s", name);
-			return "failed to delete";
+	switch (run_update_hook(cmd)) {
+	case 0:
+		if (is_null_sha1(new_sha1)) {
+			if (delete_ref(name, old_sha1)) {
+				error("failed to delete %s", name);
+				return "failed to delete";
+			}
+			fprintf(stderr, "%s: %s -> deleted\n", name,
+				sha1_to_hex(old_sha1));
 		}
-		fprintf(stderr, "%s: %s -> deleted\n", name,
-			sha1_to_hex(old_sha1));
-		return NULL; /* good */
-	}
-	else {
-		lock = lock_any_ref_for_update(name, old_sha1, 0);
-		if (!lock) {
-			error("failed to lock %s", name);
-			return "failed to lock";
+		else {
+			lock = lock_any_ref_for_update(name, old_sha1, 0);
+			if (!lock) {
+				error("failed to lock %s", name);
+				return "failed to lock";
+			}
+			if (write_ref_sha1(lock, new_sha1, "push")) {
+				return "failed to write"; /* error() already called */
+			}
+			fprintf(stderr, "%s: %s -> %s\n", name,
+				sha1_to_hex(old_sha1), sha1_to_hex(new_sha1));
 		}
-		if (write_ref_sha1(lock, new_sha1, "push")) {
-			return "failed to write"; /* error() already called */
+		return NULL; /* good */
+
+	case EXIT_CODE_REF_UPDATED:
+		/* hook has taken care of updating ref, which means it
+		   might be a different revision than we think. */
+		if (! resolve_ref(name, new_sha1, 1, NULL)) {
+			error("can't resolve ref %s after hook updated it",
+				name);
+			return "ref not resolvable";
 		}
 		fprintf(stderr, "%s: %s -> %s\n", name,
 			sha1_to_hex(old_sha1), sha1_to_hex(new_sha1));
 		return NULL; /* good */
+
+	default:
+		error("hook declined to update %s", name);
+		return "hook declined";
 	}
 }
 
-- 
1.5.3.6.862.g7acd00-dirty
