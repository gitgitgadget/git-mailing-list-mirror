Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCF5C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 10:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiGKKa6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 06:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiGKKaf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 06:30:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD96CA44CF
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 02:41:01 -0700 (PDT)
Received: (qmail 6901 invoked by uid 109); 11 Jul 2022 09:41:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 Jul 2022 09:41:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17113 invoked by uid 111); 11 Jul 2022 09:41:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Jul 2022 05:41:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Jul 2022 05:41:00 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 0/6] add and apply a rule to find "unused" init+free
Message-ID: <YsvwLIfjZffUWOP/@coredump.intra.peff.net>
References: <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com>
 <cover-v4-0.6-00000000000-20220705T134033Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v4-0.6-00000000000-20220705T134033Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 05, 2022 at 03:46:54PM +0200, Ævar Arnfjörð Bjarmason wrote:

> This series adds a coccinelle rule to find and remove code where the
> only reference to a variable in a given function is to malloc() &
> free() it, where "malloc" and "free" also match
> "strbuf_init/strbuf_release", and then later in the series anything
> that looks like a init/free pattern.

As before, I'm perfectly happy with the actual transformations here.

> Changes since v3[1]
> 
>  * Add a "coccicheck-test" target in an early and new patch, the
>    structure mirrors that of coccinelle.git's own tests. As the
>    diffstat shows we have a *.c and *.res file which is C code
>    before/after a *.cocci rule is applied.

I have mixed feelings on this. I'm not opposed per se, and I even like
the fact that it provides examples of what we expect a rule to do. But I
worry about a world where the cost of using coccinelle goes up because
now transformations need to have tests along with them. The idea of
cocci is to make your life a little simpler and more efficient when
fixing up the code base (as opposed to perl, etc). But if it comes with
a bunch of boilerplate tasks, that might no longer be the case. I'm
already often on the fence about using cocci just because of the hours
I've sunk into debugging and puzzling things out.

I dunno. Maybe the bar is higher for stuff like this that we expect to
continue to find problems as time goes on (because it is not "here is a
transition", but "this is a common and easy mistake to make").

So again, I'm not really opposed to this patch in particular, but I want
to express caution at the direction we might be going, and at applying
new rules over-zealously.

>  * We now catch init/reset patterns as well as init/release fully
>    (i.e. for the "struct strbuf" early on)

Yeah, that makes sense.

-Peff
