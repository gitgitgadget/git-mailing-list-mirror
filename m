From: Greg Brockman <gdb@MIT.EDU>
Subject: [PATCH/RFC] split_cmdline: Allow caller to access error string
Date: Sat,  7 Aug 2010 01:13:39 -0400
Message-ID: <1281158019-25995-1-git-send-email-gdb@mit.edu>
Cc: Greg Brockman <gdb@mit.edu>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Aug 07 07:14:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhbjN-00064Y-8W
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 07:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531Ab0HGFNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Aug 2010 01:13:53 -0400
Received: from DMZ-MAILSEC-SCANNER-2.MIT.EDU ([18.9.25.13]:60882 "EHLO
	dmz-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751604Ab0HGFNw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Aug 2010 01:13:52 -0400
X-AuditID: 1209190d-b7c82ae000000a16-1c-4c5ceb915dd1
Received: from mailhub-auth-3.mit.edu (MAILHUB-AUTH-3.MIT.EDU [18.9.21.43])
	by dmz-mailsec-scanner-2.mit.edu (Symantec Brightmail Gateway) with SMTP id F1.2F.02582.19BEC5C4; Sat,  7 Aug 2010 01:13:53 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o775DnFo012492;
	Sat, 7 Aug 2010 01:13:49 -0400
Received: from localhost (EASTCAMPUS-ONE-O-FIVE-HUNDRED-FOURTEEN.MIT.EDU [18.238.7.247])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o775Dmve015687;
	Sat, 7 Aug 2010 01:13:49 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.4
X-Brightmail-Tracker: AAAAARV7RYg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152843>

This allows the caller to add its own error message to that returned
by split_cmdline.  Thus error output following a failed split_cmdline
can be of the form

fatal: Bad alias.test string: cmdline ends with \

rather than

error: cmdline ends with \
fatal: Bad alias.test string

Signed-off-by: Greg Brockman <gdb@mit.edu>
---

For reference, this functionality was suggested by Junio in
http://article.gmane.org/gmane.comp.version-control.git/151330/.  If
we decide to go this route, the git-shell patches currently in pu should
be patched to use split_cmdline_strerror.

Thanks in advance for whatever comments you have on this implementation.

 alias.c         |   11 ++++++++---
 builtin/merge.c |    3 ++-
 cache.h         |    2 ++
 git.c           |    3 ++-
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/alias.c b/alias.c
index 372b7d8..6f771cb 100644
--- a/alias.c
+++ b/alias.c
@@ -1,7 +1,9 @@
 #include "cache.h"
-
 static const char *alias_key;
 static char *alias_val;
+#define SPLIT_CMDLINE_BAD_ENDING 1
+#define SPLIT_CMDLINE_UNCLOSED_QUOTE 2
+static const char *split_cmdline_errors = { "cmdline ends with \\", "unclosed quote" };
 
 static int alias_lookup_cb(const char *k, const char *v, void *cb)
 {
@@ -53,7 +55,7 @@ int split_cmdline(char *cmdline, const char ***argv)
 				if (!c) {
 					free(*argv);
 					*argv = NULL;
-					return error("cmdline ends with \\");
+					return -SPLIT_CMDLINE_BAD_ENDING;
 				}
 			}
 			cmdline[dst++] = c;
@@ -66,7 +68,7 @@ int split_cmdline(char *cmdline, const char ***argv)
 	if (quoted) {
 		free(*argv);
 		*argv = NULL;
-		return error("unclosed quote");
+		return -SPLIT_CMDLINE_UNCLOSED_QUOTE;
 	}
 
 	ALLOC_GROW(*argv, count+1, size);
@@ -75,3 +77,6 @@ int split_cmdline(char *cmdline, const char ***argv)
 	return count;
 }
 
+const char *split_cmdline_strerror(int split_cmdline_errno) {
+	return split_cmdline_errors[-split_cmdline_errno-1];
+}
diff --git a/builtin/merge.c b/builtin/merge.c
index 37ce4f5..b488263 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -486,7 +486,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		buf = xstrdup(v);
 		argc = split_cmdline(buf, &argv);
 		if (argc < 0)
-			die("Bad branch.%s.mergeoptions string", branch);
+			die("Bad branch.%s.mergeoptions string: %s", branch,
+			    split_cmdline_strerror(argc));
 		argv = xrealloc(argv, sizeof(*argv) * (argc + 2));
 		memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
 		argc++;
diff --git a/cache.h b/cache.h
index c9fa3df..7466ad0 100644
--- a/cache.h
+++ b/cache.h
@@ -1096,6 +1096,8 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix);
 
 char *alias_lookup(const char *alias);
 int split_cmdline(char *cmdline, const char ***argv);
+/* Takes a negative value returned by split_cmdline */
+const char *split_cmdline_strerror(int cmdline_errno);
 
 /* builtin/merge.c */
 int checkout_fast_forward(const unsigned char *from, const unsigned char *to);
diff --git a/git.c b/git.c
index f37028b..6fc07a5 100644
--- a/git.c
+++ b/git.c
@@ -188,7 +188,8 @@ static int handle_alias(int *argcp, const char ***argv)
 		}
 		count = split_cmdline(alias_string, &new_argv);
 		if (count < 0)
-			die("Bad alias.%s string", alias_command);
+			die("Bad alias.%s string: %s", alias_command,
+			    split_cmdline_strerror(count));
 		option_count = handle_options(&new_argv, &count, &envchanged);
 		if (envchanged)
 			die("alias '%s' changes environment variables\n"
-- 
1.7.0.4
