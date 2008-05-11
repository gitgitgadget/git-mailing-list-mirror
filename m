From: nathan spindel <nathans@gmail.com>
Subject: [PATCH v2] instaweb: make it compatible with Mac OS X 10.5's apache installation.
Date: Sun, 11 May 2008 12:36:09 -0700
Message-ID: <1210534569-48466-1-git-send-email-nathans@gmail.com>
Cc: nathan spindel <nathans@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 11 21:37:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvHM3-0002h5-HP
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 21:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756071AbYEKTgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 15:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756065AbYEKTgP
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 15:36:15 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:30308 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755514AbYEKTgO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 15:36:14 -0400
Received: by wa-out-1112.google.com with SMTP id j37so3050027waf.23
        for <git@vger.kernel.org>; Sun, 11 May 2008 12:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=Z2q8qgZWlV1oZ6p94MmryNefcdBxJBkfyuo95Hly2Gg=;
        b=p2ksG5RA+HtMgW/Ic1cDHvz+bhvwLJ1dIzqN4QUvp65Z4MsVgQrQLDtJDvu3sByQUBDXuRQopffNeck5JX6JkYKA4tY0l2Sz3Mf88PiOPlcBChsDRrTNzCs4IVXmyC55UB4N63akvP2DPZVLbSZSxetvSKmnAsOdiHxZYgyP1Ps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=A9b7JRcXoNUs00bWW3JmpdjsMBUhTXf9ybiol0d2uYApYxq3jsVa2LUNnEBOgAkDcGMz3SNONC8EkDLqNEQE+Ho/NMpVxS2riAddK+8GxBKgmqJK3Zrp5swKarJr1yZNycjkdZnD4W8NaDz/AJCoOsNCg0BblaaDnRWZw4C1Pxw=
Received: by 10.142.242.8 with SMTP id p8mr2920900wfh.196.1210534574020;
        Sun, 11 May 2008 12:36:14 -0700 (PDT)
Received: from localhost ( [76.14.71.118])
        by mx.google.com with ESMTPS id 9sm16569603wfc.6.2008.05.11.12.36.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 May 2008 12:36:10 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.178.g1f811.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81816>

When in apache2 mode if there isn't an apache2 command on the
system but there is a httpd command installed (like there is
on Mac OS X) use that command instead.

When in apache2 mode and there isn't a module_path specified, look for
module paths in /usr/lib/apache2/modules _and_ /usr/libexec/apache2,
in that order.

Added a LockFile directive to the apache2 config because the default
location of /private/var/run is only root-writeable on Mac OS X.

Signed-off-by: nathan spindel <nathans@gmail.com>
---
 git-instaweb.sh |   55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 54 insertions(+), 1 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 6f91c8f..00e147f 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -172,7 +172,59 @@ EOF
 }
 
 apache2_conf () {
-	test -z "$module_path" && module_path=/usr/lib/apache2/modules
+	# if there isn't an apache2 command on the system but there
+	# is a httpd command which looks like apache, use that instead
+	# for Mac OS X compatibility.
+	httpd_only="`echo $httpd | cut -f1 -d' '`"
+	if ! type $httpd_only > /dev/null 2>&1
+	then
+		found_apache_command=1
+		httpd_parent_paths="/usr/local/sbin /usr/sbin"
+		for i in $httpd_parent_paths; do
+			if test -x "$i/$httpd_only"
+			then
+				found_apache_command=0
+				break
+			fi
+		done
+
+		if test $found_apache_command != 0
+		then
+			alt_apache="httpd"
+			if type $alt_apache > /dev/null 2>&1
+			then
+				$alt_apache -v | grep Apache > /dev/null 2>&1
+				if test $? == 0
+				then
+					httpd=`echo "$httpd" | sed "s/apache2/httpd/"`
+				else
+					for i in $httpd_parent_paths; do
+						if test -x "$i/$alt_apache"
+						then
+							$i/$alt_apache -v | grep Apache > /dev/null 2>&1
+							if test $? == 0
+							then
+								httpd=`echo "$httpd" | sed "s/apache2/httpd/"`
+								break
+							fi
+						fi
+					done
+				fi
+			fi
+		fi
+	fi
+
+	if test -z "$module_path"
+	then
+		for path in /usr/lib/apache2/modules /usr/libexec/apache2; do
+			if test -d "$path"
+			then
+				module_path="$path"
+				break
+			fi
+		done
+	fi
+
 	mkdir -p "$GIT_DIR/gitweb/logs"
 	bind=
 	test x"$local" = xtrue && bind='127.0.0.1:'
@@ -182,6 +234,7 @@ ServerName "git-instaweb"
 ServerRoot "$fqgitdir/gitweb"
 DocumentRoot "$fqgitdir/gitweb"
 PidFile "$fqgitdir/pid"
+LockFile "$fqgitdir/gitweb/logs/accept.lock"
 Listen $bind$port
 EOF
 
-- 
1.5.5.1.179.g2fe4.dirty
