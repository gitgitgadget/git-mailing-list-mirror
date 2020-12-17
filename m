Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC80AC4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 05:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C6223407
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 05:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgLQFTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 00:19:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55903 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgLQFTG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 00:19:06 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 345ED911E2;
        Thu, 17 Dec 2020 00:18:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4qrg/GIYxlTIpzqkN+8DOgUno44=; b=LhD/Wm
        GedyjQip+bEg/4nWa/mYapMCfJPWODjK3Hx4uDQlKJxNuhggkSpMJFOh1KKE7+Ri
        XVJgf5aaYu+2+LTpgVfEEx1/jeGy7Nas33D38xXXl/s1EygTawJObQH+pluhuAB1
        jOFrAOYrhXxQ/sUoPjizR5k7RIhXLRKZFlqbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hkSHHIQgV39K6LSNiOyyo8eoBiPGed9t
        CT0vsNeDlVQFNcbslBYfdx26acB1U8yWdbHcQX4gMZOU3o0gRkzbeXjc1MUBgyUz
        yZ3h9q2rYes+yO5XRZ9n0OeLghPtqIVrsvk4u8fYurEByhEogx2egnrJU1+HkdP1
        Q5vsQCmeDLY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BA40911E1;
        Thu, 17 Dec 2020 00:18:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A9C63911E0;
        Thu, 17 Dec 2020 00:18:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
References: <20201216174345.28146-1-felipe.contreras@gmail.com>
        <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
        <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
Date:   Wed, 16 Dec 2020 21:18:21 -0800
In-Reply-To: <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
        (Seth House's message of "Wed, 16 Dec 2020 15:53:09 -0700 (MST)")
Message-ID: <xmqqr1npypr6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4860D762-4027-11EB-AAD4-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House <seth@eseth.com> writes:

> I wasn't aware of this plubming when I wrote the initial shell-script
> version of the technique. This is a much better approach (even *if*
> there's a negligible performance penalty). This nicely avoids
> UNIX/Windows line-ending surprises, and instead leans on
> already-configured Git defaults for those. Plus the non-text files
> benefit you mentioned is also huge.
>
>> as I understand "mergetool" is handed an
>> already conflicted state and asked to resolve it, it would not be
>> possible without at least looking at the stage #1 to recover the
>> base for folks who do not use diff3 style.
>
> I feel strongly that LOCAL, REMOTE, and BASE should be left intact for
> this reason, Also because they aid readers in understanding the
> pre-conflicts versions of the file.

Well, good to see that we helped somebody who we do not see
regularly around here.  You should hang around here more often ;-)

