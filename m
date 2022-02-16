Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E20C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 22:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbiBPWhk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 17:37:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbiBPWhi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 17:37:38 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4412560FD
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 14:37:24 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 466E917DF25;
        Wed, 16 Feb 2022 17:37:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SsvSg+tDuqu37nU8n9FxO9YWhjVHXZEEpF+Z/G
        bQ0m0=; b=sU4CyJxaovEMv4j0npBVVAhE+bJbt9if65vZqBXZEzMPlOiHpWrXRb
        b/oHa01mXplko2oIBP6+dU5V0kFBXDbiNiuiAQSjSApX8DFtTygiNMcaUpEzRJGt
        5HpPAwiK/XpkXJd4vDtNjZ3/DaNxkDcUcvjJUh0xsQKvkYONVEh+s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2BCC817DF24;
        Wed, 16 Feb 2022 17:37:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 82A9F17DF21;
        Wed, 16 Feb 2022 17:37:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: Supporting --depth when cloning from a bundle
References: <20220216220710.td4vp6mile5m6hjn@meerkat.local>
Date:   Wed, 16 Feb 2022 14:37:20 -0800
In-Reply-To: <20220216220710.td4vp6mile5m6hjn@meerkat.local> (Konstantin
        Ryabitsev's message of "Wed, 16 Feb 2022 17:07:10 -0500")
Message-ID: <xmqqzgmqbfq7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0131D722-8F79-11EC-94B7-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> Hello, all:
>
> It would be pretty handy if it was possible to do shallow clones from a bundle
> file. For example, this would be nice for CI environments that first download
> a clone.bundle file from a locally cached location, clone from it, and then
> fetch any remaining objects from remote.
>
> E.g., in my mind this outta work:
>
> $ wget https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/clone.bundle
> $ git clone --depth 1 clone.bundle linux -b master
>
> Right now, this operation succeeds as-is without any errors, but the resulting
> git repository isn't actually shallow.
>
> Oh, it would be even awesomer if the bundle files could be used directly with
> --reference, e.g.:
>
> $ git clone --reference clone.bundle --dissociate \
>   https://git.kernel.org/.../torvalds/linux.git linux
>
> Any reason that can't work?

The "depth" is used to negitiate what objects to include in the
packfile that is transmit from the other side.  That would not
fundamentally work on bundles, because a bundle is pregenerated and
there is nobody on the other side for you to negotiate with to
affect what objects are included in the packfile which is contained
in the bundle file.

You _should_ be able to make the resulting full clone into a shallow
one, though.
