From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: [PATCH 3/5] git-send-email: remove invalid addresses earlier
Date: Thu, 22 Nov 2012 19:12:10 +0100
Message-ID: <1353607932-10436-3-git-send-email-krzysiek@podlesie.net>
References: <7v8v9vrgc9.fsf@alter.siamese.dyndns.org>
 <1353607932-10436-1-git-send-email-krzysiek@podlesie.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Felipe Balbi <balbi@ti.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Krzysztof Mazur <krzysiek@podlesie.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 00:00:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbfkf-0005aO-Iy
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 00:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248Ab2KVWu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 17:50:27 -0500
Received: from [93.179.225.50] ([93.179.225.50]:46328 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752537Ab2KVScP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 13:32:15 -0500
Received: from geronimo.kostuchna.emnet (localhost [127.0.0.1])
	by shrek.podlesie.net (Postfix) with ESMTP id 262705EF;
	Thu, 22 Nov 2012 19:12:55 +0100 (CET)
X-Mailer: git-send-email 1.8.0.411.g71a7da8
In-Reply-To: <1353607932-10436-1-git-send-email-krzysiek@podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210220>

Some addresses are passed twice to unique_email_list() and invalid addresses
may be reported twice per send_message. Now we warn about them earlier
and we also remove invalid addresses.

This also removes using of undefined values for string comparison
for invalid addresses in cc list processing.

Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
---
 git-send-email.perl | 52 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 356f99d..5056fdc 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -786,9 +786,11 @@ sub expand_one_alias {
 }
 
 @initial_to = expand_aliases(@initial_to);
-@initial_to = (map { sanitize_address($_) } @initial_to);
+@initial_to = validate_address_list(sanitize_address_list(@initial_to));
 @initial_cc = expand_aliases(@initial_cc);
+@initial_cc = validate_address_list(sanitize_address_list(@initial_cc));
 @bcclist = expand_aliases(@bcclist);
+@bcclist = validate_address_list(sanitize_address_list(@bcclist));
 
 if ($thread && !defined $initial_reply_to && $prompting) {
 	$initial_reply_to = ask(
@@ -839,6 +841,28 @@ sub extract_valid_address {
 	return undef;
 }
 
+sub extract_valid_address_or_die {
+	my $address = shift;
+	$address = extract_valid_address($address);
+	die "error: unable to extract a valid address from: $address\n"
+		if !$address;
+	return $address;
+}
+
+sub validate_address {
+	my $address = shift;
+	if (!extract_valid_address($address)) {
+		print STDERR "W: unable to extract a valid address from: $address\n";
+		return undef;
+	}
+	return $address;
+}
+
+sub validate_address_list {
+	return (grep { defined $_ }
+		map { validate_address($_) } @_);
+}
+
 # Usually don't need to change anything below here.
 
 # we make a "fake" message id by taking the current number
@@ -955,6 +979,10 @@ sub sanitize_address {
 
 }
 
+sub sanitize_address_list {
+	return (map { sanitize_address($_) } @_);
+}
+
 # Returns the local Fully Qualified Domain Name (FQDN) if available.
 #
 # Tightly configured MTAa require that a caller sends a real DNS
@@ -1017,14 +1045,13 @@ sub maildomain {
 
 sub send_message {
 	my @recipients = unique_email_list(@to);
-	@cc = (grep { my $cc = extract_valid_address($_);
+	@cc = (grep { my $cc = extract_valid_address_or_die($_);
 		      not grep { $cc eq $_ || $_ =~ /<\Q${cc}\E>$/ } @recipients
 		    }
-	       map { sanitize_address($_) }
 	       @cc);
 	my $to = join (",\n\t", @recipients);
 	@recipients = unique_email_list(@recipients,@cc,@bcclist);
-	@recipients = (map { extract_valid_address($_) } @recipients);
+	@recipients = (map { extract_valid_address_or_die($_) } @recipients);
 	my $date = format_2822_time($time++);
 	my $gitversion = '@@GIT_VERSION@@';
 	if ($gitversion =~ m/..GIT_VERSION../) {
@@ -1267,7 +1294,7 @@ foreach my $t (@files) {
 				foreach my $addr (parse_address_line($1)) {
 					printf("(mbox) Adding to: %s from line '%s'\n",
 						$addr, $_) unless $quiet;
-					push @to, sanitize_address($addr);
+					push @to, $addr;
 				}
 			}
 			elsif (/^Cc:\s+(.*)$/) {
@@ -1376,6 +1403,9 @@ foreach my $t (@files) {
 		($confirm =~ /^(?:auto|compose)$/ && $compose && $message_num == 1));
 	$needs_confirm = "inform" if ($needs_confirm && $confirm_unconfigured && @cc);
 
+	@to = validate_address_list(sanitize_address_list(@to));
+	@cc = validate_address_list(sanitize_address_list(@cc));
+
 	@to = (@initial_to, @to);
 	@cc = (@initial_cc, @cc);
 
@@ -1431,14 +1461,10 @@ sub unique_email_list {
 	my @emails;
 
 	foreach my $entry (@_) {
-		if (my $clean = extract_valid_address($entry)) {
-			$seen{$clean} ||= 0;
-			next if $seen{$clean}++;
-			push @emails, $entry;
-		} else {
-			print STDERR "W: unable to extract a valid address",
-					" from: $entry\n";
-		}
+		my $clean = extract_valid_address_or_die($entry))
+		$seen{$clean} ||= 0;
+		next if $seen{$clean}++;
+		push @emails, $entry;
 	}
 	return @emails;
 }
-- 
1.8.0.393.gcc9701d
