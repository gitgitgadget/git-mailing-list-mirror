Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19C1FA3741
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 02:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiKACcj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 22:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiKACcj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 22:32:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCBBCD5
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 19:32:37 -0700 (PDT)
Received: (qmail 4016 invoked by uid 109); 1 Nov 2022 02:32:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Nov 2022 02:32:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18194 invoked by uid 111); 1 Nov 2022 02:32:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 31 Oct 2022 22:32:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 31 Oct 2022 22:32:36 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC PATCH] fetch: stop emitting duplicate
 transfer.credentialsInUrl=warn warnings
Message-ID: <Y2CFRJLFRXvGwFBC@coredump.intra.peff.net>
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <RFC-patch-1.1-0266485bc6c-20221031T204149Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <RFC-patch-1.1-0266485bc6c-20221031T204149Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 09:47:08PM +0100, Ævar Arnfjörð Bjarmason wrote:

>  * When we invoke e.g. "git-remote-https" (aka. "git-remote-curl")
>    from "git fetch". For those cases let's pass down the equivalent of a
>    "-c transfer.credentialsInUrl=allow", since we know that we've already
>    inspected our remotes in the parent process.
> 
>    See 7390f05a3c6 (fetch: after refetch, encourage auto gc repacking,
>    2022-03-28) for prior use of git_config_push_parameter() for this
>    purpose, i.e. to push config parameters before invoking a
>    sub-process.

So I guess I don't have any _specific_ thing that goes wrong with this
approach, but it really feels sketchy to me. We are lying to
sub-processes about the config the user asked for. And again, I see how
it works, but I wonder if this kind of approach would ever backfire on
us. For example, if transfer.credentialsInUrl=warn ever ended up having
any side effects besides the warning, and the sub-processes ended up
skipping those effects.

I know that's a hypothetical, and probably not even a likely one, but it
just gets my spider sense tingling.

> > Since it is not actually important how many times Git prints the
> > warning/error message, as long as it prints it at least once, let's just
> > make the test a bit more lenient and test for the latter instead of the
> > former, which works around these CI issues.
> 
> That being said your change is obviously smaller, so if we'd prefer
> that in first as a band-aid I'm fine with that.
> 
> But I'd really like to object to the "it is not actually important how
> many...", it's crappy UX to spew duplicate output at the user, and we
> should avoid it.
> 
> So it does matter, and we get it wrong not just in this but also some
> other cases.

Yeah, I think it is crappy UX, too. It's just that I think the tests
should not _asserting_ the bad behavior. At most, they should tolerate
the bad behavior as a band-aid. So I think Dscho's patch is doing the
right thing (and I do agree that we should fix the immediate CI pain by
adjusting the tests, and letting the user-visible fix proceed
independently).

-Peff
