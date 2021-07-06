Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B48C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 15:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF5426101C
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 15:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhGFPrD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 11:47:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60077 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhGFPrC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 11:47:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EE937132C46;
        Tue,  6 Jul 2021 11:44:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dEZtgMiVP8FXTo/00qPdgOo6KzPBxtQGvMyRgx
        qMIWY=; b=FtoQJpAfFn3Oc2nfx7bFttFbyqnQEoBBVFKCqwJ0h9IbGoGZv8rBO7
        5l4zK+dBd07luLHC2eqKmCBd+ihhPN3U9bETlX7TrcrQ0biSBDdZbpYZvO46hLec
        XitWt5OfiUfTQ/JOC54p71fVx21L+SIyACPOofKsNs9OrHmwiPxhA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E4CC3132C45;
        Tue,  6 Jul 2021 11:44:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 699FF132C42;
        Tue,  6 Jul 2021 11:44:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hu Jialun <hujialun@comp.nus.edu.sg>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] commit: remove irrelavent prompt on
 `--allow-empty-message`
References: <20210706022438.580374-1-hujialun@comp.nus.edu.sg>
Date:   Tue, 06 Jul 2021 08:44:19 -0700
In-Reply-To: <20210706022438.580374-1-hujialun@comp.nus.edu.sg> (Hu Jialun's
        message of "Tue, 6 Jul 2021 10:24:38 +0800")
Message-ID: <xmqqlf6jla5o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08284CA0-DE71-11EB-BB07-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hu Jialun <hujialun@comp.nus.edu.sg> writes:

> Currently, COMMIT_EDITMSG contains "...and an empty message aborts the
> commit", regardless of whether the --allow-empty-message option is
> specified or not. This is deemed confusing and unintended.

I have to wonder what reason a user have to use that option, other
than wanting to record a commit without any message.  In other words,
wouldn't it be a bug for this command 

    $ git commit --allow-empty-message

to open an editor to allow editing the message, instead of just
committing with an empty message?  If we fix that, then the user
wouldn't have to see "edit this file in your editor. making it empty
will abort the commit" message in the first place, so all the
message changes do not have to be done.

If we still want to open an editor when --allow-empty-message is
given, then I would say the "making it empty will abort" part of the
message is *not* "confusing and unintended".  It is a confused and
wrong message.

The resulting code looks correct, even though it is somewhat too
repetitious.  The existing code may want to see a preliminary
clean-up patch (PATCH 1/2) to move these messages to a set of
variables, so that the fix (PATCH 2/2) can swap the contents of
these variables based on the value of allow_empty_message, if it
makes the resulting code easier to follow (I haven't tried it, so
please tell me if that improved the code or not after trying to do
so ;-)).

As to the proposed log message, let's not start it with "Currently",
and spell out the approach to fix the issue explicitly, perhaps like.

    Even when the `--allow-empty-message` option is given, "git
    commit" offers an interactive editor session with prefilled
    message that says the commit will be aborted if the buffer is
    emptied, which is wrong.

    Remove the "an empty message aborts" part from the message when
    the option is given to fix it.

Thanks.


> Signed-off-by: Hu Jialun <hujialun@comp.nus.edu.sg>
> ---
>  builtin/commit.c | 41 ++++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 190d215d43..61e3382db9 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -910,21 +910,36 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		}
>  
>  		fprintf(s->fp, "\n");
> -		if (cleanup_mode == COMMIT_MSG_CLEANUP_ALL)
> -			status_printf(s, GIT_COLOR_NORMAL,
> -				_("Please enter the commit message for your changes."
> -				  " Lines starting\nwith '%c' will be ignored, and an empty"
> -				  " message aborts the commit.\n"), comment_line_char);
> -		else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
> +		if (cleanup_mode == COMMIT_MSG_CLEANUP_ALL) {
> +			if (allow_empty_message) {
> +				status_printf(s, GIT_COLOR_NORMAL,
> +					_("Please enter the commit message for your changes."
> +					" Lines starting\nwith '%c' will be ignored.\n"), comment_line_char);
> +			} else {
> +				status_printf(s, GIT_COLOR_NORMAL,
> +					_("Please enter the commit message for your changes."
> +					" Lines starting\nwith '%c' will be ignored, and an empty"
> +					" message aborts the commit.\n"), comment_line_char);
> +			}
> +		} else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
>  			if (whence == FROM_COMMIT && !merge_contains_scissors)
>  				wt_status_add_cut_line(s->fp);
> -		} else /* COMMIT_MSG_CLEANUP_SPACE, that is. */
> -			status_printf(s, GIT_COLOR_NORMAL,
> -				_("Please enter the commit message for your changes."
> -				  " Lines starting\n"
> -				  "with '%c' will be kept; you may remove them"
> -				  " yourself if you want to.\n"
> -				  "An empty message aborts the commit.\n"), comment_line_char);
> +		} else { /* COMMIT_MSG_CLEANUP_SPACE, that is. */
> +			if (allow_empty_message) {
> +				status_printf(s, GIT_COLOR_NORMAL,
> +					_("Please enter the commit message for your changes."
> +					" Lines starting\n"
> +					"with '%c' will be kept; you may remove them"
> +					" yourself if you want to.\n"), comment_line_char);
> +			} else {
> +				status_printf(s, GIT_COLOR_NORMAL,
> +					_("Please enter the commit message for your changes."
> +					" Lines starting\n"
> +					"with '%c' will be kept; you may remove them"
> +					" yourself if you want to.\n"
> +					"An empty message aborts the commit.\n"), comment_line_char);
> +			}
> +		}
>  
>  		/*
>  		 * These should never fail because they come from our own
