Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D747C83F2C
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 16:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbjIEQAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353655AbjIEHFS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 03:05:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0807E1B4
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 00:05:14 -0700 (PDT)
Received: (qmail 13660 invoked by uid 109); 5 Sep 2023 07:05:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Sep 2023 07:05:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19693 invoked by uid 111); 5 Sep 2023 07:05:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Sep 2023 03:05:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Sep 2023 03:05:12 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/10] parse-options: mark unused "opt" parameter in
 callbacks
Message-ID: <20230905070512.GC199565@coredump.intra.peff.net>
References: <20230831211637.GA949188@coredump.intra.peff.net>
 <20230831212128.GF949469@coredump.intra.peff.net>
 <98d1cd21-fb2a-269a-8d0b-f3e050682739@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98d1cd21-fb2a-269a-8d0b-f3e050682739@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 02, 2023 at 12:12:56PM +0200, René Scharfe wrote:

> Am 31.08.23 um 23:21 schrieb Jeff King:
> > The previous commit argued that parse-options callbacks should try to
> > use opt->value rather than touching globals directly. In some cases,
> > however, that's awkward to do. Some callbacks touch multiple variables,
> > or may even just call into an abstracted function that does so.
> >
> > In some of these cases we _could_ convert them by stuffing the multiple
> > variables into a single struct and passing the struct pointer through
> > opt->value. But that may make other parts of the code less readable,
> > as the struct relationship has to be mentioned everywhere.
> 
> Does that imply you'd be willing to use other methods?  Let's find out
> below. :)

Well, I'm not necessarily _opposed_. :) Mostly my cutoff was cases where
the end result was not obviously and immediately more readable. It is
not that big a deal to add an UNUSED annotation. My main goal was to use
the opportunity to check that we aren't papering over an obvious bug.

So for example...

> > diff --git a/builtin/gc.c b/builtin/gc.c
> > index 369bd43fb2..b842349d86 100644
> > --- a/builtin/gc.c
> > +++ b/builtin/gc.c
> > @@ -1403,7 +1403,7 @@ static void initialize_task_config(int schedule)
> >  	strbuf_release(&config_name);
> >  }
> >
> > -static int task_option_parse(const struct option *opt,
> > +static int task_option_parse(const struct option *opt UNUSED,
> 
> Only the global variable "tasks" seems to be used in here if you don't
> count the constant "TASK__COUNT", so you could pass it in.  This could
> also be converted to OPT_STRING_LIST with parsing and duplicate checking
> done later.

...in many cases things can be simplified by parsing into a string, and
then validating or acting on the string later. And sometimes that's even
a better strategy (because it lets the arg parsing handle all the "last
one wins" logic and we just get the result).

But it can also make the code harder to follow, too, because it's now
split it into segments (although one is mostly declarative, which is
nice).

So I generally tried to err on the side of not touching working
code. Both to avoid breaking it, but also to keep the focus on the goal
of the series. And I think that applies to a lot of the other cases you
mentioned below (I won't respond to each; I think some of them could be
fine, but it also feels like writing and review effort for not much
gain. I'm not opposed if you want to dig into them, though).

> And I don't understand why the callback returns 1 (PARSE_OPT_NON_OPTION)
> on error, but that's a different matter.

Yeah, that doesn't make sense at all.

> > -static int clear_decorations_callback(const struct option *opt,
> > -					    const char *arg, int unset)
> > +static int clear_decorations_callback(const struct option *opt UNUSED,
> > +				      const char *arg, int unset)
> >  {
> >  	string_list_clear(&decorate_refs_include, 0);
> >  	string_list_clear(&decorate_refs_exclude, 0);
> >  	use_default_decoration_filter = 0;
> >  	return 0;
> >  }
> >
> 
> Meta: Why do we get seven lines of context in an -U3 patch here?  Did
> you use --inter-hunk-context?

Yes, I set diff.interhunkcontext=1 in my config (and have for many
years; I think this is the first time anybody noticed in a patch). My
rationale is that with "1" the output is never longer, since you save
the hunk header. It is a little funny in this case, since the two
changes aren't really connected.

> This patch would be better viewed with --function-context to see that
> the callbacks change multiple variables or do other funky things.  Only
> doubles the line count.

I do sometimes use options like that to make a patch more readable, if I
notice the difference. I didn't happen to in this case (though I don't
disagree with you). As a reviewer, I typically apply and run "git show"
myself if I want to dig more (or just go directly look at the preimage
in my local repo, of course).

> > -static int option_parse_strategy(const struct option *opt,
> > +static int option_parse_strategy(const struct option *opt UNUSED,
> 
> Could be an OPT_STRING_LIST and parsing done later.  Except that
> --no-strategy does nothing, which is weird.

Yeah, I think the handling of "unset" is a bug (similar to the xopts one
fixed earlier).

-Peff
