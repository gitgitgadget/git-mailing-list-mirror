Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E2EC433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 19:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F094A21D7D
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 19:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgIIT6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:58:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:52600 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgIIT6E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 15:58:04 -0400
Received: (qmail 7230 invoked by uid 109); 9 Sep 2020 19:58:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Sep 2020 19:58:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5178 invoked by uid 111); 9 Sep 2020 19:58:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Sep 2020 15:58:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Sep 2020 15:58:03 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, whydoubt@gmail.com,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] blame.c: replace instance of !oidcmp for oideq
Message-ID: <20200909195803.GA2515827@coredump.intra.peff.net>
References: <20200907171639.766547-1-eantoranz@gmail.com>
 <ce94b41f-e829-d7ca-a5f5-e41748caea81@gmail.com>
 <20200909091149.GB2496536@coredump.intra.peff.net>
 <CAOc6etZS3mGxsPPh25XFi2-qR0TNzq0Gx1NrydgQwmHbsjxejA@mail.gmail.com>
 <20200909191345.GA2511547@coredump.intra.peff.net>
 <20200909191746.GA2514794@coredump.intra.peff.net>
 <0773b560-b456-fc88-42d7-f214246ddd1b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0773b560-b456-fc88-42d7-f214246ddd1b@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 09, 2020 at 09:54:55PM +0200, René Scharfe wrote:

> > diff -u -p a/packfile.c b/packfile.c
> > --- a/packfile.c
> > +++ b/packfile.c
> > @@ -735,7 +735,7 @@ struct packed_git *add_packed_git(const
> >  	p->mtime = st.st_mtime;
> >  	if (path_len < the_hash_algo->hexsz ||
> >  	    get_sha1_hex(path + path_len - the_hash_algo->hexsz, p->hash))
> > -		hashclr(p->hash);
> > +		oidclr(p);
> >  	return p;
> >  }
> >
> >
> > Maybe it's worth being looser in our cocci patch definitions. I'm having
> > trouble thinking of a downside...
> 
> For transformations that change the type as in the example above we
> should insist on getting the right one, otherwise we might introduce
> bugs -- like in the example above.  p points to a struct packed_git and
> not to a struct object_id, so this introduces a type mismatch.

Heh. You'd think that I would have applied that patch and run "make". Or
even read it carefully.

Thanks for pointing that out. I guess now we have a real example of a
downside (the compiler _would_ still catch it, but it means "make
coccicheck" is useless if it's repeatedly suggesting a bad
transformation).

-Peff
