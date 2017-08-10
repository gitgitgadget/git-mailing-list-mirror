Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 980241F667
	for <e@80x24.org>; Thu, 10 Aug 2017 22:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752942AbdHJWXE (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 18:23:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62373 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752281AbdHJWXD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 18:23:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D79179A819;
        Thu, 10 Aug 2017 18:22:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RJJSIb3yRtW/lrw5gt+ljLDz/Ms=; b=bS2XUx
        rBVOFQ5U+3OefnwrLGil22GtM2llZFNFtUxckGSu6TfsF/gUE/NWE/N0Z255jZGs
        LwXgN670T1mc4+TJ6xYL4gxxMW7ObzfyxFKsC1Vd+3MYOdHxZlY+kO+PeaCrGrHf
        S7Dsrzdl/YAMfh+KC3RqJhzA7dQac0Ooyb1ds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T22qQkvOXsDbyl2myukUfmrhKt3GgcYL
        ae/A23Pjzx+L697XBCEnjY9eT8p3H2QqyeUh+6LnciosfdP34tjeuo+jXol8qEIO
        Xe72uzK84nvCLB2Nx/mJLDd9Emk2ulvop4uYB2KUkCJQCmKLQ9yvjW1bb3eZI6Xx
        3eFXN2adPJk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CEBC59A818;
        Thu, 10 Aug 2017 18:22:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2FA949A816;
        Thu, 10 Aug 2017 18:22:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Willford <kcwillford@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, peartben@gmail.com,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH] commit: skip discarding the index if there is no pre-commit hook
References: <20170810185416.8224-1-kewillf@microsoft.com>
Date:   Thu, 10 Aug 2017 15:22:54 -0700
In-Reply-To: <20170810185416.8224-1-kewillf@microsoft.com> (Kevin Willford's
        message of "Thu, 10 Aug 2017 14:54:16 -0400")
Message-ID: <xmqqo9rn12rl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74D92696-7E1A-11E7-A33E-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Willford <kcwillford@gmail.com> writes:

> If there is not a pre-commit hook, there is no reason to discard
> the index and reread it.
>
> This change checks to presence of a pre-commit hook and then only
> discards the index if there was one.
>
> Signed-off-by: Kevin Willford <kewillf@microsoft.com>
> ---

Peff already has done a good job reviewing the patch text, and I
agree that this is a worthwhile optimization.

Could Microsoft folks all make sure that their signed-off-by lines
match their From: address (or leave an in-body From: to override
the From: address your MUA places in your messages)?

Thanks.

>  builtin/commit.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index e7a2cb6285..443949d87b 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -671,12 +671,22 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  	const char *hook_arg2 = NULL;
>  	int clean_message_contents = (cleanup_mode != CLEANUP_NONE);
>  	int old_display_comment_prefix;
> +	const char *precommit_hook = NULL;
>  
>  	/* This checks and barfs if author is badly specified */
>  	determine_author_info(author_ident);
>  
> -	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
> -		return 0;
> +
> +	if (!no_verify) {
> +		/*
> +		 * Check to see if there is a pre-commit hook
> +		 * If there not one we can skip discarding the index later on
> +		 */
> +		precommit_hook = find_hook("pre-commit");
> +		if (precommit_hook &&
> +		    run_commit_hook(use_editor, index_file, "pre-commit", NULL))
> +			return 0;
> +	}
>  
>  	if (squash_message) {
>  		/*
> @@ -940,12 +950,15 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		return 0;
>  	}
>  
> -	/*
> -	 * Re-read the index as pre-commit hook could have updated it,
> -	 * and write it out as a tree.  We must do this before we invoke
> -	 * the editor and after we invoke run_status above.
> -	 */
> -	discard_cache();
> +	if (!no_verify && precommit_hook) {
> +		/*
> +		 * Re-read the index as pre-commit hook could have updated it,
> +		 * and write it out as a tree.  We must do this before we invoke
> +		 * the editor and after we invoke run_status above.
> +		 */
> +		discard_cache();
> +	}
> +
>  	read_cache_from(index_file);
>  	if (update_main_cache_tree(0)) {
>  		error(_("Error building trees"));
