From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] send-email: quiet some warnings
Date: Sun, 14 May 2006 19:38:08 -0700
Message-ID: <11476606883991-git-send-email-normalperson@yhbt.net>
References: <1147660345772-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon May 15 04:38:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfSyN-0003bA-2R
	for gcvg-git@gmane.org; Mon, 15 May 2006 04:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWEOCiL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 22:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWEOCiL
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 22:38:11 -0400
Received: from hand.yhbt.net ([66.150.188.102]:49056 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751389AbWEOCiK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 22:38:10 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 1E8BB7DC005;
	Sun, 14 May 2006 19:38:09 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 14 May 2006 19:38:08 -0700
To: Junio C Hamano <junkio@cox.net>, <git@vger.kernel.org>
X-Mailer: git-send-email 1.3.2.g0e5a
In-Reply-To: <1147660345772-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20012>

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-send-email.perl |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

0e5a33f56f62e527b74b2afbd93a1cca812f97af
diff --git a/git-send-email.perl b/git-send-email.perl
index d27a7a5..379e0c4 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -507,8 +507,16 @@ sub unique_email_list(@) {
 	my @emails;
 
 	foreach my $entry (@_) {
-		my $clean = extract_valid_address($entry);
-		next if $seen{$clean}++;
+		if (my $clean = extract_valid_address($entry)) {
+			$seen{$clean} ||= 0;
+			next if $seen{$clean}++;
+		} else {
+			# it could still be a local email address without '@',
+			# which neither Email::Valid or our own small regex says
+			# is valid...
+			$seen{$entry} ||= 0;
+			next if $seen{$entry}++;
+		}
 		push @emails, $entry;
 	}
 	return @emails;
-- 
1.3.2.g0e5a
