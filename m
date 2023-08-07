Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E80C001DB
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 18:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjHGSzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 14:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjHGSzi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 14:55:38 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A7A172A
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 11:55:36 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 448C723940;
        Mon,  7 Aug 2023 14:55:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f4vwbbKKBeGdk3juNX9u6U8CRtqcGWiuBWbAle
        xyIY0=; b=iR2Z9VR34fKSXzcjx9eC8cOW4o3JptgC6qOFWyRS1Y8QK+7NTB3wyx
        49tj+QWY1lyZl4g/hPTF2oRo096C+YtRnRXFqK9gDG+kpyAMY8fUyE6LknTz37sf
        HSMD4A8BR5Lu2c/gGqZMiop2WFFonslKVphEgkZ07iotUN5KtFZ3A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3DD292393F;
        Mon,  7 Aug 2023 14:55:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 64E072393E;
        Mon,  7 Aug 2023 14:55:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3] send-email: prompt-dependent exit codes
References: <xmqqttx1l3zp.fsf@gitster.g>
        <20230807165850.2335067-1-oswald.buddenhagen@gmx.de>
Date:   Mon, 07 Aug 2023 11:55:29 -0700
In-Reply-To: <20230807165850.2335067-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Mon, 7 Aug 2023 18:58:50 +0200")
Message-ID: <xmqqbkfifzry.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FAF98148-3553-11EE-9316-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> From the perspective of a scripted caller, failure to send (some) mails
> is an error even if it was interactively requested, so it should be
> indicated by the exit code.

I am not sure if unconditional change of exit code this late in the
game.  When was the interactive "no, do not send this one" feature
introduced?  The end-users (not necessarily all of them, of course)
have been happily using the command and have appreciated not having
to see non-zero exit code after skipping some messages.  I wonder if
this should be hidden behind an opt-in command line option and possibly
a configuration variable that defaults to "no".

> To make it somewhat specific, the exit code is 10 when only some mails
> were skipped, and 11 if the user quit on the first prompt.

If 10 and 11 were *not* taken out of thin air, but there is a
precedent to use these two values in e-mail related programs, please
share.  It may give us a good justification.

With or without other people's precedents, and with or without
making it conditional, the new behaviour must be documented, if the
command has already a documentation (and it seems that there exists
the Documentation/git-send-email.txt file).  It may be preferrable
to protect the new feature with a test or two added to t9001 but it
obviously depends on how hard you find testing interactive stuff is.

> For interactive calls from the command line, interactive cancellation is
> arguably not really an error, but there the exit code will be more or
> less ignored anyway.

Not necessarily.  Some people prefer to see it and show it in their
command line prompt.

> diff --git a/git-send-email.perl b/git-send-email.perl
> index affbb88509..cd4db84b7f 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -256,6 +256,26 @@ sub system_or_die {
>  	die $msg if $msg;
>  }
>  
> +my $sent_files = 0;
> +
> +sub do_exit {
> +	if ($sent_files == @files) {
> +		# All specified messages were sent
> +		exit(0);
> +	} elsif ($sent_files) {
> +		# At least some messages were sent
> +		exit(10);
> +	} else {
> +		# User cancelled on first message already
> +		exit(11);
> +	}
> +}

OK.  As log as we won't start doing 

	while (loop) {
		$file = shift @files;
		send $file;
	}

this will keep working fine, and the logic is very clear to see.

Thanks.  Will queue but expect at least some documentation updates.


