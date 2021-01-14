Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC86C433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 06:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F9F02396F
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 06:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbhANGoY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 01:44:24 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50446 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbhANGoX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 01:44:23 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D2ED10A0F4;
        Thu, 14 Jan 2021 01:43:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=w7R/jkyfTP2oHQ12JkiFwZhyJpU=; b=ONYRgaL1MIF5a9kq6SBo
        iouC6PxnbKOhuZcByIIuFmUUbOrp4lSo+0eg8Wsf+XXI1j45ytKEpVydYGCtA9Gw
        Zz/0SiBHYBa+wjVVmPmoomlsnXYfzK247FRkIX+fnwr6p3xLf26sT17qjFjpvKEm
        0I/WCxof9B8fqSfhR3Ep/Fk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=DcUq0KASFkADbX94MMoQmYN02b/nt+gdjCT2IdZbKR5q8s
        7/I/evpuq4V8EeCdV+Qf55tvk2oBszuwZY3B9s8BfgnCPJ7yoiqQ9wgcQCrUX5GE
        0DKJ0NN1w1S01rn2ZfAHoXo/KdvcoQSVwvH5RYZ3S9FYQR+MQpyQubI6P4CE0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 46C3710A0F3;
        Thu, 14 Jan 2021 01:43:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 93DDE10A0F2;
        Thu, 14 Jan 2021 01:43:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, jrnieder@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v2 15/20] for_each_object_in_pack(): convert to new
 revindex API
References: <cover.1610129796.git.me@ttaylorr.com>
        <cover.1610576604.git.me@ttaylorr.com>
        <e7574763513294b71071b032d5cd3aa0976969dd.1610576604.git.me@ttaylorr.com>
Date:   Wed, 13 Jan 2021 22:43:37 -0800
Message-ID: <xmqq8s8wyq5i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5DB9600-5633-11EB-8B2D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Avoid looking at the 'revindex' pointer directly and instead call
> 'pack_pos_to_index()'.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  packfile.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/packfile.c b/packfile.c
> index 936ab3def5..7bb1750934 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -2086,7 +2086,7 @@ int for_each_object_in_pack(struct packed_git *p,
>  		struct object_id oid;
>  
>  		if (flags & FOR_EACH_OBJECT_PACK_ORDER)
> -			pos = p->revindex[i].nr;
> +			pos = pack_pos_to_index(p, i);

It wasn't too bad before this series formally defined what
"position", "index" and "offset" mean, but now this has become
highly misleading. The variable "pos" here holds what we consider
"index" while "i" holds what we call "position" [*1*].

>  		else
>  			pos = i;

Perhaps renaming "uint32_t pos" to "nth" would avoid confusion?

-	if (nth_packed_object_id(&oid, p, pos) < 0)
+	if (nth_packed_object_id(&oid, p, nth) < 0)
		return error(...);


[Footnote]

*1* The nth_packed_object_id() call we make later using the value we
obtain here should be documented to take "index" as its last
parameter, now that is what we call the location in the index, which
is in object name order.



