From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 6/7] web--browse: use (x-)www-browser if available
Date: Fri,  3 Dec 2010 17:47:40 +0100
Message-ID: <1291394861-11989-7-git-send-email-giuseppe.bilotta@gmail.com>
References: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 03 17:48:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POYoJ-0007II-R0
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 17:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452Ab0LCQsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 11:48:21 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38941 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098Ab0LCQsT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 11:48:19 -0500
Received: by mail-wy0-f174.google.com with SMTP id 28so9636145wyb.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 08:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=KRCiaQwAXwzAf6zlkk2l8qVwuxpSP4/odBSvO584fgc=;
        b=OkhBbrQNdjbxmu6ebQq5isWv4tNegcqOhWZjKVXbEbr3HlZgrnTcQmtEPAPvOdbnka
         nL/HPOZV0egt9RxXFKwHet5cS/AK053XTvhai7+yOK/rDG/wUTnMZB+d8R8ZZjU3txMD
         ktMy+7d5EF9e/IZTZx+O8LOvCzRJs91woir4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lYlvyXaRq9QCmloAnV+I+yNqN9wLeOVymxYfne5aKYjVfC4+9GfTtVI/Sl7unT8XxT
         /Hb6aAWe+aAnvXPPvGZ1GjfIhI3giuJSwqP+Rp8bgzjjt0NrV2pgroGud+uC910dvAh+
         sgN6I74aYkvTmey5Ejpi9Lt9gfSAZ3c8xNwYs=
Received: by 10.227.138.5 with SMTP id y5mr2168638wbt.50.1291394899096;
        Fri, 03 Dec 2010 08:48:19 -0800 (PST)
Received: from localhost (nat.ct.ingv.it [193.206.223.100])
        by mx.google.com with ESMTPS id h29sm1391743wbc.21.2010.12.03.08.48.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 08:48:18 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.664.g294b8.dirty
In-Reply-To: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162810>

Debian and derivatives have an alternatives-based default browser
configuration that uses the /usr/bin/gnome-www-browser,
/usr/bin/x-www-browser and /usr/bin/www-browser symlinks.

When no browser is selected by the user and the Debian alternatives are
available, try to see if they are one of our recognized selection and
in the affermative case use it. Otherwise, warn the user about them
being unsupported and move on with the previous detection logic.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 Documentation/git-web--browse.txt |    4 ++
 git-web--browse.sh                |   59 +++++++++++++++++++++++++++++++++++--
 2 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index c0416e5..de034a5 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -36,6 +36,10 @@ The following browsers (or commands) are currently supported:
 
 Custom commands may also be specified.
 
+If no default browser is specified, and /usr/bin/x-www-browser
+(under X) or /usr/bin/www-browser is present, they are used to determine
+the browser to use.
+
 OPTIONS
 -------
 -b <browser>::
diff --git a/git-web--browse.sh b/git-web--browse.sh
index d0e99f5..48ea168 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -49,6 +49,38 @@ init_browser_path() {
 	test -z "$browser_path" && browser_path="$1"
 }
 
+# check if a given executable is a browser we like
+valid_exe() {
+	testexe="$1"
+	basename=$(basename $(readlink -f "$testexe"))
+	if valid_tool "$basename" ; then
+		browser="$basename"
+		browser_path="$testexe"
+		return 0
+	fi
+
+	# if the linked executable doesn't match a browser name,
+	# look at the version string
+	verstring="$("$testexe" --version 2> /dev/null)"
+	browser="$(echo "$verstring" | head -n 1 | cut -f1 -d' ' | tr A-Z a-z)"
+	case "$browser" in
+		mozilla)
+			browser="$(echo "$verstring" | head -n 1 | cut -f2 -d' ' | tr A-Z a-z)"
+			;;
+		google)
+			browser="google-chrome"
+			;;
+	esac
+	if valid_tool "$browser" ; then
+		browser_path="$i"
+		return 0
+	fi
+
+	echo >&2 "$basename ($browser) is not a supported browser, skipping"
+	browser=""
+	return 1
+}
+
 while test $# != 0
 do
 	case "$1" in
@@ -106,6 +138,26 @@ then
 	fi
 fi
 
+# Debian and derivatives use gnome-www-browser, x-www-browser or www-browser to
+# set the default browser for the system. If the user did not specify a tool and
+# we detect that one of the *www-browser links to a supported one, we pick it.
+# Otherwise, we warn the user about them being unsupported and proceed to look
+# for a supported browser.
+if test -z "$browser" ; then
+	wwwbrowser="/usr/bin/www-browser"
+	if test -n "$DISPLAY"; then
+		wwwbrowser="/usr/bin/x-www-browser $wwwbrowser"
+		if test -n "$GNOME_DESKTOP_SESSION_ID"; then
+			wwwbrowser="/usr/bin/gnome-www-browser $wwwbrowser"
+		fi
+	fi
+	for i in $wwwbrowser; do
+		if test -x $i && valid_exe $i ; then
+			break
+		fi
+	done
+fi
+
 if test -z "$browser" ; then
 	if test -n "$DISPLAY"; then
 		browser_candidates="firefox iceweasel google-chrome chrome chromium chromium-browser konqueror opera seamonkey iceape w3m elinks links lynx dillo"
@@ -133,7 +185,7 @@ if test -z "$browser" ; then
 		fi
 	done
 	test -z "$browser" && die "No known browser available."
-else
+else if test -z "$browser_path"; then
 	valid_tool "$browser" || die "Unknown browser '$browser'."
 
 	init_browser_path "$browser"
@@ -141,12 +193,13 @@ else
 	if test -z "$browser_cmd" && ! type "$browser_path" > /dev/null 2>&1; then
 		die "The browser $browser is not available as '$browser_path'."
 	fi
-fi
+fi fi
 
 case "$browser" in
 firefox|iceweasel|seamonkey|iceape)
 	# Check version because firefox < 2.0 does not support "-new-tab".
-	vers=$(expr "$($browser_path -version)" : '.* \([0-9][0-9]*\)\..*')
+	test -z "$verstring" && verstring="$($browser_path -version)"
+	vers=$(expr "$verstring" : '.* \([0-9][0-9]*\)\..*')
 	NEWTAB='-new-tab'
 	test "$vers" -lt 2 && NEWTAB=''
 	"$browser_path" $NEWTAB "$@" &
-- 
1.7.3.2.664.g294b8.dirty
