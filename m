Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 777211F4DD
	for <e@80x24.org>; Fri, 25 Aug 2017 09:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754648AbdHYJMZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 05:12:25 -0400
Received: from zm-mta-out-1.u-ga.fr ([152.77.200.56]:58672 "EHLO
        zm-mta-out-1.u-ga.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754607AbdHYJMY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 05:12:24 -0400
Received: from zm-mta-out.u-ga.fr (zm-mta-out.u-ga.fr [152.77.200.58])
        by zm-mta-out-1.u-ga.fr (Postfix) with ESMTP id 82DD7A02D5;
        Fri, 25 Aug 2017 11:12:22 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps.univ-grenoble-alpes.fr [195.83.24.202])
        by zm-mta-out.u-ga.fr (Postfix) with ESMTP id 6DFE7E0099;
        Fri, 25 Aug 2017 11:12:25 +0200 (CEST)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPS id A7C5A6036A;
        Fri, 25 Aug 2017 11:12:23 +0200 (CEST)
Received: from moy by anie with local (Exim 4.84_2)
        (envelope-from <moy@imag.fr>)
        id 1dlAf9-0003XM-IU; Fri, 25 Aug 2017 11:12:23 +0200
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Matthieu Moy <git@matthieu-moy.fr>
Subject: [PATCH v2 2/2] send-email: don't use Mail::Address, even if available
Date:   Fri, 25 Aug 2017 11:12:00 +0200
Message-Id: <20170825091200.13358-2-git@matthieu-moy.fr>
X-Mailer: git-send-email 2.14.0.rc0.dirty
In-Reply-To: <20170825091200.13358-1-git@matthieu-moy.fr>
References: <vpq378g107m.fsf@anie.imag.fr>
 <20170825091200.13358-1-git@matthieu-moy.fr>
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
index dfd646ac5b..0061dbfab9 100755
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

