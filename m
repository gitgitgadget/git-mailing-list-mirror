From: Steven Penny <svnpenn@gmail.com>
Subject: [PATCH] web--browse: Use powershell on Windows
Date: Sun, 16 Feb 2014 01:22:27 -0600
Message-ID: <1392535347-3008-1-git-send-email-svnpenn@gmail.com>
Cc: Steven Penny <svnpenn@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 16 08:23:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEw4l-0006Q0-68
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 08:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbaBPHXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 02:23:15 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:61336 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbaBPHXO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 02:23:14 -0500
Received: by mail-ob0-f179.google.com with SMTP id wo20so15703115obc.38
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 23:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nil2Xmhw3R9hrc5R4NRBmeWk0l6JkyriZ4JVD3NDwEY=;
        b=NfMZaD2v+gcAn8sBoNQsEd9bTM5DM3YwR9ObcnufojFpXVZbnexLbcPHV24MneSv3I
         da6sg1DuB0AGS3nyUXd+Y4pgBeZeQfWj98Rp1/1oyr9ID109fVDzw54c5gURzrpW8Ay1
         oORQ0W3R9DI22H2CtdJLusx3aIfdvButSitwxF0eDII5kLFEHW7uyPn3Bdift9PcjYTw
         TcNlD56xvK6zPfnFqr+e614rociiSFkkgpTTgXziiz37Ze/TpiH1zTqHCfenjutj0Chm
         wzrsGvyCeWTRBlGJepzX9SW/HJpWUj6/EV1HWierAER3cLblEYexozidzSbg5kYEVEGw
         y5Xg==
X-Received: by 10.60.98.240 with SMTP id el16mr59502oeb.50.1392535394006;
        Sat, 15 Feb 2014 23:23:14 -0800 (PST)
Received: from localhost (99-109-97-214.lightspeed.rcsntx.sbcglobal.net. [99.109.97.214])
        by mx.google.com with ESMTPSA id ut2sm34492899obc.3.2014.02.15.23.23.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Feb 2014 23:23:13 -0800 (PST)
X-Mailer: git-send-email 1.8.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242216>

On Windows you can have either MinGW or Cygwin. As has been shown in this script
MinGW uses "start" while Cygwin uses "cygstart". The "cygstart" command is
robust but the "start" command breaks on certain URLs

    $ git web--browse 'http://wikipedia.org/wiki/Key_&_Peele'
    '_Peele' is not recognized as an internal or external command,
    operable program or batch file.

An alternative is to use PowerShell. PowerShell is a component of Windows and
will work with both MinGW and Cygwin.

Signed-off-by: Steven Penny <svnpenn@gmail.com>
---
 Documentation/git-web--browse.txt |  3 +--
 git-web--browse.sh                | 19 ++++++++-----------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 2de575f..02cccf9 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -33,8 +33,7 @@ The following browsers (or commands) are currently supported:
 * lynx
 * dillo
 * open (this is the default under Mac OS X GUI)
-* start (this is the default under MinGW)
-* cygstart (this is the default under Cygwin)
+* powershell (this is the default under Windows)
 * xdg-open
 
 Custom commands may also be specified.
diff --git a/git-web--browse.sh b/git-web--browse.sh
index ebdfba6..72fbe32 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -34,7 +34,7 @@ valid_tool() {
 	firefox | iceweasel | seamonkey | iceape | \
 	chrome | google-chrome | chromium | chromium-browser | \
 	konqueror | opera | w3m | elinks | links | lynx | dillo | open | \
-	start | cygstart | xdg-open)
+	powershell | xdg-open)
 		;; # happy
 	*)
 		valid_custom_tool "$1" || return 1
@@ -124,13 +124,10 @@ if test -z "$browser" ; then
 	then
 		browser_candidates="open $browser_candidates"
 	fi
-	# /bin/start indicates MinGW
-	if test -x /bin/start; then
-		browser_candidates="start $browser_candidates"
-	fi
-	# /usr/bin/cygstart indicates Cygwin
-	if test -x /usr/bin/cygstart; then
-		browser_candidates="cygstart $browser_candidates"
+	# OS indicates Windows
+	if test -n "$OS"
+	then
+		browser_candidates="powershell $browser_candidates"
 	fi
 
 	for i in $browser_candidates; do
@@ -179,11 +176,11 @@ konqueror)
 		;;
 	esac
 	;;
-w3m|elinks|links|lynx|open|cygstart|xdg-open)
+w3m|elinks|links|lynx|open|xdg-open)
 	"$browser_path" "$@"
 	;;
-start)
-	exec "$browser_path" '"web-browse"' "$@"
+powershell)
+	"$browser_path" saps "'$@'"
 	;;
 opera|dillo)
 	"$browser_path" "$@" &
-- 
1.8.5.3
