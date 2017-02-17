Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF91320136
	for <e@80x24.org>; Fri, 17 Feb 2017 13:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933967AbdBQNQq (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 08:16:46 -0500
Received: from zm23-mta-out-2.grenet.fr ([130.190.191.53]:33185 "EHLO
        zm23-mta-out-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933915AbdBQNQq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 08:16:46 -0500
Received: from zm23-mta-out.grenet.fr (zm23-mta-out.grenet.fr [130.190.191.35])
        by zm23-mta-out-2.grenet.fr (Postfix) with ESMTP id B4691C92B;
        Fri, 17 Feb 2017 14:16:42 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps1.u-ga.fr [152.77.1.30])
        by zm23-mta-out.grenet.fr (Postfix) with ESMTP id B5A6E100543;
        Fri, 17 Feb 2017 14:16:42 +0100 (CET)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 95BBE125EAE;
        Fri, 17 Feb 2017 14:16:42 +0100 (CET)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Johan Hovold <johan@kernel.org>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Kevin Daudt <me@ikke.info>, Junio C Hamano <gitster@pobox.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: body-CC-comment regression
References: <20170216174924.GB2625@localhost> <vpqlgt6hug6.fsf@anie.imag.fr>
        <20170217110642.GD2625@localhost>
Date:   Fri, 17 Feb 2017 14:16:42 +0100
In-Reply-To: <20170217110642.GD2625@localhost> (Johan Hovold's message of
        "Fri, 17 Feb 2017 12:06:42 +0100")
Message-ID: <vpq7f4pdkjp.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via submission-587 ACL (112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johan Hovold <johan@kernel.org> writes:

> There is another option, namely to only accept a single address for tags
> in the body. I understand that being able to copy a CC-header to either
> the header section or to the command line could be useful, but I don't
> really see the point in allowing this in the tags in the body (a SoB
> always has one address, and so should a CC-tag).

I mostly agree for the SoB, but why should a Cc tag have only one email?

The "multiple emails per Cc: field" has been there for a while already
(b1c8a11c8024 released in 2.6.0, sept 2015), some users may have got
used to it. What you are proposing breaks their flow.

> And since this is a regression for something that has been working for
> years that was introduced by a new feature, I also think it's reasonable
> to (partially) revert the feature.

I'd find it rather ironic to fix your case by breaking a feature that
has been working for more than a year :-(. What would you answer to a
contributor comming one year from now and proposing to revert your
reversion because it breaks his flow?

All that said, I think another fix would be both satisfactory for
everyone and rather simple:

1) Stop calling Mail::Address even if available. It used to make sense
   to do that when our in-house parser was really poor, but we now have
   something essentially as good as Mail::Address. We test our parser
   against Mail::Address and we do have a few known differences (see
   t9000), but they are really corner-cases and shouldn't matter.

   A good consequence of this is that we stop depending on the way Perl
   is installed to parse emails. Regardless of the current issue, I
   think it is a good thing.

2) Modify our in-house parser to discard garbage after the >. The patch
   should look like (untested):

--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -903,11 +903,11 @@ sub parse_mailboxes {
        my (@addr_list, @phrase, @address, @comment, @buffer) = ();
        foreach my $token (@tokens) {
                if ($token =~ /^[,;]$/) {
-                       # if buffer still contains undeterminated strings
-                       # append it at the end of @address or @phrase
-                       if ($end_of_addr_seen) {
-                               push @phrase, @buffer;
-                       } else {
+                       # if buffer still contains undeterminated
+                       # strings append it at the end of @address,
+                       # unless we already saw the closing >, in
+                       # which case we discard it.
+                       if (!$end_of_addr_seen) {
                                push @address, @buffer;
                        }
 
What do you think?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
