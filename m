Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FE251FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 18:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933056AbdCJS65 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 13:58:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54490 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932683AbdCJS6z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 13:58:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AA95684F0;
        Fri, 10 Mar 2017 13:58:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kwfFx61TQdCm6EE+/zE0xzr6ixw=; b=ZqVKzS
        fFLzXtQbjSr4/SIBtg27V4rb3Hxgbvh1I2/zrJos35LyYBNg5mUSs0cdi24PHe86
        lzOjBUyhRqhrA6VY9I0ygjsNLAlxsDiD4oamrMqYM8jPB14LWF959HvNNnDSHur9
        OOg36JlnyXHIUoMUxFJUlxmFIvdE+PV27y0yY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c5V7IRn3696s+jBEoEDjH7+qIdMzwCEU
        fPJXpThNTMEi4q14QlLiepcwXOeKdL/ySa6jWd568hMOyrcVR/y2PN1FyxLDiHGZ
        hGaBuJKrPE3ztfygDPLXIoeNgm/rJeSg2BbogNiYNZDsBbUYezgHLiD2YW/ORUht
        PyQcZt/CY5w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34014684EE;
        Fri, 10 Mar 2017 13:58:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D45C684ED;
        Fri, 10 Mar 2017 13:58:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v5 10/11] setup_git_directory_gently_1(): avoid die()ing
References: <cover.1488897111.git.johannes.schindelin@gmx.de>
        <cover.1489098170.git.johannes.schindelin@gmx.de>
        <a1e24f1b31773f4d2f7f06ab7d5870e920211d51.1489098170.git.johannes.schindelin@gmx.de>
Date:   Fri, 10 Mar 2017 10:58:51 -0800
In-Reply-To: <a1e24f1b31773f4d2f7f06ab7d5870e920211d51.1489098170.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 9 Mar 2017 23:25:28 +0100
        (CET)")
Message-ID: <xmqqefy5yn4k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A66BCA4-05C3-11E7-ADC3-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> @@ -890,14 +892,22 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>  	if (one_filesystem)
>  		current_device = get_device_or_die(dir->buf, NULL, 0);
>  	for (;;) {
> -		int offset = dir->len;
> +		int offset = dir->len, error_code = 0;
>  
>  		if (offset > min_offset)
>  			strbuf_addch(dir, '/');
>  		strbuf_addstr(dir, DEFAULT_GIT_DIR_ENVIRONMENT);
> -		gitdirenv = read_gitfile(dir->buf);
> -		if (!gitdirenv && is_git_directory(dir->buf))
> -			gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
> +		gitdirenv = read_gitfile_gently(dir->buf, die_on_error ?
> +						NULL : &error_code);
> +		if (!gitdirenv) {

We tried to read ".git" as a regular file, but couldn't.  There are
some cases but I am having trouble to convince myself all cases are
covered correctly here, so let me follow the code aloud.

> +			if (die_on_error ||
> +			    error_code == READ_GITFILE_ERR_NOT_A_FILE) {
> +				if (is_git_directory(dir->buf))
> +					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;

If we are told to die on error, but if it is a Git directory, then
we do not have to (and want to) die and instead report that
directory as discovered.

If we are to report the failure status instead of dying, we also do
want to recover when the read_gitfile_gentrly() failed only because
it was a real Git directory.  READ_GITFILE_ERR_NOT_A_FILE could be a
signal for that, and we recover after making sure it is a Git
directory.

Among the READ_GITFILE_ERR_* codes, ERR_NOT_A_FILE is the only one
we attempt this recovery.  All others just take the "else if" thing
below.

What happens when is_git_directory() test here does not pass,
though?  Let's say stat() in read_gitfile_gently() found a FIFO
there, it gives us ERR_NOT_A_FILE, is_git_directory() would say
"Nah", and then ...?  Don't we want the other side for this if()
statement that returns failure?

> +			} else if (error_code &&
> +				   error_code != READ_GITFILE_ERR_STAT_FAILED)
> +				return GIT_DIR_INVALID_GITFILE;
> +		}

On the other hand, if read_gitfile_gently() didn't say "we found
something that is not a regular file" we come here.  If the error
came because there wasn't ".git" in the directory we are looking at,
i.e. stat(2) in read_gitfile_gently() gave ENOENT, it is perfectly
normal and we just want to go one level up.

But shouldn't read_gitfile_gently() be inspecting errno when it sees
a stat() failure?  If there _is_ ".git" but we failed to stat it for
whatever reason (EACCES, ELOOP,...), we do not want to go up but
give the INVALID_GITFILE from here, just like other cases, no?
For that I imagine that ERR_STAT_FAILED needs to be split into two,
one for true ERR_STAT_FAILED (from which we cannot recover) and the
other for ERR_ENOENT to signal us that there is nothing there (which
allows us to go up).

By the way, is the "error_code &&" needed?  Unless the original path
given to read_gitfile_gently() is a NULL pointer, the only time its
return value is NULL is when it has non-zero error_code.


>  		strbuf_setlen(dir, offset);
>  		if (gitdirenv) {
>  			strbuf_addstr(gitdir, gitdirenv);
> @@ -934,7 +944,7 @@ const char *discover_git_directory(struct strbuf *gitdir)
>  		return NULL;
>  
>  	cwd_len = dir.len;
> -	if (setup_git_directory_gently_1(&dir, gitdir) <= 0) {
> +	if (setup_git_directory_gently_1(&dir, gitdir, 0) <= 0) {
>  		strbuf_release(&dir);
>  		return NULL;
>  	}
> @@ -994,7 +1004,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  		die_errno(_("Unable to read current working directory"));
>  	strbuf_addbuf(&dir, &cwd);
>  
> -	switch (setup_git_directory_gently_1(&dir, &gitdir)) {
> +	switch (setup_git_directory_gently_1(&dir, &gitdir, 1)) {
>  	case GIT_DIR_NONE:
>  		prefix = NULL;
>  		break;
