From: Lars Noschinski <lars@public.noschinski.de>
Subject: [PATCH] post-receive-email: do not call sendmail if no mail was generated
Date: Tue,  8 Sep 2009 21:00:18 +0200
Message-ID: <1252436418-7660-1-git-send-email-lars@public.noschinski.de>
References: <20090908185555.GA3858@lars.home.noschinski.de>
Cc: andyparkins@gmail.com, pape@smarden.org, gitster@pobox.com,
	Lars Noschinski <lars@public.noschinski.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 08 21:09:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml64D-00048S-4H
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 21:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbZIHTJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 15:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbZIHTJO
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 15:09:14 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:56318 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbZIHTJN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 15:09:13 -0400
Received: from [87.78.95.112] (helo=fruehjahrsmuede.home.noschinski.de)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars@vertikal.home.noschinski.de>)
	id 1Ml5uV-0007MU-DQ; Tue, 08 Sep 2009 20:59:23 +0200
Received: from lars by fruehjahrsmuede.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars@vertikal.home.noschinski.de>)
	id 1Ml5wL-000202-Bp; Tue, 08 Sep 2009 21:01:18 +0200
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <20090908185555.GA3858@lars.home.noschinski.de>
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128024>

contrib/hooks/post-receive-email used to call the send_mail function
(and thus, /usr/sbin/sendmail), even if generate_mail generated no
output.  This is problematic, as the sendmail binary provided by exim4
generates an error mail if provided with an empty input.

Therefore, we now read one line ourselves and use the result to decide
if we really want to call /usr/sbin/sendmail.
---
 contrib/hooks/post-receive-email |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

Two things changed:

 - we do not read the whole mail in a shell variable
 - the decision whether to call sendmail is based on the output generated
   by generate_mail, not its return code

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 2a66063..c855c31 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -637,6 +637,16 @@ show_new_revisions()
 
 send_mail()
 {
+	OIFS=$IFS
+	IFS='
+'
+	read FIRSTLINE || exit 1
+	(printf $FIRSTLINE'\n'; cat) | call_sendmail
+	IFS=$OLD_IFS
+}
+
+call_sendmail()
+{
 	if [ -n "$envelopesender" ]; then
 		/usr/sbin/sendmail -t -f "$envelopesender"
 	else
@@ -644,6 +654,7 @@ send_mail()
 	fi
 }
 
+
 # ---------------------------- main()
 
 # --- Constants
-- 
1.6.3.3
