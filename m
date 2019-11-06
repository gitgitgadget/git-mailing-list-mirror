Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3DCC1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 05:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbfKFFMV (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 00:12:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58553 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfKFFMV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 00:12:21 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 307FD25368;
        Wed,  6 Nov 2019 00:12:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4vKq6oZX9Y8KU0dCVnygCKYPtVo=; b=F662IS
        WitFPMWXeNXrfUtcSMBG282HFVstOaMs5UzkHIIxGvNthM9Z0prE4KANncyuY9qg
        ACO6qFueqpp/JFsZV6Cut0oE8bfw31cPGCF9snxysGk8PCr4NHsATk5MU9eMr5Wh
        0iv8m1cCMgalYHYlDflw1R2T+sZkdbOg8xFYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=anD1nEbeJHaUQkh5BIHl6EP2mE4DYNKy
        jER+9zGmA7SW4XOViikDDBzQzQBkK2L9BP0QSRCh7d98CEEeOVwUW+Yp0nnV3aTa
        vjWElRFEVDS9+s/9Z40T0YZyBLg1hdwCvqygCTvdcW9w4QpsZTjlcy7otIEY/n4F
        p8dKzDity2A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2849425367;
        Wed,  6 Nov 2019 00:12:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8AC7625366;
        Wed,  6 Nov 2019 00:12:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/8] reflog-walk.c: don't print last newline with oneline
References: <cover.1572897736.git.liu.denton@gmail.com>
        <449c58009ae46d43ec2bd0499674c9858b706d04.1572897736.git.liu.denton@gmail.com>
Date:   Wed, 06 Nov 2019 14:12:17 +0900
In-Reply-To: <449c58009ae46d43ec2bd0499674c9858b706d04.1572897736.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 4 Nov 2019 15:04:01 -0500")
Message-ID: <xmqqwocdtwpa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 013706A4-0054-11EA-BF33-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Subject: Re: [PATCH 6/8] reflog-walk.c: don't print last newline with oneline

Please find a better phrasing that does not mislead the readers to
think "eek, so now output from 'git log -g --oneline' does not get
LF terminated?"

I think you are just changing the place where the LF is given from
the callee that shows a single record (and then used to show LF
after the record) to the caller that calls the callee (and now it
shows LF after the call returns), in order to preserve the output,
but with the given proposed log message, it is not clear if that is
what you meant to do (I can read from the code what _is_ going on,
but the log is to record what you _wanted_ to do, which can be
different).

> @@ -661,8 +661,10 @@ void show_log(struct rev_info *opt)

In the pre-context before this line there is a guard to ensure that
we do this only when showing an entry from the reflog, so the effect
of this hunk is "when showing from reflog in --oneline format, show
LF after showing a single record" ...

>  					    opt->commit_format == CMIT_FMT_ONELINE,
>  					    &opt->date_mode,
>  					    opt->date_mode_explicit);
> -			if (opt->commit_format == CMIT_FMT_ONELINE)
> +			if (opt->commit_format == CMIT_FMT_ONELINE) {
> +				putc('\n', opt->diffopt.file);
>  				return;
> +			}
>  		}
>  	}
>  
> diff --git a/reflog-walk.c b/reflog-walk.c
> index 3a25b27d8f..e2b4c0b290 100644
> --- a/reflog-walk.c
> +++ b/reflog-walk.c
> @@ -285,7 +285,11 @@ void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
>  		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
>  		get_reflog_selector(&selector, reflog_info, dmode, force_date, 0);
>  		if (oneline) {
> -			printf("%s: %s", selector.buf, info->message);
> +			struct strbuf message = STRBUF_INIT;
> +			strbuf_addstr(&message, info->message);
> +			strbuf_trim_trailing_newline(&message);
> +			printf("%s: %s", selector.buf, message.buf);
> +			strbuf_release(&message);

... and this one is what gets called from the above caller; we lost
the final LF (if there is) from the output, that is compensated by
the caller.

How well do we work with the "-z" output format, by the way, with
the hardcoded '\n' on the output codepath?

Making a new allocation feels inefficient just to omit the trailing
newlines.  I wonder if a helper function that takes a "const char *"
and returns a "const char *" in that string that points at the CRLF
or LF or NUL at its end would be warranted.  If we do not care about
CRLF, this part would become something like...

	if (oneline) {
		const char *endp = strchrnul(info->message, '\n');
		printf("%s: %.*s", selector.buf,
			(int)(endp - info->message), info->message);
	}

but I didn't trace the code/data flow to see where info->message
comes from well enough to tell if we need to worry about CRLF.  I
thought reflogs are always written with LF termination, though.

Thanks.
