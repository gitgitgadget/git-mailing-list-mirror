Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B93C83F37
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 21:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbjHaV34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 17:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbjHaV3y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 17:29:54 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC99EB8
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 14:29:51 -0700 (PDT)
Received: (qmail 26056 invoked by uid 109); 31 Aug 2023 21:29:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 21:29:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11716 invoked by uid 111); 31 Aug 2023 21:29:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 17:29:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 17:29:50 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org
Subject: Re: [PATCH v4] format-patch: --rfc honors what --subject-prefix sets
Message-ID: <20230831212950.GA949706@coredump.intra.peff.net>
References: <20230830064646.30904-1-sir@cmpwn.com>
 <xmqqsf808h4g.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsf808h4g.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 30, 2023 at 12:28:15PM -0700, Junio C Hamano wrote:

> Will queue.  Let's wait to see if others find something fishy for a
> day or two and then merge it down to 'next'.

It looks good to me, and I'm much happier with where the refactoring
ended up compared to the earlier versions. I did have two nits, but I'm
content if neither is addressed.

One is that the commit message doesn't really describe the refactoring
of --subject-prefix. I'm OK with that rationale being in the list
archive, though.

> >  static int subject_prefix_callback(const struct option *opt, const char *arg,
> >  			    int unset)
> >  {
> > +	struct strbuf *sprefix;
> > +
> >  	BUG_ON_OPT_NEG(unset);
> > +	sprefix = (struct strbuf *)opt->value;
> >  	subject_prefix = 1;
> > -	((struct rev_info *)opt->value)->subject_prefix = arg;
> > +	strbuf_reset(sprefix);
> > +	strbuf_addstr(sprefix, arg);
> >  	return 0;
> >  }
> 
> OK.

The cast is unnecessary here, since opt->value is a void pointer which
allows implicit casts. Just:

  struct strbuf *sprefix = opt->value;

is IMHO a little more readable. But as we're just passing it along to
strbuf functions anyway, it would also work to do:

  strbuf_reset(opt->value);
  strbuf_addstr(opt->value, arg);

I think we're deep into questions of style / preference here, so I'm OK
with any of them. It's probably only that I've recently been refactoring
so many parseopt callbacks with the same pattern that I have opinions at
all. ;)

-Peff
