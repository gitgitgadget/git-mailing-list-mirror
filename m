From: "Kevin P. Fleming" <kpfleming@digium.com>
Subject: [PATCH] Add support for limiting number of lines generated in messages by post-receive-email
Date: Thu,  8 Jul 2010 14:03:10 -0500
Message-ID: <1278615790-5433-1-git-send-email-kpfleming@digium.com>
Cc: "Kevin P. Fleming" <kpfleming@digium.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 08 21:03:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWwNT-0000xr-Jh
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 21:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756244Ab0GHTDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 15:03:14 -0400
Received: from mail.digium.com ([216.207.245.2]:44300 "EHLO mail.digium.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757182Ab0GHTDN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 15:03:13 -0400
X-Greylist: delayed 1613 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Jul 2010 15:03:13 EDT
Received: from zimbra.digium.internal ([10.24.55.203] helo=zimbra.hsv.digium.com)
	by mail.digium.com with esmtp (Exim 4.69)
	(envelope-from <kpfleming@digium.com>)
	id 1OWwNN-0003az-Bn
	for git@vger.kernel.org; Thu, 08 Jul 2010 14:03:13 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.hsv.digium.com (Postfix) with ESMTP id 4EA501A2012
	for <git@vger.kernel.org>; Thu,  8 Jul 2010 14:03:13 -0500 (CDT)
Received: from zimbra.hsv.digium.com ([127.0.0.1])
	by localhost (zimbra.hsv.digium.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id myK3I9hypRpU; Thu,  8 Jul 2010 14:03:12 -0500 (CDT)
Received: from kildare (unknown [10.24.250.46])
	by zimbra.hsv.digium.com (Postfix) with ESMTPS id E313A1A2008;
	Thu,  8 Jul 2010 14:03:12 -0500 (CDT)
Received: from kpfleming by kildare with local (Exim 4.71)
	(envelope-from <kpfleming@digium.com>)
	id 1OWwNM-0001QB-Nd; Thu, 08 Jul 2010 14:03:12 -0500
X-Mailer: git-send-email 1.7.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150596>

We have become used to the features of svnmailer when used with Subversion,
and one of those useful features is that it can limit the maximum length
(in lines) of a commit email message. This is terribly useful since once the
goes beyond a reasonable number of lines, nobody is going to read the remainder,
and if they really want the entire contents of the commits, they can use
git itself to get them using the revision IDs present in the message already.

This patch adds a new parameter to the post-receive-email hook script called
'maxlines', that defaults to 2048 if not specified. The entire message is
filtered through a function that counts the number of lines generated
(including headers), and any lines beyond the limit are suppressed; if any
lines are suppressed, a final line is added indicating the number that
were suppressed.

Signed-off-by: Kevin P. Fleming <kpfleming@digium.com>
---
 contrib/hooks/post-receive-email |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 30ae63d..436c13f 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -55,6 +55,11 @@
 #     "t=%s; printf 'http://.../?id=%%s' \$t; echo;echo; git show -C \$t; echo"
 #   Be careful if "..." contains things that will be expanded by shell "eval"
 #   or printf.
+# hooks.maxlines
+#   The maximum number of lines that should be included in the generated
+#   email (including its headers). If not specified, defaults to 2048.
+#   Lines beyond the limit are suppressed and counted, and a final
+#   line is added indicating the number of suppressed lines.
 #
 # Notes
 # -----
@@ -642,6 +647,29 @@ show_new_revisions()
 }
 
 
+limit_lines()
+{
+    lines=0
+    skipped=0
+    limit=$(($1 - 2))
+    while IFS="" read line
+    do
+	lines=$((lines + 1))
+	if [ $lines -gt $limit ]
+	then
+	    skipped=$((skipped + 1))
+	else
+	    echo "$line"
+	fi
+    done
+    if [ $skipped -ne 0 ]
+    then
+	echo
+	echo "... $skipped lines suppressed ..."
+    fi
+}
+
+
 send_mail()
 {
 	if [ -n "$envelopesender" ]; then
@@ -679,6 +707,7 @@ announcerecipients=$(git config hooks.announcelist)
 envelopesender=$(git config hooks.envelopesender)
 emailprefix=$(git config hooks.emailprefix || echo '[SCM] ')
 custom_showrev=$(git config hooks.showrev)
+maxlines=$(git config hooks.maxlines || echo '2048')
 
 # --- Main loop
 # Allow dual mode: run from the command line just like the update hook, or
@@ -691,6 +720,6 @@ if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
 else
 	while read oldrev newrev refname
 	do
-		generate_email $oldrev $newrev $refname | send_mail
+		generate_email $oldrev $newrev $refname | limit_lines $maxlines | send_mail
 	done
 fi
-- 
1.7.1.1
