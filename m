Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC80CC4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B3AC2168B
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GYZxWCO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372731AbgJWOob (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 10:44:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58947 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S369629AbgJWOob (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 10:44:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EFCE289B1E;
        Fri, 23 Oct 2020 10:44:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NCnFmSwA7eoXFagNhhttqBatqzE=; b=GYZxWC
        O9EFT1xTRkKWknyiVm5L0kqxeur1wEhnzZ/bQ/0JGwLq0gNELRroW657DbBZhfJj
        hARwgIjNCjCcJSZLEettwvqCKDx4u3ESv3lo16O9HONc63mysYgSYXneSut16h//
        lTUN0QICsR7CyccB8n0+FefZsJYMvDFVV4QHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HpP1WzpAUK6kGsez0xuqNVKn/GlYOlPN
        F6Ev1m88A0/jxdHupjna2X3SZeBYhalYYINutf589ht32VKQaeLEuciCnJwlMC7a
        MmDqGZhHR/5Elkl5OSi5xQ3oR6pXq1mjrDcloCB0qAb1RaGG2Jsw0yZ/Ldx2gIWB
        fkBP3dUgmwo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E734F89B1D;
        Fri, 23 Oct 2020 10:44:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 752DF89B1C;
        Fri, 23 Oct 2020 10:44:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 3/3] sideband: add defense against packets missing a
 band designator
References: <pull.753.git.1602600323973.gitgitgadget@gmail.com>
        <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
        <c61e560451c4d7f101a23acec69117ddac563330.1603136143.git.gitgitgadget@gmail.com>
        <20201023083424.GD4012156@coredump.intra.peff.net>
Date:   Fri, 23 Oct 2020 07:44:27 -0700
In-Reply-To: <20201023083424.GD4012156@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 23 Oct 2020 04:34:24 -0400")
Message-ID: <xmqqv9f1huic.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40D79404-153E-11EB-AB4D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Oct 19, 2020 at 07:35:42PM +0000, Johannes Schindelin via GitGitGadget wrote:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> 
>> While there is currently no instance of code producing this type of
>> packet, if the `demultiplex_sideband()` would receive a packet whose
>> payload is not only empty but even misses the band designator, it would
>> mistake it for a flush packet.
>> 
>> Let's defend against such a bug in the future.
>
> That seems reasonable, but I'm not sure if these ought to be BUG()s.
> Isn't it an indication that the other side sent us bogus input? That
> likely is a bug on the other end, but I think it should be a die(), just
> as we would produce for any other malformed protocol input.

Thanks for spotting.  I also think this was a good change, but at
this point in the code we found a problem in the data the other side
created (i.e. we diagnosed a bug on the other side), which is a
usual input error, so it should not be a BUG().  

Would this be something we can warn and ignore if the connection is
still active, I wonder, though.
