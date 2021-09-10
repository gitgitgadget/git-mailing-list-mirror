Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB99C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0343C60235
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbhIJO1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 10:27:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:43906 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233120AbhIJO1n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 10:27:43 -0400
Received: (qmail 5857 invoked by uid 109); 10 Sep 2021 14:26:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Sep 2021 14:26:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25525 invoked by uid 111); 10 Sep 2021 14:26:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Sep 2021 10:26:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Sep 2021 10:26:31 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] ref-filter: hacky "streaming" mode
Message-ID: <YTtrF8C0mmT6kBJT@coredump.intra.peff.net>
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net>
 <YTNpeH+jO0zQgAVT@coredump.intra.peff.net>
 <CAOLTT8Tka0nxHb3G9yb-fs8ue7RaPCUVSKi5PM+GY+rMjFRnog@mail.gmail.com>
 <YTTARcEvpXWSDfYW@coredump.intra.peff.net>
 <CAOLTT8QbdNBSY95bCa+UNJBqsJEEHbnaKfZLzvN2Qzd-Np8Lqg@mail.gmail.com>
 <YTeo/dCFfpAIfo3K@coredump.intra.peff.net>
 <CAOLTT8Ru-Zhmo5j=jNjWexrahT0qAO5zEMW09XT00-TCca-SkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLTT8Ru-Zhmo5j=jNjWexrahT0qAO5zEMW09XT00-TCca-SkA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 09, 2021 at 10:45:15PM +0800, ZheNing Hu wrote:

> @@ -2735,6 +2723,7 @@ void pretty_print_ref(const char *name, const
> struct object_id *oid,
> 
>         ref_item = new_ref_array_item(name, oid);
>         ref_item->kind = ref_kind_from_refname(name);
> +       read_ref_full(name, 0, NULL, &ref_item->flag);
>         if (format_ref_array_item(ref_item, format, &output, &err))
>                 die("%s", err.buf);
>         fwrite(output.buf, 1, output.len, stdout);

IMHO this is the wrong place to do it, since the caller may already have
the flags (and looking up the ref again is a non-trivial cost).

The caller in builtin/tag.c should switch to using read_ref_full() and
pass in the flags.

The caller in builtin/verify-tag.c _probably_ should resolve the ref in
the same way and pass in that full refname and flags. I do worry that
this may be a compatibility problem, but the current behavior seems so
broken to me.

> >   - I suspect people may be relying on the current behavior. The
> >     original was added to be able to compare the internal tagname to the
> >     refname. I.e., that:
> >
> >       git tag -v --format='%(refname) %(tag)' foo
> >
> >     would show "foo foo". Now that _should_ be "%(refname:strip=2)", I
> >     think, but we'd probably be breaking scripts. OTOH, it really feels
> >     like _not_ handing over a real, fully-qualified refname to the
> >     ref-filter code will mean other things are broken (e.g.,
> >     ATOM_UPSTREAM is assuming we have a fully-qualified ref).
> >
> 
> This is indeed a sad thing: A bug becomes a feature.
> 
> >     I think a backwards-compatible way of fixing it would be to have
> >     this call hand over the full refname to the ref-filter code, but
> >     tell it that %(refname) should default to strip=2. And then anybody
> >     who wants the full name can use %(refname:strip=0).
> >
> 
> Doesn't this make things more complicated? Those callers of git for-each-ref,
> wouldn't our changes like this destroy them?

My proposal was that we'd have a specific flag in ref-filter to say
"default refname:strip to this value". And then _only_ "tag --verify"
would set that (to "2"), leaving for-each-ref, etc unaffected.

So yes, it's complicated. And it must be explained to the user that
"%(refname)" behaves slightly differently with "git tag --verify", but
that is unavoidable if we do not want to break scripts (it _already_
behaves slightly differently, and we just never told anyone).

The other option is to declare the current behavior a bug and fix it. I
am quite tempted by that route, given the inconsistency with other
formatters, including even "git tag --list --format=%(refname)"!

-Peff
