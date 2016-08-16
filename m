Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAE4F1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 13:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbcHPNRA (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 09:17:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:56201 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753306AbcHPNQo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 09:16:44 -0400
Received: (qmail 6562 invoked by uid 109); 16 Aug 2016 13:16:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 13:16:43 +0000
Received: (qmail 26305 invoked by uid 111); 16 Aug 2016 13:16:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 09:16:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Aug 2016 09:16:41 -0400
Date:	Tue, 16 Aug 2016 09:16:41 -0400
From:	Jeff King <peff@peff.net>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/3] receive-pack: allow a maximum input size to be
 specified
Message-ID: <20160816131640.h2zzn3sy5qqdeewc@sigill.intra.peff.net>
References: <20160816081701.29949-1-chriscool@tuxfamily.org>
 <20160816081701.29949-4-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160816081701.29949-4-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 10:17:01AM +0200, Christian Couder wrote:

> From: Jeff King <peff@peff.net>
> 
> Receive-pack feeds its input to either index-pack or
> unpack-objects, which will happily accept as many bytes as
> a sender is willing to provide. Let's allow an arbitrary
> cutoff point where we will stop writing bytes to disk.
> 
> Cleaning up what has already been written to disk is a
> related problem that is not addressed by this patch.
> 
> The problem is that git-gc can clean up tmp_pack_* files
> after their grace time expired, but that may not be
> enough if someone tries to "git push" in a loop.
> 
> A simple fix is to call register_tempfile() in
> open_pack_file(), and just have index-pack clean up the
> file on its way out.
> 
> But there are harder cases. For instance, if somebody
> pushes a 500MB file, and there is a pre-receive hook that
> says "too big; I won't accept this". And then they push in
> a loop, the incoming pack has already been accepted into
> the repository by the time the pre-receive hook runs.
> It's not possible to just delete it, because we don't know
> if other simultaneous processes have started to depend on
> the objects.

IMHO, everything after "not addressed by this patch" doesn't really add
anything. This commit has value on its own, and the discussion about the
next steps is already documented on the list (and hopefully will be
fixed with other patches!).

> +test_expect_success 'create remote repository' '
> +	git init --bare dest
> +'
> +
> +# Let's run tests with different unpack limits: 1 and 10
> +# When the limit is 1, `git receive-pack` will call `git index-pack`.
> +# When the limit is 10, `git receive-pack` will call `git unpack-objects`.
> +
> +while read unpacklimit filesize filename
> +do
> [...]
> +done <<\EOF
> +1 1024 one-k-file
> +10 2048 two-k-file
> +EOF

Is there any reason to use different filenames and sizes for the two
runs? They should behave identically, so it would make more sense to me
to subject them to identical inputs.

I know you need different files and filenames to continue pushing into
the same "dest", but the problem is easily solved by bumping the "git
init" into the loop.

-Peff
