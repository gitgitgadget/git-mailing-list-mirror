Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50147C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 22:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389477AbiDUWmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 18:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbiDUWmN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 18:42:13 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0C044744
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 15:39:22 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0142812A7FE;
        Thu, 21 Apr 2022 18:39:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HNy/s8gVTn54
        HZ406LB7V4f8brr0MbThw72JMzhXAWk=; b=TDPBQ2ajVivwrr4tw8iQqVQbfGXe
        VDi9YKD2BA4MMFD02JihBPqI5OTQKwdZkzL4S7JV2LxJfOmTtHcP4Da5sn2ENN59
        skJnHr4iYoVpF04omBXGvpi/+OHU8HsFZ6pfc9wvrCSWWlMQUZQbLIq0w3oUNeM7
        Yj7VFMBEPuZSp+Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB3E112A7FD;
        Thu, 21 Apr 2022 18:39:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 563E012A7FC;
        Thu, 21 Apr 2022 18:39:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Hans Jerry Illikainen <hji@dyntopia.com>
Subject: Re: [PATCH 4/4] object-file: fix a unpack_loose_header() regression
 in 3b6a8db3b03
References: <cover-0.4-00000000000-20220421T200733Z-avarab@gmail.com>
        <patch-4.4-7698c0f11a8-20220421T200733Z-avarab@gmail.com>
Date:   Thu, 21 Apr 2022 15:39:20 -0700
In-Reply-To: <patch-4.4-7698c0f11a8-20220421T200733Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Apr
 2022 22:14:37 +0200")
Message-ID: <xmqqa6cedpt3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E30D8FC0-C1C3-11EC-8708-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
> -				NULL) < 0) {
> +	switch (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
> +				    NULL)) {
> +	case ULHR_OK:
> +		break;
> +	case ULHR_BAD:
> +	case ULHR_TOO_LONG:
>  		error(_("unable to unpack header of %s"), path);
>  		goto out;
>  	}

Sigh, well spotted.  This is why I hate the application of "enum is
better, let's rewrite the 'negative is error, 0 is good' with it"
and other dogmatic "clean-up" that touch everywhere in the codebase.

Now because it is ULHR_OK or everything else that is an error, I think
the fix should be

	if (unpack_loose_header(...) !=3D ULHR_OK) {
		error(...);
		goto out;
	}

It would also be much closer in spirit to the original code before
the "enum" change broke it.
