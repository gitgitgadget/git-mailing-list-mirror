From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/4] send-email: actually add bcc headers
Date: Sun,  7 Mar 2010 13:33:15 -0800
Message-ID: <1267997598-20815-2-git-send-email-bebarino@gmail.com>
References: <7vk4torn8j.fsf@alter.siamese.dyndns.org>
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Steven Drake <sdrake@xnet.co.nz>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 22:33:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoO6c-0004xa-SH
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 22:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898Ab0CGVd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 16:33:26 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63945 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754802Ab0CGVdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 16:33:25 -0500
Received: by gwb15 with SMTP id 15so2693575gwb.19
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 13:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=AGnB3jNJHiacFOKV8jJVd50HwsLMneQfCeBzRt7vl58=;
        b=jWO2hB1B61DwzGoL9GHT/TObE2W4RA5jB44cLWM0rI73QsdILdtcraNgEqL4RcRAFv
         TNj/3ewgzERMGugwWKldnDm/nxyRFBncnMpCCCBCYbBjsg0pPboBRkHJ4qbPwpls/fQF
         8PlWojXwrbpOYymnDLY9uhNU8iSK56gw7r8Z4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=G0nCxPcfiha2SDfeWA1ThnSC9OvRdppIX8exDduArc8pujimsMZC4bdjGupueH9O1Z
         FYuLN1lZIIS4CyXuVhJHZEr6/HGfIUXOi0vhSSlYQKgb3ItB0o/+LajJWhz5rfVZNg7p
         pq8vfCSLAusXCdL0PvKszbYqSIaeNjoavSSi8=
Received: by 10.101.136.23 with SMTP id o23mr3768418ann.159.1267997604052;
        Sun, 07 Mar 2010 13:33:24 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 7sm1135891yxd.62.2010.03.07.13.33.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 13:33:23 -0800 (PST)
X-Mailer: git-send-email 1.7.0.1.171.geb5ee
In-Reply-To: <7vk4torn8j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141733>

This bug looks ancient. In fact it doesn't look like --bcc ever worked
even when it was introduced in 5806324 (Add support for --bcc to
git-send-email., 2006-05-29).

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 git-send-email.perl   |    7 ++++++-
 t/t9001-send-email.sh |    1 +
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e05455f..3d9c832 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -856,11 +856,16 @@ sub send_message
 	if ($cc ne '') {
 		$ccline = "\nCc: $cc";
 	}
+	my $bcc = join(",\n\t", unique_email_list(@bcclist));
+	my $bccline = "";
+	if ($bcc ne '') {
+		$bccline = "\nBcc: $bcc";
+	}
 	my $sanitized_sender = sanitize_address($sender);
 	make_message_id() unless defined($message_id);
 
 	my $header = "From: $sanitized_sender
-To: $to${ccline}
+To: $to${ccline}${bccline}
 Subject: $subject
 Date: $date
 Message-Id: $message_id
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index c09f375..db91721 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -149,6 +149,7 @@ Cc: cc@example.com,
 	A <author@example.com>,
 	One <one@example.com>,
 	two@example.com
+Bcc: bcc@example.com
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
 Message-Id: MESSAGE-ID-STRING
-- 
1.7.0.1.171.geb5ee
