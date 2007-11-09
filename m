From: Jonas Fonseca <fonseca@diku.dk>
Subject: [BUG] git-rebase fails when a commit message contains a diff
Date: Fri, 9 Nov 2007 02:12:14 +0100
Message-ID: <20071109011214.GA5903@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 02:12:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqIQD-00071D-QN
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbXKIBMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 20:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754273AbXKIBMS
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 20:12:18 -0500
Received: from mgw2.diku.dk ([130.225.96.92]:54273 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751646AbXKIBMR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 20:12:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 4BF9719BB5D
	for <git@vger.kernel.org>; Fri,  9 Nov 2007 02:12:16 +0100 (CET)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22420-01 for <git@vger.kernel.org>; Fri,  9 Nov 2007 02:12:14 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 9E46019BB57
	for <git@vger.kernel.org>; Fri,  9 Nov 2007 02:12:14 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP id 4B37D6E0129
	for <git@vger.kernel.org>; Fri,  9 Nov 2007 02:11:53 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 78E945B8001; Fri,  9 Nov 2007 02:12:14 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64100>

I have concocted a test that illustrates the problem: patch below.  The problem
is that the patches in .dotest are not properly formatted to make it easy to
distinguish commit message from commit diff.

When running the test git-rebase fails with:

	Applying Test message with diff in it
	error: config: does not exist in index
	fatal: sha1 information is lacking or useless (config).
	Repository lacks necessary blobs to fall back on 3-way merge.
	Cannot fall back to three-way merge.
	Patch failed at 0004.

By modifying the test below, a similar problem related with handling of the
end-of-message marker (---\n) can be exposed. A commit message that contains
this marker and text afterwards ends up only having the text preceeding the
marker.

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 95e33b5..75babdb 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -83,4 +83,25 @@ test_expect_success 'rebase a single mode change' '
      GIT_TRACE=1 git rebase master
 '
 
+cat >commitdiff-message <<EOF
+Test message with diff in it
+
+--- .git/config	2007-11-02 22:44:55.000000000 +0100
++++ .git/config+	2007-11-09 01:40:30.000000000 +0100
+@@ -1,3 +1,4 @@
++# Broken
+ [core]
+ 	repositoryformatversion = 0
+ 	filemode = true
+EOF
+
+test_expect_success 'rebase commit with diff in the commit message' \
+'
+     git checkout -b diff-msg upstream-merged-nonlinear &&
+     echo 1 > W &&
+     git add W &&
+     git commit -F commitdiff-message &&
+     git rebase master
+'
+
 test_done

-- 
Jonas Fonseca
