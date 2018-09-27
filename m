Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2A161F453
	for <e@80x24.org>; Thu, 27 Sep 2018 05:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbeI0MKs (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 08:10:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:33120 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726561AbeI0MKr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 08:10:47 -0400
Received: (qmail 10814 invoked by uid 109); 27 Sep 2018 05:54:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Sep 2018 05:54:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28009 invoked by uid 111); 27 Sep 2018 05:53:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 27 Sep 2018 01:53:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2018 01:54:15 -0400
Date:   Thu, 27 Sep 2018 01:54:15 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH] fetch: replace string-list used as a look-up table with
 a hashmap
Message-ID: <20180927055415.GC14178@sigill.intra.peff.net>
References: <xmqqin2sj6df.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kamkLV7yHtCu_qSqNzj7bJm0=Uw1CKxss+zTKJWsYz3qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kamkLV7yHtCu_qSqNzj7bJm0=Uw1CKxss+zTKJWsYz3qw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 03:59:08PM -0700, Stefan Beller wrote:

> > +struct refname_hash_entry {
> > +       struct hashmap_entry ent; /* must be the first member */
> 
> $ git grep "struct hashmap_entry" reveals that we have another
> convention that we follow but not document, which is to stress
> the importance of putting the hashmap_entry first. ;-)

One thing I've liked about the list.h implementation is that you can
store the list pointer anywhere in the struct, or even have the same
struct in multiple lists.

The only funny thing is that you have to "dereference" the iterator like
this:

  struct list_head *pos;
  struct actual_thing *item;
  ...
  item = list_entry(pos, struct actual_thing, list_member);

which is a minor pain, but it's reasonably hard to get it wrong.

I wonder if we could do the same here. The hashmap would only ever see
the "struct hashmap_entry", and then the caller would convert that back
to the actual type. I think we could even get away with not converting
existing callers; if the hashmap _is_ at the front, then that
list_entry() really just devolves to a cast. So as long as the struct
definition and the users of the struct agree, it would just work.

> > +static int refname_hash_entry_cmp(const void *hashmap_cmp_fn_data,
> > +                                 const struct refname_hash_entry *e1,
> > +                                 const struct refname_hash_entry *e2,
> > +                                 const void *keydata)
> > +{
> > +       return strcmp(e1->refname, keydata ? keydata : e2->refname);
> > +}
> 
> and later
> 
>     hashmap_init(...  (hashmap_cmp_fn)refname_hash_entry_cmp, ...);
> 
> I wonder if we'd want to stick to this style, as that seems to be the easiest
> to do, and drop the efforts started in 55c965f3a2 (Merge branch
> 'sb/hashmap-cleanup', 2017-08-11), that avoids the cast in the init,
> but puts the (implicit) casts in the _cmp function as we'd take
> void pointers as the function signature and recast to a local variable.

I think that casting the function pointer technically breaks the C
standard, though probably not in a way that is a problem on any real
systems.

The other thing about the "cast inside the cmp function" approach from
sb/hashmap-cleanup is that it is less likely to go stale. If we change
the definition of hashmap_cmp_fn, then any functions which are manually
cast will suppress the compiler errors. When the function takes void
pointers, the same can happen if "struct refname_hash_entry" is swapped
out for another struct, but IMHO that's a less likely error to make.

I admit that's just a gut feeling, though. It would be nice if we could
avoid casting altogether, but I think that puts us into macro territory
(which I'm not altogether opposed to, but it has its own drawbacks).

-Peff
