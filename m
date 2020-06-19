Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8963FC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72E132158C
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392801AbgFSQBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:01:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:37300 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404225AbgFSQBb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 12:01:31 -0400
Received: (qmail 3540 invoked by uid 109); 19 Jun 2020 16:01:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Jun 2020 16:01:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15720 invoked by uid 111); 19 Jun 2020 16:01:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Jun 2020 12:01:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Jun 2020 12:01:29 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] fast-export: allow dumping the refname mapping
Message-ID: <20200619160129.GA1843858@coredump.intra.peff.net>
References: <20200619132304.GA2540657@coredump.intra.peff.net>
 <20200619132546.GA2540774@coredump.intra.peff.net>
 <CAPig+cRNem-S5LGX=v=1Tid64sXWBxNyWH4ffgLgF0o1yN=mtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRNem-S5LGX=v=1Tid64sXWBxNyWH4ffgLgF0o1yN=mtw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 19, 2020 at 11:51:06AM -0400, Eric Sunshine wrote:

> > +static void maybe_dump_anon(FILE *out, struct seen_set *seen,
> > +                           const char *orig, const char *anon)
> > +{
> > +       if (!out)
> > +               return;
> > +       if (!check_and_mark_seen(seen, orig))
> > +               fprintf(out, "%s %s\n", orig, anon);
> > +}
> 
> Nit: For a function which has only a single caller in this patch and
> one more caller added in 3/3, I wonder if the, um, convenience of this
> function short-circuiting as the very first thing it does outweighs
> the loss of clarity of having the callers make the check themselves.
> That is, have the caller do this instead:
> 
>     if (anonymized_refnames_handle)
>         dump_anon(anonymized_refnames_handle, ...);

<shrug> The names were long enough that I thought it was more clear not
to repeat myself. I actually wrote originally:

  if (anonymized_refnames_handle &&
      check_and_mark_seen(&seen, full_refname))
          fprintf(anonymized_refnames_handle, "%s %s\n",
	          full_refname, anon.buf));

but I wasn't sure if it was better not to duplicate the output format.
OTOH, we _could_ be using quote_path() for the path dumping, in which
case the formats would start to differ.

> > @@ -1213,6 +1249,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
> > +       if (anonymized_refnames_file)
> > +               anonymized_refnames_handle = xfopen(anonymized_refnames_file, "w");
> 
> For completeness, do you want to close this file at some point?

My thought was to just let it auto-close at exit() time, since it's
effectively process-length.

> > diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
> > @@ -46,6 +46,18 @@ test_expect_success 'stream omits tag message' '
> > +test_expect_success 'refname mapping can be dumped' '
> > +       git fast-export --anonymize --all \
> > +               --dump-anonymized-refnames=refs.out >/dev/null &&
> > +       # we make no guarantees of the exact anonymized names,
> > +       # so just check that we have the right number and
> > +       # that a sample line looks sane.
> > +       # Note that master is not anonymized, and so not included
> > +       # in the mapping.
> > +       test_line_count = 6 refs.out &&
> 
> This hard-coded "6" seems rather fragile, causing the test to break if
> other refs are ever added or removed. Perhaps just count the refs
> dynamically?
> 
>     git show-ref >refs &&
>     nrefs=$(wc -l refs) &&
>     # Note that master is not anonymized, and so not included
>     # in the mapping.
>     nrefs=$((nrefs - 1))
>     test_line_count = $nrefs refs.out &&
> 
> and then drop the 'nrefs=$((nrefs - 1))' line and associated comment
> in patch 2/3 which removes the "master" special case.

That's exactly what I wrote originally, but it failed on macos due to
extra spaces in the "wc" output. There are other tests nearby that also
count the refs (e.g., exactly 2 branches), so I didn't think it was
worth trying to deal with the portability issue.

-Peff
