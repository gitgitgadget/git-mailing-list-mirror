Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEE1C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 16:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E30D6159A
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 16:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352365AbhI3Qvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 12:51:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53523 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348841AbhI3Qva (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 12:51:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45EEFF1130;
        Thu, 30 Sep 2021 12:49:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B/MpE2ll8/f7GO5JzetCfJyMhbdeTmhlBPZLs/
        BehsQ=; b=sH6CEev8jwnjS8jJHVKso3QiKmFKmrzuq6mGIs2ODru2rvWS0UL6co
        73VoW4EDcdiKPPvS/2iCX048hcod7SkE1sTEAuHhIQTxoYajj1zATF0CWqVw+vo2
        PVLh7HdHjNGpTlTRNXAf6fb7e+tbOzfUKiL9Xhy2Dbq1vht6WFFSs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DD27F112F;
        Thu, 30 Sep 2021 12:49:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B1FDDF112E;
        Thu, 30 Sep 2021 12:49:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v2] receive-pack: not receive pack file with large object
References: <20210930121058.5771-1-chiyutianyi@gmail.com>
        <20210930132004.16075-1-chiyutianyi@gmail.com>
Date:   Thu, 30 Sep 2021 09:49:45 -0700
In-Reply-To: <20210930132004.16075-1-chiyutianyi@gmail.com> (Han Xin's message
        of "Thu, 30 Sep 2021 21:20:04 +0800")
Message-ID: <xmqqczoqdn4m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B57B62C-220E-11EC-9444-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Xin <chiyutianyi@gmail.com> writes:

> @@ -519,6 +520,8 @@ static void *unpack_raw_entry(struct object_entry *obj,
>  		shift += 7;
>  	}
>  	obj->size = size;
> +	if (max_input_object_size && size > max_input_object_size)
> +		die(_("object exceeds maximum allowed size "));
>  
>  	switch (obj->type) {
>  	case OBJ_REF_DELTA:

Here obj->size is the inflated payload size of a single entry in the
packfile.  If it happens to be represented as a base object
(i.e. without delta, just deflated), it would be close to the size
of the blob in the working tree (but LF->CRLF conversion and the
like may further inflate it), but if it is a delta object, this size
is just the size of the delta data we feed patch_delta() with, and
has no relevance to the actual "file size".

Sure, it is called max_INPUT_object_size and we can say we are not
limiting the final disk size, and that might be a workable excuse
to check based on the obj->size here, but then its usefulness from
the point of view of end users, who decide to set the variable to
limit "some" usage, becomes dubious.

So...

