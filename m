Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8663BC47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 18:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 558FE20663
	for <git@archiver.kernel.org>; Tue,  5 May 2020 18:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xBGrUB9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbgEESU0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 14:20:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54596 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbgEESU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 14:20:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7127BBC7EC;
        Tue,  5 May 2020 14:20:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bcq4O8DAg3CMe3D2EmgDduXAjMU=; b=xBGrUB
        9DmcKWtFPwsOpVPIgmk8h3yRnt9l+h/zBVFb6BfUBrHg9uyA5gOWHnv05Fh4q565
        u9QhvS4Oq6DcMBJ6S1RWQY411MqIDRxwzCAS99LOy7ZNxcxEFT/kH39AmXbVdWih
        5W3TXsnUEAOgEPziiiI4NkB0o1HsylENaND+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q3dJEyCxa/LLikkuU0t/ie1/MZ0fN0h1
        IuMgJuBBagiWjpK+RpAxeYLkqaUhYOTTje3L6j3gcO4Vr8fuXr1nxfJOsBhAb/cW
        ck6VkT4c7B0XrizgM7I45AVEix8b2xxbFyh1LxVp0xX9E7xUeagXyt8P3wN/8b71
        NSTMBuZwHFQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 676E3BC7EA;
        Tue,  5 May 2020 14:20:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AB7A5BC7E7;
        Tue,  5 May 2020 14:20:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, chriscool@tuxfamily.org
Subject: Re: [PATCH 3/4] pack-bitmap.c: support 'tree:0' filtering
References: <cover.1588633810.git.me@ttaylorr.com>
        <87b21d72bb588f7366d928544aeaf4de68b027a7.1588633810.git.me@ttaylorr.com>
        <xmqq7dxrc5r9.fsf@gitster.c.googlers.com>
        <20200505155951.GA69300@syl.local>
Date:   Tue, 05 May 2020 11:20:20 -0700
In-Reply-To: <20200505155951.GA69300@syl.local> (Taylor Blau's message of
        "Tue, 5 May 2020 09:59:51 -0600")
Message-ID: <xmqqftceb5wb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14ED0FE4-8EFD-11EA-AA3B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I think we need some sort of guard here, since we could receive any
> value of object_type, but you're right that this isn't the right one. It
> should probably be something like:
>
>   if (type < OBJ_COMMIT || type > OBJ_TAG)
>
> to pick out the sentinel values like OBJ_BAD and OBJ_NONE, as well as
> the pack-specific types, like OBJ_OFS_DELTA and so on.

Yeah, it looked strange to start checking for OBJ_BLOB and OBJ_TREE
in commits that starts passing these types to the function, while
the code in the function was prepared to take any valid type, so
using the above condition from the get-go would probably be a lot
more sensible.

