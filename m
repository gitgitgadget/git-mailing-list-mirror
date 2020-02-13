Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4ADC2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 17:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CF8206ED
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 17:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tVpk5HlA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgBMRpW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:45:22 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62408 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMRpW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 12:45:22 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 699A6AD0AA;
        Thu, 13 Feb 2020 12:45:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TKi6b5PIyFdUsjrdbBxaiQr6n7k=; b=tVpk5H
        lAlvw4XVMYbXFeDC568+0sdpP2R6eNuf3yF8VsjOs0bTAwAVSyLjJtMqvrb9+XB9
        XPagqHeU5XrAd92o0dhhRNgagdhRD4sZAeHFQSVypOQSx7MnP20SCgEIdVYAIxR9
        S/jf+uvHinBUenwOOrKSBK1BJQe0c7wmW218s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S75IdLtMt6cwQPC2uvCMhOWd4V7Em69m
        Fdo4PVtoc8E432f4xLk44s+gEVXR/1TCn8BOBCDfglz4N9wLLudw8pBKoFsmhJ1m
        L+ftDu0DLBiDg9djbTLGmCPX8Rn1PVoJpOmsphmMtx0C3/JdNUTQuqtAYxBgZ2Ha
        ZoelDXYUbLI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 605D2AD0A9;
        Thu, 13 Feb 2020 12:45:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 87497AD0A2;
        Thu, 13 Feb 2020 12:45:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/13] pack-bitmap: factor out type iterator initialization
References: <20200213021506.GA1124607@coredump.intra.peff.net>
        <20200213021615.GA1126038@coredump.intra.peff.net>
Date:   Thu, 13 Feb 2020 09:45:14 -0800
In-Reply-To: <20200213021615.GA1126038@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 12 Feb 2020 21:16:15 -0500")
Message-ID: <xmqqlfp6s7o5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98E20AA8-4E88-11EA-9C91-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When count_object_type() wants to iterate over the bitmap of all objects
> of a certain type, we have to pair up OBJ_COMMIT with bitmap->commits,
> and so forth. Since we're about to add more code to iterate over these
> bitmaps, let's pull the initialization into its own function.
>
> We can also use this to simplify traverse_bitmap_commit_list(). It
> accomplishes the same thing by manually passing the object type and the
> bitmap to show_objects_for_type(), but using our helper we just need the
> object type.
>
> Note there's one small code change here: previously we'd simply return
> zero when counting an unknown object type, and now we'll BUG(). This
> shouldn't matter in practice, as all of the callers pass in only usual
> commit/tree/blob/tag types.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  pack-bitmap.c | 63 +++++++++++++++++++++++++++------------------------
>  1 file changed, 33 insertions(+), 30 deletions(-)

Nicely written and makes perfect sense.  show_objects_for_type()
used to have a redundant pair of parameters, but it is impossible
to pass them inconsistently after this change.

Thanks.
