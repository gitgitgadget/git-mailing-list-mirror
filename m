From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH 2/2] git-svn.perl: keep processing all commits in parents_exclude
Date: Sun, 19 Aug 2012 21:39:41 -0400
Message-ID: <1345426781-7754-2-git-send-email-stevenrwalter@gmail.com>
References: <20120819193356.GA6203@dcvr.yhbt.net>
 <1345426781-7754-1-git-send-email-stevenrwalter@gmail.com>
Cc: Steven Walter <stevenrwalter@gmail.com>
To: normalperson@yhbt.net, sam@vilain.net, avarab@gmail.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 03:44:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3H2r-0003G2-UA
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 03:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867Ab2HTBok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 21:44:40 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58336 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110Ab2HTBoi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 21:44:38 -0400
Received: by obbuo13 with SMTP id uo13so8816187obb.19
        for <git@vger.kernel.org>; Sun, 19 Aug 2012 18:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TgNys/+EK45EZR9eMiwbQhY+KAZR/ub2vJv6sin7InQ=;
        b=zDZ1DfdjXRHxOFUCfpL4NrquN2CzkkjK0l46G1SlJfQ/NBD1vp+XW3RnFARRS7ii/V
         FILN2MWHwwDeteum1y4HBhRWp3A6DQH7M1eePVsLlSB+8QAsrk5YFERuQ6K4IHQ/11HZ
         zLs5ExrHhi32U8J9sQTnqVjrUK1y2ZxtjYm8//aaVqJhNBf0rB4l2Wf6laa4xdWhgGGr
         /RdjyIzFsobe5giNc0FX4KyuXd0SB88hFNGAIr2zNQjflFw+RyMRKaB25aHXTI3ql+D2
         GMsufdQ+C4A4EJ6H4FgZHtr2jgAbNaKz1AmwANec8IPVxyN0aHR3Gpb083IyuQfKdqpq
         aBjg==
Received: by 10.50.202.73 with SMTP id kg9mr8339407igc.42.1345427077756;
        Sun, 19 Aug 2012 18:44:37 -0700 (PDT)
Received: from brock (CPE-76-177-45-54.natcky.res.rr.com. [76.177.45.54])
        by mx.google.com with ESMTPS id c3sm22969333iga.8.2012.08.19.18.44.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Aug 2012 18:44:36 -0700 (PDT)
Received: by brock (Postfix, from userid 1000)
	id BCEB92604BC; Sun, 19 Aug 2012 21:39:42 -0400 (EDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345426781-7754-1-git-send-email-stevenrwalter@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203751>

This fixes a bug where git finds the incorrect merge parent.  Consider a
repository with trunk, branch1 of trunk, and branch2 of branch1.
Without this change, git interprets a merge of branch2 into trunk as a
merge of branch1 into trunk.

Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
---
 perl/Git/SVN.pm                                  |    1 -
 t/t9166-git-svn-fetch-merge-branch-of-branch2.sh |   53 ++++++++++++++++++++++
 2 files changed, 53 insertions(+), 1 deletion(-)
 create mode 100755 t/t9166-git-svn-fetch-merge-branch-of-branch2.sh

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 2707003..e48ba46 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1661,7 +1661,6 @@ sub parents_exclude {
 				if ( $commit eq $excluded ) {
 					push @excluded, $commit;
 					$found++;
-					last;
 				}
 				else {
 					push @new, $commit;
diff --git a/t/t9166-git-svn-fetch-merge-branch-of-branch2.sh b/t/t9166-git-svn-fetch-merge-branch-of-branch2.sh
new file mode 100755
index 0000000..af0ec0e
--- /dev/null
+++ b/t/t9166-git-svn-fetch-merge-branch-of-branch2.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Steven Walter
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
+		svn_cmd add foo &&
+		svn_cmd commit -m "initial commit" &&
+		svn_cmd cp -m branch "$svnrepo"/trunk "$svnrepo"/branches/branch1 &&
+		svn_cmd switch "$svnrepo"/branches/branch1 &&
+		touch bar &&
+		svn_cmd add bar &&
+		svn_cmd commit -m branch1 &&
+		svn_cmd cp -m branch "$svnrepo"/branches/branch1 "$svnrepo"/branches/branch2 &&
+		svn_cmd switch "$svnrepo"/branches/branch2 &&
+		touch baz &&
+		svn_cmd add baz &&
+		svn_cmd commit -m branch2 &&
+		svn_cmd switch "$svnrepo"/trunk &&
+		svn_cmd merge --reintegrate "$svnrepo"/branches/branch2 &&
+		svn_cmd commit -m "merge branch2"
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
+	test "x$x" = "x$y"
+'
+
+test_done
-- 
1.7.9.5
