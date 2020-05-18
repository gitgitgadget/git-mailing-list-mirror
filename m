Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F58C433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F7C20715
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nBdz28a1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgERRXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 13:23:41 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59664 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgERRXl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 13:23:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 395BABED33;
        Mon, 18 May 2020 13:23:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LFIE0KAkXm3dGQ7oEhIR+Mm9PUI=; b=nBdz28
        a1dHGAy/gqcmgYeVxbZhBSwtWorXUFF+NtOCSoQWEBvETqrwmrHcIHe3/zqOqMQO
        ztH4N7d9KA+39bGGtD/CAT7uHIrnu47urGequNIIO9c5Tg6Nf5iO4DU2zZrfTw92
        muzVKrSNI1/CauQN03ZAdNRCryVcTCLJwyz/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M6O5CQL6xLKZTXgAtf7DF/GNN8yaEbC5
        +0CC/CxCZqfexH41KE0MCw/VUjKgEQfHDKhoeXL3e3xFlXGinGQGYB3qocIvIHtr
        ylSt6NuiIOA5+l/1UC+ixbIjzvc81to8C3qzRfxxn/4DiMBI1eoidh0/p0AAs6AB
        mzzyI8aAMEY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3169FBED32;
        Mon, 18 May 2020 13:23:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 73C22BED30;
        Mon, 18 May 2020 13:23:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     anng.sw@gmail.com
Cc:     git@vger.kernel.org, eantoranz@gmail.com,
        Andrew Ng <andrew.ng@sony.com>
Subject: Re: [PATCH] merge: optimization to skip evaluate_result for single strategy
References: <20200518153613.17497-1-anng.sw@gmail.com>
Date:   Mon, 18 May 2020 10:23:34 -0700
In-Reply-To: <20200518153613.17497-1-anng.sw@gmail.com> (anng sw's message of
        "Mon, 18 May 2020 16:36:13 +0100")
Message-ID: <xmqqk11940o9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E9F3D3C-992C-11EA-AD21-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

anng.sw@gmail.com writes:

> From: Andrew Ng <andrew.ng@sony.com>
>
> For a merge with a single strategy, the result of evaluate_result() is
> effectively not used and therefore is not needed, so avoid altogether.

Excellent observation.

> On Windows, this optimization can half the time required to perform a

s/half/halve/

> recursive merge of a single commit with the LLVM repo.
>
> Signed-off-by: Andrew Ng <andrew.ng@sony.com>
> ---
>  builtin/merge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index ca6a5dc4bf..7da707bf55 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1656,7 +1656,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  				}
>  				merge_was_ok = 1;
>  			}
> -			cnt = evaluate_result();
> +			cnt = (use_strategies_nr > 1) ? evaluate_result() : 0;

As best_cnt is initialized to (-1), any value would trigger the
logic to nominate the current one as "best so far", and 0 is just as
good as it gets ;-)  And we'll finish the loop soon after doing so.

Looks good.

>  			if (best_cnt <= 0 || cnt <= best_cnt) {
>  				best_strategy = use_strategies[i]->name;
>  				best_cnt = cnt;

