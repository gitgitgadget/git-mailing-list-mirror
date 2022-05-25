Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A001BC433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 09:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiEYJRa convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 25 May 2022 05:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiEYJRT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 05:17:19 -0400
X-Greylist: delayed 537 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 May 2022 02:17:16 PDT
Received: from mailproxy07.manitu.net (mailproxy07.manitu.net [IPv6:2a00:1828:1000:1112::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C658DDC3
        for <git@vger.kernel.org>; Wed, 25 May 2022 02:17:15 -0700 (PDT)
Received: from localhost (nb-ana002.math.uni-hannover.de [130.75.46.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy07.manitu.net (Postfix) with ESMTPSA id 4D272C882E;
        Wed, 25 May 2022 11:08:04 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <xmqqh75eef0f.fsf@gitster.g>
References: <cover.1651859773.git.git@grubix.eu> <nycvar.QRO.7.76.6.2205232248360.352@tvgsbejvaqbjf.bet> <xmqqr14jluu4.fsf@gitster.g> <nycvar.QRO.7.76.6.2205240124280.352@tvgsbejvaqbjf.bet> <xmqqa6b7lrw6.fsf@gitster.g> <nycvar.QRO.7.76.6.2205241258510.352@tvgsbejvaqbjf.bet> <xmqqleuqj1gy.fsf@gitster.g> <20220524201639.2gucdkzponddk5qt@carlos-mbp.lan> <220524.86mtf6ve89.gmgdl@evledraar.gmail.com> <xmqqh75eef0f.fsf@gitster.g>
Subject: Re: [PATCH] http.c: clear the 'finished' member once we are done with it
From:   Michael J Gruber <git@grubix.eu>
Cc:     Carlo Marcelo Arenas =?utf-8?q?Bel=C3=B3n?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
To:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>
Message-ID: <165346968167.4313.13200529030347354219.git@grubix.eu>
Date:   Wed, 25 May 2022 11:08:01 +0200
User-Agent: alot/0.10
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 2022-05-25 00:34:40:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > It doesn't mean that GCC has additionally proved that we'll later used
> > it in a way that will have a meaningful impact on the behavior of our
> > program, or even that it's tried to do that. See an excerpt from the GCC
> > code (a comment) in [1].
> 
> But that means the warning just as irrelevant as "you stored 438 to
> this integer variable".  Sure, there may be cases where that integer
> variable should not exceed 400 and if the compiler can tell us that,
> that would be a valuable help to developers. 

An integer can hold 438 perfectly, without any help by carefully
designed code.

> But "you stored an
> address of an object that can go out of scope in another object
> whose lifetime lasts beyond the scope" alone is not, without "and
> the caller that passed the latter object later dereferences that
> address here".  We certainly shouldn't -Werror on such a warning
> and bend our code because of it.

A global variable cannot hold a meaningful pointer to a local variable,
unless the carefully designed code helps. So that "analogy" rather
highlights the essential difference, unless you think about a pointer
as "just some number" rather than "something that can be dereferenced".

[read global as outer scope, local as inner scope for simplicity]

Common practice is not necessarily good practice. In a traditional C
mindset, everything around pointers and memory management is doomed to
boom unless the code is designed carefully and "you know what you are
doing". I'm not indicating that you do not - on the contrary, you very
well do, as your detailed analysis of the code flow shows. At the same
time, it shows that we cannot be certain about that piece of code
without that detailed expert analysis.

C is not C++ nor rust, nor should it be; but the warnings and errors in
newer standards typically try to avoid those pitfalls by making sure
that, e.g., pointers do not go stale for "obvious reasons". They might
missflag cases where this is preempted for non-obvious reasons, but forcing
you to be explicit (more obvious) in your code is a good thing,
especially for maintainability of the code base.

Pointing from outer scope to memory in an inner scope should be a no-go;
that's what this error is about. Unsetting that pointer (by setting the
pointer to NULL) right before the inner scope ends is exactly the
right solution. If this "breaks" the code, the code is broken already.

Ironically, my original one line patch seems to work here, as your
detailed analysis shows. Truth in advertising: I arrived at that patch
after a considerably less detailed analysis ;)

Michael
