Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B85EE49A5
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 22:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjHUWQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 18:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjHUWQx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 18:16:53 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2053BE4
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 15:16:50 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 664381BCBC2;
        Mon, 21 Aug 2023 18:16:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UI47pdpZ5G2p0ChM7bqiWPkwWg3od9tdD11wX7
        KvG0w=; b=OIPWdIl9kUFVr/0lFyBMRyY2PVt7EoZv5CXys2GYE9cFr3RxFrxOEf
        Q1ed1lDOD4CWFuhCu7A4V5vvyHSnh2yYAb0EiOeQcobY+48gmPNw5RXRTNhV6CQA
        mX05cWnavTylQHzapiCumBCEnLxYwbQpdPpIBmywtikh0KFkisKfY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D35F1BCBC1;
        Mon, 21 Aug 2023 18:16:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BECE21BCBC0;
        Mon, 21 Aug 2023 18:16:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 5/5] diff: the -w option breaks --exit-code for --raw
 and other output modes
References: <20230817222949.3835424-1-gitster@pobox.com>
        <20230818235932.3253552-1-gitster@pobox.com>
        <20230818235932.3253552-6-gitster@pobox.com>
        <20230821210058.GD1800481@coredump.intra.peff.net>
Date:   Mon, 21 Aug 2023 15:16:47 -0700
In-Reply-To: <20230821210058.GD1800481@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 21 Aug 2023 17:00:58 -0400")
Message-ID: <xmqqttssnir4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C071586-4070-11EE-89B7-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Alternatively, we could put it in the caller, like so:
>
> diff --git a/diff.c b/diff.c
> index 78f4e7518f..e7281e75eb 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6528,6 +6528,7 @@ void diff_flush(struct diff_options *options)
>  			if (check_pair_status(p))
>  				flush_one_pair(p, options);
>  		}
> +		options->found_changes = !!q->nr;
>  		separator++;
>  	}

Yup, I suspect they amount to the same thing in practice, but I
couldn't come up with a good explanation to give casual readers of
the conditional call to flush_one_pair() a few lines above why
this is correct.

