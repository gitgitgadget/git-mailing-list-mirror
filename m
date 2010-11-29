From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 5/6] web--browse: use (x-)www-browser if available
Date: Mon, 29 Nov 2010 15:47:54 +0100
Message-ID: <1291042075-19983-6-git-send-email-giuseppe.bilotta@gmail.com>
References: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 29 15:48:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN51q-00088I-Mo
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 15:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505Ab0K2Os0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 09:48:26 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39547 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308Ab0K2OsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 09:48:25 -0500
Received: by eye27 with SMTP id 27so1954069eye.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 06:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=iw2uu+LyQLAEN2F7qof/WqzzG+1Ps/F4YW8uuN9Thd8=;
        b=bMm+WvhxSNrNSrmWcS34WTvxS7JvqrsDIjbo6v9zl+m2BM9urHw7/B81yqRe4eL8zY
         x/Se8RO3lzQfuuxudNPf4gsc27qg9Q550fuSC1Qq5czr2G6MgnKG6rfjimZuOqLn3UE4
         tBFUYc9LkhInvI9lJpEplaxrKr2pDV6reyGvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SooJEHdNoTj3ub11u2rUxQYDY4JsQn1uxu+ekQRTBG9Kz5zMa0GM1OxTU7Jnl1vfiC
         i+l9QZy6k0Q2/1pk2Thql1K66oAI41brUTXy7GhXk0rWTA0GjXas6+dC+GMVpShyu/4Y
         sXyWyc06UcUu9O/Gaviu5dsBPw6oLmlBrMiz8=
Received: by 10.216.90.145 with SMTP id e17mr5076557wef.16.1291042103625;
        Mon, 29 Nov 2010 06:48:23 -0800 (PST)
Received: from localhost (nat.ct.ingv.it [193.206.223.100])
        by mx.google.com with ESMTPS id f31sm2425469wej.39.2010.11.29.06.48.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 06:48:22 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.624.gec6c7.dirty
In-Reply-To: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162390>

Debian and derivatives have an alternatives-based default browser
configuration that uses the /usr/bin/x-www-browser and
/usr/bin/www-browser symlinks.

When no browser is selected by the user and the Debian alternatives are
available, try to see if they are one of our recognized selection and
in the affermative case use it.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 Documentation/git-web--browse.txt |    4 ++++
 git-web--browse.sh                |   34 +++++++++++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 5d3ae07..76b5cdc 100644
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
index 7b7f45f..f991dd0 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -102,6 +102,33 @@ then
 	fi
 fi
 
+# Debian and derivatives use x-www-browser or www-browser to set
+# the default browser for the system
+if test -z "$browser" ; then
+	wwwbrowser="/usr/bin/www-browser"
+	if test -n "$DISPLAY"; then
+		wwwbrowser="/usr/bin/x-www-browser $wwwbrowser"
+	fi
+	for i in $wwwbrowser; do
+		if test -x $i ; then
+			verstring="$($i --version 2> /dev/null | head -n 1)"
+			browser="$(echo "$verstring" | cut -f1 -d' ' | tr A-Z a-z)"
+			case "$browser" in
+			mozilla)
+				browser="$(echo "$verstring" | cut -f2 -d' ' | tr A-Z a-z)"
+				;;
+			google)
+				browser="google-chrome"
+				;;
+			esac
+			if valid_tool "$browser" ; then
+				browser_path="$i"
+				break
+			fi
+		fi
+	done
+fi
+
 if test -z "$browser" ; then
 	if test -n "$DISPLAY"; then
 		browser_candidates="firefox iceweasel google-chrome chrome chromium konqueror opera seamonkey iceape w3m elinks links lynx dillo"
@@ -129,7 +156,7 @@ if test -z "$browser" ; then
 		fi
 	done
 	test -z "$browser" && die "No known browser available."
-else
+else if test -z "$browser_path"; then
 	valid_tool "$browser" || die "Unknown browser '$browser'."
 
 	init_browser_path "$browser"
@@ -137,12 +164,13 @@ else
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
1.7.3.2.624.gec6c7.dirty
