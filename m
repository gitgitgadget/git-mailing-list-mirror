Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF107C43331
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 18:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9485B2074D
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 18:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V5N3tsuV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgCXSs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:48:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56825 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgCXSs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 14:48:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1F2F59104;
        Tue, 24 Mar 2020 14:48:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=okHMELBE3FBzecff8X7RfUEn3+A=; b=V5N3ts
        uVUInoc8WFi0okICE/TTDUdCz9IJpUUdpIU9F8fTqxdBuy/oqdfARsipWY6aU0g2
        VIJmm/F2EQHZQeck1lzo5pv5GSkCIh57l7QiVMJbOrCH+gE1TRWe3hx7esKrcJYv
        GU1oXjZ2sO3GUQePsk/THBmKvze5+meHaNLm4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cmMYEMktpuKZHCM4PM+paYWzWhUY6Q7g
        4diXhra8498ni25FtviEYeTwTrsXWzxm2dwyi9RYuYPxXGP6KJj/7VxWc5lbOMVP
        O4rR9n0pMC4KNNpe0XIyV8VNMb1HsjAnqhcs2PFvZej9E88ou+Cdx8yXbuYdJtEP
        iQIzMvSqRKc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D79AD59103;
        Tue, 24 Mar 2020 14:48:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5BCC559101;
        Tue, 24 Mar 2020 14:48:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Damien Robert <damien.olivier.robert@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        William Baker <William.Baker@microsoft.com>,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: Re: [PATCH v3 1/1] midx.c: fix an integer overflow
References: <20200312173520.2401776-1-damien.olivier.robert+git@gmail.com>
        <20200323222515.779477-1-damien.olivier.robert+git@gmail.com>
        <20200324060125.GA610977@coredump.intra.peff.net>
Date:   Tue, 24 Mar 2020 11:48:55 -0700
In-Reply-To: <20200324060125.GA610977@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 24 Mar 2020 02:01:25 -0400")
Message-ID: <xmqqtv2d1td4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D9B0394-6E00-11EA-B70C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'd be OK with just this, but adding a binary t/t5319/zero-objs.midx
> would be fine by me, too.

Yup, that sounds like a simple way to make sure we won't regress.

> One minor style nit:
>
>> @@ -1124,6 +1130,13 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
>>  				    i, oid_fanout1, oid_fanout2, i + 1);
>>  	}
>>  
>> +	if (m->num_objects == 0) {
>> +		midx_report(_("the midx contains no oid"));
>> +		// remaining tests assume that we have objects, so we can
>> +		// return here
>> +		return verify_midx_error;
>> +	}
>
> We prefer /**/ for comments, like:
>
>   /*
>    * Remaining tests assume that we have objects, so we can
>    * return here.
>    */

Thanks for catching it.

