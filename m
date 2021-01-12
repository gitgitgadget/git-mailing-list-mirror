Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42575C433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 11:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E484A23109
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 11:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbhALLXN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 06:23:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:53234 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbhALLXM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 06:23:12 -0500
Received: (qmail 8832 invoked by uid 109); 12 Jan 2021 11:22:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jan 2021 11:22:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12274 invoked by uid 111); 12 Jan 2021 11:22:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jan 2021 06:22:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jan 2021 06:22:31 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Should you use test_i18ngrep or GIT_TEST_GETTEXT_POISON=false?
Message-ID: <X/2Gd9J/zWqK2wLn@coredump.intra.peff.net>
References: <20201223013606.7972-1-avarab@gmail.com>
 <20210105194252.627-13-avarab@gmail.com>
 <20210110132155.GT8396@szeder.dev>
 <87y2h062jd.fsf@evledraar.gmail.com>
 <xmqqczyca6vq.fsf@gitster.c.googlers.com>
 <87pn2b6eyb.fsf@evledraar.gmail.com>
 <xmqqim836v6m.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqim836v6m.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 11, 2021 at 01:05:37PM -0800, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > What do you think about just removing it? I.e. make setting it a noop?
> 
> I have been seeing occasional CI job failures from new tests that
> forget to use test_i18ngrep.  I actually think marking such a grep
> as "this is looking for a string that is meant for humans" a good
> way to document the interface and expected end-user interaction,
> so I am not sure about just removing it.
> 
> So after all, test_i18ngrep may make more sense than setting
> GIT_TEST_GETTEXT_POISON to false.  I dunno.

I agree that test_i18ngrep is preferable to setting
GIT_TEST_GETTEXT_POISON. Since it's tied to the comparison itself, I
think it's easier to see which messages we're expecting as
human-readable. It's also shorter and more readable IMHO (you'd already
be calling grep or test_cmp, so it is only a little longer).

I am on the fence on whether the presence of something like
test_i18ngrep in the test suite is really serving as a useful indication
of what was meant to be translated and what wasn't. It's such an
incomplete coverage of the total set of messages we generate that I
wouldn't trust it. I'd be more likely to look at the source to see if a
message is actually translated, or just assume we follow some basic
rules (in general, things to stderr are translatable; I think the
plumbing outputs from unpack_trees() were really the exception).

So I'm open to the idea that the whole poison mechanism has just
outlived its usefulness.

-Peff
