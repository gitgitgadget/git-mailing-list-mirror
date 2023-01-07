Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D94C46467
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 13:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjAGNVd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 08:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjAGNVa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 08:21:30 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C14C5880D
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 05:21:28 -0800 (PST)
Received: (qmail 23397 invoked by uid 109); 7 Jan 2023 13:21:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 07 Jan 2023 13:21:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23511 invoked by uid 111); 7 Jan 2023 13:21:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Jan 2023 08:21:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Jan 2023 08:21:26 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/5] strvec: add a "nodup" mode, fix memory leaks
Message-ID: <Y7lx1hUpZ7zOP1Lo@coredump.intra.peff.net>
References: <221214.86ilie48cv.gmgdl@evledraar.gmail.com>
 <RFC-cover-0.5-00000000000-20221215T090226Z-avarab@gmail.com>
 <Y53AXmfabIvdkfZz@coredump.intra.peff.net>
 <221219.867cyn20zj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221219.867cyn20zj.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2022 at 10:20:00AM +0100, Ævar Arnfjörð Bjarmason wrote:

> I hear you, but I also think you're implicitly conflating two things
> here.
> 
> There's the question of whether we should in general optimize for safety
> over more optimila memory use. I.e. if we simply have every strvec,
> string_list etc. own its memory fully we don't need to think as much
> about allocation or ownership.
> 
> I think we should do that in general, but we also have cases where we'd
> like to not do that, e.g. where we're adding thousands of strings to a
> string_list, which are all borrewed from elsewhere, except for a few
> we'd like to xstrdup().
> 
> Such API use *is* tricky, but I think formalizing it as the
> "string_list" does is making it better, not worse. In particular...:

I think the two things are related, though, because "safety" is "people
not mis-using the API". Once you give the API the option to do the
trickier thing, people will do it, and they will do it badly. That has
been my experience with the string-list API (especially that people try
to do clever things with transferring ownership by using a
non-duplicating list and then setting strdup_strings midway through the
function).

> > I would disagree that this hasn't been an issue in practice. A few
> > recent examples:
> >
> >   - 5eeb9aa208 (refs: fix memory leak when parsing hideRefs config,
> >     2022-11-17)
> >   - 7e2619d8ff (list_objects_filter_options: plug leak of filter_spec
> >     strings, 2022-09-08)
> >   - 4c81ee9669 (submodule--helper: fix "reference" leak, 2022-09-01)
> 
> ...it's funny that those are the examples I would have dug up to argue
> that this is a good idea, and to add some:
> 
> 	- 4a0479086a9 (commit-graph: fix memory leak in misused
>           string_list API, 2022-03-04)
> 	- b202e51b154 (grep: fix a "path_list" memory leak, 2021-10-22)
> 
> I.e. above you note "in both directions [...] leaks [...] and double
> frees", but these (and the ones I added) are all in the second category.

I almost didn't give a list, because it's hard to dig into all of the
details. For example the second one in my list, which I worked on, did
fix things by consistently setting strdup_strings, and it was "just" a
leak fix. But it took me a full day to untangle the mess of that code,
and there were intermediate states were we did access dangling pointers
before I got to a working order of the series.  And all of it was
complicated by the fact that string_list is configurable, so different
bits of the code expected different things. Even after that commit,
there's a horrible hack to set the strdup field and hope it's enough.

If that were the only time I'd wrestled with string_list, I'd be less
concerned. But (subjectively) this feels like the latest in a long line
of bugs and irritations.

-Peff
