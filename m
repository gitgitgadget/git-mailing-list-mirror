From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v2 2/3] send-email: handle multiple Cc addresses when reading mbox message
Date: Sat, 14 Feb 2009 23:32:14 -0500
Message-ID: <1234672335-54321-3-git-send-email-jaysoffian@gmail.com>
References: <1234672335-54321-1-git-send-email-jaysoffian@gmail.com>
 <1234672335-54321-2-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 05:35:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYYj9-0007tT-Rl
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 05:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbZBOEcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 23:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752868AbZBOEcw
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 23:32:52 -0500
Received: from mail-gx0-f222.google.com ([209.85.217.222]:47171 "EHLO
	mail-gx0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbZBOEcv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 23:32:51 -0500
Received: by gxk22 with SMTP id 22so2090856gxk.13
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 20:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Ucj6wgkaHPz2q0j+KgnYXYINY57T/SrRO2MCjALU8VA=;
        b=Nm/eJ9eacSFqfazRR3p10Cg7G97KVEeIyp8Zoq609MMaf3g27FD2q6+vy179YqBt0a
         X4nZ7D2Aed0IyabfZZDpfDrP3UpgZKggZkXENfXxUOmli44SaeuqSG2a+TAd9J97ykPp
         PWq/c7Jo2Wd5cE57acEcKJiGpwyqfCmPaCAno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fc0SPuEb1+c07lEN/al2KfJIEaywicW5IkRUQlaijlwcDmIotQoiBC3leXluPy6E8/
         2tqluckoKnX0Ba19/vJ1ywNSkFo8N2uam2KHn6V0neZ/2YvS6ladfWWiXwdIP1vlww4Q
         eQXVtc04LUo8SiewEOhTESean7rYBITa+Cp+8=
Received: by 10.100.9.19 with SMTP id 19mr2540315ani.8.1234672369226;
        Sat, 14 Feb 2009 20:32:49 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c14sm6494360ana.41.2009.02.14.20.32.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Feb 2009 20:32:48 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.250.g3b7b7
In-Reply-To: <1234672335-54321-2-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109958>

When git format-patch is given multiple --cc arguments, it generates a
Cc header that looks like:

 Cc: first@example.com,
     second@example.com,
     third@example.com

Before this commit, send-email was unable to handle such a message as it
did not handle folded header lines, nor multiple recipients in a Cc
line.

This patch:

- Unfolds header lines by pre-processing the header before extracting
  any of its fields.

- Handles Cc lines with multiple recipients.

- Adds use of Mail::Address if available for splitting Cc line and
  the "Who should the emails be sent to?" prompt", with fall back to
  existing split_addrs() function.

- Tests the new functionality and adds two tests for detecting whether
  "From:" appears correctly in message body when patch author differs
  from patch sender.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Changes from v1:

The original version of this messed up the logic about when to put a
"From:" in the message body. I fixed that and added two tests to make
sure it is right.

j.

 git-send-email.perl   |  153 +++++++++++++++++++++++++++---------------------
 t/t9001-send-email.sh |   44 ++++++++++++--
 2 files changed, 123 insertions(+), 74 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 9dad100..a6efd1f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -126,6 +126,7 @@ sub format_2822_time {
 }
 
 my $have_email_valid = eval { require Email::Valid; 1 };
+my $have_mail_address = eval { require Mail::Address; 1 };
 my $smtp;
 my $auth;
 
@@ -366,6 +367,14 @@ foreach my $entry (@bcclist) {
 	die "Comma in --bcclist entry: $entry'\n" unless $entry !~ m/,/;
 }
 
+sub parse_address_line {
+	if ($have_mail_address) {
+		return map { $_->format } Mail::Address->parse($_[0]);
+	} else {
+		return split_addrs($_[0]);
+	}
+}
+
 sub split_addrs {
 	return quotewords('\s*,\s*', 1, @_);
 }
@@ -602,7 +611,7 @@ if (!@to) {
 	}
 
 	my $to = $_;
-	push @to, split_addrs($to);
+	push @to, parse_address_line($to);
 	$prompting++;
 }
 
@@ -929,88 +938,98 @@ foreach my $t (@files) {
 	@cc = @initial_cc;
 	@xh = ();
 	my $input_format = undef;
-	my $header_done = 0;
+	my @header = ();
 	$message = "";
+	# First unfold multiline header fields
 	while(<F>) {
-		if (!$header_done) {
-			if (/^From /) {
-				$input_format = 'mbox';
-				next;
+		last if /^\s*$/;
+		if (/^\s+\S/ and @header) {
+			chomp($header[$#header]);
+			s/^\s+/ /;
+			$header[$#header] .= $_;
+	    } else {
+			push(@header, $_);
+		}
+	}
+	# Now parse the header
+	foreach(@header) {
+		if (/^From /) {
+			$input_format = 'mbox';
+			next;
+		}
+		chomp;
+		if (!defined $input_format && /^[-A-Za-z]+:\s/) {
+			$input_format = 'mbox';
+		}
+
+		if (defined $input_format && $input_format eq 'mbox') {
+			if (/^Subject:\s+(.*)$/) {
+				$subject = $1;
 			}
-			chomp;
-			if (!defined $input_format && /^[-A-Za-z]+:\s/) {
-				$input_format = 'mbox';
+			elsif (/^From:\s+(.*)$/) {
+				($author, $author_encoding) = unquote_rfc2047($1);
+				next if $suppress_cc{'author'};
+				next if $suppress_cc{'self'} and $author eq $sender;
+				printf("(mbox) Adding cc: %s from line '%s'\n",
+					$1, $_) unless $quiet;
+				push @cc, $1;
 			}
-
-			if (defined $input_format && $input_format eq 'mbox') {
-				if (/^Subject:\s+(.*)$/) {
-					$subject = $1;
-
-				} elsif (/^(Cc|From):\s+(.*)$/) {
-					if (unquote_rfc2047($2) eq $sender) {
+			elsif (/^Cc:\s+(.*)$/) {
+				foreach my $addr (parse_address_line($1)) {
+					if (unquote_rfc2047($addr) eq $sender) {
 						next if ($suppress_cc{'self'});
-					}
-					elsif ($1 eq 'From') {
-						($author, $author_encoding)
-						  = unquote_rfc2047($2);
-						next if ($suppress_cc{'author'});
 					} else {
 						next if ($suppress_cc{'cc'});
 					}
 					printf("(mbox) Adding cc: %s from line '%s'\n",
-						$2, $_) unless $quiet;
-					push @cc, $2;
+						$addr, $_) unless $quiet;
+					push @cc, $addr;
 				}
-				elsif (/^Content-type:/i) {
-					$has_content_type = 1;
-					if (/charset="?([^ "]+)/) {
-						$body_encoding = $1;
-					}
-					push @xh, $_;
-				}
-				elsif (/^Message-Id: (.*)/i) {
-					$message_id = $1;
-				}
-				elsif (!/^Date:\s/ && /^[-A-Za-z]+:\s+\S/) {
-					push @xh, $_;
-				}
-
-			} else {
-				# In the traditional
-				# "send lots of email" format,
-				# line 1 = cc
-				# line 2 = subject
-				# So let's support that, too.
-				$input_format = 'lots';
-				if (@cc == 0 && !$suppress_cc{'cc'}) {
-					printf("(non-mbox) Adding cc: %s from line '%s'\n",
-						$_, $_) unless $quiet;
-
-					push @cc, $_;
-
-				} elsif (!defined $subject) {
-					$subject = $_;
+			}
+			elsif (/^Content-type:/i) {
+				$has_content_type = 1;
+				if (/charset="?([^ "]+)/) {
+					$body_encoding = $1;
 				}
+				push @xh, $_;
 			}
-
-			# A whitespace line will terminate the headers
-			if (m/^\s*$/) {
-				$header_done = 1;
+			elsif (/^Message-Id: (.*)/i) {
+				$message_id = $1;
 			}
+			elsif (!/^Date:\s/ && /^[-A-Za-z]+:\s+\S/) {
+				push @xh, $_;
+			}
+
 		} else {
-			$message .=  $_;
-			if (/^(Signed-off-by|Cc): (.*)$/i) {
-				next if ($suppress_cc{'sob'});
-				chomp;
-				my $c = $2;
-				chomp $c;
-				next if ($c eq $sender and $suppress_cc{'self'});
-				push @cc, $c;
-				printf("(sob) Adding cc: %s from line '%s'\n",
-					$c, $_) unless $quiet;
+			# In the traditional
+			# "send lots of email" format,
+			# line 1 = cc
+			# line 2 = subject
+			# So let's support that, too.
+			$input_format = 'lots';
+			if (@cc == 0 && !$suppress_cc{'cc'}) {
+				printf("(non-mbox) Adding cc: %s from line '%s'\n",
+					$_, $_) unless $quiet;
+				push @cc, $_;
+			} elsif (!defined $subject) {
+				$subject = $_;
 			}
 		}
 	}
+	# Now parse the message body
+	while(<F>) {
+		$message .=  $_;
+		if (/^(Signed-off-by|Cc): (.*)$/i) {
+			next if ($suppress_cc{'sob'});
+			chomp;
+			my $c = $2;
+			chomp $c;
+			next if ($c eq $sender and $suppress_cc{'self'});
+			push @cc, $c;
+			printf("(sob) Adding cc: %s from line '%s'\n",
+				$c, $_) unless $quiet;
+		}
+	}
 	close F;
 
 	if (defined $cc_cmd && !$suppress_cc{'cccmd'}) {
@@ -1029,7 +1048,7 @@ foreach my $t (@files) {
 			or die "(cc-cmd) failed to close pipe to '$cc_cmd'";
 	}
 
-	if (defined $author) {
+	if (defined $author and $author ne $sender) {
 		$message = "From: $author\n\n$message";
 		if (defined $author_encoding) {
 			if ($has_content_type) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index cb3d183..63ab88b 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -32,7 +32,7 @@ clean_fake_sendmail() {
 }
 
 test_expect_success 'Extract patches' '
-    patches=`git format-patch -n HEAD^1`
+    patches=`git format-patch --cc="One <one@example.com>" --cc=two@example.com -n HEAD^1`
 '
 
 test_expect_success 'Send patches' '
@@ -42,6 +42,8 @@ test_expect_success 'Send patches' '
 cat >expected <<\EOF
 !nobody@example.com!
 !author@example.com!
+!one@example.com!
+!two@example.com!
 EOF
 test_expect_success \
     'Verify commandline' \
@@ -50,13 +52,15 @@ test_expect_success \
 cat >expected-show-all-headers <<\EOF
 0001-Second.patch
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
+(mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
+(mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
 Dry-OK. Log says:
 Server: relay.example.com
 MAIL FROM:<from@example.com>
-RCPT TO:<to@example.com>,<cc@example.com>,<author@example.com>,<bcc@example.com>
+RCPT TO:<to@example.com>,<cc@example.com>,<author@example.com>,<one@example.com>,<two@example.com>,<bcc@example.com>
 From: Example <from@example.com>
 To: to@example.com
-Cc: cc@example.com, A <author@example.com>
+Cc: cc@example.com, A <author@example.com>, One <one@example.com>, two@example.com
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
 Message-Id: MESSAGE-ID-STRING
@@ -104,6 +108,28 @@ test_expect_success 'no patch was sent' '
 	! test -e commandline1
 '
 
+test_expect_success 'Author From: in message body' '
+	clean_fake_sendmail &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		$patches &&
+	sed "1,/^$/d" < msgtxt1 > msgbody1
+	grep "From: A <author@example.com>" msgbody1
+'
+
+test_expect_success 'Author From: not in message body' '
+	clean_fake_sendmail &&
+	git send-email \
+		--from="A <author@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		$patches &&
+	sed "1,/^$/d" < msgtxt1 > msgbody1
+	! grep "From: A <author@example.com>" msgbody1
+'
+
 test_expect_success 'allow long lines with --no-validate' '
 	git send-email \
 		--from="Example <nobody@example.com>" \
@@ -170,13 +196,15 @@ test_expect_success 'second message is patch' '
 cat >expected-show-all-headers <<\EOF
 0001-Second.patch
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
+(mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
+(mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
 Dry-OK. Log says:
 Server: relay.example.com
 MAIL FROM:<from@example.com>
-RCPT TO:<to@example.com>,<cc@example.com>,<author@example.com>
+RCPT TO:<to@example.com>,<cc@example.com>,<author@example.com>,<one@example.com>,<two@example.com>
 From: Example <from@example.com>
 To: to@example.com
-Cc: cc@example.com, A <author@example.com>
+Cc: cc@example.com, A <author@example.com>, One <one@example.com>, two@example.com
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
 Message-Id: MESSAGE-ID-STRING
@@ -203,13 +231,15 @@ test_expect_success 'sendemail.cc set' '
 cat >expected-show-all-headers <<\EOF
 0001-Second.patch
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
+(mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
+(mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
 Dry-OK. Log says:
 Server: relay.example.com
 MAIL FROM:<from@example.com>
-RCPT TO:<to@example.com>,<author@example.com>
+RCPT TO:<to@example.com>,<author@example.com>,<one@example.com>,<two@example.com>
 From: Example <from@example.com>
 To: to@example.com
-Cc: A <author@example.com>
+Cc: A <author@example.com>, One <one@example.com>, two@example.com
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
 Message-Id: MESSAGE-ID-STRING
-- 
1.6.2.rc0.251.g344d
