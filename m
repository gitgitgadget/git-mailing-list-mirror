From: Lars Noschinski <lars@public.noschinski.de>
Subject: [PATCH] post-receive-email: do not call sendmail if no mail was generated
Date: Fri, 28 Aug 2009 19:39:47 +0200
Message-ID: <1251481187-6361-1-git-send-email-lars@public.noschinski.de>
Cc: gitster@pobox.com, Lars Noschinski <lars@public.noschinski.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 20:02:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh5mi-0007QB-BJ
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 20:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbZH1SCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 14:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbZH1SCj
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 14:02:39 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:42351 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbZH1SCj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 14:02:39 -0400
X-Greylist: delayed 416 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Aug 2009 14:02:39 EDT
Received: from [87.78.70.143] (helo=fruehjahrsmuede.home.noschinski.de)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars@vertikal.home.noschinski.de>)
	id 1Mh5PD-0003eW-Qn; Fri, 28 Aug 2009 19:38:32 +0200
Received: from lars by fruehjahrsmuede.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars@vertikal.home.noschinski.de>)
	id 1Mh5Qd-0001f5-Rt; Fri, 28 Aug 2009 19:40:00 +0200
X-Mailer: git-send-email 1.6.3.3
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127321>

contrib/hooks/post-receive-email used to call the send_mail function
(and thus, /usr/sbin/sendmail), even if generate_mail returned an error.
This is problematic, as the sendmail binary provided by exim4 generates
an error mail if provided with an empty input.

Therefore, this commit changes post-receive-email to only call sendmail
if generate_mail returned without error.

Signed-off-by: Lars Noschinski <lars@public.noschinski.de>
---
 contrib/hooks/post-receive-email |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

Obvious drawback of this solution is that the mails are kept in memory as a
whole. But the mails should be small enough, so that this does not hurt.

I'm not sure how to write a test for this bug, as the hook (correctly) uses an
absolute path to call sendmail.

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 2a66063..818a270 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -684,6 +684,9 @@ if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
 else
 	while read oldrev newrev refname
 	do
-		generate_email $oldrev $newrev $refname | send_mail
+		mail="$(generate_email $oldrev $newrev $refname)"
+		if [ $? -eq 0 ]; then
+			printf '%s' "$mail" | send_mail
+		fi
 	done
 fi
-- 
1.6.3.3
