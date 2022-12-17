Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989BFC4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 13:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiLQNNH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 08:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLQNNF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 08:13:05 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9C217416
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 05:13:03 -0800 (PST)
Received: (qmail 1905 invoked by uid 109); 17 Dec 2022 13:13:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Dec 2022 13:13:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22622 invoked by uid 111); 17 Dec 2022 13:13:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Dec 2022 08:13:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 17 Dec 2022 08:13:02 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/5] strvec: add a "nodup" mode, fix memory leaks
Message-ID: <Y53AXmfabIvdkfZz@coredump.intra.peff.net>
References: <221214.86ilie48cv.gmgdl@evledraar.gmail.com>
 <RFC-cover-0.5-00000000000-20221215T090226Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <RFC-cover-0.5-00000000000-20221215T090226Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2022 at 10:11:06AM +0100, Ævar Arnfjörð Bjarmason wrote:

> This is an alternative to René's [1], his already fixes a leak in "git
> am", and this could be done later, so I'm submitting it as RFC, but it
> could also replace it.
> 
> I think as this series shows extending the "strvec" API to get a
> feature that works like the existing "strdup_strings" that the "struct
> string_list" has can make memory management much simpler.

I know this is kind of a surface level review, but...please don't do
this. We have chased so many bugs over the years due to string-list's
"maybe this is allocated and maybe not", in both directions (accidental
leaks and double-frees).

One of the reasons I advocated for strvec in the first place is so that
it would have consistent memory management semantics, at the minor cost
of sometimes duplicating them when we don't need to.

And having a nodup form doesn't even save you from having to call
strvec_clear(); you still need to do so to avoid leaking the array
itself. It only helps in the weird parse-options case, where we don't
handle ownership of the array very well (the strvec owns it, but
parse-options wants to modify it).

> This does make the API slightly more dangerous to use, as it's no
> longer guaranteed that it owns all the members it points to. But as
> the "struct string_list" has shown this isn't an issue in practice,
> and e.g. SANITIZE=address et al are good about finding double-frees,
> or frees of fixed strings.

I would disagree that this hasn't been an issue in practice. A few
recent examples:

  - 5eeb9aa208 (refs: fix memory leak when parsing hideRefs config,
    2022-11-17)
  - 7e2619d8ff (list_objects_filter_options: plug leak of filter_spec
    strings, 2022-09-08)
  - 4c81ee9669 (submodule--helper: fix "reference" leak, 2022-09-01)

Now you could argue that those leaks might still exist if we only had a
duplicating version of string-list (after all, the problem in a leak is
an extra duplication). But IMHO it is the ambiguity and the games we
play with setting/unsetting the strdup_strings field that lead to these
errors.

And yes, leak-checking and sanitizers can sometimes find these bugs. But
that implies triggering the bug in the test suite. And it implies extra
time to track and fix them. An interface which is harder to get wrong in
the first place is preferable.

-Peff
