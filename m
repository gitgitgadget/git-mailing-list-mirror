From: Greg Brockman <gdb@MIT.EDU>
Subject: [PATCH] shell: Display errors from improperly-formatted command lines
Date: Fri, 27 Aug 2010 01:36:13 -0400
Message-ID: <1282887373-25618-1-git-send-email-gdb@mit.edu>
Cc: Greg Brockman <gdb@mit.edu>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 27 07:36:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oorc3-0003Ln-DV
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 07:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996Ab0H0FgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 01:36:21 -0400
Received: from DMZ-MAILSEC-SCANNER-1.MIT.EDU ([18.9.25.12]:62105 "EHLO
	dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751685Ab0H0FgT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Aug 2010 01:36:19 -0400
X-AuditID: 1209190c-b7c9cae00000753f-0b-4c774ed213a2
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-1.mit.edu (Symantec Brightmail Gateway) with SMTP id 74.A9.30015.2DE477C4; Fri, 27 Aug 2010 01:36:18 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id o7R5aHGt012756;
	Fri, 27 Aug 2010 01:36:17 -0400
Received: from localhost (dhcp-18-111-101-135.dyn.mit.edu [18.111.101.135])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o7R5aFDm023277;
	Fri, 27 Aug 2010 01:36:16 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.4
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154583>

The interface for split_cmdline has changed such that the caller holds
responsibility for printing any error messages.  This patch changes
the git shell to print these error messages as appropriate.
---
 shell.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

The error behavior of split_cmdline was changed in the patch  'split_cmdline: Allow
caller to access error string'.  This updates git-shell to deal with printing out
split_cmdline errors itself.

diff --git a/shell.c b/shell.c
index b539cdf..7be826d 100644
--- a/shell.c
+++ b/shell.c
@@ -74,8 +74,10 @@ static void run_shell(void)
 		const char *prog;
 		char *full_cmd;
 		char *rawargs;
+		char *split_args;
 		const char **argv;
 		int code;
+		int count;
 
 		fprintf(stderr, "git> ");
 		if (strbuf_getline(&line, stdin, '\n') == EOF) {
@@ -85,7 +87,12 @@ static void run_shell(void)
 		}
 		strbuf_trim(&line);
 		rawargs = strbuf_detach(&line, NULL);
-		if (split_cmdline(rawargs, &argv) == -1) {
+		split_args = xstrdup(rawargs);
+		count = split_cmdline(split_args, &argv);
+		if (count < 0) {
+			fprintf(stderr, "invalid command format '%s': %s\n", rawargs,
+				split_cmdline_strerror(count));
+			free(split_args);
 			free(rawargs);
 			continue;
 		}
@@ -129,6 +136,7 @@ int main(int argc, char **argv)
 	const char **user_argv;
 	struct commands *cmd;
 	int devnull_fd;
+	int count;
 
 	git_setup_gettext();
 
@@ -193,7 +201,8 @@ int main(int argc, char **argv)
 	}
 
 	cd_to_homedir();
-	if (split_cmdline(prog, &user_argv) != -1) {
+	count = split_cmdline(prog, &user_argv);
+	if (count >= 0) {
 		if (is_valid_cmd_name(user_argv[0])) {
 			prog = make_cmd(user_argv[0]);
 			user_argv[0] = prog;
@@ -204,6 +213,7 @@ int main(int argc, char **argv)
 		die("unrecognized command '%s'", argv[2]);
 	} else {
 		free(prog);
-		die("invalid command format '%s'", argv[2]);
+		die("invalid command format '%s': %s", argv[2],
+		    split_cmdline_strerror(count));
 	}
 }
-- 
1.7.0.4
