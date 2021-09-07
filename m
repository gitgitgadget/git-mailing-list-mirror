Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BE4C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 18:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 582CA60698
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 18:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344755AbhIGSCl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 14:02:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:40816 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhIGSCk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 14:02:40 -0400
Received: (qmail 19844 invoked by uid 109); 7 Sep 2021 18:01:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Sep 2021 18:01:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15938 invoked by uid 111); 7 Sep 2021 18:01:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Sep 2021 14:01:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Sep 2021 14:01:33 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] ref-filter: hacky "streaming" mode
Message-ID: <YTeo/dCFfpAIfo3K@coredump.intra.peff.net>
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net>
 <YTNpeH+jO0zQgAVT@coredump.intra.peff.net>
 <CAOLTT8Tka0nxHb3G9yb-fs8ue7RaPCUVSKi5PM+GY+rMjFRnog@mail.gmail.com>
 <YTTARcEvpXWSDfYW@coredump.intra.peff.net>
 <CAOLTT8QbdNBSY95bCa+UNJBqsJEEHbnaKfZLzvN2Qzd-Np8Lqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLTT8QbdNBSY95bCa+UNJBqsJEEHbnaKfZLzvN2Qzd-Np8Lqg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 01:28:33PM +0800, ZheNing Hu wrote:

> > I think it's just because pretty_print_ref() does not take a "flag"
> > parameter for the caller. So it never sees that REF_ISSYMREF is set.
> >
> 
> yeah, pretty_print_ref() does not set the flag, this is a defect of
> pretty_print_ref(), maybe we need to find a way to set this flag.

In general, I think it could take a flag parameter from its caller. But
its caller comes indirectly from for_each_tag_name(), which isn't a
regular ref-iterator. It would probably need to switch to using
read_ref_full() to get the flags.

> > I notice that the --verify output also shows the short refname, which
> > makes me wonder if %(symref) would have other bugs there (because it
> > has to re-resolve the ref to come up with the symref destination).
> >
> 
> This may be easy to fix:
> 
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 452558ec95..4be5d36366 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -152,11 +152,11 @@ static int verify_tag(const char *name, const char *ref,
>         if (format->format)
>                 flags = GPG_VERIFY_OMIT_STATUS;
> 
> -       if (gpg_verify_tag(oid, name, flags))
> +       if (gpg_verify_tag(oid, ref, flags))
>                 return -1;
> 
>         if (format->format)
> -               pretty_print_ref(name, oid, format);
> +               pretty_print_ref(ref, oid, format);
> 
>         return 0;
>  }

Yeah, I think that would work, although:

  - there's another caller in cmd_verify_tag() which seems to just pass
    whatever was on the command line. It doesn't even resolve the ref
    itself!

  - I suspect people may be relying on the current behavior. The
    original was added to be able to compare the internal tagname to the
    refname. I.e., that:

      git tag -v --format='%(refname) %(tag)' foo

    would show "foo foo". Now that _should_ be "%(refname:strip=2)", I
    think, but we'd probably be breaking scripts. OTOH, it really feels
    like _not_ handing over a real, fully-qualified refname to the
    ref-filter code will mean other things are broken (e.g.,
    ATOM_UPSTREAM is assuming we have a fully-qualified ref).

    I think a backwards-compatible way of fixing it would be to have
    this call hand over the full refname to the ref-filter code, but
    tell it that %(refname) should default to strip=2. And then anybody
    who wants the full name can use %(refname:strip=0).

    It makes the behavior confusing and quirky, but we can't avoid that
    without breaking compatibility.

-Peff
