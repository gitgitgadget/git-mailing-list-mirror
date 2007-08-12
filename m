From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] diff: don't run pager if user asked for a diff style exit
 code
Date: Sun, 12 Aug 2007 19:46:55 +0200
Message-ID: <46BF478F.7030603@lsrfire.ath.cx>
References: <17875.88.10.191.55.1186873960.squirrel@secure.wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Aug 12 19:47:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKHWx-0002mj-Lh
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 19:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765157AbXHLRrI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 13:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764726AbXHLRrH
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 13:47:07 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:37206
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1765033AbXHLRrF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 13:47:05 -0400
Received: from [10.0.1.201] (p508ED523.dip.t-dialin.net [80.142.213.35])
	by neapel230.server4you.de (Postfix) with ESMTP id 860D38B008;
	Sun, 12 Aug 2007 19:47:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <17875.88.10.191.55.1186873960.squirrel@secure.wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55694>

As Wincent Colaiuta found out, it's a bit unexpected for git diff to
start a pager even when the --quiet option is specified.  The problem
is that the pager hides the return code -- which is the only output
we're interested in in this case.

Push pager setup down into builtin-diff.c and don't start the pager
if --exit-code or --quiet (which implies --exit-code) was specified.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

 builtin-diff.c |    6 ++++++
 git.c          |    2 +-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index b48121e..8dc17b0 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -235,6 +235,12 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	rev.diffopt.allow_external = 1;
 	rev.diffopt.recursive = 1;
 
+	/* If the user asked for our exit code then don't start a
+	 * pager or we would end up reporting its exit code instead.
+	 */
+	if (!rev.diffopt.exit_with_status)
+		setup_pager();
+
 	/* Do we have --cached and not have a pending object, then
 	 * default to HEAD by hand.  Eek.
 	 */
diff --git a/git.c b/git.c
index e5daae0..cab0e72 100644
--- a/git.c
+++ b/git.c
@@ -325,7 +325,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "config", cmd_config },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
 		{ "describe", cmd_describe, RUN_SETUP },
-		{ "diff", cmd_diff, USE_PAGER },
+		{ "diff", cmd_diff },
 		{ "diff-files", cmd_diff_files },
 		{ "diff-index", cmd_diff_index, RUN_SETUP },
 		{ "diff-tree", cmd_diff_tree, RUN_SETUP },
