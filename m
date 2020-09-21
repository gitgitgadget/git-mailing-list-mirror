Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF72EC4727C
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EAD223A1B
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S297ATl2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgIUWiC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 18:38:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55487 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbgIUWiC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 18:38:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 064F7F6A6D;
        Mon, 21 Sep 2020 18:38:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1gMCdUNzk7+4TjKaTpHfKuzjGF0=; b=S297AT
        l2SHakX6n94fh+Xs471g5xathcO2yVrP3k7EwuLobBFkwbw//P/QeB/lBBV8GCGT
        XZuqt7GxthU2K1O9GASlFdgmw+bKDJPriJKbHMJ9jtAzsm0C2YC0IxTdvFBSgCDD
        ETuncYoGGjHcVHeUt0NC+HKlBfy7hfB7F26R4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bGQGLrWsE3zc2ZfDi18yH5NDkT3NkNOn
        SqbNixIpU1oM6XeDaSIJpU657ceFk5pq0tleqykqvIUk+JfBNq1vvUC74gT33cX3
        4+YCLAGKtKY77gkxBGVdPG6Eo45ZOvyZaIR6rFYHzRxUzwUy5cIIRIpsgAJql6mb
        Vg7TJFaAaeo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F3E9BF6A6C;
        Mon, 21 Sep 2020 18:38:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3CE3CF6A6A;
        Mon, 21 Sep 2020 18:37:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>, git@vger.kernel.org,
        dermoth@aei.ca
Subject: Re: [PATCH v2] diff: Fix modified lines stats with --stat and
 --numstat
References: <20200918113256.8699-2-tguyot@gmail.com>
        <20200920130945.26399-1-tguyot@gmail.com>
        <20200920153915.GB2726066@nand.local>
        <xmqqlfh4gt5z.fsf@gitster.c.googlers.com>
        <20200921192630.GA2399334@coredump.intra.peff.net>
        <xmqqft7aer3a.fsf@gitster.c.googlers.com>
        <20200921222021.GA3533110@coredump.intra.peff.net>
Date:   Mon, 21 Sep 2020 15:37:57 -0700
In-Reply-To: <20200921222021.GA3533110@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 21 Sep 2020 18:20:21 -0400")
Message-ID: <xmqqv9g6dad6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19C27C2C-FC5B-11EA-BE28-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> .... I agree that other code could be depending on oid_valid in a weird
> way, but IMHO that code is probably wrong to do so. But it may not be
> worth digging into, if nobody has complained about the waste.

Yup, that was my feeling when I wrote the message you are responding
to.
