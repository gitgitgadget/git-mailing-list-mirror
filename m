Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3384C433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 22:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiC1WPQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 18:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiC1WPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 18:15:09 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB888566A
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 15:07:46 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CC5E10FCA9;
        Mon, 28 Mar 2022 17:53:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+qVYyscoGfQNqOpUInsl+ulnR4F4qA/TCkp/al
        5dFgw=; b=fDKsn0EqtxydIfPseB0U+gNTRwBVdT/CPbv5p0j697gPY7osh2qnGc
        DqfSXVssKjNIpjpDuivtf6m41F54mnCstYIdu/Hj/oyFsas+CJf1EKWtxBqBKvlQ
        oJkE6KRBBp7cmWuWObjH5p/rdE0WRaPpwdF4FyFWnB+83kZoIWIUk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5430A10FCA8;
        Mon, 28 Mar 2022 17:53:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BEC1B10FCA7;
        Mon, 28 Mar 2022 17:53:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danny Lin <danny0838@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git develop <git@vger.kernel.org>
Subject: Re: [PATCH] git-prompt: fix sequencer/todo detection
References: <20220325145301.3370-1-danny0838@gmail.com>
Date:   Mon, 28 Mar 2022 14:53:29 -0700
In-Reply-To: <20220325145301.3370-1-danny0838@gmail.com> (Danny Lin's message
        of "Fri, 25 Mar 2022 22:53:01 +0800")
Message-ID: <xmqqwngdzque.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81AB05FE-AEE1-11EC-8B59-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danny Lin <danny0838@gmail.com> writes:

> Previous case does not correctly check the "p ..." pattern.
>
> Signed-off-by: Danny Lin <danny0838@gmail.com>
> ---
>  contrib/completion/git-prompt.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index db7c0068fb..8ae341a306 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -315,7 +315,7 @@ __git_sequencer_status ()
>  	elif __git_eread "$g/sequencer/todo" todo
>  	then
>  		case "$todo" in
> -		p[\ \	]|pick[\ \	]*)
> +		p[\ \	]*|pick[\ \	]*)
>  			r="|CHERRY-PICKING"
>  			return 0
>  		;;

It is obvious that the original code is *not* prepared to see 'p'
followed by whitespace followed by other things, but I am not sure
how the code in sequencer.c::todo_list_write_to_file() can choose
to pass flags & TODO_LIST_ABBREVIATE_CMDS to todo_list_to_strbuf().

Danny, do you have a reproduction recipe, preferrably one you can
turn into a new test in t9903-bash-prompt.sh?  Or was this found
merely by inspecting the code?

Dscho, as far as I can tell, builtin/rebase.c can set the bit in the
flags word when rebase.abbreviatecommands configuration is set, but
that configuration variable is about rebase and it shouldn't affect
how multi-step cherry-pick would work, should it?  I am wondering if
an uninitialized "flags" word, whose TODO_LIST_ABBREVIATE_CMDS bit
randomly was turned on, caused todo_list_to_strbuf() to write an
abbreviated insn in the todo file.  If so, the insn word being
abbreviated or fully spelled out would not affect the correctness,
but the flags word affects other things that are more crucial to
correctness, so...

Thanks.


