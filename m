Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61B4C433E0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 05:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BA2764FE5
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 05:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhCJFYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 00:24:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51995 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbhCJFYV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 00:24:21 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF211A6434;
        Wed, 10 Mar 2021 00:24:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ayzPGoFlTxsNIMmjJ0m0TPpesZc=; b=dh73nK
        kGvffv74Jxjqh4Lu4FOXgHTh7xkOvGyCNzQdDbWamrBv92yuqKFahy5HYSxH+jDn
        NBJtD9BFPpBWASlnTd/xrLRTMPE6meuJTKjZEL9fjPhpDsC1tDT/lq7i+v31sfxY
        AuNN0pmjuGtmFrPFlgvVL8/gjgAUpBgNlFhQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vwPYic3/p09c1aZwpsgJgZVTU9cSVYT9
        L0KqtV82n7Z2H6uwyiXgmauGHsiHXuyANNfne6Enu+5dpgbUSO+IcFaPTCPU94X/
        401EB3hD4uSJZC+BI1fgCVzI6YFYKoU6wVLqX3J/0fDKM2GEzNKATi7jn8Hj2h7M
        V/uYmJsOITc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B6A48A6433;
        Wed, 10 Mar 2021 00:24:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 211CEA6432;
        Wed, 10 Mar 2021 00:24:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, nmulcahey@google.com
Subject: Re: [PATCH] fetch-pack: do not mix --pack_header and packfile uri
References: <xmqqv9a58a18.fsf@gitster.c.googlers.com>
        <20210308191424.12149-1-jonathantanmy@google.com>
        <xmqqft155tiu.fsf@gitster.c.googlers.com>
        <xmqqwnugywax.fsf@gitster.c.googlers.com>
Date:   Tue, 09 Mar 2021 21:24:18 -0800
In-Reply-To: <xmqqwnugywax.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 09 Mar 2021 11:13:58 -0800")
Message-ID: <xmqqr1knmvi5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DDB6E05C-8160-11EB-BEA1-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Instead, I think we should not touch index_pack in the earlier part
> of the function at all (both reading, writing, or even checking for
> NULL-ness), ...

I have to take the "NULL-ness" part back.  As the NULL-ness of the
variable is also used to convey that URI packfile is in use, which
in turn means we have to tell "index-pack" we are going to use for
processing in-stream packfile that the objects in the pack may be
pointing at objects that are not yet available.  So we do need to
check for the NULL-ness in order to decide what command line to use
to process the in-stream packdata.

