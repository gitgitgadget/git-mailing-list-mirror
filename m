Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 765441FAFB
	for <e@80x24.org>; Tue,  4 Apr 2017 02:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbdDDC3t (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 22:29:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:56308 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752126AbdDDC3t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 22:29:49 -0400
Received: (qmail 18180 invoked by uid 109); 4 Apr 2017 02:29:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Apr 2017 02:29:47 +0000
Received: (qmail 3172 invoked by uid 111); 4 Apr 2017 02:30:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Apr 2017 22:30:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Apr 2017 22:29:46 -0400
Date:   Mon, 3 Apr 2017 22:29:46 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@jeffhostetler.com, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 2/4] fsck: force core.checksumindex=1
Message-ID: <20170404022945.nmadthjzovmjplyb@sigill.intra.peff.net>
References: <20170403185306.36164-1-git@jeffhostetler.com>
 <20170403185306.36164-3-git@jeffhostetler.com>
 <CACBZZX7DFuLia8RzB908EG7+oWQiFGkFEq14bzT77A75msM98Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX7DFuLia8RzB908EG7+oWQiFGkFEq14bzT77A75msM98Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 03, 2017 at 10:31:03PM +0200, Ævar Arnfjörð Bjarmason wrote:

> On Mon, Apr 3, 2017 at 8:53 PM,  <git@jeffhostetler.com> wrote:
> > Teach fsck to override core.checksumindex and always verify
> > the index checksum when reading the index.
> 
> Sorry to only chime in about this at v4.
> 
> I think this patch & the documentation you added for
> core.checksumindex in 1/4 would be much less confusing if you made
> this a on-by-default command-line option like e.g. "full".
> 
> With this patch nothing amends the documentation to indicate that the
> core.checksumindex is magically overridden when fsck runs, I think
> something like this (needs amending to integrate) on top would make
> this clearer:

I think that is the wrong direction to reduce confusion. We don't need
more options to twiddle this flag, we need fewer. For instance, in your
proposed documentation:

> @@ -61,6 +61,11 @@ index file, all SHA-1 references in `refs`
> namespace, and all reflogs
>         object pools.  This is now default; you can turn it off
>         with --no-full.
> 
> +--[no-]checksum-index:
> +       Validate the checksum at the end of the index file, on by
> +       default, locally overrides any "core.checksumIndex" setting
> +       unless negated. See linkgit:git-config[1].

That tells us _what_ it does, but I'm left scratching my head with
"why".

I don't think there is any reason you would want fsck not to compute
that checksum (just like there is no option to ask fsck not to check
pack sha1 trailers).

I would go so far as to say that the config option itself is unnecessary
in this iteration of the series. I only asked for it so that we could
test the verification code paths (both for correctness and performance).
But if fsck can exercise the code path, we can check correctness that
way. And for performance, it's probably enough to test two separate
builds (which Jeff has already done).

Junio also asked for the usual "add a config, and then later we'll flip
the default" procedure. But IMHO that isn't necessary here. Nobody
should ever care about this flag. It was largely useless to check it on
every read in the first place. And if you suspect there's corruption in
your repository, you should run "git fsck".

-Peff
