Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03BE11F4DD
	for <e@80x24.org>; Fri, 25 Aug 2017 09:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754636AbdHYJMS (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 05:12:18 -0400
Received: from zm-mta-out-1.u-ga.fr ([152.77.200.56]:58660 "EHLO
        zm-mta-out-1.u-ga.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754607AbdHYJMR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 05:12:17 -0400
Received: from zm-mta-out.u-ga.fr (zm-mta-out.u-ga.fr [152.77.200.58])
        by zm-mta-out-1.u-ga.fr (Postfix) with ESMTP id BA0F4A0295;
        Fri, 25 Aug 2017 11:12:14 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps.univ-grenoble-alpes.fr [195.83.24.202])
        by zm-mta-out.u-ga.fr (Postfix) with ESMTP id A5506E0099;
        Fri, 25 Aug 2017 11:12:17 +0200 (CEST)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPS id DF2BD6036A;
        Fri, 25 Aug 2017 11:12:15 +0200 (CEST)
Received: from moy by anie with local (Exim 4.84_2)
        (envelope-from <moy@imag.fr>)
        id 1dlAf1-0003Wp-Q7; Fri, 25 Aug 2017 11:12:15 +0200
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Matthieu Moy <git@matthieu-moy.fr>
Subject: [PATCH v2 1/2] send-email: fix garbage removal after address
Date:   Fri, 25 Aug 2017 11:11:59 +0200
Message-Id: <20170825091200.13358-1-git@matthieu-moy.fr>
X-Mailer: git-send-email 2.14.0.rc0.dirty
In-Reply-To: <vpq378g107m.fsf@anie.imag.fr>
References: <vpq378g107m.fsf@anie.imag.fr>
X-Greylist: Whitelist-UJF SMTP non authentifie - depuis 129.88.42.32
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a followup over 9d33439 (send-email: only allow one address
per body tag, 2017-02-20). The first iteration did allow writting

  Cc: <foo@example.com> # garbage

but did so by matching the regex ([^>]*>?), i.e. stop after the first
instance of '>'. However, it did not properly deal with

  Cc: foo@example.com # garbage

Fix this using a new function strip_garbage_one_address, which does
essentially what the old ([^>]*>?) was doing, but dealing with more
corner-cases. Since we've allowed

  Cc: "Foo # Bar" <foobar@example.com>

in previous versions, it makes sense to continue allowing it (but we
still remove any garbage after it). OTOH, when an address is given
without quoting, we just take the first word and ignore everything
after.

Signed-off-by: Matthieu Moy <git@matthieu-moy.fr>
---
Change since v1: removed dead code as suggested by Junio.


 git-send-email.perl   | 22 ++++++++++++++++++++--
 t/t9001-send-email.sh |  4 ++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index fa6526986e..dfd646ac5b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1089,6 +1089,22 @@ sub sanitize_address {
 
 }
 
+sub strip_garbage_one_address {
+	my ($addr) = @_;
+	chomp $addr;
+	if ($addr =~ /^(("[^"]*"|[^"<]*)? *<[^>]*>).*/) {
+		# "Foo Bar" <foobar@example.com> [possibly garbage here]
+		# Foo Bar <foobar@example.com> [possibly garbage here]
+		# <foo@example.com> [possibly garbage here]
+		return $1;
+	}
+	if ($addr =~ /^([^"#,\s]*)/) {
+		# address without quoting: remove anything after the address
+		return $1;
+	}
+	return $addr;
+}
+
 sub sanitize_address_list {
 	return (map { sanitize_address($_) } @_);
 }
@@ -1590,10 +1606,12 @@ foreach my $t (@files) {
 	# Now parse the message body
 	while(<$fh>) {
 		$message .=  $_;
-		if (/^(Signed-off-by|Cc): ([^>]*>?)/i) {
+		if (/^(Signed-off-by|Cc): (.*)/i) {
 			chomp;
 			my ($what, $c) = ($1, $2);
-			chomp $c;
+			# strip garbage for the address we'll use:
+			$c = strip_garbage_one_address($c);
+			# sanitize a bit more to decide whether to suppress the address:
 			my $sc = sanitize_address($c);
 			if ($sc eq $sender) {
 				next if ($suppress_cc{'self'});
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index d1e4e8ad19..f30980895c 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -148,6 +148,8 @@ cat >expected-cc <<\EOF
 !two@example.com!
 !three@example.com!
 !four@example.com!
+!five@example.com!
+!six@example.com!
 EOF
 "
 
@@ -161,6 +163,8 @@ test_expect_success $PREREQ 'cc trailer with various syntax' '
 	Cc: <two@example.com> # trailing comments are ignored
 	Cc: <three@example.com>, <not.four@example.com> one address per line
 	Cc: "Some # Body" <four@example.com> [ <also.a.comment> ]
+	Cc: five@example.com # not.six@example.com
+	Cc: six@example.com, not.seven@example.com
 	EOF
 	clean_fake_sendmail &&
 	git send-email -1 --to=recipient@example.com \
-- 
2.14.0.rc0.dirty

