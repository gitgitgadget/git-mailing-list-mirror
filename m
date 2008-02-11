From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-web--browse: improve browser support under OS X
Date: Sun, 10 Feb 2008 19:01:56 -0800
Message-ID: <7vve4wb3h7.fsf@gitster.siamese.dyndns.org>
References: <1202505794-13409-1-git-send-email-jaysoffian+git@gmail.com>
	<1202696664-1565-1-git-send-email-jaysoffian+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: jaysoffian+git@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 11 04:03:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOOwp-0000Or-63
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 04:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbYBKDCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 22:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbYBKDCV
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 22:02:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36767 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbYBKDCU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 22:02:20 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 381EE2B83;
	Sun, 10 Feb 2008 22:02:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 78CE22B81;
	Sun, 10 Feb 2008 22:02:13 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73462>

Because we preprocess git-web--browse.sh to create the final
git-web--browse to be installed, something like "open" that is
not a user but a platform preference might be better done as a
build-time thing, instead of forcing everybody to spawn "uname",
perhaps like this?

Also I wonder why the check for SECURITYSESSIONID your original
had is not good enough for this Mac specific customization?


 Makefile           |    2 ++
 git-web--browse.sh |   18 +++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index d288378..5c278d2 100644
--- a/Makefile
+++ b/Makefile
@@ -419,6 +419,7 @@ ifeq ($(uname_S),Darwin)
 	endif
 	NO_STRLCPY = YesPlease
 	NO_MEMMEM = YesPlease
+	PLATFORM_BROWSER = open
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
@@ -840,6 +841,7 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
+	    -e 's/@@PLATFORM_BROWSER@@/$(PLATFORM_BROWSER)/g' \
 	    $@.sh >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
diff --git a/git-web--browse.sh b/git-web--browse.sh
index 3ade500..61a3514 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -27,6 +27,8 @@ valid_tool() {
 	case "$1" in
 		firefox | iceweasel | konqueror | w3m | links | lynx | dillo)
 			;; # happy
+		"@@PLATFORM_BROWSER@@" )
+			;;
 		*)
 			return 1
 			;;
@@ -105,6 +107,20 @@ if test -z "$browser" ; then
 	browser_candidates="w3m links lynx"
     fi
 
+    # Test if the current environment is suitable for the
+    # platform preference and add it as the default
+
+    if	case "@@PLATFORM_BROWSER@@" in
+	open)
+		test -n "$SECURITYSESSIONID" ;;
+	# other platform preference come here...
+	*)
+		false ;;
+	esac
+    then
+	browser_candidates="@@PLATFORM_BROWSER@@ $browser_candidates"
+    fi
+
     for i in $browser_candidates; do
 	init_browser_path $i
 	if type "$browser_path" > /dev/null 2>&1; then
@@ -147,7 +163,7 @@ case "$browser" in
 		;;
 	esac
 	;;
-    w3m|links|lynx)
+    w3m|links|lynx|open)
 	eval "$browser_path" "$@"
 	;;
     dillo)
