From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] send-email: handle multiple Cc addresses when reading mbox message
Date: Fri, 13 Feb 2009 18:05:13 -0500
Message-ID: <1234566313-36478-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Ryan Anderson <ryan@michonline.com>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 00:06:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY77R-0001J6-B4
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 00:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755522AbZBMXFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 18:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755004AbZBMXFV
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 18:05:21 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:61413 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401AbZBMXFT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 18:05:19 -0500
Received: by qyk4 with SMTP id 4so1969765qyk.13
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 15:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=VNJAK3y+GZ+2wPD3V+CBg/HTVUzMMo+ilYPSe1nnWK0=;
        b=m1T4DQJrGE2pE4bhHiq8NiUvqeyDXuIf8oO+MmEMEccnowezKGtD5CicOmXro+4sFM
         EaC7/e0ldjaS2ojQaCKrkH+i+c95k8NL5qCbsAUHp+JQ1YfmJSkfov5abnz7bxUxduHl
         a8yCZgCIEAPlueYI3mAoKMSrpy9SAdoNSZLy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=EWt0kl+uQCh+o2gFUrkjf6xfS7NAMYJmvyB+l2Cj8FWmGPBY8uyYZlZw3+lISH+zGz
         LVryByJmh96Oy7UFL+lwr11POJ2ZBj2DAy+nofLTy5kXs3tdAaTa24VO3uU6DyWrxlKf
         8vbnTVgSaPC5zSpOctoklE0TMP5tPi4wJ1LOQ=
Received: by 10.224.28.72 with SMTP id l8mr4283883qac.77.1234566317370;
        Fri, 13 Feb 2009 15:05:17 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 5sm1273008qwg.54.2009.02.13.15.05.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Feb 2009 15:05:16 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.235.g1319
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109783>

From: Jay Soffian <jaysoffian@gmail.com>

When git format-patch is given multiple --cc arguments, it generates a
Cc header that looks like:

 Cc: first@example.com,
     second@example.com,
     third@example.com

Before this commit, send-email was unable to handle such a message.
First, it didn't know how to handle a header split across multiple
lines. Second, it couldn't handle multiple comma-separated addresses,
even if they were provided all on a single Cc: line.

This patch teaches it to unfold header lines by pre-processing the
header before extracting any of its fields. It also teaches it to split
the Cc line using Mail::Address if available, otherwise it just splits
on a simple \s*,\s* regular expression.

Also, conditionally use Mail::Address to handle the response to the "Who
should the emails be sent to?" prompt.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
This message which you are reading was generated with:
$ git format-patch --cc="Ryan Anderson <ryan@michonline.com>" \
  --cc=gitster@pobox.com -s -1

And sent with:
$ git send-email --from 'Jay Soffian <jaysoffian@gmail.com>' \
  --to git@vger.kernel.org  --cc 'Jay Soffian <jaysoffian@gmail.com>'

Before this patch, send-email would not have sent it properly. :-)

j.

 git-send-email.perl   |  150 +++++++++++++++++++++++++++---------------------
 t/t9001-send-email.sh |   22 +++++--
 2 files changed, 99 insertions(+), 73 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 77ca8fe..cde294c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -126,6 +126,7 @@ sub format_2822_time {
 }
 
 my $have_email_valid = eval { require Email::Valid; 1 };
+my $have_mail_address = eval { require Mail::Address; 1 };
 my $smtp;
 my $auth;
 
@@ -360,6 +361,14 @@ foreach my $entry (@bcclist) {
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
@@ -593,7 +602,7 @@ if (!@to) {
 	}
 
 	my $to = $_;
-	push @to, split_addrs($to);
+	push @to, parse_address_line($to);
 	$prompting++;
 }
 
@@ -920,88 +929,97 @@ foreach my $t (@files) {
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
+				next if ($suppress_cc{'author'});
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
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index cb3d183..da54835 100755
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
@@ -170,13 +174,15 @@ test_expect_success 'second message is patch' '
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
@@ -203,13 +209,15 @@ test_expect_success 'sendemail.cc set' '
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
1.6.2.rc0.67.g77afc
