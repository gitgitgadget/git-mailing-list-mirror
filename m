Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3E881F859
	for <e@80x24.org>; Tue, 16 Aug 2016 12:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244AbcHPMgg (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 08:36:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:56159 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752223AbcHPMgf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 08:36:35 -0400
Received: (qmail 4269 invoked by uid 109); 16 Aug 2016 12:36:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 12:36:34 +0000
Received: (qmail 25864 invoked by uid 111); 16 Aug 2016 12:36:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 08:36:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Aug 2016 08:36:31 -0400
Date:	Tue, 16 Aug 2016 08:36:31 -0400
From:	Jeff King <peff@peff.net>
To:	Eli Barzilay <eli@barzilay.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
Subject: Re: Minor bug: git config ignores empty sections
Message-ID: <20160816123631.ckbvzustl2j37gdx@sigill.intra.peff.net>
References: <CALO-gutdz5VMgoRmbqEa9UiaTC+L2Sy2n-3AF+zfPr-X8+1U4A@mail.gmail.com>
 <20160815120916.6iobqirqbg76exms@sigill.intra.peff.net>
 <8737m63phh.fsf@linux-m68k.org>
 <20160815180905.znnz6evufsne5wy6@sigill.intra.peff.net>
 <xmqqh9alhoor.fsf@gitster.mtv.corp.google.com>
 <20160815185500.htgrz3t2wkztg4ww@sigill.intra.peff.net>
 <CALO-guvVMFitNdGYEonXZ9rh8g8=L9gZojXVUu7FO2_0ki24EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALO-guvVMFitNdGYEonXZ9rh8g8=L9gZojXVUu7FO2_0ki24EQ@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 12:06:56AM -0400, Eli Barzilay wrote:

> So it sounds like removing an empty header is problematic in most cases,
> but adding a new variable to an existing empty header should not be...?

I think it's less problematic, though there are still some funny cases.
Like:

  [foo]
  # comments for the "foo" section

  # comments introducing the "bar" section
  [bar]

Ideally the new entry goes in between the two comments. But I don't
think it would be unreasonable to add it right after "[foo]". In this
example, using the blank line as a hint might be useful, but that's
going to be a lot harder to coax out of the callback-parser as syntactic
event.

> I looked at the code, and had a rough sketch that works as follows:
> 
> * Make git_parse_source() call the callback in a special way to note
>   that a section header is seen (I hacked it by passing a special value,
>   a pointer to a global string, as the second argument)

We'd want to make sure that didn't kick in for "regular" callers, with
some kind of option (or, blech, a global variable that changes the
behavior of git_parse_source(), though the config code is already full
of them).

> * Add a new store.last_section_offset field
>
> * In store_aux(), if it's getting the special value, and the section
>   name matches, save the offset in store.last_section_offset

Make sense.

> * In git_config_set_multivar_in_file_gently() right before the "write
>   the first part of the config" comment, test that
>       (store.seen == 1 && copy_begin == 0 && copy_end == contents_sz
>        && store.last_section_offset > 0)
>   and if so, write the contents up to that point, and set copy_begin;
>   if the condition is false, do the same thing it does now

This part I'm not sure about. Naively I'd think you could do with less
special-casing here. If we want to add "foo.two" and find:

  [foo]
  one = whatever

then we mark the end of that line as the point we want to copy up to,
and then add our new "two = ..." line.

Conceptually if we see just:

  [foo]

we should be able to kick in the same code. So it seems like the logic
would all be in the detection and setting of the offset.

But I am not sure I understand all of the code here, and it's rather
complicated. So there is probably a good reason that wouldn't work.

> It looks to me like something like this can work, but it's very hacky
> because I wanted to see if it can work quickly, and because I don't know
> if this kind of a solution will be wanted, and because I don't know
> enough about that code in general.  Making it be an actual solution
> involves a better way to call the callback in a special way (my hack
> does the special thing only if `fn==store_aux`, but it shouldn't),
> calling it after the last variable in a section is seen so it's added
> after that.
> 
> So, will something like this be acceptable?  If so, is there anyone who
> I can ask questions about the code?

Yeah, I think this general strategy is the smallest change that could
work.

What I think would be much more sane in general is to parse the whole
thing into a tree (or even a flat list of events), marking each
syntactically as a section header, a key, a comment, a run of
whitespace, and so on. And then do manipulations on that tree (e.g.,
walk down to the section of interest, add a new key at the end), and
then reformat the tree back into a stream of bytes. That lets you
separate the policy logic from the parsing, and do high-level operations
that might involve multiple passes or backtracking in the tree (e.g.,
walk to the section, walk past any existing keys, walk past any comments
but _not_ past any blank lines, then add the new key).

There are other other upsides, too. For example, the current code cannot
write multiple unrelated keys in a single pass.

The downsides is that it's a complete rewrite of the code. So it's a
_lot_ more work, and it carries more risk of regression. So please don't
take this as "no, your solution isn't OK; you have to do the rewrite".
We've been living with band-aids on the config code for a decade, so I
am OK with one more.

-Peff
