Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A365C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 22:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238535AbiGSW5s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 18:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238289AbiGSW5q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 18:57:46 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877DB624AB
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 15:57:44 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A6D24127E16;
        Tue, 19 Jul 2022 18:57:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4iXQzpaBUXDR9Bz/s2jdMJPC5P4IXJQxEz5kuR
        zcdPM=; b=O8HHCQgsbRCTThnHV+UF3rEHPA3+4bhcfwFk4a/o6wlZi5GpP7+WUh
        g7FV+6kuQrTu+vBqwP0xhh3HQleMXRaxzjCQeeQoS1Vm8/HjzUYo0C0REfkBbB/l
        giccZAPoGCie+FFCsj4tGMZtmer29iyikgeyIdIrY6ayBo4vmMccI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F207127E13;
        Tue, 19 Jul 2022 18:57:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0EE66127E12;
        Tue, 19 Jul 2022 18:57:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 5/6] merge: ensure we can actually restore pre-merge
 state
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
        <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
        <a03075167c1f4410a1b4f415313f11a7e1c3a594.1655621424.git.gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 15:57:41 -0700
In-Reply-To: <a03075167c1f4410a1b4f415313f11a7e1c3a594.1655621424.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sun, 19 Jun 2022
        06:50:23 +0000")
Message-ID: <xmqq7d487lsq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 327C1DE6-07B6-11ED-A6AE-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Merge strategies can fail -- not just have conflicts, but give up and
> say that they are unable to handle the current type of merge.  However,
> they can also make changes to the index and working tree before giving
> up; merge-octopus does this, for example.  Currently, we do not expect
> the individual strategies to clean up after themselves, but instead
> expect builtin/merge.c to do so.  For it to be able to, it needs to save
> the state before trying the merge strategy so it can have something to
> restore to.  Therefore, remove the shortcut bypassing the save_state()
> call.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/merge.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 2dc56fab70b..aaee8f6a553 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1663,12 +1663,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  	 * tree in the index -- this means that the index must be in
>  	 * sync with the head commit.  The strategies are responsible
>  	 * to ensure this.
> +	 *
> +	 * Stash away the local changes so that we can try more than one.
>  	 */

The comment explains why we limited the save_state() to avoid wasted
cycles and SSD wear and tear by looking at the number of strategies.
But because we are removing the restriction (which I am not 100%
sure is a good idea), "so that we can try more than one" no longer
applies as the reason why we run save_state() here.

> -	if (use_strategies_nr == 1 ||
> -	    /*
> -	     * Stash away the local changes so that we can try more than one.
> -	     */
> -	    save_state(&stash))
> +	if (save_state(&stash))
>  		oidclr(&stash);
>  
>  	for (i = 0; !merge_was_ok && i < use_strategies_nr; i++) {
