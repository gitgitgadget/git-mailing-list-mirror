Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0F5C001B0
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 19:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjHGTJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 15:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjHGTJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 15:09:09 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AF7171E
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 12:09:08 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 03E3E1A6247;
        Mon,  7 Aug 2023 15:09:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X8dgBjj2t0Jy6kbyX5IhtjaHrrXtuTbwpcN69B
        xqPQk=; b=Aoi8Hah09qOGEDHFGNyyCtkzrmFKRZ57zjdpe2oW6ANsLUQ5l5kZjS
        w5yf87aVikKDsWndZ7eTcb8iumlCgQHyIdo2rUd8L4dQ7iJOWxX8LgBkhTVlzJkL
        541VVHouwAfUhoNVN32pZD82OMyq6yitCgjJgCDPKlCjEi/lnBj54=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EA51A1A6246;
        Mon,  7 Aug 2023 15:09:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 106171A6245;
        Mon,  7 Aug 2023 15:09:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 2/3] t/lib-rebase: set_fake_editor(): handle FAKE_LINES
 more consistently
References: <a803e1ad-1025-164a-f7ca-cc1a41e4f12b@gmail.com>
        <20230807170935.2336663-1-oswald.buddenhagen@gmx.de>
        <20230807170935.2336663-3-oswald.buddenhagen@gmx.de>
Date:   Mon, 07 Aug 2023 12:09:05 -0700
In-Reply-To: <20230807170935.2336663-3-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Mon, 7 Aug 2023 19:09:34 +0200")
Message-ID: <xmqqzg32ekku.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1BD39AC-3555-11EE-8C46-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> Default next action after 'fakesha' to preserving the command instead
> of forcing 'pick', consistently with other "instant-effect" keywords.
> There is no reason why one would want that inconsistency, so this was
> clearly just an oversight in commit 5dcdd740 ("t/lib-rebase: prepare
> for testing `git rebase --rebase-merges`"). Rectifying it makes the
> behavior easier to reason about and document.
>
> This would affect hypothetical "fakesha <n>" sequences where line <n>
> already isn't a pick, which currently don't appear.
>
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> ---
> Cc: Phillip Wood <phillip.wood123@gmail.com>
> ---
>  t/lib-rebase.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I do recall seeing this change and remember wondering what the
fallout from this change would be.  So relative to the previous
round, the above is a definite improvement to clearly state that no
test that is currently in the codebase is affected by this change.

As to the change itself, I do not much care among (1) what this
patch does, (2) doing nothing, or (3) barf when the action is not a
pick.  At least, having this step separate from other changes like
this round of the series does is a very good thing---when somebody
with more knowledge and stake in what the fake-editor does appears
and explains why forcing pick is a good idea, we can easily revert
only this step.

Will queue as-is together with the other two patches.

Thanks.

> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> index e6179ab529..9ed87ca7ab 100644
> --- a/t/lib-rebase.sh
> +++ b/t/lib-rebase.sh
> @@ -64,7 +64,7 @@ set_fake_editor () {
>  		fakesha)
>  			test \& != "$action" || action=pick
>  			echo "$action XXXXXXX False commit" >> "$1"
> -			action=pick;;
> +			action=\&;;
>  		*)
>  			sed -n "${line}s/^[a-z][a-z]*/$action/p" < "$1".tmp >> "$1"
>  			action=\&;;
