Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7808202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 05:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751290AbdKUFUW (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 00:20:22 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58896 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750794AbdKUFUW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 00:20:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3BB3CBE043;
        Tue, 21 Nov 2017 00:20:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hf0aBaN0uXLOcEFnjEpaK30JtLc=; b=g03HGl
        yBOfDYUM7GwfNKBwseLjHy8Bf0FhEE1Q5Z5Tvqz3Ma9ZdlESRHsnQ5ewOSTypaAB
        NXqdo3EgLz+v6IKhPPJoDymOODgOv/VkX9n5P8NY5QMrJAsaWKw6kRWVdweA5EC6
        It6pwJxqK1MJi8HNYgWUcsduu/E49Tj+Qq3gw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KdudrnoUh3RxcVkzj4GK2d0jPoSUTJFm
        mWE/QCRGWcCMHGIRXTrcDkeyUtbOTzN5L7uRm3cRgNFcxVaG6TsTXSOEENWr/ZcV
        AedunlGad0n2gXcr0un+wV6jDT+DUDASi7AwODw+5pIYkFFY9DhnynR0C1/r55E4
        bRVrnN95qx8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 333D6BE042;
        Tue, 21 Nov 2017 00:20:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A6614BE041;
        Tue, 21 Nov 2017 00:20:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] sha1_file: don't re-scan pack directory for null sha1
References: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
        <20171120203523.c3pt5qi43e24ttqq@sigill.intra.peff.net>
Date:   Tue, 21 Nov 2017 14:20:19 +0900
In-Reply-To: <20171120203523.c3pt5qi43e24ttqq@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 20 Nov 2017 15:35:23 -0500")
Message-ID: <xmqqwp2ki4x8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB383D2E-CE7B-11E7-B6E7-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This is the minimal fix that addresses the performance issues.
> I'd actually have no problem at all declaring that looking up a null
> sha1 is insane, and having the object-lookup routines simply return "no
> such object" without even doing the loose/pack lookup first.
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 8a7c6b7eba..dde0ad101d 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1180,6 +1180,9 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>  		if (!sha1_loose_object_info(real, oi, flags))
>  			return 0;
>  
> +		if (is_null_sha1(sha1))
> +			return -1;
> +
>  		/* Not a loose object; someone else may have just packed it. */
>  		if (flags & OBJECT_INFO_QUICK) {
>  			return -1;

After queuing this series to an earlier part of 'pu' and resolving a
conflict with jh/fsck-promisors topic, I ended up with a code that
rejects 0{40} a lot earlier, before we try to see if a pack entry
for 0{40} exists, even though the patch that is queued on this topic
is more conservative (i.e. the above one).

Perhaps we would want to use the alternate version that declares the
0{40} is a sentinel that signals that there is no such object in
this topic---that would give us a consistent semantics without
having to adjust jh/fsck-promisors when it becomes ready to be
merged.


