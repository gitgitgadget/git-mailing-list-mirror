From: Karl Chen <quarl@cs.berkeley.edu>
Subject: [PATCH] Support diff.autorefreshindex=true in `git-diff --quiet'
Date: Mon, 01 Sep 2008 01:29:27 -0700
Message-ID: <quack.20080901T0129.lth8wuci80o@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 01 10:30:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka4o2-0001h5-LJ
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 10:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbYIAI3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 04:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbYIAI3c
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 04:29:32 -0400
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:47775 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064AbYIAI3c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 04:29:32 -0400
Received: by roar.quarl.org (Postfix, from userid 18378)
	id 8E84C34497; Mon,  1 Sep 2008 01:29:27 -0700 (PDT)
X-Quack-Archive: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94542>


When diff.autorefreshindex is true, if a file has merely been 'touched' (mtime
changed, but contents unchanged), then `git-diff --quiet' will now return 0
(indicating no change) instead of 1, and also silently refresh the index.

Signed-off-by: Karl Chen <quarl@quarl.org>
---

In current git master:
   
  git init
  echo abc > file1
  git add file1
  git commit -m msg
   
  sleep 1; touch file1
   
  git diff --exit-code --quiet file1
  echo $?
      # 1 [I expected 0]
   
  git diff --exit-code file1
  echo $?
      # 0 [as expected]
   
  git diff --exit-code --quiet file1
  echo $?
      # 0 [the non-quiet diff refreshed the cache]

I think `git diff --quiet file1' should return 0 when file1 only
differs by mtime.  I got this to work by having diffcore_std()
call diffcore_skip_stat_unmatch() even when --quiet is specified.
(I'm not sure about interaction with the other options.)


 diff.c |   34 ++++++++++++++++++----------------
 1 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/diff.c b/diff.c
index 135dec4..986cec3 100644
--- a/diff.c
+++ b/diff.c
@@ -3386,22 +3386,24 @@ static void diffcore_skip_stat_unmatch(struct diff_options *diffopt)
 
 void diffcore_std(struct diff_options *options)
 {
-	if (DIFF_OPT_TST(options, QUIET))
-		return;
-
-	if (options->skip_stat_unmatch && !DIFF_OPT_TST(options, FIND_COPIES_HARDER))
-		diffcore_skip_stat_unmatch(options);
-	if (options->break_opt != -1)
-		diffcore_break(options->break_opt);
-	if (options->detect_rename)
-		diffcore_rename(options);
-	if (options->break_opt != -1)
-		diffcore_merge_broken();
-	if (options->pickaxe)
-		diffcore_pickaxe(options->pickaxe, options->pickaxe_opts);
-	if (options->orderfile)
-		diffcore_order(options->orderfile);
-	diff_resolve_rename_copy();
+	if (DIFF_OPT_TST(options, QUIET)) {
+		if (options->skip_stat_unmatch)
+			diffcore_skip_stat_unmatch(options);
+	} else {
+		if (options->skip_stat_unmatch && !DIFF_OPT_TST(options, FIND_COPIES_HARDER))
+			diffcore_skip_stat_unmatch(options);
+		if (options->break_opt != -1)
+			diffcore_break(options->break_opt);
+		if (options->detect_rename)
+			diffcore_rename(options);
+		if (options->break_opt != -1)
+			diffcore_merge_broken();
+		if (options->pickaxe)
+			diffcore_pickaxe(options->pickaxe, options->pickaxe_opts);
+		if (options->orderfile)
+			diffcore_order(options->orderfile);
+		diff_resolve_rename_copy();
+	}
 	diffcore_apply_filter(options->filter);
 
 	if (diff_queued_diff.nr)
-- 
1.5.6.3
