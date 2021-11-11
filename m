Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841E4C433F5
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 18:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59A8961268
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 18:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbhKKSGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 13:06:04 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58900 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhKKSGD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 13:06:03 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 20980163907;
        Thu, 11 Nov 2021 13:03:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1svwbh3AqlqE
        n83Lz6TSaiCPEwsBdzOLRKuzdpcfdNw=; b=VQoxy4kv4Yp6AterDQUCOnhVmGV2
        bh1sDeKK63zgmgJ0I1WcyAT+eatKwdiwXg/ghHmRTaiTPP4mmIRqba/520UFCXvM
        uERmDUU311RLrUL69l2gHX7s+Sy5g4ukiAOzqcDWLaipDXHscDla/ZL7ijHP33p5
        LDHA2D+XxPKSBXM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 18353163906;
        Thu, 11 Nov 2021 13:03:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 75961163903;
        Thu, 11 Nov 2021 13:03:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Wong <e@80x24.org>, Christoph Hellwig <hch@lst.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: RFC: A configuration design for future-proofing fsync()
 configuration
References: <211110.86r1bogg27.gmgdl@evledraar.gmail.com>
Date:   Thu, 11 Nov 2021 10:03:10 -0800
In-Reply-To: <211110.86r1bogg27.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 10 Nov 2021 16:09:33 +0100")
Message-ID: <xmqqh7cimuxt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A2219FE8-4319-11EC-BBAE-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Continuing a discussion from [1] currently we have:
>
>     ; Defaults to 'false'
>     core.fsyncObjectFiles =3D [true|false]
>
> In master..next this has been extended to this by Neeraj:
>
>    core.fsyncObjectFiles =3D [true|false|batch]
>
> Which, as an aside I hadn't considered before and I think we need to
> change before it lands on "master", we really don't want config users
> want to enable that makes older versions hard die. It's annoying to wan=
t
> to configure a new thing and not being able to put it in .gitconfig
> because older versions die on it:
>
>     $ git -c core.fsyncObjectFiles=3Dbatch status; echo $?
>     fatal: bad boolean config value 'batch' for 'core.fsyncobjectfiles'
>     128

But then it is also annoying to find out that the shiny new toy you
thought you configured silently is not kicking in.  I actually think
Neeraj's "if you are in a mixed environment, you need to be aware of
which copies of Git you use are prepared to use it" would be better
for end users.

For us Git developers, it would be less convenient, though.
