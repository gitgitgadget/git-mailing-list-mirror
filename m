Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FFCC433E0
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 23:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 208D92073A
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 23:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YdWQjRUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgGUX1W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:27:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53458 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgGUX1V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 19:27:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B62DEBF69;
        Tue, 21 Jul 2020 19:27:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zk8mkXP8ZyPcUkkmmhyP6w16+/A=; b=YdWQjR
        UJ3y3rBG/ZhkwH0/6Y6T98xeR7vM4S+T3gyzcoOaYNZZJN9dJjischxaY0jpbyIg
        vyqA5xssJC9I+OTFwct/x866OpHfuhEnlGhLGA9654QTgLBUsNzTuIOMslnm/t5t
        II5Aqa+0C+aedf5BkGZvYRJFE2E2dQUxbaMtY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZaduKRRTy15/SG125fh09XY5ePWmHG5P
        2hMWUaB2jWFCrE0YTm0cytDCHmUcV7LtzneyTX5l3qM8Ulnh/FErNrD1Y6Yz+N4R
        xJQUhFMAZ5Zs/HQxZ0pbDSRF+h0s82zfHd1b+9luJoLC8Vqmm2fuZl8Fh017ltND
        NNCJs63WaHg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E50B1EBF68;
        Tue, 21 Jul 2020 19:27:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2A0A3EBF64;
        Tue, 21 Jul 2020 19:27:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] sha1-file: make pretend_object_file() not prefetch
References: <20200721225020.1352772-1-jonathantanmy@google.com>
Date:   Tue, 21 Jul 2020 16:27:15 -0700
In-Reply-To: <20200721225020.1352772-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 21 Jul 2020 15:50:20 -0700")
Message-ID: <xmqq4kq078ks.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7359FA8-CBA9-11EA-8B57-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When pretend_object_file() is invoked with an object that does not exist
> (as is the typical case), there is no need to fetch anything from the
> promisor remote, because the caller already knows what the object is
> supposed to contain. Therefore, suppress the fetch. (The
> OBJECT_INFO_QUICK flag is added for the same reason.)

Yes, "pretend" is also a way to lie about the contents IIRC, so even
if the object is available elsewhere, we should *not* fetch from the
promisor.  Makes sense to me.
