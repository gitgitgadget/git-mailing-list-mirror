Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DEEC54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 17:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D10520706
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 17:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FTDcqDIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgDVRcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:32:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64962 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDVRcm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 13:32:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 067575B82F;
        Wed, 22 Apr 2020 13:32:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bCozbhTvho+a+5IPyS+FR/QDtCI=; b=FTDcqD
        Ih2+85NUjE9dRsBiPQrtE+ZDql3P0/4MHlEhwePVo9hoG3IZY8w29L0L9KnT7YIP
        LsTb3hnOzA35OTSuhopDfzg2Pryj7d/U2x5gis4I9kytq6l3jqtGkigmVoRwna0s
        K3+5RGnmptxYHraRyQHPN05fhG3GwMFD6rNRM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FlpwkHASm2TFhTB6fkviki7xUai/GTwU
        ofYR9a2ruO76J1BFd58aSMnMlC6IRyDx02j2/be5aofvVHcJV5hi2bBti13adgYY
        V7BZSmzalSkaBBhep4/CY4ZgmICmQRhQutOlA5P9FklGHGVgnUPrJpHT9nNZWkv5
        +dfsFU5e7TA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EFD755B82E;
        Wed, 22 Apr 2020 13:32:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6447D5B82D;
        Wed, 22 Apr 2020 13:32:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Lubomir Rintel <lkundrak@v3.sk>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Git 2.26 fetches many times more objects than it should, wasting gigabytes
References: <20200422084254.GA27502@furthur.local>
        <20200422095702.GA475060@coredump.intra.peff.net>
        <20200422165358.GB140314@google.com>
Date:   Wed, 22 Apr 2020 10:32:38 -0700
In-Reply-To: <20200422165358.GB140314@google.com> (Jonathan Nieder's message
        of "Wed, 22 Apr 2020 09:53:58 -0700")
Message-ID: <xmqq7dy7juix.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43804ADA-84BF-11EA-8466-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> When process_acks sees an ACK, it passes it on to the negotiator.
> It wants to record that it received an ack to reset in_vain, but
> it forgets to!  The function is initialized and read but never
> written to.

Yeah, this smells like the right solution ;-)

s/function/variable/ though.

>
> So I'd expect the following to help:
>
> diff --git i/fetch-pack.c w/fetch-pack.c
> index 1734a573b01..a1d743e1f61 100644
> --- i/fetch-pack.c
> +++ w/fetch-pack.c
> @@ -1287,6 +1287,8 @@ static int process_acks(struct fetch_negotiator *negotiator,
>  			struct object_id oid;
>  			if (!get_oid_hex(arg, &oid)) {
>  				struct commit *commit;
> +
> +				received_ack = 1;
>  				oidset_insert(common, &oid);
>  				commit = lookup_commit(the_repository, &oid);
>  				if (negotiator)
