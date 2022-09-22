Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7B0ECAAD8
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 21:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiIVVTu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 17:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIVVTs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 17:19:48 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E113FA0A
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 14:19:45 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5A3A134245;
        Thu, 22 Sep 2022 17:19:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=exvsTXYhjN6CzSO7mxTq9Aj2DtDeITnQEERFa2
        lVvjI=; b=j2N9M6CfOgBpJ4eCWpk0g8EHunbxu1znZAJBo/CK5NCPAN4ySb7Czd
        T18eg1WkAfdeDz9kxDaqPK/tdC4iYHsEVQAk1wWRyaU8kP2KsCIY33YTAjAxpmmM
        Y7QpHmYKs9uehv9jldtnfLq6Az3ry2gLiONKJqNM/FU9Rtted1EKA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD407134244;
        Thu, 22 Sep 2022 17:19:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2EB39134243;
        Thu, 22 Sep 2022 17:19:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        mjcheetham@outlook.com,
        Matthew John Cheetham <mjcheetham@github.com>
Subject: Re: [PATCH 1/3] wincred: ignore unknown lines (do not die)
References: <pull.1363.git.1663865974.gitgitgadget@gmail.com>
        <6426f9c3954866b3fd9259d1a58d2c41dc42e17f.1663865974.git.gitgitgadget@gmail.com>
Date:   Thu, 22 Sep 2022 14:19:43 -0700
In-Reply-To: <6426f9c3954866b3fd9259d1a58d2c41dc42e17f.1663865974.git.gitgitgadget@gmail.com>
        (Matthew John Cheetham via GitGitGadget's message of "Thu, 22 Sep 2022
        16:59:32 +0000")
Message-ID: <xmqqbkr7xg28.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4741DADE-3ABC-11ED-9201-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Matthew John Cheetham <mjcheetham@outlook.com>
>
> It is the expectation that credential helpers be liberal in what they
> accept and conservative in what they return, to allow for future growth
> and evolution of the protocol/interaction.

That is nice in principle, and the updated code below may work well
with existing "other side of the connection" (codepaths in "git"
that asks credential API to talk to the helpers), but I am not sure
if this is always a safe thing to do.

When we gain a new "command" in the protocol, if we just read it
without understanding it, would we open ourselves to a risk of
breaking the protocol communication, worst of which may be to
deadlock?  A new command, when received by a more recent helper that
understands how to react to it, may _require_ it to write more than
"username" and "password" back to "git" from get_credential(), for
example, but the helper with this patch alone, while not complaining
about seeing such a new and unknown command, would not know how to
compute and write that third thing other than "username" and
"password"---would the other side who issued that new command get
stuck waiting for us to return the third thing?  Worse yet, the new
command may expect us to read further in get_credential()
(e.g. maybe they will give us a challenge, which may need to be used
when yielding the "username" and "password" things), but because we
do not even know we need to read, their attempt to write to us may
get them stuck, and that is when we are expecting to write to them,
easily leading to a deadlock, no?

> All of the other helpers (store, cache, osxkeychain, libsecret,
> gnome-keyring) except `netrc` currently ignore any credential lines
> that are not recognised, whereas the Windows helper (wincred) instead
> dies.

Is that different from saying "everybody other than netrc and win
ignore unknown"?

> Fix the discrepancy and ignore unknown lines in the wincred helper.

OK.  As long as everybody consistently ignores, and possibly opens
themselves up consistently to a protocol mismatch issue, it is OK.
We will know if that can be a real problem or does not happen in
practice.

> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
> ---
>  contrib/credential/wincred/git-credential-wincred.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
> index 5091048f9c6..ead6e267c78 100644
> --- a/contrib/credential/wincred/git-credential-wincred.c
> +++ b/contrib/credential/wincred/git-credential-wincred.c
> @@ -278,8 +278,11 @@ static void read_credential(void)
>  			wusername = utf8_to_utf16_dup(v);
>  		} else if (!strcmp(buf, "password"))
>  			password = utf8_to_utf16_dup(v);
> -		else
> -			die("unrecognized input");
> +		/*
> +		 * Ignore other lines; we don't know what they mean, but
> +		 * this future-proofs us when later versions of git do
> +		 * learn new lines, and the helpers are updated to match.
> +		 */
>  	}
>  }
