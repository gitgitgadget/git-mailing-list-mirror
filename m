Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 379BE1FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 19:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933335AbdCJTeq (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 14:34:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51356 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932789AbdCJTeo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 14:34:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DC2D68EC4;
        Fri, 10 Mar 2017 14:34:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kFmoocmdwt+ZZZxv828nqHWY/6M=; b=SHzjOp
        araL4SmZqsGeefIlHPJ6J2uZ+1tvpw6Z7ClB2L3KX/9gG0NPFnEZcYawWpOfI/AC
        JAt0Q+CE0FlA6L/tt5soQXJnuuqA8Ps7M4u2hfybFvtjBOTMb7WkMzR0Ea5pr0Ym
        jwt+vT6DTN3HWp/+6SYu0lDlYougcFvnSR7aE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YJanz51nmuSUUN4JDd9zYNNPANDaLCP/
        S3RiCjLFKWyaev+t7arJBvCLNCa0KVZxeA0vmCQcTQ209yXmYVF1jsEOKGCkxEgk
        8Z5hIu/kCuThp7szvH2RQSu1bpEPS3Ne1jINSz5XXA+/6eFKtSH2xGwBT08/wNy1
        jMaSZPyyey0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85D5068EC3;
        Fri, 10 Mar 2017 14:34:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 00E5768EC2;
        Fri, 10 Mar 2017 14:34:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v5 04/11] setup_git_directory_1(): avoid changing global state
References: <cover.1488897111.git.johannes.schindelin@gmx.de>
        <cover.1489098170.git.johannes.schindelin@gmx.de>
        <bafa0c8e7a760aa26add5e3f757062c230fbd6a9.1489098170.git.johannes.schindelin@gmx.de>
Date:   Fri, 10 Mar 2017 11:34:40 -0800
In-Reply-To: <bafa0c8e7a760aa26add5e3f757062c230fbd6a9.1489098170.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 9 Mar 2017 23:24:02 +0100
        (CET)")
Message-ID: <xmqq4lz1ylgv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B98665E-05C8-11E7-9836-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>  /*
>   * We cannot decide in this function whether we are in the work tree or
>   * not, since the config can only be read _after_ this function was called.
> + *
> + * Also, we avoid changing any global state (such as the current working
> + * directory) to allow early callers.
> + *
> + * The directory where the search should start needs to be passed in via the
> + * `dir` parameter; upon return, the `dir` buffer will contain the path of
> + * the directory where the search ended, and `gitdir` will contain the path of
> + * the discovered .git/ directory, if any. This path may be relative against
> + * `dir` (i.e. *not* necessarily the cwd).

I had to read the last sentence three times because my earlier two
attempts misread/misinterpreted as "this may be relative to cwd, but
not necessarily, because this may be relative to dir".  The correct
reading is "when this is relative, it is relative to dir.  It would
not be relative to cwd if you start with dir that is not cwd".

It would be nicer if all readers can get to that without re-reading
three times.

> -static const char *setup_git_directory_gently_1(int *nongit_ok)
> +static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
> ...
> @@ -889,63 +888,104 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
>  	 */
>  	one_filesystem = !git_env_bool("GIT_DISCOVERY_ACROSS_FILESYSTEM", 0);
>  	if (one_filesystem)
> -		current_device = get_device_or_die(".", NULL, 0);
> +		current_device = get_device_or_die(dir->buf, NULL, 0);
>  	for (;;) {
> -		gitfile = (char*)read_gitfile(DEFAULT_GIT_DIR_ENVIRONMENT);
> -		if (gitfile)
> -			gitdirenv = gitfile = xstrdup(gitfile);
> -		else {
> -			if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
> -				gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
> +		int offset = dir->len;
> +
> +		if (offset > min_offset)
> +			strbuf_addch(dir, '/');
> +		strbuf_addstr(dir, DEFAULT_GIT_DIR_ENVIRONMENT);
> +		gitdirenv = read_gitfile(dir->buf);
> +		if (!gitdirenv && is_git_directory(dir->buf))
> +			gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
> +		strbuf_setlen(dir, offset);
> +		if (gitdirenv) {
> +			strbuf_addstr(gitdir, gitdirenv);
> +			return GIT_DIR_DISCOVERED;
>  		}

I commented on this part more extensively in a later step of the
series after the read_gitfile() call is replaced with the non-dying
version.  I see that issues in corner cases are inherited from the
code even before this step.  

We'd either want to at least document the corner cases that are not
handled with /* NEEDSWORK: */ in-code comments , or address them in
a follow-up series before we forget.  They are not new problems, so
I am OK if we choose to leave them broken, as people haven't triggered
them in the current code.

Thanks.
