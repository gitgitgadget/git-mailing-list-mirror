Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82A7C433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 09:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A9152224D
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 09:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgJSJz6 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 19 Oct 2020 05:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgJSJz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 05:55:58 -0400
Received: from mx.pao1.isc.org (mx.pao1.isc.org [IPv6:2001:4f8:0:2::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53740C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 02:55:58 -0700 (PDT)
Received: from zmx1.isc.org (zmx1.isc.org [149.20.0.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.pao1.isc.org (Postfix) with ESMTPS id 4A1B83AB002;
        Mon, 19 Oct 2020 09:55:58 +0000 (UTC)
Received: from zmx1.isc.org (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTPS id 3F4C3160073;
        Mon, 19 Oct 2020 09:55:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTP id 2CE8F160071;
        Mon, 19 Oct 2020 09:55:58 +0000 (UTC)
Received: from zmx1.isc.org ([127.0.0.1])
        by localhost (zmx1.isc.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id B9oYFzj-LMZJ; Mon, 19 Oct 2020 09:55:58 +0000 (UTC)
Received: from larwa.hq.kempniu.pl (unknown [212.180.223.213])
        by zmx1.isc.org (Postfix) with ESMTPSA id 6A3B7160044;
        Mon, 19 Oct 2020 09:55:57 +0000 (UTC)
Date:   Mon, 19 Oct 2020 11:55:54 +0200
From:   =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] diff: add -I<regex> that ignores matching changes
Message-ID: <20201019095554.GC3717@larwa.hq.kempniu.pl>
References: <20201012091751.19594-1-michal@isc.org>
 <20201015072406.4506-1-michal@isc.org>
 <20201015072406.4506-3-michal@isc.org>
 <xmqqa6wmc9yo.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6wmc9yo.fsf@gitster.c.googlers.com>
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Michał Kępień <michal@isc.org> writes:
> 
> > +test_expect_success 'diff -I<regex>' '
> > +	test_seq 50 >I.txt &&
> > +	sed -e "s/13/ten and three/" -e "/7\$/d" <I.txt >J.txt &&
> > +	echo >>J.txt &&
> > +
> > +	test_expect_code 1 git diff --no-index --ignore-blank-lines -I"ten.*e" -I"^[124-9]" I.txt J.txt >actual &&
> 
> Please wrap an overly long line like this oned, perhaps like:
> 
> 	test_expect_code 1 git diff --no-index --ignore-blank-lines \
> 		-I"ten.*e" -I"^[124-9]" I.txt J.txt >actual &&

Yeah, thanks, I was unsure what the line length limit for test code is.
I will fix this in v4.

> > +	test_expect_code 1 git diff --stat --no-index --ignore-blank-lines -I"ten.*e" -I"^[124-9]" I.txt J.txt >actual &&
> 
> > +	test_expect_code 129 git diff --no-index --ignore-matching-lines="^[124-9]" --ignore-matching-lines="^[124-9" I.txt J.txt >output 2>&1 &&
> 
> Cramming unrelated tests into a single one made me puzzled, staring
> at this line for longer than necessary before realizing that this is
> an attempt to catch a malformed regexp.  If this were in a separate
> test with its own title, e.g.
> 
> (...)
> 		
> It would have been much easier to follow.
> 
> It also is curious that it only tests --no-index, which is a bolted
> on feature that may not exercise the codepath the users depend on
> working correctly.  If this were tested with "git log -p" for a few
> commits, the early destruction of regexp may have been caught,
> especially with ASAN build.

Sorry, I think I got a bit carried away trying to use the test suggested
by Johannes while also extending it with the missing bits.  I will try
to come up with something more balanced in v4.

-- 
Best regards,
Michał Kępień
