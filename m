Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADC4C0015E
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 20:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjHIUvz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjHIUvy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 16:51:54 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C35196
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 13:51:54 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 805D21899ED;
        Wed,  9 Aug 2023 16:51:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rRencTPuxgbCi44kYOf2aj0w1qNADeNHCrXZPG
        ke2lE=; b=Of6vPWrd4Uucn3qeqwVm2FdY4nA88dvkaGFBpPvkX4qWhkzcWpvG4i
        bMfBtd0UsDiFnzf1AW0Vu5CFIG9yFM5GbywIEM9gnti1maczPXZOnvuFxCOQIHS+
        JPtO+tk7HpqUR9BGNgoMqhLc+vFAQx3EfqsZiurFGMLXUOQf5YCQY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78CE71899EB;
        Wed,  9 Aug 2023 16:51:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DE3DD1899EA;
        Wed,  9 Aug 2023 16:51:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2] sequencer: simplify allocation of result array in
 todo_list_rearrange_squash()
References: <20230809171532.2564880-1-oswald.buddenhagen@gmx.de>
Date:   Wed, 09 Aug 2023 13:51:51 -0700
In-Reply-To: <20230809171532.2564880-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Wed, 9 Aug 2023 19:15:32 +0200")
Message-ID: <xmqqsf8skkgo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91B19D16-36F6-11EE-A723-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

>  	if (rearranged) {
> +		ALLOC_ARRAY(items, todo_list->nr);
> +
>  		for (i = 0; i < todo_list->nr; i++) {
>  			enum todo_command command = todo_list->items[i].command;
>  			int cur = i;
> @@ -6357,16 +6359,15 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
>  				continue;
>  
>  			while (cur >= 0) {
> -				ALLOC_GROW(items, nr + 1, alloc);
>  				items[nr++] = todo_list->items[cur];
>  				cur = next[cur];
>  			}
>  		}
>  
> +		assert(nr == todo_list->nr);

The assert() made me wonder what kind of bugs we are worried about.

The next[] array elements are initialized to -1 and then gets "i"
that runs (0..todo_list->nr) and get shuffled among the elements of
the same array, so next[cur] reference in the while loop we see
above will always be within (0..todo_list->nr).  It is trivial to
see that the items[] array that is preallocated so that it can hold
up to todo_list->nr items is large enough.

But the condition of the assert() is even stronger.  We want to make
sure we did not drop any original items in the todo_list, as the
objective of this helper function is to shuffle the insns and
selectively turn "pick 01234567 fixup! title of another commit"
into "fixup 01234567 fixup! title of another commit".  There is no
reason we should have fewer elements in the result.

All makes sense.  Nice.

Thanks, will queue.




> +		todo_list->alloc = nr;
>  		FREE_AND_NULL(todo_list->items);
>  		todo_list->items = items;
> -		todo_list->nr = nr;
> -		todo_list->alloc = alloc;
>  	}
>  
>  	free(next);
