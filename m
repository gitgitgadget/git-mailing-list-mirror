From: Michael Adam <obnox@samba.org>
Subject: [PATCH] contrib/hooks/post-receive-email: send individual mails to recipients
Date: Wed, 12 Nov 2008 17:21:27 +0100
Organization: SerNet GmbH, Goettingen, Germany
Message-ID: <E1L0ITB-00Bv9t-72@intern.SerNet.DE>
Cc: Andy Parkins <andyparkins@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Adam <obnox@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 12 17:46:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Iqs-0002jK-07
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 17:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbYKLQoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 11:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbYKLQoT
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 11:44:19 -0500
Received: from mail1.SerNet.de ([193.175.80.2]:50730 "EHLO mail.SerNet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777AbYKLQoS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 11:44:18 -0500
X-Greylist: delayed 1359 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Nov 2008 11:44:18 EST
Received: from intern.SerNet.DE by mail.SerNet.DE
	with esmtp (Exim 4.63 #1)
	id 1L0ITB-0002jo-Ks; Wed, 12 Nov 2008 17:21:29 +0100
Received: by intern.SerNet.DE
	id 1L0ITB-00Bv9t-72; Wed, 12 Nov 2008 17:21:29 +0100
Received: from intern.SerNet.DE (localhost [127.0.0.1])
	by localhost (AvMailGate-2.1.4-7) id 2841324-kruBpf;
	Wed, 12 Nov 2008 17:21:29 +0100 (CET)
Received: by intern.SerNet.DE
	id 1L0ITA-00Bv9j-UT; Wed, 12 Nov 2008 17:21:29 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100767>

This changes the behaviour of post-receive-email when a list of recipients
(separated by commas) is specified as hooks.mailinglist. With this modification,
an individual mail is sent out for each recipient entry in the list, instead
of sending a single mail with all the recipients in the "To: " field.

Signed-off-by: Michael Adam <obnox@samba.org>
---
 contrib/hooks/post-receive-email |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 28a3c0e..5deaf28 100644
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
-- 
1.5.6
