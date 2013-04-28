From: Ilya Basin <basinilya@gmail.com>
Subject: [PATCH 2/5] git-svn-test: don't test for possible bug "Failed to
 strip path", try #3
Date: Mon, 29 Apr 2013 00:10:53 +0400
Message-ID: <5180046d.6905700a.65c8.00b5@mx.google.com>
Cc: Ray Chen <rchen@cs.umd.edu>, Eric Wong <normalperson@yhbt.net>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 30 19:50:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXEhQ-00044j-Mb
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 19:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760848Ab3D3Ruk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 13:50:40 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:44857 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759165Ab3D3Ruj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 13:50:39 -0400
Received: by mail-lb0-f170.google.com with SMTP id r10so791068lbi.1
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:from:date:subject:to:cc;
        bh=+wp9jN1SIFYZ37WrQcZtvtMUANpO675anj22Tq8GoN8=;
        b=WSm32cnSrGe1Pf6WMCjA7vhUNMjZnGfNFFYDKHrT4cEspGfQ1XWXxNIs5Pa7ZV7NWO
         gzEuE+iwqRdgrlORmhMBIw3tKqVM4Emi17VXHU4nNPo7FPY09EY+r+1d6q9HwBp+U/tG
         PzbRteBXwOo5xomf7X4d8onrU6PjYRjxZsLk2Cxsfl5NPTL/Ufm4efqqyq8nUZfmi0Cd
         f6dDaID6P9m+oVwYjNW899a7YceJcIJhuvftw6E96DS3vYs1c3Wbkj+5pxwWoDN9dWOC
         OGrQ/xImHX56PAQr9lOA4mpyMllSaGvync1+94bRwY9BUtMLlyNTHpbeVtJjLNAO9fQq
         +2Yg==
X-Received: by 10.112.136.161 with SMTP id qb1mr14692729lbb.134.1367344238130;
        Tue, 30 Apr 2013 10:50:38 -0700 (PDT)
Received: from [192.168.0.78] ([178.71.111.32])
        by mx.google.com with ESMTPSA id r9sm18577lbr.3.2013.04.30.10.50.36
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 10:50:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222969>

In the previous commit a showcase was added to
t9160-git-svn-preserve-empty-dirs.sh for the "Failed to strip path" bug.
Now the flag --stdlayout should be enough.
---
 t/t9160-git-svn-preserve-empty-dirs.sh | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/t/t9160-git-svn-preserve-empty-dirs.sh b/t/t9160-git-svn-preserve-empty-dirs.sh
index 1b5a286..43b1852 100755
--- a/t/t9160-git-svn-preserve-empty-dirs.sh
+++ b/t/t9160-git-svn-preserve-empty-dirs.sh
@@ -51,21 +51,13 @@ test_expect_success 'initialize source svn repo containing empty dirs' '
 		echo "Conflict file" > 5/.placeholder &&
 		mkdir 6/.placeholder &&
 		svn_cmd add 5/.placeholder 6/.placeholder &&
-		svn_cmd commit -m "Placeholder Namespace conflict" &&
-
-		echo x > fil.txt &&
-		svn_cmd add fil.txt &&
-		svn_cmd commit -m "this commit should not kill git-svn"
+		svn_cmd commit -m "Placeholder Namespace conflict"
 	) &&
 	rm -rf "$SVN_TREE"
 '
 
 test_expect_success 'clone svn repo with --preserve-empty-dirs --stdlayout' '
-	git svn clone "$svnrepo" --preserve-empty-dirs --stdlayout "$GIT_REPO" || (
-		cd "$GIT_REPO"
-		git svn fetch # fetch the rest can succeed even if clone failed
-		false # this test still failed
-	)
+	git svn clone "$svnrepo" --preserve-empty-dirs --stdlayout "$GIT_REPO"
 '
 
 # "$GIT_REPO"/1 should only contain the placeholder file.
@@ -89,11 +81,11 @@ test_expect_success 'add entry to previously empty directory' '
 	test -f "$GIT_REPO"/4/a/b/c/foo
 '
 
-# The HEAD~3 commit should not have introduced .gitignore placeholder files.
+# The HEAD~2 commit should not have introduced .gitignore placeholder files.
 test_expect_success 'remove non-last entry from directory' '
 	(
 		cd "$GIT_REPO" &&
-		git checkout HEAD~3
+		git checkout HEAD~2
 	) &&
 	test_must_fail test -f "$GIT_REPO"/2/.gitignore &&
 	test_must_fail test -f "$GIT_REPO"/3/.gitignore
-- 
1.8.1.5
