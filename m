X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/2] git-svn: update tests for recent changes
Date: Mon, 27 Nov 2006 21:46:50 -0800
Message-ID: <20061128054650.GB396@soma>
References: <loom.20061124T143148-286@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 05:47:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <loom.20061124T143148-286@post.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32486>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Govnz-0002cp-GH for gcvg-git@gmane.org; Tue, 28 Nov
 2006 06:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935633AbWK1Fqw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 00:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935634AbWK1Fqw
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 00:46:52 -0500
Received: from hand.yhbt.net ([66.150.188.102]:13034 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S935633AbWK1Fqw (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 00:46:52 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 7CF1A2DC034; Mon, 27 Nov 2006 21:46:50 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 27 Nov 2006
 21:46:50 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

* Enable test for delta transfers in full-svn-test.

* Run tests against the root of the repository so we won't have
  to revisit 308906fa6e98132cab839a4f42701386fba368ef and
  efe4631def181d32f932672a7ea31e52ee0ab308 again.
  The graft-branches test still runs as before.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/Makefile                        |    3 ++-
 t/lib-git-svn.sh                  |    2 +-
 t/t9100-git-svn-basic.sh          |    5 +++++
 t/t9103-git-svn-graft-branches.sh |    2 ++
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 8983509..0abe66d 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -27,8 +27,9 @@ clean:
 
 # we can test NO_OPTIMIZE_COMMITS independently of LC_ALL
 full-svn-test:
+	$(MAKE) $(TSVN) GIT_SVN_NO_LIB=0 GIT_SVN_DELTA_FETCH=1 \
+					GIT_SVN_NO_OPTIMIZE_COMMITS=1 LC_ALL=C
 	$(MAKE) $(TSVN) GIT_SVN_NO_LIB=1 GIT_SVN_NO_OPTIMIZE_COMMITS=1 LC_ALL=C
-	$(MAKE) $(TSVN) GIT_SVN_NO_LIB=0 GIT_SVN_NO_OPTIMIZE_COMMITS=1 LC_ALL=C
 	$(MAKE) $(TSVN) GIT_SVN_NO_LIB=1 GIT_SVN_NO_OPTIMIZE_COMMITS=0 \
 							LC_ALL=en_US.UTF-8
 	$(MAKE) $(TSVN) GIT_SVN_NO_LIB=0 GIT_SVN_NO_OPTIMIZE_COMMITS=0 \
diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 29a1e72..63c6703 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -45,6 +45,6 @@ else
 	svnadmin create "$svnrepo"
 fi
 
-svnrepo="file://$svnrepo/test-git-svn"
+svnrepo="file://$svnrepo"
 
 
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 34a3ccd..f9de232 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -228,6 +228,11 @@ tree 56a30b966619b863674f5978696f4a3594f
 tree d667270a1f7b109f5eb3aaea21ede14b56bfdd6e
 tree 8f51f74cf0163afc9ad68a4b1537288c4558b5a4
 EOF
+
+if test -z "$GIT_SVN_NO_LIB" || test "$GIT_SVN_NO_LIB" -eq 0; then
+	echo tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904 >> expected
+fi
+
 test_expect_success "$name" "diff -u a expected"
 
 test_done
diff --git a/t/t9103-git-svn-graft-branches.sh b/t/t9103-git-svn-graft-branches.sh
index cc62d4e..293b98f 100755
--- a/t/t9103-git-svn-graft-branches.sh
+++ b/t/t9103-git-svn-graft-branches.sh
@@ -1,6 +1,8 @@
 test_description='git-svn graft-branches'
 . ./lib-git-svn.sh
 
+svnrepo="$svnrepo/test-git-svn"
+
 test_expect_success 'initialize repo' "
 	mkdir import &&
 	cd import &&
-- 
1.4.4.1.g22a08
