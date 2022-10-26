Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D80C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 05:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbiJZFeu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 01:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbiJZFer (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 01:34:47 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A116922B13
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 22:34:43 -0700 (PDT)
Received: (qmail 10657 invoked by uid 109); 26 Oct 2022 05:34:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Oct 2022 05:34:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1656 invoked by uid 111); 26 Oct 2022 05:34:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Oct 2022 01:34:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 26 Oct 2022 01:34:42 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 4/4] Documentation: add lint-fsck-msgids
Message-ID: <Y1jG8p1aARb9+CV+@coredump.intra.peff.net>
References: <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
 <20221025224224.2352979-1-gitster@pobox.com>
 <20221025224224.2352979-5-gitster@pobox.com>
 <221026.867d0ncncu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221026.867d0ncncu.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2022 at 04:43:32AM +0200, Ævar Arnfjörð Bjarmason wrote:

> 
> On Tue, Oct 25 2022, Junio C Hamano wrote:
> 
> > During the initial development of the fsck-msgids.txt feature, it
> > has become apparent that it is very much error prone to make sure
> > the description in the documentation file are sorted and correctly
> > match what is in the fsck.h header file.
> 
> I have local fixes for the same issues in the list of advice in our
> docs, some of it's missing, wrong, out of date etc.
> 
> I tried to quickly adapt the generation script I had for that, which
> works nicely, and by line count much shorter than the lint :)

Yeah, my instinct here was to generate rather than lint. If you make a
mistake and the linter hits you over the head, that is better than
quietly letting your mistake go. But better still is making it
impossible to make in the first place.

The downside is added complexity to the build, but it doesn't seem too
bad in this case.

(I had a similar thought after getting hit on the head by the recent
t0450-txt-doc-vs-help.sh).

> Having to exhaustively list every *.c file that uses fsck.h is a bit of
> a bother, but we have the same with the other generated *.h's, so it
> shouldn't be too bad.

It feels like this could be made much shorter by having a separate
fsck-msgs.h and not including it from fsck.h. Only fsck.c and mktag.c
need the actual list. It would probably have to stop being an "enum",
though.

Another alternative is to generate the doc from the code, rather than
the other way around.

> +# Unfortunately our dependency management of generated headers used
> +# from within other headers suck, so we'll need to list every user of
> +# fsck.h here, but not too bad...
> +FSCK_MSGIDS_H_BUILTINS = fsck index-pack mktag receive-pack unpack-objects
> +$(foreach f,$(FSCK_MSGIDS_H_BUILTINS:%=builtin/%),$f.sp $f.s $f.o): fsck-msgids.h
> +FSCK_MSGIDS_H_LIBS = fetch-pack fsck
> +$(foreach f,$(FSCK_MSGIDS_H_LIBS),$f.sp $f.s $f.o): fsck-msgids.h

I don't understand the "used within other headers" part here. Computed
dependencies will get this right. It's only the initial build (before we
have any computed dependencies) that needs to know that the C files in
question depend on the generated file. But that is true whether they do
so directly or indirectly.

-Peff
