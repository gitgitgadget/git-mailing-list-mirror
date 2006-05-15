From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] send-email: quiet some warnings, reject invalid addresses
Date: Mon, 15 May 2006 02:41:01 -0700
Message-ID: <11476860611181-git-send-email-normalperson@yhbt.net>
References: <7vlkt3x1qz.fsf@assigned-by-dhcp.cox.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon May 15 11:41:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfZZb-00017J-UB
	for gcvg-git@gmane.org; Mon, 15 May 2006 11:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWEOJlE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 05:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWEOJlE
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 05:41:04 -0400
Received: from hand.yhbt.net ([66.150.188.102]:12707 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932208AbWEOJlD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 05:41:03 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id AEAAF7DC005;
	Mon, 15 May 2006 02:41:01 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 15 May 2006 02:41:01 -0700
To: git <git@vger.kernel.org>, Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Ryan Anderson <ryan@michonline.com>, Greg KH <greg@kroah.com>
X-Mailer: git-send-email 1.3.2.g7d11
In-Reply-To: <7vlkt3x1qz.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20038>

I'm not sure why we never actually rejected invalid addresses in
the first place.  We just seemed to be using our email validity
checkers to kill duplicates.

Now we just drop invalid email addresses completely and warn
the user about it.

Since we support local sendmail, we'll also accept username-only
addresses.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-send-email.perl |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

f069e9a9cee726d82dfeee1d477152a0fe0651c1
diff --git a/git-send-email.perl b/git-send-email.perl
index 0540e93..312a4ea 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -307,6 +307,10 @@ our ($message_id, $cc, %mail, $subject, 
 
 sub extract_valid_address {
 	my $address = shift;
+
+	# check for a local address:
+	return $address if ($address =~ /^([\w\-]+)$/);
+
 	if ($have_email_valid) {
 		return Email::Valid->address($address);
 	} else {
@@ -498,9 +502,14 @@ sub unique_email_list(@) {
 	my @emails;
 
 	foreach my $entry (@_) {
-		my $clean = extract_valid_address($entry);
-		next if $seen{$clean}++;
-		push @emails, $entry;
+		if (my $clean = extract_valid_address($entry)) {
+			$seen{$clean} ||= 0;
+			next if $seen{$clean}++;
+			push @emails, $entry;
+		} else {
+			print STDERR "W: unable to extract a valid address",
+					" from: $entry\n";
+		}
 	}
 	return @emails;
 }
-- 
1.3.2.g7d11
