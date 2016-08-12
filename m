Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 484EA1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 15:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377AbcHLPod (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 11:44:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:54222 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750708AbcHLPnf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 11:43:35 -0400
Received: (qmail 4135 invoked by uid 109); 12 Aug 2016 15:43:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Aug 2016 15:43:34 +0000
Received: (qmail 20436 invoked by uid 111); 12 Aug 2016 15:43:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Aug 2016 11:43:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Aug 2016 11:43:31 -0400
Date:	Fri, 12 Aug 2016 11:43:31 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	gitster@pobox.com, jrnieder@gmail.com, git@vger.kernel.org,
	remi.galan-alfonso@ensimag.grenoble-inp.fr
Subject: Re: [PATCHv3] checkout: do not mention detach advice for explicit
 --detach option
Message-ID: <20160812154331.y2z6pv2w6cwsdsqw@sigill.intra.peff.net>
References: <20160812153744.15045-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160812153744.15045-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 12, 2016 at 08:37:44AM -0700, Stefan Beller wrote:

> > Is there a reason for not unsetting `advice.detachedHead` at the
> > end of the test?
> 
> done
> 
> I did not consider to clean up after myself... what a selfish world!

The right way to do it is:

  test_config advice.detachedHead false &&
  ...

so that the cleanup runs whether or not you may it to the end of the
script.

> +test_expect_success 'no advice given for explicit detached head state' '
> +	git config advice.detachedHead false &&
> +	git checkout child &&
> +	git checkout --detach HEAD >expect &&
> +	git config advice.detachedHead true &&
> +	git checkout child &&
> +	git checkout --detach HEAD >actual &&
> +	test_cmp expect actual &&
> +	git checkout child &&
> +	git checkout HEAD >actual &&
> +	! test_cmp expect actual &&
> +	git config --unset advice.detachedHead
> +'

Hmm. Using "!test_cmp" seems weird to me, just because it would falsely
claim success if something else unexpected changes. Our usual method for
making sure some particular output does not appear is "test_i18ngrep"
with a liberal pattern.

-Peff
