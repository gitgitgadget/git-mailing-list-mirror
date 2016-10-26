Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E28042022A
	for <e@80x24.org>; Wed, 26 Oct 2016 12:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753859AbcJZMQF (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 08:16:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:34284 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750938AbcJZMQD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 08:16:03 -0400
Received: (qmail 4546 invoked by uid 109); 26 Oct 2016 12:15:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Oct 2016 12:15:28 +0000
Received: (qmail 9899 invoked by uid 111); 26 Oct 2016 12:15:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Oct 2016 08:15:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Oct 2016 08:15:26 -0400
Date:   Wed, 26 Oct 2016 08:15:26 -0400
From:   Jeff King <peff@peff.net>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>, gitster@pobox.com,
        git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com
Subject: Re: [PATCH 27/36] attr: convert to new threadsafe API
Message-ID: <20161026121525.twgiavpgfbr2ahvn@sigill.intra.peff.net>
References: <20161022233225.8883-1-sbeller@google.com>
 <20161022233225.8883-28-sbeller@google.com>
 <alpine.DEB.2.20.1610261049470.3264@virtualbox>
 <20161026093558.drsdwn2hm7bbcktt@ruderich.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161026093558.drsdwn2hm7bbcktt@ruderich.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2016 at 11:35:58AM +0200, Simon Ruderich wrote:

> >  static pthread_mutex_t attr_mutex;
> > -#define attr_lock()pthread_mutex_lock(&attr_mutex)
> > +static inline void attr_lock(void)
> > +{
> > +	static int initialized;
> > +
> > +	if (!initialized) {
> > +		pthread_mutex_init(&attr_mutex, NULL);
> > +		initialized = 1;
> > +	}
> > +	pthread_mutex_lock(&attr_mutex);
> > +}
> 
> This may initialize the mutex multiple times during the first
> lock (which may happen in parallel).
> 
> pthread provides static initializers. To quote the man page:
> 
>     Variables of type pthread_mutex_t can also be initialized
>     statically, using the constants PTHREAD_MUTEX_INITIALIZER
>     (for fast mutexes), PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP
>     (for recursive mutexes), and
>     PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP (for error checking
>     mutexes).

I seem to recall this does not work on Windows, where the pthread
functions are thin wrappers over CRITICAL_SECTION. Other threaded code
in git does an explicit setup step before entering threaded sections.
E.g., see start_threads() in builtin/grep.c.

-Peff
