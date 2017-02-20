Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC8BA201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 12:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbdBTMKL (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 07:10:11 -0500
Received: from zm23-mta-out-2.grenet.fr ([130.190.191.53]:49328 "EHLO
        zm23-mta-out-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752187AbdBTMKK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 07:10:10 -0500
Received: from zm23-mta-out.grenet.fr (zm23-mta-out.grenet.fr [130.190.191.35])
        by zm23-mta-out-2.grenet.fr (Postfix) with ESMTP id C52A2C779;
        Mon, 20 Feb 2017 13:10:07 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [195.83.24.202])
        by zm23-mta-out.grenet.fr (Postfix) with ESMTP id BFC9B100347;
        Mon, 20 Feb 2017 13:10:07 +0100 (CET)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id B6FE360382;
        Mon, 20 Feb 2017 12:27:03 +0100 (CET)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Johan Hovold <johan@kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Kevin Daudt <me@ikke.info>,
        Larry Finger <Larry.Finger@lwfinger.net>, git@vger.kernel.org
Subject: Re: [PATCH v2] send-email: only allow one address per body tag
References: <xmqqbmu0pgg6.fsf@gitster.mtv.corp.google.com>
        <20170220114406.19436-1-johan@kernel.org>
Date:   Mon, 20 Feb 2017 13:10:07 +0100
In-Reply-To: <20170220114406.19436-1-johan@kernel.org> (Johan Hovold's message
        of "Mon, 20 Feb 2017 12:44:06 +0100")
Message-ID: <vpqo9xxkqqo.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via smtps.univ-grenoble-alpes.fr ACL (97)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johan Hovold <johan@kernel.org> writes:

> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1563,7 +1563,7 @@ foreach my $t (@files) {
>  	# Now parse the message body
>  	while(<$fh>) {
>  		$message .=  $_;
> -		if (/^(Signed-off-by|Cc): (.*)$/i) {
> +		if (/^(Signed-off-by|Cc): ([^>]*>?)/i) {

I think this is acceptable, but this doesn't work with trailers like

Cc: "Some > Body" <Some.Body@example.com>

A proper management of this kind of weird address should be doable by
reusing the regexp parsing "..." in parse_mailbox:

	my $re_quote = qr/"(?:[^\"\\]|\\.)*"/;

So the final regex would look like

if (/^(Signed-off-by|Cc): (([^>]*|"(?:[^\"\\]|\\.)*")>?)/i) {

I don't think that should block the patch inclusion, but it may be worth
considering.

Anyway, thanks for the patch!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
