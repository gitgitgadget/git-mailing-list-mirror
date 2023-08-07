Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9531CC001B0
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 20:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjHGUTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 16:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjHGUTn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 16:19:43 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9432310EC
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 13:19:42 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3744C318EF;
        Mon,  7 Aug 2023 16:19:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jRPTCbWC6WRqLKdAq7Xi3ysRHj0Wk4nCV8MBg6
        emBbA=; b=D+7oEhc9c4ACMRIhw4GIbg/OGHcK45bxMIZyJGpuHWIX9p6OZIyp2b
        79oyIV45IGyNdrNNfrXL0TbmCxEgASY+moah4qkSSP2mnE/agFZiaIMizRnW2BjU
        l3ggf1qgRtSn2JYZtWY4o9JfpyjZQ0+3hmV14jDO9TUG1M+tdP9NQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 30379318EE;
        Mon,  7 Aug 2023 16:19:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4AE88318EB;
        Mon,  7 Aug 2023 16:19:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] sequencer: rectify empty hint in call of
 require_clean_work_tree()
References: <20230323162234.995514-1-oswald.buddenhagen@gmx.de>
        <20230807170935.2336730-1-oswald.buddenhagen@gmx.de>
Date:   Mon, 07 Aug 2023 13:19:37 -0700
In-Reply-To: <20230807170935.2336730-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Mon, 7 Aug 2023 19:09:35 +0200")
Message-ID: <xmqqa5v2ehba.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBC11D90-355F-11EE-8765-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> The canonical way to represent "no error hint" is making it null, which
> shortcuts the error() call altogether. This fixes the output by removing
> the line which said just "error:".
>
> Alternatively, one could make the function treat empty strings like null
> strings, which would make it resemble its original script implementation
> more closely, but that doesn't seem like a worthwhile goal. If anything,

The analysis I gave you in the previous round was primarily to
explain how this bug came to be, i.e. a misconversion of the
scripted original, and that would be a lot more pertinent
information than "is this closer to or further from the scripted
original?"  IOW, "equating NULL and an empty string is how the
original implemented the logic correctly, but the misconversion made
the current source to fail to do so" is the take-home message.  

You could correct the current version by making it follow the same
"NULL and an empty string are the same" convention to implement the
logic correctly, or you can build on the misconverted callee that
treats only NULL specially hence pass NULL instead of "".  Either
one is a valid implementation, but the reason to choose the former
would not be to "make it resemble the original".

IOW, "doesn't seem like a worthwhile goal" is beating a strawman.
Nobody advocates "if (!hint || !*hint)" because "the code must look
exactly like the original".  It is merely that it is one known way
to achieve correctness, as it was how the original achieved its
correctness.

> I'd go in the opposite direction and assert() that the argument is not
> an empty string.

If we were writing this program from scratch, "NULL means something
different from any sttring, and an empty string does not have
anything special compared to any other strings" would probably be a
good semantics to give to this helper function.  I'd be OK with the
change.  Also, adding "if (!*hint) BUG(...)" would be a good future
direction, I would think.

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
