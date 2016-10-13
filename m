Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53EE0209AE
	for <e@80x24.org>; Thu, 13 Oct 2016 05:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755313AbcJMFr4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 01:47:56 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56753 "EHLO mx2.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755040AbcJMFry (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 01:47:54 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u9D5lbbB008096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 13 Oct 2016 07:47:37 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u9D5lbnt025237;
        Thu, 13 Oct 2016 07:47:37 +0200
From:   Matthieu Moy <Matthieu.Moy@imag.fr>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Larry Finger <Larry.Finger@lwfinger.net>,
        Jeff King <peff@peff.net>,
        Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] parse_mailboxes: accept extra text after <...> address
Date:   Thu, 13 Oct 2016 07:47:27 +0200
Message-Id: <20161013054727.13402-1-Matthieu.Moy@imag.fr>
X-Mailer: git-send-email 2.10.0.rc0.1.g07c9292
In-Reply-To: <vpqmvi8n71g.fsf@anie.imag.fr>
References: <vpqmvi8n71g.fsf@anie.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Thu, 13 Oct 2016 07:47:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u9D5lbbB008096
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1476942463.12345@LQ4sBdomKyVerKBtf598QQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test introduced in this commit succeeds without the patch to Git.pm
if Mail::Address is installed, but fails otherwise because our in-house
parser does not accept any text after the email address. They succeed
both with and without Mail::Address after this commit.

Mail::Address accepts extra text and considers it as part of the name,
iff the address is surrounded with <...>. The implementation mimics
this behavior as closely as possible.

This mostly restores the behavior we had before b1c8a11 (send-email:
allow multiple emails using --cc, --to and --bcc, 2015-06-30), but we
keep the possibility to handle comma-separated lists.

Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 perl/Git.pm           | 13 +++++++------
 t/t9001-send-email.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index ce7e4e8da394..ca769246216c 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -879,6 +879,7 @@ sub parse_mailboxes {
 	# divide the string in tokens of the above form
 	my $re_token = qr/(?:$re_quote|$re_word|$re_comment|\S)/;
 	my @tokens = map { $_ =~ /\s*($re_token)\s*/g } @_;
+	my $end_of_addr_seen = 0;
 
 	# add a delimiter to simplify treatment for the last mailbox
 	push @tokens, ",";
@@ -888,10 +889,10 @@ sub parse_mailboxes {
 		if ($token =~ /^[,;]$/) {
 			# if buffer still contains undeterminated strings
 			# append it at the end of @address or @phrase
-			if (@address) {
-				push @address, @buffer;
-			} else {
+			if ($end_of_addr_seen) {
 				push @phrase, @buffer;
+			} else {
+				push @address, @buffer;
 			}
 
 			my $str_phrase = join ' ', @phrase;
@@ -915,16 +916,16 @@ sub parse_mailboxes {
 			push @addr_list, $str_mailbox if ($str_mailbox);
 
 			@phrase = @address = @comment = @buffer = ();
+			$end_of_addr_seen = 0;
 		} elsif ($token =~ /^\(/) {
 			push @comment, $token;
 		} elsif ($token eq "<") {
 			push @phrase, (splice @address), (splice @buffer);
 		} elsif ($token eq ">") {
+			$end_of_addr_seen = 1;
 			push @address, (splice @buffer);
-		} elsif ($token eq "@") {
+		} elsif ($token eq "@" && !$end_of_addr_seen) {
 			push @address, (splice @buffer), "@";
-		} elsif ($token eq ".") {
-			push @address, (splice @buffer), ".";
 		} else {
 			push @buffer, $token;
 		}
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index b3355d2c7016..3dc4a3454d22 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -140,6 +140,35 @@ test_expect_success $PREREQ 'Verify commandline' '
 	test_cmp expected commandline1
 '
 
+test_expect_success $PREREQ 'setup expect for cc trailer' "
+cat >expected-cc <<\EOF
+!recipient@example.com!
+!author@example.com!
+!one@example.com!
+!two@example.com!
+!three@example.com!
+!four@example.com!
+!five@example.com!
+EOF
+"
+
+test_expect_success $PREREQ 'cc trailer with various syntax' '
+	test_commit cc-trailer &&
+	test_when_finished "git reset --hard HEAD^" &&
+	git commit --amend -F - <<-EOF &&
+	Test Cc: trailers.
+
+	Cc: one@example.com
+	Cc: <two@example.com> # this is part of the name
+	Cc: <three@example.com>, <four@example.com> # not.five@example.com
+	Cc: "Some # Body" <five@example.com> [part.of.name.too]
+	EOF
+	clean_fake_sendmail &&
+	git send-email -1 --to=recipient@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" &&
+	test_cmp expected-cc commandline1
+'
+
 test_expect_success $PREREQ 'setup expect' "
 cat >expected-show-all-headers <<\EOF
 0001-Second.patch
-- 
2.10.0.rc0.1.g07c9292

