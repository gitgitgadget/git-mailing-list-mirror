Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A414C433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 07:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 513FE61266
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 07:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhKEHdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 03:33:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56245 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhKEHdE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 03:33:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4676F2517;
        Fri,  5 Nov 2021 03:30:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=5SFohYKDfyhpTWhp4yDIAC22Tv6SLIDs9UwvU9vxh+o=; b=h90n
        Yzf529lXC9gFYaBeYZVQj21m4WMmF1mu6FpCPloeCNOo6O/qrOTz23Yu9BE+L2fK
        Zdk0SfCgi1XZl4qaQTLNUbvnPPj38fxJJsiLbxQFd0xh+TMHy7agbvlPrvy7zXz0
        pJTwdKY6dvydAVJw3tyTCBIw8ELBiDUH9DAmHCQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 99946F2516;
        Fri,  5 Nov 2021 03:30:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C254F2514;
        Fri,  5 Nov 2021 03:30:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
Subject: Re: [PATCH] t/lib-git.sh: fix ACL-related permissions failure
References: <20211104192533.2520-1-adam@dinwoodie.org>
        <xmqq7ddn3dlt.fsf@gitster.g> <xmqqzgqj1yff.fsf@gitster.g>
        <20211104223633.5j556ggfga43myz5@fs>
Date:   Fri, 05 Nov 2021 00:30:22 -0700
Message-ID: <xmqqtugrxdo1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D4C79F8-3E0A-11EC-834F-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> The problem is that the ssh-keygen in the layz_prereq will succeed but
> might create a private key with world readable permissions. Only the
> remaining tests using this key will then fail with a "your private key
> permissions are too restrictive" like error. If we would like to make
> sure in the prereq that the keys actually work fine we would need to do
> a signing operation with them in it.

That sounds like a right thing to do, with or without the setfacl fix.

>
> Something like the following call would be enough:
> echo "test" | ssh-keygen -Y sign -f $GPGSSHKEY_PRIMARY -n "git" 
> Not sure if we want to go that far though. The setfacl seems fine to me
> otherwise.

