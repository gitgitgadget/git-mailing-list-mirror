Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F88020248
	for <e@80x24.org>; Thu, 14 Mar 2019 00:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfCNAbe (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 20:31:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:50092 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726799AbfCNAbe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 20:31:34 -0400
Received: (qmail 31356 invoked by uid 109); 14 Mar 2019 00:31:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Mar 2019 00:31:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17864 invoked by uid 111); 14 Mar 2019 00:30:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Mar 2019 20:30:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2019 20:30:16 -0400
Date:   Wed, 13 Mar 2019 20:30:16 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/5] gc: refactor a "call me once" pattern
Message-ID: <20190314003016.GH31968@sigill.intra.peff.net>
References: <87imwmbv7l.fsf@evledraar.gmail.com>
 <20190313235439.30439-4-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190313235439.30439-4-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 12:54:37AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Change an idiom we're using to ensure that gc_before_repack() only
> does work once (see 62aad1849f ("gc --auto: do not lock refs in the
> background", 2014-05-25)) to be more obvious.
> 
> Nothing except this function cares about the "pack_refs" and
> "prune_reflogs" variables, so let's not leave the reader wondering if
> they're being zero'd out for later use somewhere else.

I agree the existing code is not very obvious about what it's trying to
do. I think a comment would have helped a lot.

Your rewrite is definitely better than the original, but I think it
might also benefit from a comment. I.e., something like:

>  static void gc_before_repack(void)
>  {
	/*
	 * We may be called twice, as both the pre- and post-daemonized
	 * phases will call us, but running these commands more than
	 * once is pointless and wasteful.
	 */
> +	static int done = 0;
> +	if (done++)
> +		return;

-Peff
