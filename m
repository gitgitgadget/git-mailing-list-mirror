Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF95BC54EE9
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 17:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiI0R0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 13:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiI0R0O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 13:26:14 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B09ADCCF
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 10:26:12 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B7AE213C39A;
        Tue, 27 Sep 2022 13:26:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CFngmmIr8KYSFNdUuRPU1fG14vy50iQAETiijh
        9TJrI=; b=t/8S4OixiWmPfrbX61oKczwaD4FQX+wNUAMK5/XMFBBPqzjlP+1U8t
        CdIelqTeqs2jvhztqec0SfqoKjxEQqD7quwmmZKUMZd8HbvT/7PrPGqMs09sW6SX
        BkH9szOC0kmZOwkoK13Wh8xEaAiHAZgvg8Ek+hHJOi9eA68Y6RAgs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AEC0013C398;
        Tue, 27 Sep 2022 13:26:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1B39713C397;
        Tue, 27 Sep 2022 13:26:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/5] config: relax requirements on multi-value return
References: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
        <b2558a737f31465b38ad361a412d923ef186a38a.1664287711.git.gitgitgadget@gmail.com>
Date:   Tue, 27 Sep 2022 10:26:08 -0700
In-Reply-To: <b2558a737f31465b38ad361a412d923ef186a38a.1664287711.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 27 Sep 2022
        14:08:27 +0000")
Message-ID: <xmqqmtak685r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7ADFCFEC-3E89-11ED-9860-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The git_configset_get_value() method has an assert() statement
> guaranteeing that the result from git_configset_get_value_multi() is
> either NULL or has at least one element. We want to change that return
> to provide an empty list instead of a NULL list, so change the earlier
> 'return 1' condition to care about a NULL or empty list.

If we are allowing to return an empty string_list from the function
in later steps, the assert() that insists the list has at least 1
item on it will get in the way.  OK.

> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  config.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/config.c b/config.c
> index cbb5a3bab74..bf89afbdab0 100644
> --- a/config.c
> +++ b/config.c
> @@ -2407,9 +2407,8 @@ int git_configset_get_value(struct config_set *cs, const char *key, const char *
>  	 */
>  	values = git_configset_get_value_multi(cs, key);
>  
> -	if (!values)
> +	if (!values || !values->nr)
>  		return 1;
> -	assert(values->nr > 0);
>  	*value = values->items[values->nr - 1].string;

But we need to guard against an empty list, obviously.  OK.

>  	return 0;
>  }
