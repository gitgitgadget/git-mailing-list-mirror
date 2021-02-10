Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ED9C433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 10:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D00264E37
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 10:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhBJKEd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 05:04:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:56068 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229706AbhBJKCC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 05:02:02 -0500
Received: (qmail 30957 invoked by uid 109); 10 Feb 2021 10:01:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Feb 2021 10:01:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16577 invoked by uid 111); 10 Feb 2021 10:01:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Feb 2021 05:01:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Feb 2021 05:01:19 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Kyle Meyer <kyle@kyleam.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] rev-list --disk-usage
Message-ID: <YCOu70m5SKU7L4CS@coredump.intra.peff.net>
References: <YBHlGPBSJC++CnPy@coredump.intra.peff.net>
 <YCJpbPIlSpCAKSBF@coredump.intra.peff.net>
 <xmqqh7mkycno.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7mkycno.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 09, 2021 at 04:44:27PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Here's a re-roll of my series to add "rev-list --disk-usage", for
> > counting up object storage used for various slices of history.
> > ...
> >  t/t6114-rev-list-du.sh             | 51 +++++++++++++++++++
> >  t/test-lib-functions.sh            |  9 +++-
> >  7 files changed, 199 insertions(+), 8 deletions(-)
> >  create mode 100755 t/t6114-rev-list-du.sh
> 
> I relocated 6114 to 6115 to avoid tests sharing the same number.

Thanks. I wondered why I didn't notice, but it's because the other 6114
also just made it into "seen". :)

> I am getting these numbers from random ranges I am interested in,
> but do they say what I think they mean?  Was the development effort
> went into the v2.28 release almost half the size of v2.29, and have
> we already done about the same amont of work for this cycle?
> 
> : gitster git.git/seen; rungit seen rev-list --disk-usage master..next
> 83105
> : gitster git.git/seen; rungit seen rev-list --disk-usage v2.30.0..master
> 183463
> : gitster git.git/seen; rungit seen rev-list --disk-usage v2.29.0..v2.30.0
> 231640
> : gitster git.git/seen; rungit seen rev-list --disk-usage v2.28.0..v2.29.0
> 334355
> : gitster git.git/seen; rungit seen rev-list --disk-usage v2.27.0..v2.28.0
> 182298

As Taylor mentioned, this is only hitting the commits. So you might as
well just be looking at commit counts as a measure of work, I'd think
(and indeed v2.28 has about half as many commits as v2.29!).

Adding --objects gets you a rougher estimate of "bytes changed", which
helps accounts for commits of different sizes. But there I think you'd
do just as well to look at the actual number of lines changed with "git
diff --numstat".

I'd expect the number of on-disk bytes to _roughly_ correspond to the
size of the changes. But you are working against the heuristics of the
delta chains there. It may well be that we would store a base object in
the v2.28..v2.29 range, and a delta against it in v2.27..v2.28. And that
would attribute most of the bytes to v2.29, even though they should be
shared roughly with v2.28.

I'm sure one could devise a scheme for "sharing" the bytes from a delta
family across all of its objects. That might even be worth implementing
on top (I don't even think it would be too expensive; you just have to
collect the delta chains for any objects you're reporting, and then
average the total size among a chain).

But in practice, we've found this kind of naive --disk-usage useful for
answering questions like:

  - do I need all of these objects? Comparing "rev-list --disk-usage
    --objects --all", "rev-list --disk-usage --objects --all --reflog",
    and "du objects/pack/*.pack" will tell you if a prune/repack might
    help, and whether expiring reflogs makes a difference.

  - the size of the shared alternates repo for a set of forks has
    jumped. Comparing "rev-list --disk-usage --objects --remotes=$base
    --not --remotes=$fork" will tell you what's reachable from a fork
    but not from the base (we use "refs/remotes/$id/*" to keep track of
    fork refs in our alternates repo). This can be junk like somebody
    forking git/git and then uploading a bunch of pirated video files.
    :)

  - likewise, the size of cloning a single repo may jump. Comparing
    "rev-list --disk-usage --objects HEAD..$branch" for each branch
    might show that one branch is an outlier (e.g., because somebody
    accidentally committed a bunch of build artifacts).

In those kinds of cases, it's not usually "oh, this version is twice as
big as this other one". It's more like "wow, this branch is 100x as big
as the other branches", and little decisions like delta direction are
just noise. I imagine that in those cases the uncompressed object sizes
would probably produce similar patterns and answers. But it's actually
faster to produce the on-disk sizes. :)

-Peff
