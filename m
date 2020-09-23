Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEFDC4727D
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 16:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 457BB20719
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 16:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B0OgDh0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgIWQ3R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 12:29:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59759 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWQ3R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 12:29:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 153C083DC5;
        Wed, 23 Sep 2020 12:29:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Px8/O8+OdFJ2eN7KOT0pb4fBQy0=; b=B0OgDh
        0GTSq3SjpHLvgk2uLSJw39/SApQF7FY310Y3qUz0JyukFEVgT1L8DgQleKKjwyQD
        9iSlDP3KVnndGyPnSdrsabvPOYXcRvDYI4Y+QWIX2584GACLj2DvveIQYwX/WFXG
        1gAwr0mP32v6DHrwCbOqh4kQ//f3vquPGES8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xNqvCsEv9K/Rl/z+trFF3S+J3JZidOHa
        JzARXaRx8sP4TTzkCyBaxKgWr+smNPSqoqYZwYjtcmDCEmKx5BVKqHFtUSX6l3DG
        M6A3NPv8TZ1cJoV+Q3KomBfF3PbmUl1B6btbW8WCGjjfOmAapLz4tFkN2FHW086i
        UO8+SqLZ7fw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C22B83DC4;
        Wed, 23 Sep 2020 12:29:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 910BC83DC2;
        Wed, 23 Sep 2020 12:29:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 1/3] push: add reflog check for "--force-if-includes"
References: <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
        <20200923073022.61293-1-shrinidhi.kaushik@gmail.com>
        <20200923073022.61293-2-shrinidhi.kaushik@gmail.com>
Date:   Wed, 23 Sep 2020 09:29:13 -0700
In-Reply-To: <20200923073022.61293-2-shrinidhi.kaushik@gmail.com> (Srinidhi
        Kaushik's message of "Wed, 23 Sep 2020 13:00:20 +0530")
Message-ID: <xmqqeemsjw2u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB441BAC-FDB9-11EA-B2DD-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

> diff --git a/remote.h b/remote.h
> index 5e3ea5a26d..7c5e59770e 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -104,7 +104,11 @@ struct ref {
>  		forced_update:1,
>  		expect_old_sha1:1,
>  		exact_oid:1,
> -		deletion:1;
> +		deletion:1,
> +		/* Need to check if local reflog reaches the remote tip. */
> +		check_reachable:1,
> +		/* The local reflog does not reach the remote tip. */
> +		unreachable:1;

I know the comment text above is what I suggested, but it may be
more useful to readers to explain the latter as

		/* ... the result of the above check */
		unreachable:1;

Thanks.
