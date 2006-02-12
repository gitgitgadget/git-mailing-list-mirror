From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] avoid echo -e, there are systems where it does not work
Date: Sun, 12 Feb 2006 19:05:34 +0100
Message-ID: <20060212180534.GB3322@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 12 19:05:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8LbT-0008P7-S8
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 19:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWBLSFl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 13:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWBLSFl
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 13:05:41 -0500
Received: from devrace.com ([198.63.210.113]:25093 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1750806AbWBLSFk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 13:05:40 -0500
Received: from tigra.home (p54A06C50.dip.t-dialin.net [84.160.108.80])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k1CI5ZwA067824;
	Sun, 12 Feb 2006 12:05:36 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1F8LbL-0005g2-00; Sun, 12 Feb 2006 19:05:35 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1F8LbL-0000rs-03; Sun, 12 Feb 2006 19:05:35 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16004>

FreeBSD 4.11 being one example: the built-in echo doesn't have -e,
and the installed /bin/echo does not do "-e" as well.
"printf" works, laking just "\e" and "\xAB'.

---

 git-tag.sh                         |    3 ++-
 t/t3001-ls-files-others-exclude.sh |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

b155e96dcb988b2533e8546666d0f045a36f594d
diff --git a/git-tag.sh b/git-tag.sh
index 6d0c973..c74e1b4 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -85,7 +85,8 @@ if [ "$annotate" ]; then
 	exit 1
     }
 
-    ( echo -e "object $object\ntype $type\ntag $name\ntagger $tagger\n";
+    ( printf 'object %s\ntype %s\ntag %s\ntagger %s\n\n' \
+	"$object" "$type" "$name" "$tagger";
       cat "$GIT_DIR"/TAG_FINALMSG ) >"$GIT_DIR"/TAG_TMP
     rm -f "$GIT_DIR"/TAG_TMP.asc "$GIT_DIR"/TAG_FINALMSG
     if [ "$signed" ]; then
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index fde2bb2..6979b7c 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -68,7 +68,7 @@ test_expect_success \
      diff -u expect output'
 
 # Test \r\n (MSDOS-like systems)
-echo -ne '*.1\r\n/*.3\r\n!*.6\r\n' >.gitignore
+printf '*.1\r\n/*.3\r\n!*.6\r\n' >.gitignore
 
 test_expect_success \
     'git-ls-files --others with \r\n line endings.' \
-- 
1.1.6.gd46b
