Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC9701F461
	for <e@80x24.org>; Thu, 18 Jul 2019 20:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403831AbfGRU06 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 16:26:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:39690 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727972AbfGRU06 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 16:26:58 -0400
Received: (qmail 30149 invoked by uid 109); 18 Jul 2019 20:26:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Jul 2019 20:26:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20454 invoked by uid 111); 18 Jul 2019 20:27:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Jul 2019 16:27:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Jul 2019 16:26:56 -0400
Date:   Thu, 18 Jul 2019 16:26:56 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Subject: Re: [PATCH] rm: resolving by removal is not a warning-worthy event
Message-ID: <20190718202656.GC22038@sigill.intra.peff.net>
References: <5D2ED50D020000A100032435@gwsmtp.uni-regensburg.de>
 <xmqqd0i81ui4.fsf@gitster-ct.c.googlers.com>
 <xmqqims0z99w.fsf_-_@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqims0z99w.fsf_-_@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 17, 2019 at 01:38:35PM -0700, Junio C Hamano wrote:

> When resolving a conflict on a path in favor of removing it, using
> "git rm" on it is the standard way to do so.  The user however is
> greeted with a "needs merge" message during that operation:
> 
> 	$ git merge side-branch
> 	$ edit conflicted-path-1
> 	$ git add conflicted-path-1
> 	$ git rm conflicted-path-2
> 	conflicted-path-2: needs merge
> 	rm 'conflicted-path-2'
> 
> The removal by "git rm" does get performed, but an uninitiated user
> may find it confusing, "needs merge? so I need to resolve conflict
> before being able to remove it???"
> 
> The message is coming from "update-index --refresh" that is called
> internally to make sure "git rm" knows which paths are clean and
> which paths are dirty, in order to prevent removal of paths modified
> relative to the index without the "-f" option.  We somehow ended up
> not squelching this message which seeped through to the UI surface.
> 
> Use the same mechanism used by "git commit", "git describe", etc. to
> squelch the message.

Nicely explained, and the patch makes sense.

> +test_expect_success 'Resolving by removal is not a warning-worthy event' '
> +	git reset -q --hard &&
> +	test_when_finished "rm -f .git/index.lock msg && git reset -q --hard" &&
> +	qfwfq=$(echo qfwfq | git hash-object -w --stdin) &&

I'd have called this "$blob" for my own sanity in typing later lines,
but OK. :)

> +	do
> +		echo "100644 $qfwfq $stage	qfwfq"
> +	done | git update-index --index-info &&
> +	git rm qfwfq >msg &&
> +	test_i18ngrep ! "needs merge" msg &&

Should we capture stderr from "git rm", too, to cover all bases?

-Peff
