Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DBFC43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 18:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5E420CC7
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 18:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y17DDX0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgCaSP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:15:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60758 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgCaSP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 14:15:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C209BB9A17;
        Tue, 31 Mar 2020 14:15:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=19uHcy3TQRgUWXXBbuzRy06M75Q=; b=Y17DDX
        0N+przK3VzQCOZ5AoKbr25G1T7nOzwNBxd9CMVBF4ThbLJMWMSY+emVxfmrccO1S
        Zam/voHOZHIUu6jHBJwHwpDq9Sj/Lor7T7yptMSccYx6qdaIZUJoPR8UiXmP/Rjz
        xikuRYzIUGaC67a9QPQPVAhrHjYtZ00G5+U5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P3hshY8kFlXGkm4BqRhUo/pmXyuZS0gn
        lE849OVWboCJW9uY9Odx99au9uKsmVOuijyNCUBlXWPaUN/3IpFxJEvTsZfQwgQL
        0EpgJK0n1u5sm0GLm1xlzsN7+BLyMS4xr8Zcwpog11goLYyL0kiOcmin3wIF3sRr
        LBdj9rSFDV0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BA002B9A16;
        Tue, 31 Mar 2020 14:15:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 05AB3B9A0F;
        Tue, 31 Mar 2020 14:15:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] diff: restrict when prefetching occurs
References: <20200331020418.55640-1-jonathantanmy@google.com>
Date:   Tue, 31 Mar 2020 11:15:21 -0700
In-Reply-To: <20200331020418.55640-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 30 Mar 2020 19:04:18 -0700")
Message-ID: <xmqqpncs75mu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96713B0A-737B-11EA-8CA3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index e189f407af..962565f066 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> ...
> @@ -448,7 +449,18 @@ static int find_renames(struct diff_score *mx, int dst_cnt, int minimum_score, i
>  	return count;
>  }
>  
> +static void add_if_missing(struct repository *r,
> +			   struct oid_array *to_fetch,
> +			   const struct diff_filespec *filespec)
> +{
> +	if (filespec && filespec->oid_valid &&
> +	    !S_ISGITLINK(filespec->mode) &&
> +	    oid_object_info_extended(r, &filespec->oid, NULL,
> +				     OBJECT_INFO_FOR_PREFETCH))
> +		oid_array_append(to_fetch, &filespec->oid);
> +}

Do not copy&paste the exact code from elsewhere.  It is a sure way
to guarantee that they will drift apart over time.  Rename the one
in diff.c to something a bit more appropriate to be a global name
(e.g. diff_prepare_prefetch() or somesuch), make it extern in
<diffcore.h> and use it here.

Thanks.
