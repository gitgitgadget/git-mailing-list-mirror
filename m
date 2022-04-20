Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67268C433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 03:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359149AbiDTDQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 23:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359115AbiDTDQO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 23:16:14 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC16313D15
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 20:13:28 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CCFB126C8F;
        Tue, 19 Apr 2022 23:13:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=RECwAVl/RfTjgfb6+aGPvAYZstSSyaehL81L7mHQXeY=; b=Fe5g
        7PKzOMVq6mL2kDOAQKY2/4Q0J7pMzH5AiTflrJfOMbUF2kfDZ79f0VSz0IV7QgJr
        LVVrNN0ttnO2C8BTNIrpVeQKOx1Wup6Ke7TdI3Dsp/Y2tWAR1TQG0q0r+MHY25Ua
        jneA6w2VgkJAq5uGzgQBhl9e6d0R7woBRde+ewo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 12E3A126C8E;
        Tue, 19 Apr 2022 23:13:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 75429126C8D;
        Tue, 19 Apr 2022 23:13:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Thomas Hurst <tom@hur.st>
Subject: Re: Corrupt name-rev output
References: <Ylw+M5wwUYKcLM+M@voi.aagh.net>
Date:   Tue, 19 Apr 2022 20:13:24 -0700
Message-ID: <xmqq4k2otpkb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7B00AB2-C057-11EC-904E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Hurst <tom@hur.st> writes:

> I've noticed a series of about 20 commits in the HardenedBSD repository
> fairly reliably produce garbage names from git name-rev - usually
> fragments of another commit, sometimes unprintable nonsense.  Sometimes
> it works just fine...
>
> Here's a quick demo showing how to reproduce the problem:
>
> % uname -mrs
> FreeBSD 13.0-RELEASE-p11 amd64
> % git --version
> git version 2.35.2
> % git clone --bare --mirror https://github.com/HardenedBSD/hardenedBSD.git
> % cd hardenedBSD.git
> % git rev-list --branches=\* |
>   git name-rev --stdin --refs=heads/\* |
>   egrep -v '^[0-9a-f]{40}( \([a-zA-Z0-9_/.^~-]+\))?$'
> 3eb67b534cab6a78b44b13e4323fd60353003089 (y:    marcel
> MFC after:      3 days
> Relnotes:       yes
> Sponsored by:   ScaleEngine Inc.
> Differential Revision:  https://reviews.freebsd.org/D3065
> ~3)
> 3ac660fc0c6eb0f876972e7e415c89f1ebed1939 (y:    marcel
> ...
> Passing these commits into name-rev as arguments finds them under
> hardened/current/relro~199^2
>
> git fsck --full does not reveal or fix anything, and the problem also
> persists with a build from source from the next branch.
>
> I was unable to reproduce on an Ubuntu machine with 2.32.0, so I used
> that as a starting point for bisection and landed here:
>
>   3656f842789d25d75da41c6c029470052a573b54
>   name-rev: prefer shorter names over following merges

commit 3656f842789d25d75da41c6c029470052a573b54
Author: Elijah Newren <newren@gmail.com>

Hmph, Elijah, does this ring a bell?

Thanks.
