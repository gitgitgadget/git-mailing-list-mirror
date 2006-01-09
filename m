From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] GIT-VERSION-GEN: allow overriding from Makefile
Date: Mon, 09 Jan 2006 15:01:04 -0800
Message-ID: <7vpsn1f1lb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 10 00:01:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew60j-0003VT-Tk
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 00:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbWAIXBH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 18:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbWAIXBH
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 18:01:07 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:51157 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751617AbWAIXBG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2006 18:01:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060109225953.HZPU20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 9 Jan 2006 17:59:53 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14383>

The RPM building procedure relied on being able to build from a
freshly untarred tarball, so there is no way "git describe"
could figure out from which commit it is building (there was no
HEAD).

This still does not allow you to build RPM binary package from
an untagged interim version because RPM does not like '-' in
version number, but that probably is a blessing.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * For 1.1.1; the binary in 1.1.0 RPM was affected with this bug.

 GIT-VERSION-GEN |   13 +++++++++----
 Makefile        |    2 +-
 2 files changed, 10 insertions(+), 5 deletions(-)

1900d64cbecf46844dd7910d78676e0cace7139e
diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 845b9dc..c878819 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -2,8 +2,15 @@
 
 GVF=GIT-VERSION-FILE
 
-VN=$(git-describe --abbrev=4 HEAD 2>/dev/null) || VN=v1.0.GIT
-VN=$(expr "$VN" : v'\(.*\)')
+case "${VN+set}" in
+set)
+	;;
+*)
+	VN=$(git-describe --abbrev=4 HEAD 2>/dev/null) || VN=v1.0.GIT
+	VN=$(expr "$VN" : v'\(.*\)')
+	;;
+esac
+
 if test -r $GVF
 then
 	VC=$(sed -e 's/^GIT_VERSION = //' <$GVF)
@@ -14,5 +21,3 @@ test "$VN" = "$VC" || {
 	echo >&2 "GIT_VERSION = $VN"
 	echo "GIT_VERSION = $VN" >$GVF
 }
-
-
diff --git a/Makefile b/Makefile
index c9c15b5..0bbb5b8 100644
--- a/Makefile
+++ b/Makefile
@@ -494,7 +494,7 @@ dist: git.spec git-tar-tree
 	gzip -f -9 $(GIT_TARNAME).tar
 
 rpm: dist
-	$(RPMBUILD) -ta $(GIT_TARNAME).tar.gz
+	VN=$(GIT_VERSION) $(RPMBUILD) -ta $(GIT_TARNAME).tar.gz
 
 ### Cleaning rules
 
-- 
1.1.0
