Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22484C433E0
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 23:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 082A720729
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 23:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgG0XRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:17:41 -0400
Received: from 0x63.nu ([109.74.10.199]:48942 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgG0XRk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 19:17:40 -0400
Received: from ip6-localhost ([::1] helo=moveme2)
        by 0x63.nu with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1k0CNE-0008MF-4p; Tue, 28 Jul 2020 01:17:36 +0200
References: <87blk0rjob.fsf@0x63.nu> <xmqqr1swg9lc.fsf@gitster.c.googlers.com> <CAP8UFD1XV_jN10yOc2o4=5PtPcvT-RbxhY1H3swZz2r4g-Uzkw@mail.gmail.com> <87a6zkr5z7.fsf@0x63.nu> <xmqqa6zkfu3b.fsf@gitster.c.googlers.com>
User-agent: mu4e 0.9.18; emacs 26.0.91
From:   Anders Waldenborg <anders@0x63.nu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Questions about trailer configuration semantics
In-reply-to: <xmqqa6zkfu3b.fsf@gitster.c.googlers.com>
Date:   Tue, 28 Jul 2020 01:17:36 +0200
Message-ID: <87365cr1in.fsf@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano writes:

> I had the same thought but then a question struck and stopped me:
> what should happen if "trailer.X.something" and
> "trailer.x.somethingelse" are both defined?

Good point.

If we follow the same reasoning as with what happens with prefix
matching (config order matters) the one that happens to be mentioned
first in configuration wins.

The same thing actually happens today with .key:

trailer.foo.key=Hello
trailer.bar.key=HELLO

$ printf "\nHELLo: hi\n" | \
  git -c "trailer.foo.key=Hello" -c "trailer.bar.key=HELLO" interpret-trailers --parse
Hello: hi

but if we swap order of config:

$ printf "\nHELLo: hi\n" | \
  git -c "trailer.bar.key=HELLO" -c "trailer.foo.key=Hello" interpret-trailers --parse
HELLO: hi

