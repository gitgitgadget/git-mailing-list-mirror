From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] show-branch: show all local heads when only giving one rev along --topics
Date: Tue, 31 Mar 2015 07:12:23 +0900
Message-ID: <1427753543-19680-1-git-send-email-mh@glandium.org>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 31 00:12:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ychv9-0007Et-H1
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 00:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466AbbC3WMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 18:12:31 -0400
Received: from ks3293202.kimsufi.com ([5.135.186.141]:55875 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753436AbbC3WMa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 18:12:30 -0400
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1Ychux-000587-9A; Tue, 31 Mar 2015 07:12:23 +0900
X-Mailer: git-send-email 2.4.0.rc0.1.g7f94b17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266480>

"git show-branch --topics <rev> <revs>..." displays ancestry graph, only
considering commits that are in all given revs, except the first one.

"git show-branch" displays ancestry graph for all local branches.

Unfortunately, "git show-branch --topics <rev>" only prints out the rev
info for the given rev, and nothing else, e.g.:

  $ git show-branch --topics origin/master
  [origin/master] Sync with 2.3.3

While there is an option to add all remote-tracking branches (-r), and
another to add all local+remote branches (-a), there is no option to add
only local branches. Adding such an option could be considered, but a
user would likely already expect that the above command line considers
the lack of rev other than for --topics as meaning all local branches,
like when there is no argument at all.

Moreover, when using -r and -a along with --topics, the first local or
remote-tracking branch, depending on alphabetic order is used instead of
the one given after --topics (any rev given on the command line is
actually simply ignored when either -r or -a is given). And if no rev is
given at all, the fact that the first alphetical branch is the base of
topics is probably not expected by users (Maybe --topics should always
require one rev on the command line?)

This change makes
  "show-branch --topics $rev"
act as
  "show-branch --topics $rev $(git for-each-ref refs/heads
                               --format='%(refname:short)')"

  "show-branch -r --topics $rev ..."
act as
  "show-branch --topics $rev ... $(git for-each-ref refs/remotes
                                   --format='%(refname:short)')"
instead of
  "show-branch --topics $(git for-each-ref refs/remotes
                          --format='%(refname:short)')"

and
  "show-branch -a --topics $rev ..."
act as
  "show-branch --topics $rev ... $(git for-each-ref refs/heads refs/remotes
                                   --format='%(refname:short)')"
instead of
  "show-branch --topics $(git for-each-ref refs/heads refs/remotes
                          --format='%(refname:short)')"

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 builtin/show-branch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index f3fb5fb..e69fb7c 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -718,7 +718,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	}
 
 	/* If nothing is specified, show all branches by default */
-	if (ac + all_heads + all_remotes == 0)
+	if (ac <= topics && all_heads + all_remotes == 0)
 		all_heads = 1;
 
 	if (reflog) {
@@ -785,13 +785,13 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		}
 		free(ref);
 	}
-	else if (all_heads + all_remotes)
-		snarf_refs(all_heads, all_remotes);
 	else {
 		while (0 < ac) {
 			append_one_rev(*av);
 			ac--; av++;
 		}
+		if (all_heads + all_remotes)
+			snarf_refs(all_heads, all_remotes);
 	}
 
 	head_p = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
-- 
2.4.0.rc0.1.g7f94b17
