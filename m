From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] send-email: automatic envelope sender
Date: Thu, 26 Nov 2009 21:04:29 +0200
Message-ID: <1259262269-23937-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 20:04:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDje7-0004VH-Ss
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 20:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbZKZTEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 14:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbZKZTEk
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 14:04:40 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:42578 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbZKZTEj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 14:04:39 -0500
Received: by bwz27 with SMTP id 27so751502bwz.21
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 11:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=QiOmrx3/bVE27aEs87BKyqLvIWgBM5y/fwzC90sbe9w=;
        b=o2TP+elZOK8EYQxRGRFTnDh+J9/2sgYwD7YB43r02i0lnluMqocNZDD5w1Xcgr9avt
         qZBbtReOo0NbsFbD4B74cwzzdGKEi7EjMCvE3dziB2vSxgGQgr+R4vXWZVRaodK+ld8T
         +Qs1GX8NOe4sqvt4muWY0poWZfEg7cSFrXZqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=aajKB69vVuDh/sZh2+D54et3inmB6ND/iZzKSTsU5uxsz4XlVKX7G4U5ADHKTjUKSJ
         5bV8CGRfwuE9WMNAcOHCsTEp99hVqmji4T1T6mqZkSRUC2OB5BWKsd+XmHgoMEJAHPEv
         EXHNAo2IEbz7TfmLkQZrS2nJQBAIySiIg68ug=
Received: by 10.204.16.88 with SMTP id n24mr133055bka.52.1259262284168;
        Thu, 26 Nov 2009 11:04:44 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 14sm243671bwz.5.2009.11.26.11.04.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Nov 2009 11:04:43 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc0.61.geeb75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133821>

This adds the option to specify the envelope sender as "auto" which
would pick the 'from' address. This is good because now we can specify
the address only in one place (and change it easily).

Comments by Junio C Hamano.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-send-email.txt |    7 ++++---
 git-send-email.perl              |    6 +++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index c85d7f4..8c482f4 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -108,9 +108,10 @@ Sending
 --envelope-sender=<address>::
 	Specify the envelope sender used to send the emails.
 	This is useful if your default address is not the address that is
-	subscribed to a list. If you use the sendmail binary, you must have
-	suitable privileges for the -f parameter. Default is the value of
-	the 'sendemail.envelopesender' configuration variable; if that is
+	subscribed to a list. In order to use the 'From' address, set the
+	value to "auto". If you use the sendmail binary, you must have
+	suitable privileges for the -f parameter.  Default is the value of the
+	'sendemail.envelopesender' configuration variable; if that is
 	unspecified, choosing the envelope sender is left to your MTA.
 
 --smtp-encryption=<encryption>::
diff --git a/git-send-email.perl b/git-send-email.perl
index 4f5da4e..da2e56e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -862,7 +862,11 @@ X-Mailer: git-send-email $gitversion
 
 	my @sendmail_parameters = ('-i', @recipients);
 	my $raw_from = $sanitized_sender;
-	$raw_from = $envelope_sender if (defined $envelope_sender);
+	if (defined $envelope_sender) {
+		if (not $envelope_sender eq "auto") {
+			$raw_from = $envelope_sender;
+		}
+	}
 	$raw_from = extract_valid_address($raw_from);
 	unshift (@sendmail_parameters,
 			'-f', $raw_from) if(defined $envelope_sender);
-- 
1.6.6.rc0.61.geeb75
