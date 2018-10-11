Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4D4F1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 00:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbeJKHlR (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 03:41:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:36394 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726040AbeJKHlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 03:41:16 -0400
Received: (qmail 16751 invoked by uid 109); 11 Oct 2018 00:16:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Oct 2018 00:16:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24010 invoked by uid 111); 11 Oct 2018 00:15:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Oct 2018 20:15:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Oct 2018 20:16:41 -0400
Date:   Wed, 10 Oct 2018 20:16:41 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push: add an advice on unqualified <dst> push
Message-ID: <20181011001641.GB13853@sigill.intra.peff.net>
References: <20181010104145.25610-1-avarab@gmail.com>
 <20181010104145.25610-3-avarab@gmail.com>
 <20181010205505.GB12949@sigill.intra.peff.net>
 <87r2gxebsi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r2gxebsi.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 11:23:25PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I wonder if we could reword the first paragraph to be a little less
> > confusing, and spell out what we tried already. E.g., something like:
> >
> >   The destination you provided is not a full refname (i.e., starting
> >   with "ref"). Git tried to guess what you meant by:
> >
> >     - looking for a matching branch or tag on the remote side
> >
> >     - looking at the refname of the local source
> >
> >   but neither worked.
> >
> >   The <src> part of the refspec is a commit object.
> >   Did you mean...
> 
> Yeah that makes sense. I was trying to avoid touching the existing
> wording to make this more surgical, but you came up with it, and since
> you don't like it I'll just change that too.

I certainly know the feeling of trying to avoid wording bikeshed
discussions. But in this instance, please feel free to aggressively
rewrite that old message. ;)

What I wrote above was off-the-cuff, and I also do not mind if you use
it as a starting point to make improvements (or take it wholesale if you
really like it).

> > I think it would probably be OK to put the first paragraph in its own
> > variable. I know we try to avoid translation lego, but I'd think
> > paragraphs are separate units. Or are you worried about how to get them
> > into the same advise() call? I don't know that we need to, but we could
> > also plug one into the other with a "%s" (and leave a translator note).
> 
> To be honest from being on the code side of a much bigger i18n effort
> (the MediaWiki/WikiMedia software) back in the early days of my career I
> just do this sort of thing reflexively, because from experience when I
> started trying to simplify stuff by making assumptions I was wrong every
> time.
> [...]

OK, I'm happy to defer to your judgement here. I have very little
translation experience myself.

> > Can we just do it as:
> >
> >   if (advice_push_ambiguous_ref_name) {
> > 	struct object_id oid;
> > 	enum object_type type;
> >
> > 	if (get_oid(...))
> > 	   etc...
> >   }
> >
> > instead? That pushes your indentation one level in, but I think the
> > whole conditional body might be cleaner in a helper function anyway.
> 
> I started out with that and found myself really constrained by the 72
> char ceiling which I'm already smashing through with these ~95 character
> lines (but at least it's under 100!). But sure, we can do with 8 more.

That's why I suggested the helper function. :) I'm also not opposed to
pulling messages out to static file-level variables, even if they're
only used once. Sometimes it's nice to have them left-aligned (or close
to it) to see how they'll actually look in a terminal.

-Peff
