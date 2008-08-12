From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH (2)] Make builtin-revert.c use merge_recursive_generic()
Date: Tue, 12 Aug 2008 22:14:00 +0200
Message-ID: <1218572040-23362-2-git-send-email-s-beyer@gmx.net>
References: <1218559514-16890-1-git-send-email-vmiklos@frugalware.org>
 <1218572040-23362-1-git-send-email-s-beyer@gmx.net>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 22:15:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT0Gv-0001OX-NT
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 22:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbYHLUOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 16:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752170AbYHLUOH
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 16:14:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:53137 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752062AbYHLUOG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 16:14:06 -0400
Received: (qmail invoked by alias); 12 Aug 2008 20:14:03 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp060) with SMTP; 12 Aug 2008 22:14:03 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19tJawUpj5tJediZfMLHUn6BimR3NGD+7TFy0KXUr
	JqL6+RfG4VIeXu
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KT0Fk-00065E-B2; Tue, 12 Aug 2008 22:14:00 +0200
X-Mailer: git-send-email 1.6.0.rc2.281.g6f6cf
In-Reply-To: <1218572040-23362-1-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92133>

Cherry-pick and revert always ran the merging in a separate process.
This patch makes cherry-pick/revert call merge_recursive_generic()
instead of running a git-merge-recursive process.

The GITHEAD_* environment definitions are not needed anymore,
since the names are direct arguments to merge_recursive_generic().

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
	Hi,
	So this is now based on the new merge-recursive.c based on
	(1a) and (1b).
	The number of lines deleted and inserted tells me that we're
	doing something right here.

 builtin-revert.c |   50 +++++++++++++-------------------------------------
 1 files changed, 13 insertions(+), 37 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 27881e9..2a724ca 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -11,6 +11,7 @@
 #include "cache-tree.h"
 #include "diff.h"
 #include "revision.h"
+#include "merge-recursive.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -200,36 +201,6 @@ static void set_author_ident_env(const char *message)
 			sha1_to_hex(commit->object.sha1));
 }
 
-static int merge_recursive(const char *base_sha1,
-		const char *head_sha1, const char *head_name,
-		const char *next_sha1, const char *next_name)
-{
-	char buffer[256];
-	const char *argv[6];
-	int i = 0;
-
-	sprintf(buffer, "GITHEAD_%s", head_sha1);
-	setenv(buffer, head_name, 1);
-	sprintf(buffer, "GITHEAD_%s", next_sha1);
-	setenv(buffer, next_name, 1);
-
-	/*
-	 * This three way merge is an interesting one.  We are at
-	 * $head, and would want to apply the change between $commit
-	 * and $prev on top of us (when reverting), or the change between
-	 * $prev and $commit on top of us (when cherry-picking or replaying).
-	 */
-	argv[i++] = "merge-recursive";
-	if (base_sha1)
-		argv[i++] = base_sha1;
-	argv[i++] = "--";
-	argv[i++] = head_sha1;
-	argv[i++] = next_sha1;
-	argv[i++] = NULL;
-
-	return run_command_v_opt(argv, RUN_COMMAND_NO_STDIN | RUN_GIT_CMD);
-}
-
 static char *help_msg(const unsigned char *sha1)
 {
 	static char helpbuf[1024];
@@ -266,12 +237,14 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
-	int i;
+	int i, fail;
 	char *oneline, *reencoded_message = NULL;
+	const char *base_list[] = { NULL, NULL };
 	const char *message, *encoding;
 	const char *defmsg = xstrdup(git_path("MERGE_MSG"));
 
-	git_config(git_default_config, NULL);
+	git_config(merge_recursive_config, NULL);
+	merge_recursive_setup(0);
 	me = action == REVERT ? "revert" : "cherry-pick";
 	setenv(GIT_REFLOG_ACTION, me, 0);
 	parse_args(argc, argv);
@@ -373,11 +346,14 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		}
 	}
 
-	if (merge_recursive(base == NULL ?
-				NULL : sha1_to_hex(base->object.sha1),
-				sha1_to_hex(head), "HEAD",
-				sha1_to_hex(next->object.sha1), oneline) ||
-			write_cache_as_tree(head, 0, NULL)) {
+	if (base)
+		base_list[0] = sha1_to_hex(base->object.sha1);
+	fail = merge_recursive_generic(base_list, head, "HEAD",
+						  next->object.sha1, oneline);
+	if (fail < 0)
+		exit(1);
+
+	if (fail || write_cache_as_tree(head, 0, NULL)) {
 		add_to_msg("\nConflicts:\n\n");
 		read_cache();
 		for (i = 0; i < active_nr;) {
-- 
1.6.0.rc2.281.g6f6cf
