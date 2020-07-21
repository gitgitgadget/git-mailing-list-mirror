Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D83C433DF
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 21:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C62620717
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 21:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cu8bMaIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbgGUV1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:27:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59817 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730214AbgGUV1q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 17:27:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C0556E003;
        Tue, 21 Jul 2020 17:27:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=52uZyshi8Mx60EVTb+P5TKw6cO0=; b=Cu8bMa
        IjasU8lM03IsRDv1Cntiw/dNcAidSQPdPWBRk8+fZoPzsd8QH7ImgI3IGFqSYO6f
        CIInsC/vDsehrgJeuCf8UjoOLq79wtcGYpZCunj7VFXudGN7It8YlgJwOgl/sM0f
        U/WBW6JZGMeR8eQvOfnlewH5J3BSN6AboeRUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JMinojjaYnJFajhQYsuAotaB76KlHXHM
        Wux3pbvD3Hbsuw5njb/U3vvC+fuu+NkBR8aIWpgPceIBfS0VGqac/j03A/s+6IAY
        Ww+jGF30DyYt4H7bUJ53eWhH009xxstmTb63E7V8Ca27qvl5CWonuVq4TqKMCHzP
        AhEP7ET2H3M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34BDE6E001;
        Tue, 21 Jul 2020 17:27:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B70786E000;
        Tue, 21 Jul 2020 17:27:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sluongng@gmail.com
Subject: Re: [PATCH 2/2] pack-objects: prefetch objects to be packed
References: <xmqqd04p8ywt.fsf@gitster.c.googlers.com>
        <20200721163736.69610-1-jonathantanmy@google.com>
        <xmqq5zag8yg5.fsf@gitster.c.googlers.com>
Date:   Tue, 21 Jul 2020 14:27:42 -0700
In-Reply-To: <xmqq5zag8yg5.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 21 Jul 2020 12:23:06 -0700")
Message-ID: <xmqqh7u07e41.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03840CC0-CB99-11EA-94D8-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>> The optimization makes sense to me if certain
>>> conditions are met, like...
>>> 
>>>  - Most of the time there is no missing object due to promisor, even
>>>    if has_promissor_to_remote() is true;
>>
>> I think that optimizing for this condition makes sense - most pushes (I
>> would think) are pushes of objects we create locally, and thus no
>> objects are missing.

Another simple thing I missed.  Why do we specifically refer to
"push" here?  Is this codepath in pack-objects not used or less
often used by upload-pack (which is what serves "fetch")?  

I just wanted to make sure that we are not optimizing for "push",
trading efficiency for "fetch" off.

Thanks.
