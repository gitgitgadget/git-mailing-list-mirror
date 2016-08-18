Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC5BC203E2
	for <e@80x24.org>; Fri, 19 Aug 2016 01:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754664AbcHSBFE (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 21:05:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62404 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754385AbcHSBEv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 21:04:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E837733FD9;
        Thu, 18 Aug 2016 14:46:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b+tOj+btlyRceuPw8F1Q1Cdftoo=; b=uwnstm
        w+SMNYxfzW8TQUcwbgwiVc3VXPQk9Gmx8l0zP/4srAxBh/tCWrYX7sPsF3/vqomW
        /Nnxs27CNTNJWOHw4vIyjwEpWkHopQn9OhXisj5nHETvrVyncijBsJfzswMsCUJT
        by6wtsn8jMDSjqoPFTgrbySl1D8Xjl7VBVKWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k4WDg/jNSiezMlMcuZQhePdke0e1/uAh
        24KpTb06Y2J7yj12C7ZPw/iA3dJQ/s0JzosKgkK9MyocnfpxIa3g2uXTMrNdqYy1
        avmj+zDcfW5zDGsB7uG9FhWIdC8o5s9WerfhxsY6lC1Jf5qneGcsz2/dFGyvbzre
        hn7b3SvnKuc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC40033FD7;
        Thu, 18 Aug 2016 14:46:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 56BAE33FD5;
        Thu, 18 Aug 2016 14:46:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v7 4/7] submodule: allow do_submodule_path to work if given gitdir directly
References: <20160818005131.31600-1-jacob.e.keller@intel.com>
        <20160818005131.31600-5-jacob.e.keller@intel.com>
Date:   Thu, 18 Aug 2016 11:46:37 -0700
In-Reply-To: <20160818005131.31600-5-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Wed, 17 Aug 2016 17:51:28 -0700")
Message-ID: <xmqq37m17w4y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 192C79D4-6574-11E6-9A72-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> Currently, do_submodule_path relies on read_gitfile, which will die() if
> it can't read from the specified gitfile. Unfortunately, this means that
> do_submodule_path will not work when given the path to a submodule which
> is checked out directly, such as a newly added submodule which you
> cloned and then "git submodule add". 

Hmm, are you sure about that?

A call to read_gitfile() turns into a call to read_gitfile_gently()
with the return_error_code parameter set to NULL.  The function does
a stat(2), and if the given path is not a file (e.g. we created the
submodule working tree and repository in-place ourselves, instead of
cloning an existing project from elsewhere, in which case we would
see a directory there), it says READ_GIT_FILE_ERR_NOT_A_FILE and
returns NULL, because that is not a fatal error condition.  The same
thing happens if path does not yet exist.

This caller is given <path>, prepares "<path>/.git" in buf, and
calls read_gitfile().  If it returns a non-NULL, it replaces what is
in buf and continues, but if it returns a NULL (i.e. the two cases I
mentioned in the above paragraph), it continues with "<path>/.git".

While I do not think changing it to resolve_gitdir() is wrong per-se,
I am not sure if it is necessary.

I must be misreading something in the existing code.

> Instead, replace the call with
> resolve_gitdir. This first checks to see if we've been given a gitdir
> already.
>
> Because resolve_gitdir may return the same buffer it was passed, we have
> to check for this case as well, since strbuf_reset() will not work as
> expected here, and indeed is not necessary.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  path.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/path.c b/path.c
> index 17551c483476..d1af029152a2 100644
> --- a/path.c
> +++ b/path.c
> @@ -477,8 +477,8 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
>  	strbuf_complete(buf, '/');
>  	strbuf_addstr(buf, ".git");
>  
> -	git_dir = read_gitfile(buf->buf);
> -	if (git_dir) {
> +	git_dir = resolve_gitdir(buf->buf);
> +	if (git_dir && git_dir != buf->buf) {
>  		strbuf_reset(buf);
>  		strbuf_addstr(buf, git_dir);
>  	}
