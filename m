From: "Kevin P. Fleming" <kpfleming@digium.com>
Subject: [PATCH] post-receive-email: optional message line count limit
Date: Thu, 15 Jul 2010 09:51:56 -0500
Message-ID: <1279205516-3302-1-git-send-email-kpfleming@digium.com>
References: <m2vd8jhxbd.fsf@igel.home>
Cc: "Kevin P. Fleming" <kpfleming@digium.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 15 16:52:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZPnY-00016H-5h
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 16:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933434Ab0GOOwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 10:52:15 -0400
Received: from mail.digium.com ([216.207.245.2]:55576 "EHLO mail.digium.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933430Ab0GOOwN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 10:52:13 -0400
Received: from zimbra.digium.internal ([10.24.55.203] helo=zimbra.hsv.digium.com)
	by mail.digium.com with esmtp (Exim 4.69)
	(envelope-from <kpfleming@digium.com>)
	id 1OZPnH-00074q-P7
	for git@vger.kernel.org; Thu, 15 Jul 2010 09:52:11 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.hsv.digium.com (Postfix) with ESMTP id AAF79D8026
	for <git@vger.kernel.org>; Thu, 15 Jul 2010 09:52:11 -0500 (CDT)
Received: from zimbra.hsv.digium.com ([127.0.0.1])
	by localhost (zimbra.hsv.digium.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s9OWjrmavnqB; Thu, 15 Jul 2010 09:52:11 -0500 (CDT)
Received: from kildare (unknown [10.24.250.46])
	by zimbra.hsv.digium.com (Postfix) with ESMTPS id 511E4D8023;
	Thu, 15 Jul 2010 09:52:11 -0500 (CDT)
Received: from kpfleming by kildare with local (Exim 4.71)
	(envelope-from <kpfleming@digium.com>)
	id 1OZPnH-0000ro-4X; Thu, 15 Jul 2010 09:52:11 -0500
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <m2vd8jhxbd.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151082>

We have become used to the features of svnmailer when used with Subversion,
and one of those useful features is that it can limit the maximum length
(in lines) of a commit email message. This is terribly useful since once the
goes beyond a reasonable number of lines, nobody is going to read the remainder,
and if they really want the entire contents of the commits, they can use
git itself to get them using the revision IDs present in the message already.

Change the post-receive-email script to respond to an 'emailmaxlines' config key
which, if specified, will limit the number of lines generated (including
headers); any lines beyond the limit are suppressed, and a final line is added
indicating the number that were suppressed.
---
 contrib/hooks/post-receive-email |   33 ++++++++++++++++++++++++++++++++-
 1 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 30ae63d..4dc85c2 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -55,6 +55,11 @@
 #     "t=%s; printf 'http://.../?id=%%s' \$t; echo;echo; git show -C \$t; echo"
 #   Be careful if "..." contains things that will be expanded by shell "eval"
 #   or printf.
+# hooks.emailmaxlines
+#   The maximum number of lines that should be included in the generated
+#   email (including its headers). If not specified, there is no limit.
+#   Lines beyond the limit are suppressed and counted, and a final
+#   line is added indicating the number of suppressed lines.
 #
 # Notes
 # -----
@@ -642,6 +647,27 @@ show_new_revisions()
 }
 
 
+limit_lines()
+{
+	lines=0
+	skipped=0
+	while IFS="" read -r line
+	do
+		lines=$((lines + 1))
+		if [ $lines -gt $1 ]
+		then
+			skipped=$((skipped + 1))
+		else
+			printf "%s\n" "$line"
+		fi
+	done
+	if [ $skipped -ne 0 ]
+	then
+		echo "... $skipped lines suppressed ..."
+	fi
+}
+
+
 send_mail()
 {
 	if [ -n "$envelopesender" ]; then
@@ -679,6 +705,7 @@ announcerecipients=$(git config hooks.announcelist)
 envelopesender=$(git config hooks.envelopesender)
 emailprefix=$(git config hooks.emailprefix || echo '[SCM] ')
 custom_showrev=$(git config hooks.showrev)
+maxlines=$(git config hooks.emailmaxlines)
 
 # --- Main loop
 # Allow dual mode: run from the command line just like the update hook, or
@@ -691,6 +718,10 @@ if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
 else
 	while read oldrev newrev refname
 	do
-		generate_email $oldrev $newrev $refname | send_mail
+		if [ -z "$maxlines" ]; then
+			generate_email $oldrev $newrev $refname | send_mail
+		else
+			generate_email $oldrev $newrev $refname | limit_lines $maxlines | send_mail
+		fi
 	done
 fi
-- 
1.7.1.1
