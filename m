Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40440C433DB
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 22:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D51822838
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 22:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgL0Wbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 17:31:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64255 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgL0Wbu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 17:31:50 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF8DAA9525;
        Sun, 27 Dec 2020 17:31:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=m9YHSk/w59N2Wo+J79MBUpX50RQ=; b=fxVE8N1jIV33UnIJORVJ
        HbeZezNuYKcSsBv6x4PzamgB6L7vWWrmN71Jw0e4zFYEM+XFmPLDmNq2hChxpavy
        g8yy8sJnHHMg5YcmH7b8KfHMk9xtgiG66/sJh221NCuolxUP0sSKWT5KSEL1Gmdl
        9At0uS0QfD5HOA0lrmYWGR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=FhE9egBNn9yertQMEcQwCR6fBhEP63CX7nDNZwbeUqJhq9
        cSmYuiSa4pdgr/88SENGMXVknWFvlw7zVqiJd4/zQVuEuzr/BTn2d0t56cFd+OnD
        /a5kNd6zgsdjdIb/KL0b5z0P/4uSTb9B+U8C1iKlMqdRuDtat1qpujmtXfwl8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B4D6A9524;
        Sun, 27 Dec 2020 17:31:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8CBFFA9523;
        Sun, 27 Dec 2020 17:31:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 2/2] mergetool: Add per-tool support for the
 autoMerge flag
References: <20201223045358.100754-1-felipe.contreras@gmail.com>
        <20201227205835.502556-1-seth@eseth.com>
        <20201227205835.502556-3-seth@eseth.com>
Date:   Sun, 27 Dec 2020 14:31:03 -0800
Message-ID: <xmqqsg7qop94.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34AB75D2-4893-11EB-B469-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House <seth@eseth.com> writes:

> Keep the global mergetool flag and add a per-tool override flag so that
> users may enable the flag for one tool and disable it for another.
>
> Signed-off-by: Seth House <seth@eseth.com>
> ---
>  Documentation/config/mergetool.txt | 3 +++
>  git-mergetool.sh                   | 5 ++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
> index 43af7a96f9..7f32281a61 100644
> --- a/Documentation/config/mergetool.txt
> +++ b/Documentation/config/mergetool.txt
> @@ -21,6 +21,9 @@ mergetool.<tool>.trustExitCode::
>  	if the file has been updated, otherwise the user is prompted to
>  	indicate the success of the merge.
>  
> +mergetool.<tool>.autoMerge::
> +	Automatically resolve conflicts that don't require user intervention.
> +
>  mergetool.meld.hasOutput::
>  	Older versions of `meld` do not support the `--output` option.
>  	Git will attempt to detect whether `meld` supports `--output`
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 6e86d3b492..81df301734 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -323,7 +323,10 @@ merge_file () {
>  	checkout_staged_file 2 "$MERGED" "$LOCAL"
>  	checkout_staged_file 3 "$MERGED" "$REMOTE"
>  
> -	if test "$(git config --bool mergetool.autoMerge)" = "true"
> +	if test "$(
> +		git config --get --bool "mergetool.$merge_tool.automerge" ||
> +		git config --get --bool "mergetool.automerge" ||
> +		echo true)" = true

Your [v6 1/2] that you build this step on does not enable the
feature by default, but this step does; it deserves to be documented
and mentioned in the proposed log message.

But I think you'd want to build this step on top of newer one, if
only to take the portability fix to the tests, and that patch
enables the feature by default, so ...

>  	then
>  		git merge-file --diff3 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"
>  		sed -e '/^<<<<<<< /,/^||||||| /d' -e '/^=======\r\?$/,/^>>>>>>> /d' "$DIFF3" >"$BASE"

Thanks.
