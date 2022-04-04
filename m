Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F28C3527D
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 21:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380249AbiDDVVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379288AbiDDQzW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 12:55:22 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DF53B032
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 09:53:25 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 068BB1160D5;
        Mon,  4 Apr 2022 12:53:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q6zB29sQJ1GdH/mH0oZGpNKXrdX2y72brb9PPO
        kokbA=; b=XStiWnNBSpjKLoahtbSvOy9pcEaD1nm8VltKgDlL3alPsFTz+zFdRb
        +vYhQmT2aBTZM3TyJHoSsxfsRWbusB6nKg2HP02NA0bOCVChxtbkrNAqacGv0pto
        HLfelikLvbIakOxvxq+8VgyqIK84SLPxMIW4DD+Ah5nW/HHOZljIY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F24E81160D4;
        Mon,  4 Apr 2022 12:53:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 512DB1160CF;
        Mon,  4 Apr 2022 12:53:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, prohaska@zib.de, eyvind.bernhardsen@gmail.com
Subject: Re: [PATCH] convert: clarify line ending conversion warning
References: <20220404055151.160184-1-alexhenrie24@gmail.com>
Date:   Mon, 04 Apr 2022 09:53:23 -0700
In-Reply-To: <20220404055151.160184-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Sun, 3 Apr 2022 23:51:51 -0600")
Message-ID: <xmqqtub8rdrw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDE301C4-B437-11EC-B845-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Rephrase the warning to be clear that line endings have not been changed
> in the working directory but will be changed on the next checkout, and
> explicitly say which line endings the file currently has in the working
> directory.
>
> Example commands to trigger the warning on Linux:
>
> git config core.autocrlf true
> echo 'Hello world!' > hello.txt
> git add hello.txt
> git commit -m "Add hello.txt"

While the "example" does not hurt, because the log message is not
executable, it would not help to its potential unless you add its
expected output to go with it.

    On a platform whose native line endings are not CRLF
    (e.g. Linux), the "git add" step in the sequence triggers the
    waring in question.

    $ git config core.autocrlf true
    $ echo 'Hello world!' >hello.txt
    $ git add hello.txt
    warning: LF will be replaced by CRLF in hello.txt
    The file will have its original line endings in your working directory

or something like that.

I think the recent trend is to enclose end-user supplied strings
(like misspelt option names, arguments to options, and pathnames)
inside single quote, so

    warning: LF will be replaced by CRLF in 'hello.txt'.

would probably be a good idea, on top of what you are aiming for.
Also, in a multi-sentence warning message like this, I do not think
it makes sense to omit the end-of-sentence full-stop.

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
> diff --git a/convert.c b/convert.c
> index 8e39731efb..b024d74222 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -195,9 +195,10 @@ static void check_global_conv_flags_eol(const char *path,
>  		if (conv_flags & CONV_EOL_RNDTRP_DIE)
>  			die(_("CRLF would be replaced by LF in %s"), path);
>  		else if (conv_flags & CONV_EOL_RNDTRP_WARN)
> -			warning(_("CRLF will be replaced by LF in %s.\n"
> -				  "The file will have its original line"
> -				  " endings in your working directory"), path);
> +			warning(_("CRLF will be replaced by LF in %s the next"
> +				  " time you check it out.\n"
> +				  "For now, the file still has CRLF line"
> +				  " endings in your working directory."), path);

I have mixed feelings with this change, even though I agree that the
original is not good.  The first sentence of the updated text
already says that right now, the file ends with CRLF, and that the
conversion happen the next time you check out the file to the
working tree.  And that makes "For now ... still" totally redundant.

Perhaps a single sentence, nothing more than

	warning: in '%s', CRLF will be replaced by LF the next time
	you check it out

is sufficient?  I dunno.

Thanks.
