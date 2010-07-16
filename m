From: "Kevin P. Fleming" <kpfleming@digium.com>
Subject: [PATCH] post-receive-email: optional message line count limit
Date: Fri, 16 Jul 2010 14:16:23 -0500
Message-ID: <1279307783-4859-1-git-send-email-kpfleming@digium.com>
References: <7v1vb4wsso.fsf@alter.siamese.dyndns.org>
Cc: "Kevin P. Fleming" <kpfleming@digium.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 16 21:16:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZqOn-0006MB-Do
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 21:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759002Ab0GPTQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jul 2010 15:16:36 -0400
Received: from mail.digium.com ([216.207.245.2]:1026 "EHLO mail.digium.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758995Ab0GPTQg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 15:16:36 -0400
Received: from zimbra.digium.internal ([10.24.55.203] helo=zimbra.hsv.digium.com)
	by mail.digium.com with esmtp (Exim 4.69)
	(envelope-from <kpfleming@digium.com>)
	id 1OZqOh-0006lC-Qt; Fri, 16 Jul 2010 14:16:35 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.hsv.digium.com (Postfix) with ESMTP id BD98DD8026;
	Fri, 16 Jul 2010 14:16:35 -0500 (CDT)
Received: from zimbra.hsv.digium.com ([127.0.0.1])
	by localhost (zimbra.hsv.digium.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hnc2dOtkOw7K; Fri, 16 Jul 2010 14:16:35 -0500 (CDT)
Received: from kildare (unknown [10.24.250.46])
	by zimbra.hsv.digium.com (Postfix) with ESMTPS id 55194D8023;
	Fri, 16 Jul 2010 14:16:35 -0500 (CDT)
Received: from kpfleming by kildare with local (Exim 4.71)
	(envelope-from <kpfleming@digium.com>)
	id 1OZqOg-0001Gv-Uy; Fri, 16 Jul 2010 14:16:35 -0500
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <7v1vb4wsso.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151165>

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

Signed-off-by: Kevin P. Fleming <kpfleming@digium.com>
---
 contrib/hooks/post-receive-email |   34 ++++++++++++++++++++++++++++++++--
 1 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 30ae63d..11e51ec 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -55,6 +55,11 @@
 #     "t=%s; printf 'http://.../?id=%%s' \$t; echo;echo; git show -C \$t; echo"
 #   Be careful if "..." contains things that will be expanded by shell "eval"
 #   or printf.
+# hooks.emailmaxlines
+#   The maximum number of lines that should be included in the generated
+#   email body. If not specified, there is no limit.
+#   Lines beyond the limit are suppressed and counted, and a final
+#   line is added indicating the number of suppressed lines.
 #
 # Notes
 # -----
@@ -84,6 +89,7 @@ generate_email()
 	oldrev=$(git rev-parse $1)
 	newrev=$(git rev-parse $2)
 	refname="$3"
+	maxlines=$4
 
 	# --- Interpret
 	# 0000->1234 (create)
@@ -192,7 +198,12 @@ generate_email()
 		fn_name=atag
 		;;
 	esac
-	generate_${change_type}_${fn_name}_email
+
+	if [ -z "$maxlines" ]; then
+		generate_${change_type}_${fn_name}_email
+	else
+		generate_${change_type}_${fn_name}_email | limit_lines $maxlines
+	fi
 
 	generate_email_footer
 }
@@ -642,6 +653,24 @@ show_new_revisions()
 }
 
 
+limit_lines()
+{
+	lines=0
+	skipped=0
+	while IFS="" read -r line; do
+		lines=$((lines + 1))
+		if [ $lines -gt $1 ]; then
+			skipped=$((skipped + 1))
+		else
+			printf "%s\n" "$line"
+		fi
+	done
+	if [ $skipped -ne 0 ]; then
+		echo "... $skipped lines suppressed ..."
+	fi
+}
+
+
 send_mail()
 {
 	if [ -n "$envelopesender" ]; then
@@ -679,6 +708,7 @@ announcerecipients=$(git config hooks.announcelist)
 envelopesender=$(git config hooks.envelopesender)
 emailprefix=$(git config hooks.emailprefix || echo '[SCM] ')
 custom_showrev=$(git config hooks.showrev)
+maxlines=$(git config hooks.emailmaxlines)
 
 # --- Main loop
 # Allow dual mode: run from the command line just like the update hook, or
@@ -691,6 +721,6 @@ if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
 else
 	while read oldrev newrev refname
 	do
-		generate_email $oldrev $newrev $refname | send_mail
+		generate_email $oldrev $newrev $refname $maxlines | send_mail
 	done
 fi
-- 
1.7.1.1
