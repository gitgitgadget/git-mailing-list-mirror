From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH 2/2] git-svn.perl: keep processing all commits in parents_exclude
Date: Wed, 23 May 2012 20:40:45 -0400
Message-ID: <1337820046-4791-2-git-send-email-stevenrwalter@gmail.com>
References: <1337820046-4791-1-git-send-email-stevenrwalter@gmail.com>
Cc: Steven Walter <stevenrwalter@gmail.com>
To: normalperson@yhbt.net, avarab@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 24 03:03:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXMSB-0007nI-Md
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 03:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171Ab2EXBCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 21:02:55 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:52119 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357Ab2EXBCy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 21:02:54 -0400
Received: by gglu4 with SMTP id u4so7211496ggl.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 18:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=MruU66GsMqUFg23eiIK3kSup0CRr3Dw9S9Jos9iFcAw=;
        b=u+dTeWui9mMx7U6fbitgQwFZb+4oUnQ6XTnT0+1rk3rp7vOvUU8wwr1K/1+uOawUn0
         3UweqMjLQUcebIMVmDWjwh8XMAAxLdW3UiFJt3BbUxroSTtVI5zZYl+HXAB2zVQMWb5V
         7EJFo5tIcKADGOt0eyqiSwB31lI+kH5Vaf90q+0fI1Xfufcs3GKfveAQ/MdzEs8LIsOY
         62g4STz+yVD0jJdsOyWzmrrDX2NLMPnzxovR46rKT0eEOKzfIOx+2iX73X/srFhdcmty
         CFzUTKNfoeMLTDUDaD8dDb/Pf1mmIfzIHuX8WDUPD7QHIYPBMdnM5gVfyTJTRuUh2WrH
         T4EQ==
Received: by 10.101.176.19 with SMTP id d19mr10587349anp.38.1337821373705;
        Wed, 23 May 2012 18:02:53 -0700 (PDT)
Received: from brock (adsl-184-43-63-84.bgk.bellsouth.net. [184.43.63.84])
        by mx.google.com with ESMTPS id i16sm45179006anm.12.2012.05.23.18.02.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 May 2012 18:02:52 -0700 (PDT)
Received: from srwalter by brock with local (Exim 4.76)
	(envelope-from <srwalter@brock>)
	id 1SXM6h-0001Fq-5w; Wed, 23 May 2012 20:40:47 -0400
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1337820046-4791-1-git-send-email-stevenrwalter@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198338>

This fixes a bug where git finds the incorrect merge parent.  Consider a
repository with trunk, branch1 of trunk, and branch2 of branch1.
Without this change, git interprets a merge of branch2 into trunk as a
merge of branch1 into trunk.

Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
---
 git-svn.perl                                     |    1 -
 t/t9164-git-svn-fetch-merge-branch-of-branch2.sh |   53 ++++++++++++++++++++++
 2 files changed, 53 insertions(+), 1 deletion(-)
 create mode 100755 t/t9164-git-svn-fetch-merge-branch-of-branch2.sh

diff --git a/git-svn.perl b/git-svn.perl
index abcec11..c4678c1 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3623,7 +3623,6 @@ sub parents_exclude {
 				if ( $commit eq $excluded ) {
 					push @excluded, $commit;
 					$found++;
-					last;
 				}
 				else {
 					push @new, $commit;
diff --git a/t/t9164-git-svn-fetch-merge-branch-of-branch2.sh b/t/t9164-git-svn-fetch-merge-branch-of-branch2.sh
new file mode 100755
index 0000000..fb48882
--- /dev/null
+++ b/t/t9164-git-svn-fetch-merge-branch-of-branch2.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Steven Walter
+#
+
+test_description='git svn merge detection'
+. ./lib-git-svn.sh
+
+svn_ver="$(svn --version --quiet)"
+case $svn_ver in
+0.* | 1.[0-4].*)
+	skip_all="skipping git-svn test - SVN too old ($svn_ver)"
+	test_done
+	;;
+esac
+
+test_expect_success 'initialize source svn repo' '
+	svn_cmd mkdir -m x "$svnrepo"/trunk &&
+	svn_cmd mkdir -m x "$svnrepo"/branches &&
+	svn_cmd co "$svnrepo"/trunk "$SVN_TREE" &&
+	(
+		cd "$SVN_TREE" &&
+		touch foo &&
+		svn add foo &&
+		svn commit -m "initial commit" &&
+		svn cp -m branch "$svnrepo"/trunk "$svnrepo"/branches/branch1 &&
+		svn switch "$svnrepo"/branches/branch1 &&
+		touch bar &&
+		svn add bar &&
+		svn commit -m branch1 &&
+		svn cp -m branch "$svnrepo"/branches/branch1 "$svnrepo"/branches/branch2 &&
+		svn switch "$svnrepo"/branches/branch2 &&
+		touch baz &&
+		svn add baz &&
+		svn commit -m branch2 &&
+		svn switch "$svnrepo"/trunk &&
+		svn merge --reintegrate "$svnrepo"/branches/branch2 &&
+		svn commit -m "merge branch2"
+	) &&
+	rm -rf "$SVN_TREE"
+'
+
+test_expect_success 'clone svn repo' '
+	git svn init -s "$svnrepo" &&
+	git svn fetch
+'
+
+test_expect_success 'verify merge commit' 'x=$(git rev-parse HEAD^2) &&
+	y=$(git rev-parse branch2) &&
+	[ $x == $y ]
+'
+
+test_done
-- 
1.7.9.5
