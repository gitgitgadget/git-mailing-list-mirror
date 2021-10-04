Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217FDC433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 09:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061F36126A
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 09:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhJDJbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 05:31:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:60288 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhJDJbl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 05:31:41 -0400
Received: (qmail 8876 invoked by uid 109); 4 Oct 2021 09:29:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Oct 2021 09:29:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12571 invoked by uid 111); 4 Oct 2021 09:29:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Oct 2021 05:29:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 Oct 2021 05:29:51 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] object-name: make ambiguous object output
 translatable
Message-ID: <YVrJj0Ltuc1Tcm7t@coredump.intra.peff.net>
References: <cover-0.2-00000000000-20211004T013611Z-avarab@gmail.com>
 <patch-2.2-b6136380c28-20211004T013611Z-avarab@gmail.com>
 <YVqu0aEBMy3mnYoE@coredump.intra.peff.net>
 <87o885nq4z.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o885nq4z.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 04, 2021 at 10:26:10AM +0200, Ævar Arnfjörð Bjarmason wrote:

> >> +		/*
> >> +		 * TRANSLATORS: The argument is the list of ambiguous
> >> +		 * objects composed in show_ambiguous_object(). See
> >> +		 * its "TRANSLATORS" comment for details.
> >> +		 */
> >> +		advise(_("The candidates are:\n\n%s"), sb.buf);
> >
> > Here's where the extra newline.
> >
> > I understand why the earlier ones were changed for RTL languages. But
> > this one is always line-oriented. Is the point to help bottom-to-top
> > languages? I can buy that, though it feels like that would be something
> > that the terminal would deal with (because even with this, you're still
> > getting the "error:" line printed separately, for example).
> >
> > I don't think what this is doing is wrong (at first I wondered about the
> > "hint:" lines, but because advise() looks for embedded newlines, we're
> > OK). But if the translation doesn't need to reorder things across lines,
> > this extra format-into-a-strbuf step doesn't seem necessary. We can just
> > call advise() directly in show_ambiguous_object(), as before.
> >
> > If it is necessary, then note that you leak "sb" here.
> 
> I'll keep that bit as-is, it's not strictly necessary, but it gives
> translators a bit more context.

If it's just for the context, wouldn't this do the same thing:

  /*
   * TRANSLATORS: This is followed by the list of ambiguous
   * objects composed in show_ambiguous_object(). See its
   * "TRANSLATORS" comments for details.
   */
  advise(_("The candidates are:"));
  ...
  if (oid_array_for_each(&collect, show_ambiguous_object, &ds))
     ...

I.e., leave the code as-is, and just add the extra comment. There is no
need for the extra struct or any change of ordering between this
advise() and the others.

I would think it is worthwhile if we are de-lego-ing a message that is
made in chunks, but in this case the we have to construct an opaque "%s"
to represent the individual lines for each object, because we don't know
how many of them there will be.

-Peff

PS In my "something like this" commit message, I indicated that the
   "candidates" message was getting translated, but it actually is
   already translated in the pre-image. So I think we would not need to
   touch that line at all.
