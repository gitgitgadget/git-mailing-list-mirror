From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH v4] Allow update hooks to update refs on their own.
Date: Sun, 2 Dec 2007 13:22:24 -0800
Message-ID: <20071202212224.GA22117@midwinter.com>
References: <7vr6i8sfsa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 02 22:22:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IywH0-0008S7-88
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 22:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754389AbXLBVWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 16:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754048AbXLBVWZ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 16:22:25 -0500
Received: from tater.midwinter.com ([216.32.86.90]:55865 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753816AbXLBVWY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 16:22:24 -0500
Received: (qmail 22481 invoked by uid 1001); 2 Dec 2007 21:22:24 -0000
Content-Disposition: inline
In-Reply-To: <7vr6i8sfsa.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66818>

This is useful in cases where a hook needs to modify an incoming commit
in some way, e.g., fixing whitespace errors, adding an annotation to
the commit message, noting the location of output from a profiling tool,
or committing to an svn repository using git-svn.

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---

	Since Junio's main objection to this seemed to be the protocol
	change to bypass the automatic update of the tracking ref in
	git-send-pack, that code is gone (thus reverting this to the
	same code change as the initial version!) and I added a section
	to the git-send-pack manual page describing the automatic
	tracking ref update behavior, which wasn't documented at all
	before. Someone please review my terminology there.

 Documentation/git-receive-pack.txt |    8 +++-
 Documentation/git-send-pack.txt    |   16 ++++++++
 receive-pack.c                     |   70 +++++++++++++++++++++++-------------
 3 files changed, 67 insertions(+), 27 deletions(-)

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
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index a2d9cb6..db64a1b 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -115,6 +115,22 @@ Optionally, a <ref> parameter can be prefixed with a plus '+' sign
 to disable the fast-forward check only on that ref.
 
 
+Remote Tracking Refs
+--------------------
+
+After successfully sending a pack to the remote, 'git-send-pack'
+updates the corresponding remote tracking ref in the local repository
+to point to the same commit as was just sent to the remote side. In
+most cases this eliminates the need to subsequently fetch from the
+remote repository since there would be nothing new to fetch.
+
+If the remote side's update hook modifies the incoming commit
+before applying it, the local repository's remote tracking ref will
+point at a different commit than the corresponding remote ref (since
+the local repository will not have a copy of the modified version).
+In that case an explicit fetch will be required.
+
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
diff --git a/receive-pack.c b/receive-pack.c
index fba4cf8..ca906bf 100644
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
-		if (!parse_object(old_sha1)) {
-			warning ("Allowing deletion of corrupt ref.");
-			old_sha1 = NULL;
+	switch (run_update_hook(cmd)) {
+	case 0:
+		if (is_null_sha1(new_sha1)) {
+			if (!parse_object(old_sha1)) {
+				warning ("Allowing deletion of corrupt ref.");
+				old_sha1 = NULL;
+			}
+			if (delete_ref(name, old_sha1)) {
+				error("failed to delete %s", name);
+				return "failed to delete";
+			}
+			fprintf(stderr, "%s: %s -> deleted\n", name,
+				sha1_to_hex(old_sha1));
 		}
-		if (delete_ref(name, old_sha1)) {
-			error("failed to delete %s", name);
-			return "failed to delete";
+		else {
+			lock = lock_any_ref_for_update(name, old_sha1, 0);
+			if (!lock) {
+				error("failed to lock %s", name);
+				return "failed to lock";
+			}
+			if (write_ref_sha1(lock, new_sha1, "push")) {
+				return "failed to write"; /* error() already called */
+			}
 		}
 		return NULL; /* good */
-	}
-	else {
-		lock = lock_any_ref_for_update(name, old_sha1, 0);
-		if (!lock) {
-			error("failed to lock %s", name);
-			return "failed to lock";
-		}
-		if (write_ref_sha1(lock, new_sha1, "push")) {
-			return "failed to write"; /* error() already called */
+
+	case EXIT_CODE_REF_UPDATED:
+		/* hook has taken care of updating ref, which means it
+		   might be a different revision than we think. */
+		if (! resolve_ref(name, new_sha1, 1, NULL)) {
+			error("can't resolve ref %s after hook updated it",
+				name);
+			return "ref not resolvable";
 		}
 		return NULL; /* good */
+
+	default:
+		error("hook declined to update %s", name);
+		return "hook declined";
 	}
 }
 
-- 
1.5.3.6.2040.g97735-dirty
