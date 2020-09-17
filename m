Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8452AC433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2019B22205
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Al9DtnGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgIQSjk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 14:39:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63474 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgIQSj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 14:39:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 50237EF20C;
        Thu, 17 Sep 2020 14:39:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v/kbXy7bwm5PdFK2YeuF6eO1Kg4=; b=Al9Dtn
        GKMkoCzM+VSpEvhJemBRm6VKxnKgOpAB8ss1S7U0S/rkRlGe80QDlUYq/Q+dgUkt
        Lj58IgnrNpLSFzYH+fDPWiDjtPOAEbie/ioim+WCXwGtugJQZ6jGLP5USEM9Dyg1
        daz4Vg0xryQYeP0yQM7q4xmR677kioq+2wVVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hHlF3Nt1ovSsqpy/jz6L+XpNrhdGsYow
        LvBRHdqciVRu149bxrg3mVXvDncGnxpijsbRReHXrO1NeH1h273J990Jt5dRB2HI
        gOkFnQLQSHyBgFeMauIsAB/YZW8cxko3q92b2BpNauJuEOW2Cq6M7k+JTnkQBNsA
        OWQjaKGQ5OE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 49331EF20B;
        Thu, 17 Sep 2020 14:39:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 93844EF20A;
        Thu, 17 Sep 2020 14:39:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Christian Schlack via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Schlack <christian@backhub.co>
Subject: Re: [PATCH] remote: in case of error don't show success message.
References: <pull.848.git.git.1600356459092.gitgitgadget@gmail.com>
Date:   Thu, 17 Sep 2020 11:39:19 -0700
In-Reply-To: <pull.848.git.git.1600356459092.gitgitgadget@gmail.com>
        (Christian Schlack via GitGitGadget's message of "Thu, 17 Sep 2020
        15:27:38 +0000")
Message-ID: <xmqqpn6kqmco.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A20A746-F915-11EA-94E9-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Christian Schlack via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/builtin/remote.c b/builtin/remote.c
> index 542f56e387..64b4b551eb 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -1356,7 +1356,7 @@ static int set_head(int argc, const char **argv)
>  			result |= error(_("Not a valid ref: %s"), buf2.buf);
>  		else if (create_symref(buf.buf, buf2.buf, "remote set-head"))
>  			result |= error(_("Could not setup %s"), buf.buf);
> -		if (opt_a)
> +		else if (opt_a)
>  			printf("%s/HEAD set to %s\n", argv[0], head_name);
>  		free(head_name);
>  	}
>

Quite straight-forward and looks obviously good.

Thanks, will queue.
