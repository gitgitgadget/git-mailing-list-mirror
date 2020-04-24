Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034CAC54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 20:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C1A215A4
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 20:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ISyA47Eo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgDXUTA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:19:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61670 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXUTA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 16:19:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 738C956AD6;
        Fri, 24 Apr 2020 16:18:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Iga8i8zCivjtIIs9buvRkyxN2JU=; b=ISyA47
        EoFzIg9wcbv2r/GEn4BzJ4OSIVjODWi9uPaQnSbGtFiM4/aybmVtIt5yeca0XYoB
        PyD5IYJsgkxQnLo2IVITr4asSOZs2ex+78oa+bKMKUCxp8Msx8uN7v4tfoGZ1VOE
        iR67du1ZTBsYVyO4PhoimvN+ONcQwF2TfR2jg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XDmPwFIFha+a94/AARaLmXz7y/uG0KUR
        Kt6lT0GirILsCFKrzxXkzFzVDMnTPlB73Tb97EpKHHRSqVaoo7O9q8de3V6DH0B5
        6xh3jshZzO6Y6XlMimV6yFYRXSIw9pdUiFCCc5s4HUMei/QLCobjlGjXOTDtmItv
        b8pHyp81lOg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C59D56AD5;
        Fri, 24 Apr 2020 16:18:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F01E356AD4;
        Fri, 24 Apr 2020 16:18:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] blame: drop unused parameter from maybe_changed_path
References: <20200423210303.GA1635761@coredump.intra.peff.net>
        <xmqqk125g9ze.fsf@gitster.c.googlers.com>
        <20200424043225.GB1648190@coredump.intra.peff.net>
Date:   Fri, 24 Apr 2020 13:18:57 -0700
In-Reply-To: <20200424043225.GB1648190@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 24 Apr 2020 00:32:25 -0400")
Message-ID: <xmqqimhod4cu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4042004-8668-11EA-8229-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If the bloom filter also computes against an empty tree for root
> commits (I didn't check, but that would make sense), I think that AND
> could be an OR:
>
>    if (!origin->commit->parents ||
>        !oidcmp(...))
>
> though it probably doesn't matter that much in practice. Root commits
> are rather rare.

Correct.  I just followed the code from bloom.c::get_bloom_filter()
down, and for a root commit, diff_tree_oid() with NULL in the first
parameter (i.e. old_oid) is called.  This NULL pointer eventually
reaches tree-walk.c::fill_tree_descriptor() and the function just
gives an empty tree in that case, which is what we want.
>
> BTW, we could also be using oideq() here. I thought coccicheck would
> note this, but it doesn't seem to. I suspect we could also get away with
> a direct pointer comparison of "parent == origin->commit->parents->item"
> due to the way we allocate "struct commit", but I'd rather err on the
> safer and less subtle side. :)

True.  oideq() is probably an improvement; I agree that pointer
equality is taking it too far.
