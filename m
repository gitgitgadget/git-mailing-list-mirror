Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FDE51F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 02:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfJ3Co1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 22:44:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59210 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfJ3Co1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 22:44:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C70F1D536;
        Tue, 29 Oct 2019 22:44:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0ww7BI7fSc475gReUgRfITvmZE4=; b=vSNlKd
        j+f2B0qfVvbI1Kzm/ODqQpt+8WpWthC7QGPSoXP7avwz+kGj7FpowN0FOVh0D7nk
        Q8NavOT4o2chY/h8lq2B8+sTCUd91EnGkMoAMCJWptRrhCNzpLUoOSblvJNk7orv
        AYfjskylTVRCV84fGdzR93r5AyeDg84xAnmw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cL335ZuhVtm+klSop7UhZJyUhbCTi9/c
        zR/IZAZJesFalsyfmJr61Tn1NJYl2tpnm0Xz7iHpaRQx8jmfGBX3hPIFbWK2z9Ky
        W2O0gouO3rXCZa8CwORYb2uHJj7Wpx9V0/pZMGW4dSSqxa4mCmTQG0Vdnsn4iZ/3
        B/mhoCbYefU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12D631D535;
        Tue, 29 Oct 2019 22:44:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 791851D534;
        Tue, 29 Oct 2019 22:44:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Davide Berardi <berardi.dav@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Segmentation fault on non-commit objects.
References: <20191029092735.GA84120@carpenter.lan>
        <20191029140621.GC2843@sigill.intra.peff.net>
Date:   Wed, 30 Oct 2019 11:44:23 +0900
In-Reply-To: <20191029140621.GC2843@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 29 Oct 2019 10:06:21 -0400")
Message-ID: <xmqqbltz3qbc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2EF69176-FABF-11E9-9D44-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This is definitely a strict improvement over the current behavior
> (though I agree with Dscho's comments on the error message). A few
> further thoughts:
>
>   - we'll have successfully completed the rest of the clone at this
>     point. Should we leave the objects and refs in place to allow the
>     user to fix it up, as we do when "git checkout" fails?
>
>     We'd have to leave _something_ in HEAD for it to be a valid repo. I
>     guess just "refs/heads/master" would be fine, or perhaps we could
>     fall back to whatever the other side had in their HEAD (i.e.,
>     pretending that "-b" wasn't specified).

Do we know for sure that the object at HEAD on the other side is a
commit, or do we need to prepare for a case where it is not?  I
suspect it is the latter.  HEAD needs to exist and point at a ref
that is in refs/heads/ hierarchy, and the ref can even be unborn, so
falling back on 'master' sounds like a good position.

>   - there's a related case just above the lines you touched: what
>     happens if the other side feeds us a non-commit in their
>     refs/heads/? That shouldn't happen (i.e., their repo is broken), but
>     should we be protecting ourselves on the receiving side more?
>
>     Likewise in "else" below just above your lines.

Both are good points.

Thanks, all.
