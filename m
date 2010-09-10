From: "Kevin P. Fleming" <kpfleming@digium.com>
Subject: [PATCH] post-receive-email: ensure sent messages are not empty
Date: Fri, 10 Sep 2010 11:09:39 -0500
Message-ID: <1284134979-31376-1-git-send-email-kpfleming@digium.com>
Cc: "Kevin P. Fleming" <kpfleming@digium.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 10 18:10:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou6As-0007tq-MN
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 18:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755288Ab0IJQJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 12:09:55 -0400
Received: from mail.digium.com ([216.207.245.2]:47072 "EHLO mail.digium.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754943Ab0IJQJy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 12:09:54 -0400
Received: from zimbra.digium.internal ([10.24.55.203] helo=zimbra.hsv.digium.com)
	by mail.digium.com with esmtp (Exim 4.69)
	(envelope-from <kpfleming@digium.com>)
	id 1Ou6Ai-0004DB-PQ; Fri, 10 Sep 2010 11:09:52 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.hsv.digium.com (Postfix) with ESMTP id C7DF7D8193;
	Fri, 10 Sep 2010 11:09:52 -0500 (CDT)
Received: from zimbra.hsv.digium.com ([127.0.0.1])
	by localhost (zimbra.hsv.digium.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XxhBKZUUSFn6; Fri, 10 Sep 2010 11:09:52 -0500 (CDT)
Received: from kildare.digium.internal (unknown [10.24.250.46])
	by zimbra.hsv.digium.com (Postfix) with ESMTPSA id 64420D8191;
	Fri, 10 Sep 2010 11:09:52 -0500 (CDT)
X-Mailer: git-send-email 1.7.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155937>

Changes the logic in the script to determine whether an email message
will be sent before invoking the send_mail() function; otherwise, if
the logic determines that a message will not be sent, send_mail() will
cause an empty email to be sent. In addition, ensures that if multiple
refs are updated and a message cannot be sent for one of them,
the others are still processed normally.

Signed-off-by: Kevin P. Fleming <kpfleming@digium.com>
---
 contrib/hooks/post-receive-email |   47 +++++++++++++++++++++++++-------------
 1 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 0085086..85724bf 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -71,19 +71,10 @@
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
@@ -159,7 +150,7 @@ generate_email()
 			# Anything else (is there anything else?)
 			echo >&2 "*** Unknown type of update to $refname ($rev_type)"
 			echo >&2 "***  - no email generated"
-			exit 1
+			return 0
 			;;
 	esac
 
@@ -175,9 +166,32 @@ generate_email()
 		esac
 		echo >&2 "*** $config_name is not set so no email will be sent"
 		echo >&2 "*** for $refname update $oldrev->$newrev"
-		exit 0
+		return 0
 	fi
 
+	return 1
+}
+
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
@@ -717,10 +731,11 @@ if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
 	# Output to the terminal in command line mode - if someone wanted to
 	# resend an email; they could redirect the output to sendmail
 	# themselves
-	PAGER= generate_email $2 $3 $1
+	prep_for_email $2 $3 $1 && PAGER= generate_email
 else
 	while read oldrev newrev refname
 	do
-		generate_email $oldrev $newrev $refname $maxlines | send_mail
+		prep_for_email $oldrev $newrev $refname || continue
+		generate_email $maxlines | send_mail
 	done
 fi
-- 
1.7.2.2
