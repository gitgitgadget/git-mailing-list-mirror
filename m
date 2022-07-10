Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECEFC43334
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 20:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiGJUiD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 16:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGJUiB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 16:38:01 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90926BC00
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 13:38:00 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 551EE12D213;
        Sun, 10 Jul 2022 16:37:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WpFp/H4ZDaME+63cGfmRNTML0Tudr3Z4MMh3QR
        YwxiA=; b=ss0GMl+l11EBnXSR++UWbSka2gO7Aj8kDiGkhunUb/yw0e1otxbgPc
        9SvxwfueA5uasq/bozkeCH+BHsUaA+VjG8IezVNSCsUgk+p5FvxQThDZTzWw6Vs8
        MEXYvQbEziy/P417Te43S67fYxkfaICu56wsnhhqmhYjaB2aCfxfU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4BEB712D212;
        Sun, 10 Jul 2022 16:37:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A6B1712D211;
        Sun, 10 Jul 2022 16:37:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] sha256: add support for Nettle
References: <20220705230518.713218-1-sandals@crustytoothpaste.net>
        <20220710132907.1499365-1-sandals@crustytoothpaste.net>
        <220710.86mtdh81ty.gmgdl@evledraar.gmail.com>
        <xmqqwnckrkg9.fsf@gitster.g>
        <Yssyt40xrxjtaL6m@tapette.crustytoothpaste.net>
Date:   Sun, 10 Jul 2022 13:37:57 -0700
In-Reply-To: <Yssyt40xrxjtaL6m@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 10 Jul 2022 20:12:39 +0000")
Message-ID: <xmqqa69gr9ei.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F49A3F0-0090-11ED-A537-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Yeah, I think given the fact that many folks use autoconf, it's
> beneficial to allow multiple options and just choose the one we like the
> most.

Not that we any of *_SHA256 set in the configure script ;-) It still
is worth noting that the Makefile is prepared to deal with configure
scripts written in the most simple way, i.e. test for any backend
independent of other possible backends.

There can be at least three possible arrangements, and I think the
current one is the most sensible.

 (1) We can allow multiple to be set and let Makefile define
     precedence.  "If you do not choose any, then we fall back to
     ..." will fall out as a natural consequence.  

     If somebody wants to write autoconf support, they do not have
     to reinvent the precedence order.  They can just check for the
     presence of individual libraries independently from each other.

     This is what we have today.

 (2) We can allow multiple to be set and let Makefile define
     precedence.  But a misguided autoconf author can invent their
     own precedence order that may not be compatible with what the
     Makefile has.

     This allows the autoconf author weird satisifaction for being
     different from what Makefile already decided for the sake of
     being different.

     This would be unfortunate, and we should watch out when we
     review patches to add autoconf support for *_SHA256 variables.

 (3) We can allow only one to be set and otherwise error out.

     If somebody wants to write autoconf support, they have to come
     up with the precedence order, or support the "--with[out]-X"
     thing to customize, in order to ensure that the configure
     script picks exactly one.

     Because not everybody has nor need to have enough knowledge to
     choose one among the multiple choices available to them, this
     is hostile to those who do not use configure.

     Not an improvement over what we have today.

