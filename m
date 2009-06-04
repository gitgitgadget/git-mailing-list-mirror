From: Matthias Andree <matthias.andree@gmx.de>
Subject: [PATCH v4] To make GIT-VERSION-FILE, search for git more widely
Date: Thu,  4 Jun 2009 02:12:08 +0200
Message-ID: <1244074328-20995-1-git-send-email-matthias.andree@gmx.de>
References: <200906022035.30081.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Matthias Andree <matthias.andree@gmx.de>
To: git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 02:12:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MC0ZG-0006nz-EF
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 02:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723AbZFDAMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 20:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753665AbZFDAMQ
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 20:12:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:41352 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753489AbZFDAMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 20:12:16 -0400
Received: (qmail invoked by alias); 04 Jun 2009 00:12:16 -0000
Received: from e179168167.adsl.alicedsl.de (EHLO mandree.no-ip.org) [85.179.168.167]
  by mail.gmx.net (mp062) with SMTP; 04 Jun 2009 02:12:16 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX19FVdQiv/BFQW0CkCGGNr2LGUgNfbLWQRSGDRKI6j
	sniQde8ZXDptUS
Received: by merlin.emma.line.org (Postfix, from userid 1000)
	id E10A5945D1; Thu,  4 Jun 2009 02:12:14 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.1.267.gd260a
In-Reply-To: <200906022035.30081.j6t@kdbg.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120668>

Situation: sudo make install can rebuilds the whole package even if
you've just built it before. For instance:

make configure
./configure    # defaults to --prefix=/usr/local
make all doc
sudo make install install-doc install-html # REBUILDS HAPPEN HERE

This causes the "sudo make install" to rebuild everything because it believes
the version had changed.  sudo strips $PATH for security reasons.

The underlying problem flow is:

1 - Makefile has "include GIT-VERSION-FILE", thus gmake builds
    GIT-VERSION-FILE early.
2 - GIT-VERSION-FILE depends on a .PHONY target (.FORCE-GIT-VERSION-FILE)
3 - Thus, GNU make *always* executes GIT-VERSION-GEN
4 - GIT-VERSION-GEN now, under the stripped $PATH, cannot find "git" and
    sees a different version number.
5 - GIT-VERSION-GEN notes the difference in versions and regenerates
    GIT-VERSION-FILE, with up-to-date timestamp.
6 - GNU make rebuilds everything because GIT-VERSION-FILE is new.

The patch makes GIT-VERSION-GEN look for git in $(prefix)/bin, then for
the newly built git$X executable, before falling back to plain "git" and
thus to the default version in GIT-VERSION-GEN. This increases chances
that we get the same version with the stripped $PATH and get away
without rebuild.

Junio C. Hamano suggested that we look into $(prefix)/bin before the
current work directory in order to aid cross-compiling.

Signed-off-by: Matthias Andree <matthias.andree@gmx.de>
---
 GIT-VERSION-GEN         |    9 ++++-----
 Makefile                |    6 +++++-
 git-gui/GIT-VERSION-GEN |   18 ++++++++++--------
 git-gui/Makefile        |    6 +++++-
 4 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 39cde78..2334cc1 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -2,6 +2,7 @@
 
 GVF=GIT-VERSION-FILE
 DEF_VER=v1.6.3.GIT
+type >/dev/null "$GIT" || GIT=git
 
 LF='
 '
@@ -12,12 +13,12 @@ if test -f version
 then
 	VN=$(cat version) || VN="$DEF_VER"
 elif test -d .git -o -f .git &&
-	VN=$(git describe --abbrev=4 HEAD 2>/dev/null) &&
+	VN=$($GIT describe --abbrev=4 HEAD 2>/dev/null) &&
 	case "$VN" in
 	*$LF*) (exit 1) ;;
 	v[0-9]*)
-		git update-index -q --refresh
-		test -z "$(git diff-index --name-only HEAD --)" ||
+		$GIT update-index -q --refresh
+		test -z "$($GIT diff-index --name-only HEAD --)" ||
 		VN="$VN-dirty" ;;
 	esac
 then
@@ -38,5 +39,3 @@ test "$VN" = "$VC" || {
 	echo >&2 "GIT_VERSION = $VN"
 	echo "GIT_VERSION = $VN" >$GVF
 }
-
-
diff --git a/Makefile b/Makefile
index 06c39e4..7adcf40 100644
--- a/Makefile
+++ b/Makefile
@@ -184,7 +184,11 @@ all::
 # programs as a tar, where bin/ and libexec/ might be on different file systems.
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
-	@$(SHELL_PATH) ./GIT-VERSION-GEN
+	@{ GIT=$(prefix)/bin/git$X ; test -x "$$GIT" ; } \
+	|| { GIT=./git$X ; test -x "$$GIT" ; } \
+	|| GIT=git ; \
+	export GIT ; \
+	$(SHELL_PATH) ./GIT-VERSION-GEN
 -include GIT-VERSION-FILE
 
 uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
diff --git a/git-gui/GIT-VERSION-GEN b/git-gui/GIT-VERSION-GEN
index b3f937e..729e93f 100755
--- a/git-gui/GIT-VERSION-GEN
+++ b/git-gui/GIT-VERSION-GEN
@@ -3,6 +3,8 @@
 GVF=GIT-VERSION-FILE
 DEF_VER=0.12.GITGUI
 
+type >/dev/null "$GIT" || GIT=git
+
 LF='
 '
 
@@ -10,10 +12,10 @@ tree_search ()
 {
 	head=$1
 	tree=$2
-	for p in $(git rev-list --parents --max-count=1 $head 2>/dev/null)
+	for p in $($GIT rev-list --parents --max-count=1 $head 2>/dev/null)
 	do
-		test $tree = $(git rev-parse $p^{tree} 2>/dev/null) &&
-		vn=$(git describe --abbrev=4 $p 2>/dev/null) &&
+		test $tree = $($GIT rev-parse $p^{tree} 2>/dev/null) &&
+		vn=$($GIT describe --abbrev=4 $p 2>/dev/null) &&
 		case "$vn" in
 		gitgui-[0-9]*) echo $vn; break;;
 		esac
@@ -38,10 +40,10 @@ if test -f version &&
    VN=$(cat version)
 then
 	: happy
-elif prefix="$(git rev-parse --show-prefix 2>/dev/null)"
+elif prefix="$($GIT rev-parse --show-prefix 2>/dev/null)"
    test -n "$prefix" &&
-   head=$(git rev-list --max-count=1 HEAD -- . 2>/dev/null) &&
-   tree=$(git rev-parse --verify "HEAD:$prefix" 2>/dev/null) &&
+   head=$($GIT rev-list --max-count=1 HEAD -- . 2>/dev/null) &&
+   tree=$($GIT rev-parse --verify "HEAD:$prefix" 2>/dev/null) &&
    VN=$(tree_search $head $tree)
    case "$VN" in
    gitgui-[0-9]*) : happy ;;
@@ -49,7 +51,7 @@ elif prefix="$(git rev-parse --show-prefix 2>/dev/null)"
    esac
 then
 	VN=$(echo "$VN" | sed -e 's/^gitgui-//;s/-/./g');
-elif VN=$(git describe --abbrev=4 HEAD 2>/dev/null) &&
+elif VN=$($GIT describe --abbrev=4 HEAD 2>/dev/null) &&
    case "$VN" in
    gitgui-[0-9]*) : happy ;;
    *) (exit 1) ;;
@@ -60,7 +62,7 @@ else
 	VN="$DEF_VER"
 fi
 
-dirty=$(sh -c 'git diff-index --name-only HEAD' 2>/dev/null) || dirty=
+dirty=$(sh -c '$GIT diff-index --name-only HEAD' 2>/dev/null) || dirty=
 case "$dirty" in
 '')
 	;;
diff --git a/git-gui/Makefile b/git-gui/Makefile
index b3580e9..bbdb4d8 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -8,7 +8,11 @@ all::
 #
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
-	@$(SHELL_PATH) ./GIT-VERSION-GEN
+	@{ GIT=$(prefix)/bin/git$X ; test -x "$$GIT" ; } \
+	|| { GIT=./git$X ; test -x "$$GIT" ; } \
+	|| GIT=git ; \
+	export GIT ; \
+	$(SHELL_PATH) ./GIT-VERSION-GEN
 -include GIT-VERSION-FILE
 
 uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
-- 
1.6.3.1.267.gd260a
