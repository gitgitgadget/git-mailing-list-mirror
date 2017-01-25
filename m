Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1D7D1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbdAYWkq (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:40:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:44932 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752277AbdAYWkp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:40:45 -0500
Received: (qmail 9234 invoked by uid 109); 25 Jan 2017 22:40:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 22:40:45 +0000
Received: (qmail 17408 invoked by uid 111); 25 Jan 2017 22:40:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 17:40:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 17:40:43 -0500
Date:   Wed, 25 Jan 2017 17:40:43 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Segev Finer <segev208@gmail.com>
Subject: Re: [PATCH] connect: handle putty/plink also in GIT_SSH_COMMAND
Message-ID: <20170125224043.jxjc4avuy4ztnkm4@sigill.intra.peff.net>
References: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de>
 <xmqqy3ym1dsc.fsf@gitster.mtv.corp.google.com>
 <xmqq4m1911mf.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1701090825510.3469@virtualbox>
 <xmqqh958y44c.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1701091207480.3469@virtualbox>
 <xmqqmvf0wc2h.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1701251327090.3469@virtualbox>
 <xmqqinp2939j.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqinp2939j.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 02:35:36PM -0800, Junio C Hamano wrote:

> -- >8 --
> Subject: [PATCH] connect: core.sshvariant to correct misidentification

I have been watching this discussion from the sidelines, and I agree
that this direction is a big improvement.

> +static void override_ssh_variant(int *port_option, int *needs_batch)
> +{
> +	const char *variant;
> +
> +	if (git_config_get_string_const("core.sshvariant", &variant))
> +		return;
> +	if (!strcmp(variant, "tortoiseplink")) {
> +		*port_option = 'P';
> +		*needs_batch = 1;
> +	} else if (!strcmp(variant, "putty")) {
> +		*port_option = 'P';
> +		*needs_batch = 0;
> +	} else {
> +		/* default */
> +		if (strcmp(variant, "ssh")) {
> +			warning(_("core.sshvariant: unknown value '%s'"), variant);
> +			warning(_("using OpenSSH compatible behaviour"));
> +		}
> +		*port_option = 'p';
> +		*needs_batch = 0;
> +	}
> +}

IIRC, the "const" in git_config_get_string_const is only about avoiding
an annoying cast. The result is still allocated and needs freed. Since
you are not keeping the value after the function returns, I think you
could just use git_config_get_value().

(Grepping around, I see a few other places that seem to make the same
mistake. I think this is a confusing interface that should probably be
fixed).

-Peff
