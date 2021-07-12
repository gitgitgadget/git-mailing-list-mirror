Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D4AC07E9C
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0FC26135F
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbhGLUSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 16:18:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:47006 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233478AbhGLUSV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 16:18:21 -0400
Received: (qmail 21775 invoked by uid 109); 12 Jul 2021 20:15:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Jul 2021 20:15:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1900 invoked by uid 111); 12 Jul 2021 20:09:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Jul 2021 16:09:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Jul 2021 16:09:27 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] *.h: add a few missing  __attribute__((format))
Message-ID: <YOyhd/odtQxwQk2W@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
 <patch-4.6-3bf8637c16a-20210710T084445Z-avarab@gmail.com>
 <877dhw4exj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877dhw4exj.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 01:05:53AM +0200, Ævar Arnfjörð Bjarmason wrote:

> So this:
> > [...]
> > For strbuf_addftime() let's add a strftime() format checker. Our
> > function understands the non-portable %z and %Z, see
> > c3fbf81a853 (strbuf: let strbuf_addftime handle %z and %Z itself,
> > 2017-06-15).
> >
> > That might be an issue in theory, but in practice we have existing
> > codepath that supplies a fixed string to strbuf_addftime(). We're
> > unlikely to run into the "%z" and "%Z" case at all, since it's used by
> > date.c and passed via e.g. "git log --date=<format>".
> > [...]
> >  /**
> > @@ -425,6 +426,7 @@ void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
> >   * `suppress_tz_name`, when set, expands %Z internally to the empty
> >   * string rather than passing it to `strftime`.
> >   */
> > +__attribute__((format (strftime, 2, 0)))
> >  void strbuf_addftime(struct strbuf *sb, const char *fmt,
> >  		    const struct tm *tm, int tz_offset,
> >  		    int suppress_tz_name);
> 
> Fails with compat/mingw.[ch] doing:
> 
>     [...]
>     compat/mingw.c:#undef strftime
>     compat/mingw.c-size_t mingw_strftime(char *s, size_t max,
>     compat/mingw.c-               const char *format, const struct tm *tm)
>     [...]
>     compat/mingw.h:#define strftime mingw_strftime
>     [...]
> 
> What's a good macro idiom to dig oneself out of that hole? The only
> similar thing I could find was NORETURN in git-compat-util.h being
> defined differently on various platforms, and then things like:
> 
> 	+#if !defined(__MINGW32__) && !defined(_MSC_VER)
> 	 __attribute__((format (strftime, 2, 0)))
> 	+#endif
> 
> Which seems to work, and may be the simplest workaround...

I don't think there's a general standard-C way to override the macro
temporarily. You could perhaps fix it with re-ordering, but it is
super-awkward in this case (mingw stuff clearly should go in
git-compat-util.h or its includes, and the strbuf declaration should
come after that).

Gcc at least supports __strftime__ in the attribute, so that could be an
option (I've no clue how portable that is, though).

I'm skeptical on the utility of this strftime format checking in the
first place, though. The printf one is matching up the format string
with the otherwise-unchecked variable-length parameter list. That's very
easy to get wrong, very bad if we do get it wrong, and very hard for
anybody but the compiler to check accurately.

But a typo in the strftime placeholders is really no more interesting
than a typo in any other error message. If it helps even some obscure
cases it might be worth it, but:

  - we almost never feed a string literal anyway (and unlike printf,
    feeding non-literals is not dangerous). And in the one literal case
    you touched in the next patch, we had to make the code uglier to
    enable the checking.

  - as you note, this function isn't even a true strftime() replacement
    anyway. We allow %z, and I would not be at all opposed to adding
    more custom bits (either something regular strftime doesn't support
    at all, or extensions that are not universally available and we have
    to provide a fallback for).

  - it creates the macro headache you saw

  - I'm not sure if it creates other portability concerns. Does
    everybody who supports the format attribute support the strftime
    archetype? I have no clue.

So it doesn't really seem to be to be worth it on balance.

-Peff
