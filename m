From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/3] Catch early trying rebasing to unknown ref,
	and add testcase.
Date: Thu, 07 Jun 2007 00:01:47 +0200
Message-ID: <20070606220147.18635.81773.stgit@gandelf.nowhere.earth>
References: <20070606215922.18635.38379.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 00:01:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw3Zg-0007yu-2X
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 00:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935196AbXFFWBq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 18:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755655AbXFFWBq
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 18:01:46 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:60897 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172AbXFFWBp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 18:01:45 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 9DF515A121;
	Thu,  7 Jun 2007 00:01:44 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 863BB1F019;
	Thu,  7 Jun 2007 00:01:47 +0200 (CEST)
In-Reply-To: <20070606215922.18635.38379.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49323>


Signed-off-by: Yann Dirson <ydirson@altern.org>

---

 stgit/commands/rebase.py |    4 ++++
 t/t2200-rebase.sh        |   12 ++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/stgit/commands/rebase.py b/stgit/commands/rebase.py
index d132b60..2f0e660 100644
--- a/stgit/commands/rebase.py
+++ b/stgit/commands/rebase.py
@@ -52,6 +52,10 @@ def func(parser, options, args):
     check_conflicts()
     check_head_top_equal()
 
+    # ensure an exception is raised before popping on non-existent target
+    if git_id(args[0]) == None:
+        raise GitException, 'Unknown revision: %s' % git_id
+        
     applied = prepare_rebase(real_rebase=True, force=options.force)
     rebase(args[0])
     post_rebase(applied, options.nopush, options.merged)
diff --git a/t/t2200-rebase.sh b/t/t2200-rebase.sh
index 882572c..c142e08 100755
--- a/t/t2200-rebase.sh
+++ b/t/t2200-rebase.sh
@@ -31,4 +31,16 @@ test_expect_success \
 	test `stg applied | wc -l` = 1
 	'
 
+test_expect_failure \
+	'Attempt rebase to non-existing commit' \
+	'
+	stg rebase not-a-ref
+	'
+
+test_expect_success \
+	'Check patches were re-applied' \
+	'
+	test $(stg applied | wc -l) = 1
+	'
+
 test_done
