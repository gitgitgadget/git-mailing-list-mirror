Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0DCC433E0
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 23:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6842220720
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 23:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S11kjRC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgGUX5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:57:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56885 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgGUX5E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 19:57:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3B7AFF2FC1;
        Tue, 21 Jul 2020 19:57:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U4B9rvahAef2q6KZk+Zd3KtIUP0=; b=S11kjR
        C7ZB0q+zpzG85izT7peihWGbg2EuzzOL6Bo4lL6ZitELReW8JE349aWCHB9MBzyi
        9x+qzj0/2TC5+QNWvGiehtLF6Y0U3koC9XFl5tN0/rmOrvUclYYTiDiOeWuwp+q8
        WJc5XNuHhaQMTx4+IWFGMmAJ3RQBiYuhoATfo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Pgz2KnSAAnxF3Gh5ocDHPYfpThRiLpjj
        giXOHZTgOPsQwz8XDCmw85qk84p+VmtRZPVjjynLfSYosdmVvy6eO6JVjxfHtR10
        68naH9TfsH+8YsUUXGk2xmwMmOCIe4Ssm31l+jPUiebQMrIs4nrVS3MSVrrRxSdh
        VnOYtypjqyU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 343B9F2FC0;
        Tue, 21 Jul 2020 19:57:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 74561F2FBD;
        Tue, 21 Jul 2020 19:56:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sluongng@gmail.com
Subject: Re: [PATCH 2/2] pack-objects: prefetch objects to be packed
References: <xmqqh7u07e41.fsf@gitster.c.googlers.com>
        <20200721233707.1363438-1-jonathantanmy@google.com>
Date:   Tue, 21 Jul 2020 16:56:57 -0700
In-Reply-To: <20200721233707.1363438-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 21 Jul 2020 16:37:07 -0700")
Message-ID: <xmqqv9ig5smu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD8B7D04-CBAD-11EA-9C74-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> >>> The optimization makes sense to me if certain
>> >>> conditions are met, like...
>> >>> 
>> >>>  - Most of the time there is no missing object due to promisor, even
>> >>>    if has_promissor_to_remote() is true;
>> >>
>> >> I think that optimizing for this condition makes sense - most pushes (I
>> >> would think) are pushes of objects we create locally, and thus no
>> >> objects are missing.
>> 
>> Another simple thing I missed.  Why do we specifically refer to
>> "push" here?  Is this codepath in pack-objects not used or less
>> often used by upload-pack (which is what serves "fetch")?  
>> 
>> I just wanted to make sure that we are not optimizing for "push",
>> trading efficiency for "fetch" off.
>
> Ah...that's true. For "fetch" I think it's less important because the
> multiple roundtrips of the pack negotiation means that the packfiles are
> usually more specific, but this optimization will help "fetch" too. I
> don't think we're optimizing at the expense of "fetch" - any
> improvements should benefit both similarly.

The one who serves "fetch" (i.e. "upload-pack") may be advertising
the objects that it itself would have to lazily fetch from its
promisor remote, but that is sort of crazy.  As long as we have
something to discourage such an arrangement (i.e. "don't fetch from
a lazy clone"), we would be OK to assume that most of the time there
is no missing objects.

Thanks.
