From: "Kevin P. Fleming" <kpfleming@digium.com>
Subject: [PATCH] post-receive-email: ensure sent messages are not empty
Date: Mon,  2 Aug 2010 15:28:47 -0500
Message-ID: <1280780927-29006-1-git-send-email-kpfleming@digium.com>
Cc: "Kevin P. Fleming" <kpfleming@digium.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 02 22:29:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og1d8-00055M-JM
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 22:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755283Ab0HBU2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 16:28:55 -0400
Received: from mail.digium.com ([216.207.245.2]:48944 "EHLO mail.digium.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755281Ab0HBU2y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 16:28:54 -0400
Received: from zimbra.digium.internal ([10.24.55.203] helo=zimbra.hsv.digium.com)
	by mail.digium.com with esmtp (Exim 4.69)
	(envelope-from <kpfleming@digium.com>)
	id 1Og1cz-0002QL-EM
	for git@vger.kernel.org; Mon, 02 Aug 2010 15:28:53 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.hsv.digium.com (Postfix) with ESMTP id 5E5651A2015
	for <git@vger.kernel.org>; Mon,  2 Aug 2010 15:28:53 -0500 (CDT)
Received: from zimbra.hsv.digium.com ([127.0.0.1])
	by localhost (zimbra.hsv.digium.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QrpDTZh2H9dN; Mon,  2 Aug 2010 15:28:52 -0500 (CDT)
Received: from kildare (unknown [10.24.250.46])
	by zimbra.hsv.digium.com (Postfix) with ESMTPS id EFD6E1A2010;
	Mon,  2 Aug 2010 15:28:52 -0500 (CDT)
Received: from kpfleming by kildare with local (Exim 4.71)
	(envelope-from <kpfleming@digium.com>)
	id 1Og1cy-0007Yt-JH; Mon, 02 Aug 2010 15:28:52 -0500
X-Mailer: git-send-email 1.7.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152455>

Changes the logic in the script to determine whether an email message
will be sent before invoking the send_mail() function; otherwise, if
the logic determines that a message will not be sent, send_mail() will
cause an empty email to be sent.

Signed-off-by: Kevin P. Fleming <kpfleming@digium.com>
---
 contrib/hooks/post-receive-email |   42 +++++++++++++++++++++++++------------
 1 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 30ae63d..b595452 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -66,19 +66,10 @@
 # ---------------------------- Functions
 
 #
-# Top level email generation function.  This decides what type of update
-# this is and calls the appropriate body-generation routine after outputting
-# the common header
+# Function to prepare for email generation. This decides what type
+# of update this is and whether an email should even be generated.
 #
-# Note this function doesn't actually generate any email output, that is
-# taken care of by the functions it calls:
-#  - generate_email_header
-#  - generate_create_XXXX_email
-#  - generate_update_XXXX_email
-#  - generate_delete_XXXX_email
-#  - generate_email_footer
-#
-generate_email()
+prep_for_email()
 {
 	# --- Arguments
 	oldrev=$(git rev-parse $1)
@@ -171,7 +162,28 @@ generate_email()
 		echo >&2 "*** for $refname update $oldrev->$newrev"
 		exit 0
 	fi
+}
 
+#
+# Top level email generation function.  This calls the appropriate
+# body-generation routine after outputting the common header.
+#
+# Note this function doesn't actually generate any email output, that is
+# taken care of by the functions it calls:
+#  - generate_email_header
+#  - generate_create_XXXX_email
+#  - generate_update_XXXX_email
+#  - generate_delete_XXXX_email
+#  - generate_email_footer
+#
+# Note also that this function cannot 'exit' from the script; when this
+# function is running (in hook script mode), the send_mail() function
+# is already executing in another process, connected via a pipe, and
+# if this function exits without, whatever has been generated to that
+# point will be sent as an email... even if nothing has been generated.
+#
+generate_email()
+{
 	# Email parameters
 	# The email subject will contain the best description of the ref
 	# that we can build from the parameters
@@ -687,10 +699,12 @@ if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
 	# Output to the terminal in command line mode - if someone wanted to
 	# resend an email; they could redirect the output to sendmail
 	# themselves
-	PAGER= generate_email $2 $3 $1
+	prep_for_email $2 $3 $1
+	PAGER= generate_email
 else
 	while read oldrev newrev refname
 	do
-		generate_email $oldrev $newrev $refname | send_mail
+		prep_for_email $oldrev $newrev $refname
+		generate_email | send_mail
 	done
 fi
-- 
1.7.2
