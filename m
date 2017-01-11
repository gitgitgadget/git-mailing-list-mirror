Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3D6520ABE
	for <e@80x24.org>; Wed, 11 Jan 2017 21:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934721AbdAKVsd (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 16:48:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53553 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934258AbdAKVsb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 16:48:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E1156025E;
        Wed, 11 Jan 2017 16:48:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kgVfyH4IF2r5lqXP4PTJbuIn+E8=; b=p07Ku1
        wtV2TGVuh8Q1tWIxQXMAbINsugee6oNi6+p3s4AJ4PFROvEowYQ8BTwMplMmA0oQ
        YVcVQD9b4MuS78s64tWW8kv/GRMM3NyAYKVfekD8kO4qmbKit9GEXdgi2anN8IH4
        Cxgw7CejIYJWIgyIbiOs5khlzEEwGwO75SCDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fLeckINLSnArMP8dfrn/A7nKMjZmP2Eh
        M8jAXXfdOsWblLthjAoAp8SSYK44C7ZpNAJjpBN+Bw/bU4n1gyuwkywf+My7MqwH
        iScaRXLc96YQ8Xr3Y8+JBaGZMfoC3Y70xJMkIyi8kfOrfFpDxi49LMfJCrTV/8XS
        tL/xdK0ipR8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 75BAD6025C;
        Wed, 11 Jan 2017 16:48:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB3916025A;
        Wed, 11 Jan 2017 16:48:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCHv2 1/2] builtin/commit.c: drop use snprintf via dynamic allocation
References: <20170111071032.27797-1-gitter.spiros@gmail.com>
Date:   Wed, 11 Jan 2017 13:48:28 -0800
In-Reply-To: <20170111071032.27797-1-gitter.spiros@gmail.com> (Elia Pinto's
        message of "Wed, 11 Jan 2017 07:10:31 +0000")
Message-ID: <xmqqtw95mfo3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B08EB2A6-D847-11E6-AF32-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

> In general snprintf is bad because it may silently truncate results if we're
> wrong. In this patch where we use PATH_MAX, we'd want to handle larger
> paths anyway, so we switch to dynamic allocation.
>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> This is the second version of the patch.
>
> I have split the original commit in two, as discussed here
> http://public-inbox.org/git/20161213132717.42965-1-gitter.spiros@gmail.com/.

And both halves have the same title?

I think the the primary value of this one is that it removes the
PATH_MAX limitation from the environment setting that points to a
filename.  Reducing the number of snprintf() call is a side effect,
even though that may have been what motivated you originally.  The
original code used snprintf() correctly after all.

The primary value of 2/2 is reduction of the cognitive burden from
the programmers---switching to xstrfmt(), they no longer have to
count bytes needed for static allocation.  Reducing the number of
snprintf() call is a side effect, even though that may have been
what motivated you originally.  The original code used snprintf()
correctly after all.

The code looks correct in both patches (except that in 1/2 _clear()
immediately before exit() wouldn't have to be there, but it does not
hurt to have one either).  They need to be better explained.

Thanks.

>  builtin/commit.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 0ed634b26..09bcc0f13 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -960,15 +960,16 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		return 0;
>  
>  	if (use_editor) {
> -		char index[PATH_MAX];
> -		const char *env[2] = { NULL };
> -		env[0] =  index;
> -		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
> -		if (launch_editor(git_path_commit_editmsg(), NULL, env)) {
> +		struct argv_array env = ARGV_ARRAY_INIT;
> +
> +		argv_array_pushf(&env, "GIT_INDEX_FILE=%s", index_file);
> +		if (launch_editor(git_path_commit_editmsg(), NULL, env.argv)) {
>  			fprintf(stderr,
>  			_("Please supply the message using either -m or -F option.\n"));
> +			argv_array_clear(&env);
>  			exit(1);
>  		}
> +		argv_array_clear(&env);
>  	}
>  
>  	if (!no_verify &&
> @@ -1557,23 +1558,22 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
>  
>  int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...)
>  {
> -	const char *hook_env[3] =  { NULL };
> -	char index[PATH_MAX];
> +	struct argv_array hook_env = ARGV_ARRAY_INIT;
>  	va_list args;
>  	int ret;
>  
> -	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
> -	hook_env[0] = index;
> +	argv_array_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
>  
>  	/*
>  	 * Let the hook know that no editor will be launched.
>  	 */
>  	if (!editor_is_used)
> -		hook_env[1] = "GIT_EDITOR=:";
> +		argv_array_push(&hook_env, "GIT_EDITOR=:");
>  
>  	va_start(args, name);
> -	ret = run_hook_ve(hook_env, name, args);
> +	ret = run_hook_ve(hook_env.argv,name, args);
>  	va_end(args);
> +	argv_array_clear(&hook_env);
>  
>  	return ret;
>  }
