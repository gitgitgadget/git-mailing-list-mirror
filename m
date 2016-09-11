Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F2121FCA9
	for <e@80x24.org>; Sun, 11 Sep 2016 23:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754788AbcIKXiN (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 19:38:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63191 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753130AbcIKXiM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 19:38:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 713DD3ECEC;
        Sun, 11 Sep 2016 19:38:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EKN/+dDjSgn2HkZr8iN8G6d2GjY=; b=Tkpl26
        ipGedp+1HcC+mpeBP5d8j27cEyPZ++JXogA/+LuwTbLN99sQgUW1MGCO9dg0aAUl
        q/lJxTO5asocUit+jdcC1hWd6rCFK95bMpGx0B7aDYtm0ltxGX6N9TAys6MRStMz
        Zxak/MCbRiQKL0d9Z8MrFJsrktKHmvXF58ww4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Bj4BucjVkkk5uPtTr1okf4r6Ysam+4yV
        Jnnq/DPUXxVmg9Pcm6e9Tz0YXLFetx5EwsNRUWHWKzpZLfH9Cwq1bwjHsYlkWbDT
        Qz6p3a1mJCx+TzHjLMwpNuxmE1Oh8CMIMgPrROfGVJt1QUDVoYMG4XNIvqQqfZrU
        kiH7fRr+qXE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A0843ECEB;
        Sun, 11 Sep 2016 19:38:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DBDF33ECEA;
        Sun, 11 Sep 2016 19:38:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 21/25] sequencer: refactor write_message()
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <cover.1473590966.git.johannes.schindelin@gmx.de>
        <da2293aee439da2274e30304e2d1f097b9644e64.1473590966.git.johannes.schindelin@gmx.de>
Date:   Sun, 11 Sep 2016 16:38:09 -0700
In-Reply-To: <da2293aee439da2274e30304e2d1f097b9644e64.1473590966.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Sun, 11 Sep 2016 12:55:48 +0200
        (CEST)")
Message-ID: <xmqqwpii57oe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CCDBE480-7878-11E6-8EB4-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The write_message() function safely writes an strbuf to a file.
> Sometimes it is inconvenient to require an strbuf, though: the text to
> be written may not be stored in a strbuf, or the strbuf should not be
> released after writing.
>
> Let's refactor "safely writing string to a file" into
> write_with_lock_file(), and make write_message() use it. The new
> function makes it easy to create new convenience function
> write_file_gently(); as some of the upcoming callers of this new
> function would want to append a newline character, add a flag for it in
> write_file_gently(), and thus in write_with_lock_file().

Makes sense.  As an abstraction, "give me strbuf for my sole use,
and I'll trash its contents when I am done" feels like a horrible
helper interface; perhaps that was overly aggressively refactored by
noticing that then-current callers all released the strbuf, but
still feels wrong.

And this makes the underlying helper a lot more useful.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 5e5d113..aa949d4 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -242,22 +242,37 @@ static void print_advice(int show_hint, struct replay_opts *opts)
>  	}
>  }
>  
> -static int write_message(struct strbuf *msgbuf, const char *filename)
> +static int write_with_lock_file(const char *filename,
> +				const void *buf, size_t len, int append_eol)
>  {
>  	static struct lock_file msg_file;
>  
>  	int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0);
>  	if (msg_fd < 0)
>  		return error_errno(_("Could not lock '%s'"), filename);
> -	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
> -		return error_errno(_("Could not write to %s"), filename);
> -	strbuf_release(msgbuf);
> +	if (write_in_full(msg_fd, buf, len) < 0)
> +		return error_errno(_("Could not write to '%s'"), filename);
> +	if (append_eol && write(msg_fd, "\n", 1) < 0)
> +		return error_errno(_("Could not write eol to '%s"), filename);
>  	if (commit_lock_file(&msg_file) < 0)
>  		return error(_("Error wrapping up %s."), filename);
>  
>  	return 0;
>  }
>  
> +static int write_message(struct strbuf *msgbuf, const char *filename)
> +{
> +	int res = write_with_lock_file(filename, msgbuf->buf, msgbuf->len, 0);
> +	strbuf_release(msgbuf);
> +	return res;
> +}
> +
> +static int write_file_gently(const char *filename,
> +			     const char *text, int append_eol)
> +{
> +	return write_with_lock_file(filename, text, strlen(text), append_eol);
> +}
> +
>  /*
>   * Reads a file that was presumably written by a shell script, i.e.
>   * with an end-of-line marker that needs to be stripped.
