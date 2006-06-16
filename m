From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/4] git-svn: tests no longer fail if LC_ALL is not a UTF-8 locale
Date: Fri, 16 Jun 2006 10:57:24 -0700
Message-ID: <11504806481800-git-send-email-normalperson@yhbt.net>
References: <11504049343825-git-send-email-normalperson@yhbt.net> <11504806463470-git-send-email-normalperson@yhbt.net> <11504806472857-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jun 16 19:57:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrIZi-0006lH-6e
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 19:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWFPR5b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 13:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWFPR5b
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 13:57:31 -0400
Received: from hand.yhbt.net ([66.150.188.102]:10980 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751199AbWFPR5a (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 13:57:30 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id C2B657DC023;
	Fri, 16 Jun 2006 10:57:28 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 16 Jun 2006 10:57:28 -0700
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11504806472857-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21956>

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/Makefile                   |    5 +++--
 contrib/git-svn/t/t0000-contrib-git-svn.sh |    8 ++++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/contrib/git-svn/Makefile b/contrib/git-svn/Makefile
index d73aa56..6aedb10 100644
--- a/contrib/git-svn/Makefile
+++ b/contrib/git-svn/Makefile
@@ -32,9 +32,10 @@ test: git-svn
 	cd t && $(SHELL) ./t0000-contrib-git-svn.sh $(TEST_FLAGS)
 	cd t && $(SHELL) ./t0001-contrib-git-svn-props.sh $(TEST_FLAGS)
 
+# we can test NO_OPTIMIZE_COMMITS independently of LC_ALL
 full-test:
-	$(MAKE) test GIT_SVN_NO_LIB=1 GIT_SVN_NO_OPTIMIZE_COMMITS=1
-	$(MAKE) test GIT_SVN_NO_LIB=0 GIT_SVN_NO_OPTIMIZE_COMMITS=1
+	$(MAKE) test GIT_SVN_NO_LIB=1 GIT_SVN_NO_OPTIMIZE_COMMITS=1 LC_ALL=C
+	$(MAKE) test GIT_SVN_NO_LIB=0 GIT_SVN_NO_OPTIMIZE_COMMITS=1 LC_ALL=C
 	$(MAKE) test GIT_SVN_NO_LIB=1 GIT_SVN_NO_OPTIMIZE_COMMITS=0 \
 							LC_ALL=en_US.UTF-8
 	$(MAKE) test GIT_SVN_NO_LIB=0 GIT_SVN_NO_OPTIMIZE_COMMITS=0 \
diff --git a/contrib/git-svn/t/t0000-contrib-git-svn.sh b/contrib/git-svn/t/t0000-contrib-git-svn.sh
index f896e2c..0f52746 100644
--- a/contrib/git-svn/t/t0000-contrib-git-svn.sh
+++ b/contrib/git-svn/t/t0000-contrib-git-svn.sh
@@ -194,8 +194,12 @@ test_expect_success "$name" \
      diff -u a b"
 
 name='check imported tree checksums expected tree checksums'
-cat > expected <<\EOF
-tree f735671b89a7eb30cab1d8597de35bd4271ab813
+rm -f expected
+if test -n "$GIT_SVN_LC_ALL" && echo $GIT_SVN_LC_ALL | grep -q '\.UTF-8$'
+then
+	echo tree f735671b89a7eb30cab1d8597de35bd4271ab813 > expected
+fi
+cat >> expected <<\EOF
 tree 4b9af72bb861eaed053854ec502cf7df72618f0f
 tree 031b8d557afc6fea52894eaebb45bec52f1ba6d1
 tree 0b094cbff17168f24c302e297f55bfac65eb8bd3
-- 
1.4.0
