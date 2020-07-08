Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647A0C433DF
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 21:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1206E206E9
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 21:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sGOjghSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgGHVGi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 17:06:38 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55651 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGHVGh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 17:06:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0EEABE8DCB;
        Wed,  8 Jul 2020 17:06:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xKlA5DtpirRW4IDy41/zztZSjgY=; b=sGOjgh
        SQQmoRz5Ty10/wkKLyD6UdcoUIIOxtFu11ZgM0+flfXv83e79JH/FWFDr091ONpa
        +Y6YKC/Sn3pUz0gd2dbwkr22wrI5B+ZrBXhHSM5b8SzMW7TIpnrvoZzq0NXE7K/7
        /2clgT7w95OwAuTSxZYv3BwRlbcjcDWZWjFps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KzEwXybMqSn26cRBuQ0TymtmSvJDjgMF
        GGg3bIiGxAJyZ41ufr3URr7zTbLWDHH1m+0NmcTXvxQ6d2EzB9oMAiCFZXhb7v75
        E/wGxzXcM1BOlhTjlHPkWTfMatZ8AtTeFJ+v7kHz+dKo057QTnJAf810f+/sdbxk
        s1zhWAxxnGM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 074C6E8DC9;
        Wed,  8 Jul 2020 17:06:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4DEA6E8DC7;
        Wed,  8 Jul 2020 17:06:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Zach Riggle <zachriggle@gmail.com>, git@vger.kernel.org
Subject: Re: git grep --threads 12 --textconv is effectively single-threaded
References: <CAMP9c5nUteg_HouuYJZtq7g4MrSE638mns=HeKhNpNTYgQB4=w@mail.gmail.com>
        <20200707215951.GB2300296@coredump.intra.peff.net>
        <CAMP9c5mpJ9_HvEBTiEQj=vocTdH6N9uXkpLKiE8+hFbAt9p5Ow@mail.gmail.com>
        <20200708201353.GA2354599@coredump.intra.peff.net>
Date:   Wed, 08 Jul 2020 14:06:31 -0700
In-Reply-To: <20200708201353.GA2354599@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 8 Jul 2020 16:13:53 -0400")
Message-ID: <xmqqfta11zu0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6E91108-C15E-11EA-A399-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It's probably possible to teach the grep code to do the same
> check-in-the-index trick, but I'm not sure how complicated it would be.

I am not sure if we should even depend on the "check the object
database and use it instead of reading the working tree files" done
in diff code---somehow I thought we did the opposite for performance
(i.e. when we ought to be comparing two objects, taken from tree and
the index, if we notice that the index side is stat clean, we can
read/mmap the working tree file instead of going to the object layer
and deflating a loose object, or, worse yet, construct the blob by
repeatedly applying deltas on a base object in a packfile).

Is this one in the opposite direction done specifically for gaining
performance when textconv cache is in use?  If so, kudos to whoever
did it---that sounds like a clever thing to do.


