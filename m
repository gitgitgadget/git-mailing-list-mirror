Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E7AC433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 22:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242248AbiCOWzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 18:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiCOWzI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 18:55:08 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018C6DF3B
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 15:53:55 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3A771194E5E;
        Tue, 15 Mar 2022 18:53:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=PRV+mB26XC1pjE5mC3EvD9RUsv8oDZR3JAbDLOBwlLU=; b=OxUA
        zuJo2H8Hc+YzI7ldbY5siuMaGhe8Li2786HKwBckm33GlwSby+3okao2QnpnaO05
        9T9ZiTBGf2by4zcjUQCkyRh/DCJfXMfaBVdXZTwTxOgThg2D0WOW0Uaz+OhEIN57
        kLDOnIfZvvmjN7o0MJL82cWp+qZQ1mcD/vKMjyw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 32016194E5D;
        Tue, 15 Mar 2022 18:53:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B7CDF194E5C;
        Tue, 15 Mar 2022 18:53:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jayati Shrivastava via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Hariom verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jayati Shrivastava <gaurijove@gmail.com>
Subject: Re: [PATCH] Use reverse_commit_list helper function for in-place
 list reversal
References: <pull.1177.git.1647373314457.gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 15:53:51 -0700
Message-ID: <xmqq4k3yddz4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9292232-A4B2-11EC-A4F0-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jayati Shrivastava via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Subject: Re: [PATCH] Use reverse_commit_list helper function for in-place list reversal

Perhaps

    Subject: [PATCH] sequencer: use reverse_commit_list_helper()

cf. Documentation/SubmittingPatches::[[summary-section]]

> From: JAYATI SHRIVASTAVA <gaurijove@gmail.com>

This name should match what is on Signed-off-by: line.  Check your
user.name configuration, perhaps?

> Here, a reverse copy of a list is being created by iterating
> over the list after which the original list is discarded.
> Instead of creating a new allocation, we can reverse the
> original list in-place using the reverse_commit_list helper
> function.

Perhaps

    Instead of creating a new allocation, reverse the list in-place
    by calling the reverse_commit_list() helper.

cf. Documentation/SubmittingPatches::[[imperative-mood]]
>
> Signed-off-by: Jayati Shrivastava <gaurijove@gmail.com>
> ---

> @@ -3984,9 +3984,7 @@ static int do_merge(struct repository *r,
>  		      git_path_merge_head(r), 0);
>  	write_message("no-ff", 5, git_path_merge_mode(r), 0);
>  
> -	for (j = bases; j; j = j->next)
> -		commit_list_insert(j->item, &reversed);
> -	free_commit_list(bases);
> +	bases = reverse_commit_list(bases);

If the code in the original code that followed from here used both
"bases" and "reversed", this would not have worked, but because the
original gets rid of "bases", we can just reverse the list in-place
with reverse_commit_list() helper and reuse the same variable.

>  	repo_read_index(r);
>  	init_merge_options(&o, r);
> @@ -4002,10 +4000,10 @@ static int do_merge(struct repository *r,
>  		 * update the index and working copy immediately.
>  		 */
>  		ret = merge_ort_recursive(&o,
> -					  head_commit, merge_commit, reversed,
> +					  head_commit, merge_commit, bases,
>  					  &i);
>  	} else {
> -		ret = merge_recursive(&o, head_commit, merge_commit, reversed,
> +		ret = merge_recursive(&o, head_commit, merge_commit, bases,
>  				      &i);
>  	}

Looks good.

Thanks.
