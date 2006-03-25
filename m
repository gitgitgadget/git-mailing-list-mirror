From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] send-email: try to order messages in email clients more correctly
Date: Sat, 25 Mar 2006 03:01:01 -0800
Message-ID: <11432844613551-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git <git@vger.kernel.org>, Greg KH <greg@kroah.com>,
	Ryan Anderson <ryan@michonline.com>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Mar 25 12:01:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN6We-0003TK-Ie
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 12:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWCYLBb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 06:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWCYLBb
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 06:01:31 -0500
Received: from hand.yhbt.net ([66.150.188.102]:43656 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751095AbWCYLBb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 06:01:31 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 1D2807DC005;
	Sat, 25 Mar 2006 03:01:28 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17979>

If --no-chain-reply-to is set, patches may not always be ordered
correctly in email clients.  This patch makes sure each email
sent from a different second.

I chose to start with a time (slightly) in the past because
those are probably more likely in real-world usage and spam
filters might be more tolerant of them.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-send-email.perl |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

695849a185ee8cfc8f3df0c737ff16a04cc84a5b
diff --git a/git-send-email.perl b/git-send-email.perl
index 207b1fb..de635ed 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -37,7 +37,7 @@ sub cleanup_compose_files();
 my $compose_filename = ".msg.$$";
 
 # Variables we fill in automatically, or via prompting:
-my (@to,@cc,@initial_cc,$initial_reply_to,$initial_subject,@files,$from,$compose);
+my (@to,@cc,@initial_cc,$initial_reply_to,$initial_subject,@files,$from,$compose,$time);
 
 # Behavior modification variables
 my ($chain_reply_to, $smtp_server, $quiet, $suppress_from, $no_signed_off_cc) = (1, "localhost", 0, 0, 0);
@@ -295,13 +295,14 @@ sub make_message_id
 
 
 $cc = "";
+$time = time - scalar $#files;
 
 sub send_message
 {
 	my @recipients = unique_email_list(@to);
 	my $to = join (",\n\t", @recipients);
 	@recipients = unique_email_list(@recipients,@cc);
-	my $date = strftime('%a, %d %b %Y %H:%M:%S %z', localtime(time));
+	my $date = strftime('%a, %d %b %Y %H:%M:%S %z', localtime($time++));
 
 	my $header = "From: $from
 To: $to
-- 
1.2.4.gb622a
