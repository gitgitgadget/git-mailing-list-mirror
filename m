From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH v3 2/2] git-svn.perl: keep processing all commits in parents_exclude
Date: Sat, 11 Aug 2012 13:14:25 -0400
Message-ID: <1344705265-10939-2-git-send-email-stevenrwalter@gmail.com>
References: <1344705265-10939-1-git-send-email-stevenrwalter@gmail.com>
Cc: Steven Walter <stevenrwalter@gmail.com>
To: normalperson@yhbt.net, avarab@gmail.com, sam@vilain.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 11 19:15:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0FHJ-0002oE-Nj
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 19:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430Ab2HKROW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Aug 2012 13:14:22 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44240 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270Ab2HKROU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2012 13:14:20 -0400
Received: by obbuo13 with SMTP id uo13so4058912obb.19
        for <git@vger.kernel.org>; Sat, 11 Aug 2012 10:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=cPT9CKSx71uSJ1ZHtFiOwsWfMf/GBsekz7qsgGJ0dS4=;
        b=Hck+0F7u3nYEvzMHN+d5BjNl+Xlfnl+E7GzPWG9CCnBKMHgVXiSt/190SXKgSY101S
         hUs2uW9f2P5lH0AYTFg733pfWYlqdDKSFUYLrT6Uh6kFaEx5fzrBJnVD8k0EaRCmEXxN
         LlhBmPVTa3Yc8Gle+cRqyJYhxUCj8R0R3n0izvP+S8sgE/adepHX+tbU+pL5s+rF+go1
         Nc/ozN2bfwI1qflh9YeHt2t+RteayCC2Kkb4a/fJhcQbECNNIwtTumSP3nHXf87tn6Zh
         2bK9LYLfkd8UilCr18FHrl+hp1hdeLIkuk+Bd27Q5KBfRKO/6+IMueQio700DFyllEQt
         y5PQ==
Received: by 10.50.186.196 with SMTP id fm4mr1490377igc.1.1344705259642;
        Sat, 11 Aug 2012 10:14:19 -0700 (PDT)
Received: from brock (CPE-76-177-45-54.natcky.res.rr.com. [76.177.45.54])
        by mx.google.com with ESMTPS id ai6sm4293376igc.0.2012.08.11.10.14.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Aug 2012 10:14:18 -0700 (PDT)
Received: by brock (Postfix, from userid 1000)
	id C2B34261E12; Sat, 11 Aug 2012 13:14:26 -0400 (EDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1344705265-10939-1-git-send-email-stevenrwalter@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203296>

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
index 0000000..af0ec0e
--- /dev/null
+++ b/t/t9164-git-svn-fetch-merge-branch-of-branch2.sh
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
