Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660DCC001DE
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 00:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjHJAl3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 20:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHJAl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 20:41:29 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408B71729
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 17:41:28 -0700 (PDT)
Received: (qmail 24132 invoked by uid 109); 10 Aug 2023 00:41:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Aug 2023 00:41:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3179 invoked by uid 111); 10 Aug 2023 00:41:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Aug 2023 20:41:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Aug 2023 20:41:27 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] describe: fix --no-exact-match
Message-ID: <20230810004127.GD795985@coredump.intra.peff.net>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g>
 <4eea7e15-6594-93e2-27b5-3d6e3c0baac6@web.de>
 <20230808212720.GA760752@coredump.intra.peff.net>
 <xmqqzg3156sy.fsf@gitster.g>
 <20230809140902.GA775795@coredump.intra.peff.net>
 <22e5a87a-cd35-9793-5b6f-6eb368fdf40e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22e5a87a-cd35-9793-5b6f-6eb368fdf40e@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2023 at 06:41:13PM +0200, René Scharfe wrote:

> And sorry for the unused parameter warning.  Just checked; there are
> 170+ of those remaining before we can enable it in developer mode.  :-/
> Seems worthwhile, though, especially not slapping UNUSED blindly on
> them.

I know, I'm working on it. :) There were more than 800 when I started.
I'm hoping to send out the final patches during this 2.43 cycle.

> Oh.  Do we really need all those?  Anyway, if we added at least the
> most common ones, we'd be better off already, I'd expect:
> 
>    $ % git grep -h ' = opt->value;' | sed 's/\*.*$//; s/^ *//' | sort | uniq -c | sort -nr | head -10
>      29 struct diff_options
>      12 int
>       7 struct grep_opt
>       6 struct rebase_options
>       6 struct apply_state
>       5 struct strbuf
>       5 char
>       4 struct note_data
>       3 struct string_list
>       2 struct strvec
> 
> Increasing the size of the struct like that would increase the total
> memory footprint by a few KB at most -- tolerable.

Hmm, I was thinking that "int_value" might not be so bad. But it seems
like a pretty bad layering violation for parse-options.c to know about
"struct apply_state" and so on. That really is what void pointers are
for.

As for size, you should be able to use a union. All of the types inside
the struct are pointers, so they'd all be the same size. Of course then
you lose some of the safety. If the caller assigned to "int_value" that
is distinct from "foo_value", then you can be sure you will get a NULL
and segfault upon accessing foo_value. With a union, you get whatever
type-punning undefined behavior the compiler sees fit. And the point is
making sure the two match.

We really don't care about separate storage, though. We want type
safety. Maybe an option there would be to let the callback function take
the appropriate type, and cast it. I.e., something like:

  /* define a callback taking the real type */
  int my_int_opt(int *value, struct option *opt, ...etc...) { ...body... }

  /* when mentioning a callback, include the type, and make sure that
   * the value and the callback both match it */
  #define OPT_CALLBACK(s, l, type, v, cb, ...etc...) \
    { ..., \
      value.type = (v), \
      callback = (int (*)(type *, struct option *opt, ...etc...), \
    }
  ...
  OPT_CALLBACK('f', "foo", int, &my_local_int, my_int_opt)

I'm pretty sure that falls afoul of the standard, though, because we
eventually need to call that function, and we'll do so through a
function pointer that doesn't match its declaration.

I'm not sure there's a portable and non-insane way of doing what we want
here. At least at compile-time. At run-time you could record type
information in an enum and check it in the callback. That seems like
a lot of work for little reward, though.

> > Here's what it looks like, for reference.
> >
> > diff --git a/builtin/describe.c b/builtin/describe.c
> > index b28a4a1f82..718b5c3073 100644
> > --- a/builtin/describe.c
> > +++ b/builtin/describe.c
> > @@ -561,9 +561,11 @@ static void describe(const char *arg, int last_one)
> >  static int option_parse_exact_match(const struct option *opt, const char *arg,
> >  				    int unset)
> >  {
> > +	int *val = opt->value;
> 
> This line would assign opt->value_int instead...

Right, though you would not even need it. I snuck it in there because it
gives us an implicit cast from the void pointer. Without it, the current
code would have to do:

  *(int *)opt->value = unset ? DEFAULT_CANDIDATES : 0;

which was too ugly (especially the "progress" one which mentions the
value three times). But if you had pre-cast variables, you could do:

  *opt->value.int = unset ? DEFAULT_CANDIDATES : 0;

directly.

-Peff
