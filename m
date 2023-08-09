Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598EAC001DE
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 01:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjHIBYP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 21:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjHIBYO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 21:24:14 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D818A1BDA
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 18:24:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E14B21C1FA;
        Tue,  8 Aug 2023 21:24:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KlU8J21HMGGa8NG1Kl8XY+l+A+Dp7bWROE5lDS
        ++X18=; b=UtkuD4CEdBBEzceKiFe/P3xZN/oKXQlmpK3u3CJ0ZbUb3d6R97qL3F
        roFXoonK1lV3diLiYIywbshImqIU7yNvL+OwxHo1vJvND/3fifBcalSVB9jDYn+b
        jI2DVxce0S0RMz24SKFlOporgjibWlqGqus2lVwl9up+eXUPh0+3o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DAA6A1C1F9;
        Tue,  8 Aug 2023 21:24:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 72F481C1F8;
        Tue,  8 Aug 2023 21:24:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] sequencer: rectify empty hint in call of
 require_clean_work_tree()
References: <20230323162234.995514-1-oswald.buddenhagen@gmx.de>
        <20230807170935.2336730-1-oswald.buddenhagen@gmx.de>
Date:   Tue, 08 Aug 2023 18:24:06 -0700
In-Reply-To: <20230807170935.2336730-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Mon, 7 Aug 2023 19:09:35 +0200")
Message-ID: <xmqqcyzx6ma1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F6FF5DE-3653-11EE-9305-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> The canonical way to represent "no error hint" is making it null, which
> shortcuts the error() call altogether. This fixes the output by removing
> the line which said just "error:".

Sorry, but I forgot to point out a rather obvious thing in my
review.  We would want to see a reproduction recipe described here
in the proposed log message at least.  Even better is an addition to
an existing test to ensure that there is no such empty "error:"
line, which will make sure that we will notice when anybody by
mistake (this includes a mismerge of other topics) breaks this fix.

Thanks.

>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index cc9821ece2..d15a7409d8 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -6182,7 +6182,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>  	if (checkout_onto(r, opts, onto_name, &oid, orig_head))
>  		goto cleanup;
>  
> -	if (require_clean_work_tree(r, "rebase", "", 1, 1))
> +	if (require_clean_work_tree(r, "rebase", NULL, 1, 1))
>  		goto cleanup;
>  
>  	todo_list_write_total_nr(&new_todo);
