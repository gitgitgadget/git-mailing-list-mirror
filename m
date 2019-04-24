Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 263261F453
	for <e@80x24.org>; Wed, 24 Apr 2019 02:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfDXC2E (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 22:28:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57564 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfDXC2E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 22:28:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FCFF13F03D;
        Tue, 23 Apr 2019 22:28:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+3G/F+Cgjgtl/tjwqy+mi0TjTUY=; b=txpOEw
        XYztFtdBwVcBrrkEHJ5PSWtvqgAewTnbCTisCoUoT4OtZIePYuChhpLRduPnoJPO
        gpAPlDy1BKWJZ9Ano/US9lBE6DnIsBo/mzhidM7ET05WIDeyEOL2TVTD5295VYHX
        2tnXUZUBj3iHe8QTqqWGzx+biV4PFKGW7z1/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cn6OXjJobNbauhtXylWKA5yG9FJtd5r9
        Ow/1p46MFrTsi19ppNmkZlLQFy++Ju5fOBwuplbhh17vFHqXHPPbIufHrrSUGwGP
        JaHb+HTqYTUHFkok+2uz0JHrR8NruzqhkdU69wQMllupmCm2vW06ZYe2TR4bXuCF
        UJqNbIuE/Jo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA4BB13F03C;
        Tue, 23 Apr 2019 22:28:01 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3BD8B13F03B;
        Tue, 23 Apr 2019 22:28:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] run-command: add preliminary support for multiple hooks
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
        <20190424004948.728326-2-sandals@crustytoothpaste.net>
Date:   Wed, 24 Apr 2019 11:27:59 +0900
In-Reply-To: <20190424004948.728326-2-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 24 Apr 2019 00:49:44 +0000")
Message-ID: <xmqqo94w2l3k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 943D1A58-6638-11E9-A49C-DF19F34BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index f17537474a..e7cf6b16ba 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -666,6 +666,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  	struct strbuf sb = STRBUF_INIT;
>  	const char *hook_arg1 = NULL;
>  	const char *hook_arg2 = NULL;
> +	struct string_list *hooks;
>  	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
>  	int old_display_comment_prefix;
>  
> @@ -943,13 +944,15 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		return 0;
>  	}
>  
> -	if (!no_verify && find_hook("pre-commit")) {
> +	hooks = find_hooks("pre-commit");
> +	if (!no_verify && hooks) {
>  		/*
>  		 * Re-read the index as pre-commit hook could have updated it,
>  		 * and write it out as a tree.  We must do this before we invoke
>  		 * the editor and after we invoke run_status above.
>  		 */
>  		discard_cache();
> +		free_hooks(hooks);
>  	}
>  	read_cache_from(index_file);

OK, so find_hook() that used to return a single hook now can return
a list of hook scripts.  Running the single one becomes a simple
special case of "run each of them in turn, and stop at the first
failure".

> diff --git a/run-command.c b/run-command.c
> index 3449db319b..669af5ebc7 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1308,58 +1308,137 @@ int async_with_fork(void)
>  #endif
>  }
>  
> +static int has_hook(struct strbuf *path, int strip)
> +{
> +	if (access(path->buf, X_OK) < 0) {

Does ".git/post-commit" that is not an executable exist?

It was perfectly fine for find_hook() to say "there is no hook for
post-commit" in the old world in such a case, because the
unexecutable file it found is not going to be run anyway.

But it is not clear if has_hook(), that affects "there is no single
hook file for post-commit, so let's look at post-commit.d" decision
made by find_hooks(), should behave that way.  It somehow feels more
intuitive if a post-commit file that is not executable, by merely
existing, stops post-commit.d directory from being scanned, at least
to me.

>  int run_hook_ve(const char *const *env, const char *name, va_list args)
>  {
> -	struct child_process hook = CHILD_PROCESS_INIT;
> +	struct string_list *hooks;
> +	struct string_list arglist = STRING_LIST_INIT_NODUP;
>  	const char *p;
> +	struct string_list_item *q;
> +	int ret = 0;
>   ...
> +		hook.env = env;
> +		hook.no_stdin = 1;
> +		hook.stdout_to_stderr = 1;
> +		hook.trace2_hook_name = name;
> +
> +		ret = run_command(&hook);
> +		if (ret)
> +			break;
> +	}
> +	string_list_clear(&arglist, 0);
> +	free_hooks(hooks);
> +	return ret;
>  }

These "run with command line arguments as its sole input, with the
exit status as its sole output" style hooks are easily handled and
the above looks like reasonable enhancement to the existing
abstraction (e.g. run 'prepare-commit-msg' hook with these
arguments).

I however wonder how the hooks in the other style should/can be
handled, that are fed data from their standard input stream, and
returns more than one bit via their standard output stream.  In
any case, they are not in the scope of this step.

