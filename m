Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8679E208CD
	for <e@80x24.org>; Wed, 23 Aug 2017 10:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753828AbdHWK3F (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 06:29:05 -0400
Received: from zm-mta-out-1.u-ga.fr ([152.77.200.56]:59852 "EHLO
        zm-mta-out-1.u-ga.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753728AbdHWK3E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 06:29:04 -0400
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Aug 2017 06:29:04 EDT
Received: from zm-mta-out.u-ga.fr (zm-mta-out.u-ga.fr [152.77.200.58])
        by zm-mta-out-1.u-ga.fr (Postfix) with ESMTP id 03D5DA052C;
        Wed, 23 Aug 2017 12:21:16 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps.univ-grenoble-alpes.fr [152.77.1.30])
        by zm-mta-out.u-ga.fr (Postfix) with ESMTP id 58AABE0097;
        Wed, 23 Aug 2017 12:21:18 +0200 (CEST)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPS id BF79F125EB7;
        Wed, 23 Aug 2017 12:21:16 +0200 (CEST)
Received: from moy by anie with local (Exim 4.84_2)
        (envelope-from <moy@imag.fr>)
        id 1dkSmi-0005KN-Me; Wed, 23 Aug 2017 12:21:16 +0200
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     git@vger.kernel.org
Cc:     Matthieu Moy <git@matthieu-moy.fr>
Subject: [RFC PATCH 2/2] send-email: don't use Mail::Address, even if available
Date:   Wed, 23 Aug 2017 12:21:02 +0200
Message-Id: <20170823102102.20120-2-git@matthieu-moy.fr>
X-Mailer: git-send-email 2.14.0.rc0.dirty
In-Reply-To: <20170823102102.20120-1-git@matthieu-moy.fr>
References: <vpqo9r6lhzq.fsf@anie.imag.fr>
 <20170823102102.20120-1-git@matthieu-moy.fr>
X-Greylist: Whitelist-UJF SMTP non authentifie - depuis 129.88.42.32
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using Mail::Address made sense when we didn't have a proper parser. We
now have a reasonable address parser, and using Mail::Address
_if available_ causes much more trouble than it gives benefits:

* Developers typically test one version, not both.

* Users may not be aware that installing Mail::Address will change the
  behavior. They may complain about the behavior in one case without
  knowing that Mail::Address is involved.

* Having this optional Mail::Address makes it tempting to anwser "please
  install Mail::Address" to users instead of fixing our own code. We've
  reached the stage where bugs in our parser should be fixed, not worked
  around.

Signed-off-by: Matthieu Moy <git@matthieu-moy.fr>
---
 git-send-email.perl | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 33a69ffe5d..2208dcc213 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -155,7 +155,6 @@ sub format_2822_time {
 }
 
 my $have_email_valid = eval { require Email::Valid; 1 };
-my $have_mail_address = eval { require Mail::Address; 1 };
 my $smtp;
 my $auth;
 my $num_sent = 0;
@@ -490,11 +489,7 @@ my ($repoauthor, $repocommitter);
 ($repocommitter) = Git::ident_person(@repo, 'committer');
 
 sub parse_address_line {
-	if ($have_mail_address) {
-		return map { $_->format } Mail::Address->parse($_[0]);
-	} else {
-		return Git::parse_mailboxes($_[0]);
-	}
+	return Git::parse_mailboxes($_[0]);
 }
 
 sub split_addrs {
-- 
2.14.0.rc0.dirty

