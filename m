From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 6/6] web--browse: look at the BROWSER env var
Date: Mon,  6 Dec 2010 18:49:50 +0100
Message-ID: <1291657790-3719-7-git-send-email-giuseppe.bilotta@gmail.com>
References: <1291657790-3719-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 06 18:50:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPfCv-00066z-4e
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 18:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219Ab0LFRu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 12:50:28 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35320 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab0LFRuY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 12:50:24 -0500
Received: by mail-wy0-f174.google.com with SMTP id 28so12273585wyb.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 09:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=tWq8W38gggFSfU9/pPQa+NiaKzh8kyrr/SCyuoiNUB8=;
        b=yFCqmErtxdz/zr07/sC84iqtXIyPSz6S+PgKHknAznNrnvduiAs21U+MXIDKxsPeww
         FkFgEcTkaGiP9F5JjAJG6sJeeDsLagTIKgYM4UFp7fM36DZ7pUu8Xzii+w5MiDwvFxk0
         H8oX31MpQq1ufhEayhVZ6b0WoXwmsXM2me5u0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=C6ojJlf1Pq78QLp2lR0pCdiVpyEEpDth2/gn3O7157FiMGL0k9kDIq4yz//XSErzHC
         9JzbDULA067SLghSu7u21U5gYY0WJwMrI+xkR12djUpFSksMwFAWZslVxTw2yaXAmTBz
         gbp6rmXSCcSAg8bQCj5i6khSKJNpWN1gZGyLQ=
Received: by 10.227.134.20 with SMTP id h20mr6099778wbt.88.1291657823399;
        Mon, 06 Dec 2010 09:50:23 -0800 (PST)
Received: from localhost ([151.60.176.40])
        by mx.google.com with ESMTPS id h29sm3608107wbc.21.2010.12.06.09.50.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 09:50:22 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.664.g294b8.dirty
In-Reply-To: <1291657790-3719-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163009>

The BROWSER environment variables is used in Debian-based systems to set
the user-preferred browser(s).

It contains a colon-separate list of commands to (try to) execute
to open a web page. Each item in the list is allowed to have a %s
placeholder to be replaced by the URL, in which case we try to run the
command as is. If no placeholder is found, we only look at the command
name to see if it matches one of our known browsers.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-web--browse.sh |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index b496b6c..da36ca4 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -164,6 +164,51 @@ then
 	fi
 fi
 
+# Debian and derivatives provide a sensible-brower script that tries to
+# invoke the user or system preferred browser most appropriate for the
+# current situation (X or no X, GNOME or other/no DE).
+# We do not use the sensible-browser script directly since it doesn't
+# allow us to open pages in a new tab, but we can use the underlying
+# infrastructure to find the browser to use if the user didn't choose
+# one. This is done by looking at the BROWSER environment variable
+# first, and at the *www-browser links if the first search is
+# unsuccesful.
+
+# The BROWSER environment variable is a colon-separate list of commands
+# to (try and) execute to launch the browser. sensible-browser allows
+# each BROWSER entry to contain a %s placeholder that will be replaced
+# by the URL to be opened.
+# If an entry contains a %s we run it as-is, without doing any detection, on
+# the premise that it represents the exact way the user expects the browser to
+# be called. If the execution fails, we do not bail out, since the
+# failure might be due to the entry being for a graphical browser and
+# the GUI not being available, which is the reason why multiple entries
+# can be specified in BROWSER in the first place.
+# An entry without a %s is only taken as indication of the preferred
+# browser, so we proceed with our usual detection logic.
+if test -z "$browser" -a -n "$BROWSER"; then
+	OLDIFS="$IFS"
+	IFS=:
+	for i in $BROWSER; do
+		case "$i" in
+			*sensible-browser*)
+				;; # skip
+			*%s*)
+				IFS="$OLDIFS"
+				cmd=$(printf "$i\n" "$*")
+				$cmd && exit 0
+				;;
+			*)
+				prog=$(which "$i" 2> /dev/null)
+				if test -n "$prog" -a -x "$prog" && valid_browser_executable "$prog" ; then
+					break
+				fi
+				;;
+		esac
+	done
+	IFS="$OLDIFS"
+fi
+
 # Debian and derivatives use gnome-www-browser, x-www-browser or www-browser to
 # set the default browser for the system. If the user did not specify a tool and
 # we detect that one of the *www-browser links to a supported one, we pick it.
-- 
1.7.3.2.664.g294b8.dirty
