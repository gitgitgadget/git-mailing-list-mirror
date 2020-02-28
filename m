Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A844EC3F2CD
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 20:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E67620665
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 20:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WRnaJV0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgB1Uj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 15:39:56 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53157 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgB1Uj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 15:39:56 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CAFC2A9379;
        Fri, 28 Feb 2020 15:39:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qBwO1Jhvf2Wd98IucImhAfDwEbs=; b=WRnaJV
        0hcpTRVdQ0wiVeuLy/xJMOYjFmF7qbtkTPbfIYd9vtN40/v2f8K4BZ4raVrTjbD7
        4fSPr9cds/ntaKYuIxmUY9GgE1Nz0oAlOEY1cYQvSyVIJSt3xwiiLWY4OAAyxxGU
        D31ngX1+vKPbsp0IvB/nuwWqC1TZcHedkiDJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qVbMKprrxc27aJe2+h2LMS2dIheFHVNm
        nT2w1cnFtucdPwGNt2t7TxFb2Z+hWAdsMDqnfWL8BAHQAQsgzQi6qVPFeRCZZFji
        kEBxPZkB4gz7m/yq0K2JCng7TcFZgfB6nY7ISmfybk5S6Icg+TCdXzXOt/HmAfJB
        dAN99k+xJaQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C2E5CA9377;
        Fri, 28 Feb 2020 15:39:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F1644A9375;
        Fri, 28 Feb 2020 15:39:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Damien Robert <damien.olivier.robert@gmail.com>,
        git@vger.kernel.org,
        Damien Robert <damien.olivier.robert+git@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH 1/1] midx.c: fix an integer overflow
References: <20200228162450.1720795-1-damien.olivier.robert+git@gmail.com>
        <20200228185525.GB1408759@coredump.intra.peff.net>
Date:   Fri, 28 Feb 2020 12:39:50 -0800
In-Reply-To: <20200228185525.GB1408759@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 28 Feb 2020 13:55:25 -0500")
Message-ID: <xmqqzhd2cup5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 78ED2316-5A6A-11EA-9D27-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> -	for (i = 0; i < m->num_objects - 1; i++) {
>> +	for (i = 0; i + 1 < m->num_objects; i++) {
>>  		struct object_id oid1, oid2;
>>  
>>  		nth_midxed_object_oid(&oid1, m, i);
> [...]           nth_midxed_object_oid(&oid2, m, i + 1);
>
> Perhaps it would be simpler as:
>
>   for (i = 1; i < m->num_objects; i++) {
>           ...
> 	  nth_midxed_object_oid(&oid1, m, i - 1);
> 	  nth_midxed_object_oid(&oid2, m, i);
> 	  ...
>   }

"Count up while i+1 is smaller than..." looked extremely unnatural and
it was hard to grok, at least to me.  This

	for (i = 0; i < m->num_objects - 1; i++) {

might have been more palatable, but yours is much better.

> Though I almost wonder if we should be catching "m->num_objects == 0"
> early and declaring the midx to be bogus (it's not _technically_ wrong,
> but I'd have to suspect a bug in anything that generated a 0-object midx
> file).

That, too ;-)
