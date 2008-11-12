From: Michael Adam <obnox@samba.org>
Subject: [PATCH v2] contrib/hooks/post-receive-email: send individual mails to recipients
Date: Wed, 12 Nov 2008 17:50:15 +0100
Organization: SerNet GmbH, Goettingen, Germany
Message-ID: <E1L0Iv1-00BwsF-Jh@intern.SerNet.DE>
Cc: Andy Parkins <andyparkins@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Adam <obnox@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 12 17:51:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0IwI-0005FF-Az
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 17:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbYKLQuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 11:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbYKLQuT
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 11:50:19 -0500
Received: from mail.SerNet.de ([193.175.80.2]:56013 "EHLO mail.SerNet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425AbYKLQuS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 11:50:18 -0500
Received: from intern.SerNet.DE by mail.SerNet.DE
	with esmtp (Exim 4.63 #1)
	id 1L0Iv1-0001CM-RB; Wed, 12 Nov 2008 17:50:15 +0100
Received: by intern.SerNet.DE
	id 1L0Iv1-00BwsF-Jh; Wed, 12 Nov 2008 17:50:15 +0100
Received: from intern.SerNet.DE (localhost [127.0.0.1])
	by localhost (AvMailGate-2.1.4-7) id 2847918-BgNbnT;
	Wed, 12 Nov 2008 17:50:15 +0100 (CET)
Received: by intern.SerNet.DE
	id 1L0Iv1-00Bws5-EH; Wed, 12 Nov 2008 17:50:15 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100768>

This changes the behaviour of post-receive-email when a list of recipients
(separated by commas) is specified as hooks.mailinglist. With this modification,
an individual mail is sent out for each recipient entry in the list, instead
of sending a single mail with all the recipients in the "To: " field.

Signed-off-by: Michael Adam <obnox@samba.org>
---
Sorry, in the first version of the patch, I forgot to
adapt the generate_email_header() function fill the "To"
field only with "$recipient" instad of "$recipients".

Cheers - Michael

 contrib/hooks/post-receive-email |   32 ++++++++++++++++++--------------
 1 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 28a3c0e..f8bbeab 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -169,21 +169,25 @@ generate_email()
 		describe=$rev
 	fi
 
-	generate_email_header
+	# loop over the recipients to send individual mails
+	echo $recipients | sed -e 's/\s*,\s*/\n/' | while read recipient
+	do
+		generate_email_header
 
-	# Call the correct body generation function
-	fn_name=general
-	case "$refname_type" in
-	"tracking branch"|branch)
-		fn_name=branch
-		;;
-	"annotated tag")
-		fn_name=atag
-		;;
-	esac
-	generate_${change_type}_${fn_name}_email
+		# Call the correct body generation function
+		fn_name=general
+		case "$refname_type" in
+		"tracking branch"|branch)
+			fn_name=branch
+			;;
+		"annotated tag")
+			fn_name=atag
+			;;
+		esac
+		generate_${change_type}_${fn_name}_email
 
-	generate_email_footer
+		generate_email_footer
+	done
 }
 
 generate_email_header()
@@ -191,7 +195,7 @@ generate_email_header()
 	# --- Email (all stdout will be the email)
 	# Generate header
 	cat <<-EOF
-	To: $recipients
+	To: $recipient
 	Subject: ${emailprefix}$projectdesc $refname_type, $short_refname, ${change_type}d. $describe
 	X-Git-Refname: $refname
 	X-Git-Reftype: $refname_type
-- 
1.5.6
