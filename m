Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A8461F51C
	for <e@80x24.org>; Mon, 21 May 2018 02:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752691AbeEUCin (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 22:38:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:47412 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752680AbeEUCim (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 22:38:42 -0400
Received: (qmail 14389 invoked by uid 109); 21 May 2018 02:38:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 21 May 2018 02:38:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25323 invoked by uid 111); 21 May 2018 02:38:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 20 May 2018 22:38:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 May 2018 19:38:40 -0700
Date:   Sun, 20 May 2018 19:38:40 -0700
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re*: [PATCH v4 3/4] string-list: provide `string_list_appendf()`
Message-ID: <20180521023840.GA16236@sigill.intra.peff.net>
References: <CAN0heSp7DqxOy-UeLgj8t_T_4f-fNthMpGNS8oUbcs7+NvS-zw@mail.gmail.com>
 <cover.1526810549.git.martin.agren@gmail.com>
 <77b025bb47869478e3eef1c3c34d379164f5d91c.1526810549.git.martin.agren@gmail.com>
 <CA+P7+xqPnuuQpp5e7fduLgaSd+JrTn95w=Da7q=iCXUgo0QHFA@mail.gmail.com>
 <xmqqvabh3mim.fsf_-_@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqvabh3mim.fsf_-_@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 21, 2018 at 09:01:05AM +0900, Junio C Hamano wrote:

> Jacob Keller <jacob.keller@gmail.com> writes:
> 
> > On Sun, May 20, 2018 at 3:17 AM, Martin Ågren <martin.agren@gmail.com> wrote:
> >> +/**
> >> + * Add formatted string to the end of `list`. This function ignores
> >> + * the value of `list->strdup_strings` and always appends a freshly
> >> + * allocated string, so you will probably not want to use it with
> >> + * `strdup_strings = 0`.
> >> + */
> >> +struct string_list_item *string_list_appendf(struct string_list *list,
> >> +                                            const char *fmt, ...);
> >> +
> >
> > Would it make sense to verify that strdup_strings == 0? I guess we'd
> > have to use die or BUG(), but that would mean that the program could
> > crash..
> 
> It probably is clear to readers that any reasonable implementation
> of *_appendf() will create a new and unique string, as the point of
> *f() is to give a customized instantiation of fmt string for given
> parameters.  So it would be natural to expect that the storage that
> holds the generated string will belong to the list.  We _could_ make
> it honor strdup_strings and make one extra copy when strdup_strings
> is set to true, but the only effect such a stupid implementation has
> is to unnecessarily leak ;-)
> 
> I think it is probably OK to check and BUG() when strdup_strings==0,
> but such a check means that we now declare that a string list must
> either borrow all of its strings from elsewhere or own all of its
> strings itself, and mixture is not allowed.
>
> The (overly) flexible string_list API could be used to mix both
> borrowed and owned strings (an obvious strategy to do this without
> leaking and crashing is to use the .util field to mark which ones
> are owned and which ones are borrowed), so there might already be
> current users of the API that violates that rule.

IMHO such a mixed use is mildly crazy. At any rate, we would know that
anybody using appendf() would not have this problem, since we are just
introducing it now.

> I have a feeling that argv_array might be a better fit for the
> purpose of keeping track of to_free[] strings in the context of this
> series.  Moving away from string_list would allow us to sidestep the
> storage ownership issues the API has, and we do not need the .util
> thing string_list gives us (which is one distinct advantage string_list
> has over argv_array, if the application needs that feature).

I do agree that argv_array is generally a better fit for most cases.
Didn't we want to rename it to strarray or something? That's probably
too much yak-shaving for this series, though. :)

> We would need to make _pushf() and friends return "const char *" if
> we go that route to make the resulting API more useful, though.

This is the first time I think that's been suggested, but I agree it's
the only sensible thing for the functions to return.

> -- >8 --
> Subject: argv-array: return the pushed string from argv_push*()
> 
> Such an API change allows us to use an argv_array this way:
> 
> 	struct argv_array to_free = ARGV_ARRAY_INIT;
>         const char *msg;
> 
>         if (some condition) {
> 		msg = "constant string message";
> 		... other logic ...
> 	} else {
> 		msg = argv_pushf(&to_free, "format %s", var);
> 	}
> 	... use "msg" ...
> 	... do other things ...
> 	argv_clear(&to_free);
> 
> Note that argv_array_pushl() and argv_array_pushv() are used to push
> one or more strings with a single call, so we do not return any one
> of these strings from these two functions in order to reduce the
> chance to misuse the API.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Yup, this looks good to me.

-Peff
