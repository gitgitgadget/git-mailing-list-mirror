From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 5/6] web--browse: use *www-browser if available
Date: Mon,  6 Dec 2010 18:49:49 +0100
Message-ID: <1291657790-3719-6-git-send-email-giuseppe.bilotta@gmail.com>
References: <1291657790-3719-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 06 18:50:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPfCu-00066z-KO
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 18:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530Ab0LFRuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 12:50:21 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56472 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab0LFRuS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 12:50:18 -0500
Received: by mail-ww0-f44.google.com with SMTP id 36so13094000wwa.1
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 09:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=u//EjG6gy8zAKFTWhmJNWwhPL+SKzDY6bCbjD3JkHOc=;
        b=B9J2y6VoK/pmVJM7Eeg5asEask4g1wX8EAonx/is8nQXTJqnj/H5Ux/xFtUkjSk5rp
         vPCiCI9JxmlzHm3CiC8g4blFBYkFi0orFZhdB78mKYqi52wdESJ1Hh4y+/P87yt2OUL5
         p6RCynUXqRVg2Li5UQd+l6p36+j3ePd5vxR+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EACgQTjz695E/w2RbyR6s9Si1QII0ZO564F574EIY63sQB2td89VNVTmzlXy/DYTzx
         1Z7fv/fY+j5dOzhL8PdC8nQDv7SxZrNEzyYr6CYmQRQj0cQxj6v7s8ks64qZ1OEYmmmy
         cERyjleI0NfRfLLufq/3DPrGG0gTFs0xctmG8=
Received: by 10.227.133.11 with SMTP id d11mr5971518wbt.173.1291657818050;
        Mon, 06 Dec 2010 09:50:18 -0800 (PST)
Received: from localhost ([151.60.176.40])
        by mx.google.com with ESMTPS id 11sm3608366wbi.18.2010.12.06.09.50.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 09:50:17 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.664.g294b8.dirty
In-Reply-To: <1291657790-3719-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163007>

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
 git-web--browse.sh                |   84 +++++++++++++++++++++++++++++++++++-
 2 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index c0416e5..157738a 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -36,6 +36,10 @@ The following browsers (or commands) are currently supported:
 
 Custom commands may also be specified.
 
+If no default browser is specified, and /usr/bin/gnome-www-browser
+(under GNOME), /usr/bin/x-www-browser (under X) or /usr/bin/www-browser
+is present, they are used to determine the browser to use.
+
 OPTIONS
 -------
 -b <browser>::
diff --git a/git-web--browse.sh b/git-web--browse.sh
index b2fc3b4..b496b6c 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -50,6 +50,63 @@ init_browser_path() {
 	test -z "$browser_path" && browser_path="$1"
 }
 
+# check if a given executable is a browser we like
+valid_browser_executable() {
+	testexe="$1"
+
+	# check the executable name first, trying to follow symlinks if possible
+	if type readlink > /dev/null 2>&1 ; then
+		basename="$(basename $(readlink -f "$testexe"))"
+	else
+		basename="$(basename "$testexe")"
+	fi
+	if valid_tool "$basename" ; then
+		browser="$basename"
+		browser_path="$testexe"
+		return 0
+	fi
+
+	# if the linked executable doesn't match a browser name we know about,
+	# look at the version string
+
+	# even though most browsers (and applications, in fact) will show their
+	# name and version on the first line of the --version output, this is
+	# not true in particular for the KDE apps (e.g. konqueror and kfmclient),
+	# which display their name and version on the LAST line. So we cannot
+	# clip the version string at the first line when retrieving it. Rather,
+	# we keep it whole and then limit it when we know what we're dealing with.
+
+	verstring="$("$testexe" --version 2> /dev/null)"
+	browser="$(echo "$verstring" | head -n 1 | cut -f1 -d' ' | tr A-Z a-z)"
+	case "$browser" in
+		mozilla)
+			verstring="$(echo "$verstring" | head -n 1)"
+			browser="$(echo "$verstring" | cut -f2 -d' ' | tr A-Z a-z)"
+			;;
+		google)
+			verstring="$(echo "$verstring" | head -n 1)"
+			browser="google-chrome"
+			;;
+		qt:)
+			# konqueror, kfmclient or other KDE app
+			verstring="$(echo "$verstring" | tail -n 1)"
+			browser="$(echo "$verstring" | cut -f1 -d:)"
+			;;
+		*)
+			verstring="$(echo "$verstring" | head -n 1)"
+			;;
+
+	esac
+	if valid_tool "$browser" ; then
+		browser_path="$i"
+		return 0
+	fi
+
+	echo >&2 "$testexe (detected as $browser) is not a supported browser, skipping"
+	browser=""
+	return 1
+}
+
 while test $# != 0
 do
 	case "$1" in
@@ -107,6 +164,26 @@ then
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
+		if test -x $i && valid_browser_executable $i ; then
+			break
+		fi
+	done
+fi
+
 if test -z "$browser" ; then
 	if test -n "$DISPLAY"; then
 		browser_candidates="firefox iceweasel google-chrome chrome chromium chromium-browser konqueror opera seamonkey iceape w3m elinks links lynx dillo"
@@ -134,7 +211,7 @@ if test -z "$browser" ; then
 		fi
 	done
 	test -z "$browser" && die "No known browser available."
-else
+else if test -z "$browser_path"; then
 	valid_tool "$browser" || die "Unknown browser '$browser'."
 
 	init_browser_path "$browser"
@@ -142,12 +219,13 @@ else
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
