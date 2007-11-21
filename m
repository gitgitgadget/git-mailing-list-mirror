From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] Authenticate only once in git-send-email
Date: Wed, 21 Nov 2007 13:35:05 +0100
Message-ID: <1195648505-21653-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 13:35:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuonu-0002FU-LJ
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 13:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757086AbXKUMfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 07:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756696AbXKUMfW
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 07:35:22 -0500
Received: from wincent.com ([72.3.236.74]:54646 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755840AbXKUMfV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 07:35:21 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lALCZ6wV013758;
	Wed, 21 Nov 2007 06:35:07 -0600
X-Mailer: git-send-email 1.5.3.6.862.g369c8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65635>

When using git-send-email with SMTP authentication sending a patch series
would redundantly authenticate multiple times, once for each patch. In
the worst case, this would actually prevent the series from being sent
because the server would reply with a "5.5.0 Already Authenticated"
status code which would derail the process.

This commit teaches git-send-email to authenticate once and only once at
the beginning of the series.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 git-send-email.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 9c6fa64..76baa8e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -145,6 +145,7 @@ sub format_2822_time {
 
 my $have_email_valid = eval { require Email::Valid; 1 };
 my $smtp;
+my $auth;
 
 sub unique_email_list(@);
 sub cleanup_compose_files();
@@ -635,7 +636,7 @@ X-Mailer: git-send-email $gitversion
 		}
 
 		if ((defined $smtp_authuser) && (defined $smtp_authpass)) {
-			$smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
+			$auth ||= $smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
 		}
 		$smtp->mail( $raw_from ) or die $smtp->message;
 		$smtp->to( @recipients ) or die $smtp->message;
-- 
1.5.3.5.737.gdee1b
