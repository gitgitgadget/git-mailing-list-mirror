Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B133D211B4
	for <e@80x24.org>; Sat, 12 Jan 2019 10:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbfALK0h (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Jan 2019 05:26:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:34628 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725820AbfALK0h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jan 2019 05:26:37 -0500
Received: (qmail 17848 invoked by uid 109); 12 Jan 2019 10:26:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 12 Jan 2019 10:26:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16560 invoked by uid 111); 12 Jan 2019 10:26:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 12 Jan 2019 05:26:37 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Jan 2019 05:26:35 -0500
Date:   Sat, 12 Jan 2019 05:26:35 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/6] commit: copy saved getenv() result
Message-ID: <20190112102635.GA16633@sigill.intra.peff.net>
References: <20190111221414.GA31335@sigill.intra.peff.net>
 <20190111221539.GB10188@sigill.intra.peff.net>
 <xmqqsgxywp3w.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsgxywp3w.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 11, 2019 at 07:07:15PM -0800, Junio C Hamano wrote:

> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index 004b816635..7d2e0b61e5 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -351,7 +351,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
> >  		if (write_locked_index(&the_index, &index_lock, 0))
> >  			die(_("unable to create temporary index"));
> >  
> > -		old_index_env = getenv(INDEX_ENVIRONMENT);
> > +		old_index_env = xstrdup_or_null(getenv(INDEX_ENVIRONMENT));
> >  		setenv(INDEX_ENVIRONMENT, get_lock_file_path(&index_lock), 1);
> >  
> >  		if (interactive_add(argc, argv, prefix, patch_interactive) != 0)
> > @@ -361,6 +361,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
> >  			setenv(INDEX_ENVIRONMENT, old_index_env, 1);
> >  		else
> >  			unsetenv(INDEX_ENVIRONMENT);
> > +		FREE_AND_NULL(old_index_env);
> >  
> >  		discard_cache();
> >  		read_cache_from(get_lock_file_path(&index_lock));
> 
> Even though it is not wrong per-se to assign a NULL to the
> now-no-longer-referenced variable, I do not quite get why it is
> free-and-null, not a straight free.  This may be a taste-thing,
> though.
> 
> Even if a future update needs to make it possible to access
> old_index_env somewhere in the block after discard_cache() gets
> called, we would need to push down the free (or free-and-null) to
> prolong its lifetime a bit anyway, so...

My thinking was that if we simply call free(), then the variable is left
as a dangling pointer for the rest of the function, making it easy to
accidentally use-after-free.

But certainly it would not be the first such instance in our code base.
In theory a static analyzer should easily be able to figure out such a
problem, too, so maybe it is not worth being defensive about.

-Peff
