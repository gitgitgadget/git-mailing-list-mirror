Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC4FC1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 06:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJYOv4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 10:51:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:53842 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727185AbeJYOv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 10:51:56 -0400
Received: (qmail 25670 invoked by uid 109); 25 Oct 2018 06:20:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 25 Oct 2018 06:20:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13961 invoked by uid 111); 25 Oct 2018 06:19:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 25 Oct 2018 02:19:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2018 02:20:38 -0400
Date:   Thu, 25 Oct 2018 02:20:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] Poison gettext with the Ook language
Message-ID: <20181025062037.GC11460@sigill.intra.peff.net>
References: <20181022153633.31757-1-pclouds@gmail.com>
 <878t2pd6yu.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.1810231126470.4546@tvgsbejvaqbjf.bet>
 <8736sxc6gt.fsf@evledraar.gmail.com>
 <CACsJy8CX78EbANbv8a354djJaO6dKRpXshHhHJTspJvOSewgpA@mail.gmail.com>
 <871s8gd32p.fsf@evledraar.gmail.com>
 <CACsJy8Dex3VYEXmvRZv5_ot1-cwjJtir=kvupzKe7-Z2qPZw+Q@mail.gmail.com>
 <xmqqh8halm20.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh8halm20.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 25, 2018 at 12:52:55PM +0900, Junio C Hamano wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > The person who writes
> >
> >  printf(_("%s"), getenv("foo"));
> >
> > may not go through the same thought process as with complexFunction().
> > If _() calls getenv(), because you the order of parameter evaluation
> > is unspecified, you cannot be sure if getenv("foo") will be called
> > before or after the one inside _(). One of them may screw up the
> > other.
> 
> Yup, sometimes we've been sloppy but we should strive to mimick
> efforts like f4ef5173 ("determine_author_info(): copy getenv
> output", 2014-08-27).

I've wondered about this before. Even calling:

  foo = xstrdup(getenv("bar"));

is not necessarily correct, because xstrdup() relies on xmalloc(), which
may check GIT_ALLOC_LIMIT (we do cache that result, but it can happen on
the first malloc).

I also wouldn't be surprised if there are cases in our threaded code
that use getenv() without taking a lock.

I've definitely run into setenv()/getenv() races on Linux (inside Git,
even, though it was while working on custom code). But I wonder how
common it is for getenv() to be invalidated by another getenv() call.
Certainly POSIX allows it, but every implementation I've seen (which is
admittedly few) is passing back pointers to a chunk of environment
memory.

I.e., could we mostly ignore this problem as not applying to most modern
systems? And if there is such a system, give it a fallback like:

  /*
   * For systems that use a single buffer for getenv(), this hacks
   * around it by giving it _four_ buffers. That's just punting on
   * the problem, but it at least gives enough breathing room for
   * the caller to do something sane like use non-trivial functions
   * to copy the string. It still does nothing for threading, but
   * hopefully such systems don't support pthreads in the first place. ;)
   */
  const char *xgetenv(const char *key)
  {
	static struct strbuf bufs[] = {
		STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
	};
	static unsigned int cur;
	struct strbuf *buf;
	const char *value;
	size_t len;

	value = getenv(key);
	if (!value)
		return NULL;

	buf = bufs[cur++];
	cur %= ARRAY_SIZE(bufs);

	/*
	 * We have to do this length check ourselves, because allocating
	 * the strbuf may invalidate "value"!
	 */
	len = strlen(value);
	if (buf->alloc <= len) {
		strbuf_grow(buf, len);
		value = getenv(key);
		if (!value)
			return NULL; /* whoops, it went away! */
		len = strlen(value); /* paranoia that it didn't change */
	}

	strbuf_reset(buf);
	strbuf_add(buf, value, len);

	return buf->buf;
  }

I dunno. Maybe I am being overly optimistic. But I strongly suspect we
have such bugs already in our code base, and nobody has run into them
(OTOH, they are quite finicky due to things like the caching I
mentioned).

-Peff
