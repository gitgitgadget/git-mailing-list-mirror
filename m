Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19904C433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 22:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E979B230FE
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 22:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbhASWCA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 17:02:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:60290 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727918AbhASWAU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 17:00:20 -0500
Received: (qmail 14837 invoked by uid 109); 19 Jan 2021 21:59:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Jan 2021 21:59:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12748 invoked by uid 111); 19 Jan 2021 21:59:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Jan 2021 16:59:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 19 Jan 2021 16:59:18 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jacob Vosmaer <jacob@gitlab.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] ls-refs.c: minimize number of refs visited
Message-ID: <YAdWNgF75QEYFLA7@coredump.intra.peff.net>
References: <20210119144251.27924-1-jacob@gitlab.com>
 <20210119144251.27924-2-jacob@gitlab.com>
 <YAcE/dTuOB9PbGQU@nand.local>
 <CADMWQoPREhirr+RJPkJJV2U+8VG=DFotvTBCDSXFhn-3pn2X-A@mail.gmail.com>
 <YAcuUDqfvKzfHFMb@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAcuUDqfvKzfHFMb@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 02:09:04PM -0500, Taylor Blau wrote:

> > What does "delimited by /" mean?
> 
> Ah, I just meant that it looks for the longest common prefix where it
> will only split at '/' characters. But, that's not right at all:
> find_longest_prefixes_1() will happily split anywhere there is a
> difference.

Right. We thought in early revisions of the ref-filter work that we
might have to split on path components, but it turns out that the
underlying ref code is happy to take arbitrary prefixes. And it's that
code which defines our strategy; Even if the ls-refs code wanted to
allow only full path components, it should be using the limiting from
for_each_ref_in() only as an optimization, and applying its own
filtering to the output.

> > Without really understanding the longest common prefix code in
> > ref-filter.c, my intuitive concern is that the specifics of glob
> > matching and special treatment of '/' may bite us. I suppose we'll be
> > fine because ls-refs has its own matching logic. So long as
> > for_each_fullref_in_prefixes yield enough prefixes, the end result
> > would remain the same.
> 
> Right. We can ignore the concern about '/' (seeing my comment above),
> and note that find_longest_prefixes_1() breaks on glob metacharacters,
> so we'll only match or overmatch the desired set (and we'll never
> undermatch).
> 
> I made sure to write in the second patch downthread that
> ls-refs.c:send_ref() correctly handles receiving too many refs (and it
> discards ones that it doesn't want).

Yeah, I think the glob-handling is OK for that reason. We'd have a
smaller prefix, which means seeing more refs. So it's never a
correctness issue, but only a potential optimization one (we consider
more refs in ls-refs.c than we might otherwise). But I think even that s
impossible, because the glob characters are not valid in refnames. So we
would never see one at all in a string which is meant to be a pure
prefix.

> > I think my approach would be to expose the new
> > for_each_fullref_in_prefixes iterator you propose through test-tool,
> > and unit test it so we can be sure it handles both contexts
> > (for-each-refs with globs and special '/', and ls-refs without any
> > special character behavior) correctly.
> >
> > I may be overly cautious here, take this with a grain of salt because
> > I am not an experienced Git contributor. On that topic, apologies if
> > I'm botching my inline replies in this email.
> 
> I do appreciate your caution, but I'm not sure exposing a test-tool is
> necessary, since we already test this behavior extensively in t6300 (and
> now t5701, t5702 and t5704, too).

Agreed. test-tool is fine when we have no way to easily feed data to a
unit. But in this case, the prefix code is easy to test via the
for-each-ref plumbing. We'd want to make sure the new setting in ls-refs
is covered, too, but I agree that t5701 covers that well (regular
fetches make sure we don't send too few refs, but those ones check that
we limited the refs in the expected way).

-Peff
