From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] send-email: validate & reconfirm interactive responses
Date: Tue, 14 Aug 2012 15:25:32 -0700
Message-ID: <1344983132-22578-1-git-send-email-gitster@pobox.com>
References: <CAOeW2eGZm7PLRaktjQQdDJm2BqAihS0pzsY2GUNFUO83s8qBPQ@mail.gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 15 00:25:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1PYT-0000g5-8t
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 00:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133Ab2HNWZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 18:25:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48987 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095Ab2HNWZe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 18:25:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4844C9AD6;
	Tue, 14 Aug 2012 18:25:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=2VUs
	ruNlVh2StAz/GNouDuxBg+c=; b=r5wbBTTe3S0x1Z3CVMnT6CtU0/5e468PgNbu
	wlwvJ3bK0mULon0uIg+Sv+gu7OW27wNWnpDKv6+BkvgCaLNLKEsd0yhxldXwlNpW
	PRSK5sZ+4Ak23FRm6rDT0wpJdx5E3xohza4DNlEfK1mOXO5A7DhpYxWO249eXto/
	BLKDytk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Cx9684DzhnrSk+xvU907KSipZi6BT963qAvx2PoB1TqgGds83Zvm7TC10x9TD0Vr
	xNuNVD9rL9ppcGLyA0y7kkZkZjmxypLkrAyRFQHocZebnwqfwO9r8NqQ12E6V0ef
	Waz5PR1xzIUvUtw5WgKAnpabfCgBUiQxSYWJYpOtciI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 364089AD5;
	Tue, 14 Aug 2012 18:25:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CF509AD4; Tue, 14 Aug 2012
 18:25:33 -0400 (EDT)
X-Mailer: git-send-email 1.7.8.3.2.gc7cbb
In-Reply-To: <CAOeW2eGZm7PLRaktjQQdDJm2BqAihS0pzsY2GUNFUO83s8qBPQ@mail.gmail.com>
X-Pobox-Relay-ID: F6911F12-E65E-11E1-8AE5-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203456>

People answer 'y' to "Who should the emails appear to be from?"  and
'n' to "Message-ID to be used as In-Reply-To for the first email?"
for some unknown reason.  While it is possible that really have "y"
as your local username and sending the mail to your local colleagues,
it is plausible that it could be an error.

Fortunately, our interactive prompter already has input validation
mechanism built-in.  Enhance it so that we can optionally reconfirm
and allow the user to pass an input that does not validate, and
"softly" require input to the sender, in-reply-to, and recipient to
contain "@" and "." in this order, which would catch most cases of
mistakes.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-send-email.perl | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index ef30c55..e89729b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -681,6 +681,7 @@ sub ask {
 	my ($prompt, %arg) = @_;
 	my $valid_re = $arg{valid_re};
 	my $default = $arg{default};
+	my $confirm_only = $arg{confirm_only};
 	my $resp;
 	my $i = 0;
 	return defined $default ? $default : undef
@@ -698,6 +699,12 @@ sub ask {
 		if (!defined $valid_re or $resp =~ /$valid_re/) {
 			return $resp;
 		}
+		if ($confirm_only) {
+			my $yesno = $term->readline("Are you sure you want to use <$resp> [y/N]? ");
+			if (defined $yesno && $yesno =~ /y/i) {
+				return $resp;
+			}
+		}
 	}
 	return undef;
 }
@@ -745,13 +752,15 @@ sub file_declares_8bit_cte {
 if (!defined $sender) {
 	$sender = $repoauthor || $repocommitter || '';
 	$sender = ask("Who should the emails appear to be from? [$sender] ",
-	              default => $sender);
+	              default => $sender,
+		      valid_re => qr/\@.*\./, confirm_only => 1);
 	print "Emails will be sent from: ", $sender, "\n";
 	$prompting++;
 }
 
 if (!@initial_to && !defined $to_cmd) {
-	my $to = ask("Who should the emails be sent to? ");
+	my $to = ask("Who should the emails be sent to? ",
+		     valid_re => qr/\@.*\./, confirm_only => 1);
 	push @initial_to, parse_address_line($to) if defined $to; # sanitized/validated later
 	$prompting++;
 }
@@ -777,7 +786,8 @@ sub expand_one_alias {
 
 if ($thread && !defined $initial_reply_to && $prompting) {
 	$initial_reply_to = ask(
-		"Message-ID to be used as In-Reply-To for the first email? ");
+		"Message-ID to be used as In-Reply-To for the first email? ",
+		valid_re => qr/\@.*\./, confirm_only => 1);
 }
 if (defined $initial_reply_to) {
 	$initial_reply_to =~ s/^\s*<?//;
-- 
1.7.12.rc2.18.g61b472e
