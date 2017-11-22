Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4053320954
	for <e@80x24.org>; Wed, 22 Nov 2017 23:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbdKVXhM (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 18:37:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:38186 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751674AbdKVXhL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 18:37:11 -0500
Received: (qmail 7702 invoked by uid 109); 22 Nov 2017 23:37:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Nov 2017 23:37:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5763 invoked by uid 111); 22 Nov 2017 23:37:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 22 Nov 2017 18:37:27 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Nov 2017 18:37:09 -0500
Date:   Wed, 22 Nov 2017 18:37:09 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH 2/3] git-compat: introduce BUG_ON(condition, fmt, ...)
 macro
Message-ID: <20171122233709.GB8577@sigill>
References: <20171122223827.26773-1-sbeller@google.com>
 <20171122223827.26773-3-sbeller@google.com>
 <20171122230239.GG11671@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171122230239.GG11671@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 03:02:39PM -0800, Jonathan Nieder wrote:

> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -1092,9 +1092,13 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
> >  __attribute__((format (printf, 3, 4))) NORETURN
> >  void BUG_fl(const char *file, int line, const char *fmt, ...);
> >  #define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
> > +#define BUG_ON(condition, ...) do { if (condition) BUG(__VA_ARGS__); } while (0)
> >  #else
> >  __attribute__((format (printf, 1, 2))) NORETURN
> >  void BUG(const char *fmt, ...);
> > +
> > +__attribute__((format (printf, 2, 3)))
> > +void BUG_ON(int condition, const char *fmt, ...);
> >  #endif
> 
> I worry that these definitions are mildly incompatible: the macro
> accepts anything that can go in an 'if', including pointers, and the
> function only accepts an int.

I suspect this would cause real latent problems. Doing:

  const char *foo = NULL;

  ...
  BUG_ON(foo, "foo was set twice!");
  foo = xstrdup(bar);

would compile fine on modern systems, but issue a pointer-to-int
conversion warning if you didn't have variadic macros. So most git devs
would be unlikely to see it, until the trap springs on some poor soul
building on ancient AIX or something.

On the other hand, I wouldn't be surprised if our friends on less-abled
compilers see a lot of pointless warnings anyway, and almost certainly
can't deal with the equivalent of "-Werror".

I'm also not sure which compilers that even encompasses these days.
Maybe we should add variadic macros to our list of weather-balloon c99
features to test for.

> Is there a way for the macro to typecheck that its argument is an
> integer to avoid that?

I couldn't think of one.

It would be nice to just "!!condition" in the non-macro case, but of
course we can't do that automatically without a macro.

You're asking for the opposite: force the macro version to require an
int, so that the caller has to remember to do "!!condition". I can't
think of a way to do that, but I'm also not sure I like the direction,
as it pushes the effort into the callsite.

-Peff
