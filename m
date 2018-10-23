Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE71D1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 20:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbeJXExn (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 00:53:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:51676 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725948AbeJXExn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 00:53:43 -0400
Received: (qmail 7392 invoked by uid 109); 23 Oct 2018 20:28:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Oct 2018 20:28:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26401 invoked by uid 111); 23 Oct 2018 20:27:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 23 Oct 2018 16:27:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Oct 2018 16:28:43 -0400
Date:   Tue, 23 Oct 2018 16:28:43 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] thread-utils: better wrapper to avoid #ifdef
 NO_PTHREADS
Message-ID: <20181023202842.GA17371@sigill.intra.peff.net>
References: <20181018170934.GA21138@sigill.intra.peff.net>
 <20181018180522.17642-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181018180522.17642-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 18, 2018 at 08:05:22PM +0200, Nguyễn Thái Ngọc Duy wrote:

> On Thu, Oct 18, 2018 at 7:09 PM Jeff King <peff@peff.net> wrote:
> > > In this particular case though I think we should be able to avoid so
> > > much #if if we make a wrapper for pthread api that would return an
> > > error or something when pthread is not available. But similar
> > > situation may happen elsewhere too.
> >
> > Yeah, I think that is generally the preferred method anyway, just
> > because of readability and simplicity.
> 
> I've wanted to do this for a while, so let's test the water and see if
> it's well received.
> 
> This patch is a proof of concept that adds just enough macros so that
> I can build index-pack.c on a single thread mode with zero #ifdef
> related to NO_PTHREADS.
> 
> Besides readability and simplicity, it reduces the chances of breaking
> conditional builds (e.g. you rename a variable name but forgot that
> the variable is in #if block that is not used by your
> compiler/platform).

Yes, I love this. We're already halfway there with things like
read_lock() in index-pack and elsewhere, which are conditionally no-ops.
The resulting code is much easier to read, I think.

> Performance-wise I don't think there is any loss for single thread
> mode. I rely on compilers recognizing HAVE_THREADS being a constant
> and remove dead code or at least optimize in favor of non-dead code.
> 
> Memory-wise, yes we use some more memory in single thread mode. But we
> don't have zillions of mutexes or thread id, so a bit extra memory
> does not worry me so much.

Yeah, I don't think carrying around a handful of ints is going to be a
big deal.

I also think we may want to make a fundamental shift in our view of
thread support. In the early days, it was "well, this is a thing that
modern systems can take advantage of for certain commands". But these
days I suspect it is more like "there are a handful of legacy systems
that do not even support threads".

I don't think we should break the build on those legacy systems, but
it's probably OK to stop thinking of it as "non-threaded platforms are
the default and must pay zero cost" and more as "threaded platforms are
the default, and non-threaded ones are OK to pay a small cost as long as
they still work".

> @@ -74,4 +79,29 @@ int init_recursive_mutex(pthread_mutex_t *m)
>  		pthread_mutexattr_destroy(&a);
>  	}
>  	return ret;
> +#else
> +	return ENOSYS;
> +#endif
> +}

I suspect some of these ENOSYS could just become a silent success.
("yep, I initialized your dummy mutex"). But it probably doesn't matter
much either way, as we would not generally even bother checking this
return.

> +#ifdef NO_PTHREADS
> +int dummy_pthread_create(pthread_t *pthread, const void *attr,
> +			 void *(*fn)(void *), void *data)
> +{
> +	return ENOSYS;
>  }

Whereas for this one, ENOSYS makes a lot of sense (we should avoid the
threaded code-path anyway when we see that online_cpus()==1, and this
would let us know when we mess that up).

> +int dummy_pthread_init(void *data)
> +{
> +	/*
> +	 * Do nothing.
> +	 *
> +	 * The main purpose of this function is to break compiler's
> +	 * flow analysis or it may realize that functions like
> +	 * pthread_mutex_init() is no-op, which means the (static)
> +	 * variable is not used/initialized at all and trigger
> +	 * -Wunused-variable
> +	 */
> +	return ENOSYS;
> +}

It might be worth marking the dummy variables as MAYBE_UNUSED, exactly
to avoid this kind of compiler complaint.

-Peff
