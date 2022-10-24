Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC94C38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 00:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiJYA51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 20:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiJYA5N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 20:57:13 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D225F1C129
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 16:45:29 -0700 (PDT)
Received: (qmail 4536 invoked by uid 109); 24 Oct 2022 23:45:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Oct 2022 23:45:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12235 invoked by uid 111); 24 Oct 2022 23:45:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Oct 2022 19:45:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 24 Oct 2022 19:45:28 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jacob Stopak <jacob@initialcommit.io>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/7] shortlog: introduce `--group=<format>`
Message-ID: <Y1cjmJY8YUv7Pv21@coredump.intra.peff.net>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666637725.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666637725.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 24, 2022 at 02:55:26PM -0400, Taylor Blau wrote:

> There are only a couple of changes from last time: one to rebase onto
> the current tip of 'master', and another to address a bug in 4/7 (which
> was resolved by the end of the series, but now works consistently
> throughout the series).
> 
> This was pointed out by Peff in [1], and he indicated there:
> 
> > It's hard to care too much, since the end result of the series is
> > correct, and you'd end up just removing that part of the line in
> > the final patch. So I could go either way on re-rolling.
> 
> ...but not re-rolling would be somewhat unsatisfying. So here is a
> reroll that I think should be good to go.

OK, good. It offended my sensibilities, too, but I didn't want to force
extra work on you because of them. I'm glad you agreed. ;)

This isn't mark v4, but the range-diff from v3 is:

1:  31487229e6 = 1:  e79db4b987 shortlog: accept `--date`-related options
2:  be2c6c0f4c = 2:  81e91f7049 shortlog: make trailer insertion a noop when appropriate
3:  bd38ac66f2 = 3:  cde611e3b0 shortlog: extract `--group` fragment for translation
4:  277ffe92ce ! 4:  020a2175cb shortlog: support arbitrary commit format `--group`s
    @@ builtin/shortlog.c: static void insert_records_from_trailers(struct shortlog *lo
      
     +static int shortlog_needs_dedup(const struct shortlog *log)
     +{
    -+	return log->format.nr > 1 || log->trailers.nr;
    ++	return HAS_MULTI_BITS(log->groups) || log->format.nr > 1 || log->trailers.nr;
     +}
     +
     +static void insert_records_from_format(struct shortlog *log,
5:  6c02a2daab = 5:  13a1f1b8c8 shortlog: extract `shortlog_finish_setup()`
6:  969bdaae39 = 6:  8af036c9f8 shortlog: implement `--group=author` in terms of `--group=<format>`
7:  bad7a2bc68 = 7:  09d138353b shortlog: implement `--group=committer` in terms of `--group=<format>`


I had assumed you would drop the HAS_MULTI_BITS() part from this
function after patch 7, as we know that everything is either a format or
a trailer. But actually, I like keeping it. It future-proofs us against
adding more non-format group types (though I have trouble imagining what
those would be), and it's not like it's expensive to keep around.

So this iteration looks good to me. Thanks!

-Peff
