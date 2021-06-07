Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6237CC4743C
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 05:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49E4E6121F
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 05:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhFGFy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 01:54:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55316 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGFy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 01:54:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DC4ACF5A4;
        Mon,  7 Jun 2021 01:52:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tM+0iTE9C5qUfswYnW2FkT9NNyhTCNgihhcRuj
        ayiEY=; b=AHsrdqIwVd0NOTwSnC1s2VR9Oka/JxP1kxQ0mmb8kES0hlzBtgBzGe
        nVizKQTh+Xe7hRpZjkxpk0hgcvuLuwri0nkYU+koIaGvGCNT2epF8Mngrc5Q/aKd
        MqIx7HnPXSghN2E0iYulC91UB29nqdUkEGEqRg2GaHBFhUPoCb63A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 14C68CF5A3;
        Mon,  7 Jun 2021 01:52:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8CF3FCF5A2;
        Mon,  7 Jun 2021 01:52:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 4/6] [GSOC] ref-filter: add %(rest) atom and --rest option
References: <pull.972.git.1622884415.gitgitgadget@gmail.com>
        <ccdd18ad508824aa206a02c479229d0ede69522d.1622884415.git.gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 14:52:33 +0900
In-Reply-To: <ccdd18ad508824aa206a02c479229d0ede69522d.1622884415.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Sat, 05 Jun 2021 09:13:32
        +0000")
Message-ID: <xmqq7dj6w7a6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E7269E6-C754-11EB-923F-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> In order to let "cat-file --batch=%(rest)" use the ref-filter
> interface, add %(rest) atom for ref-filter and --rest option
> for "git for-each-ref", "git branch", "git tag" and "git verify-tag".
> `--rest` specify a string to replace %(rest) placeholders of
> the --format option.

I cannot think of a sane reason why we need to allow "%(rest)" in
anithing but "cat-file --batch", where a natural source of %(rest)
exists in its input stream (i.e. each input record begins with an
object name to be processed, and the rest of the record can become
"%(rest)").

The "cat-file --batch" thing is much more understandable.  You could
for example:

    git ls-files -s |
    sed -e 's/^[0-7]* \([0-9a-f]*\) [0-3]	/\1 /' |
    git cat-file --batch='%(objectname) %(objecttype) %(rest)'

to massage output from "ls-files -s" like this

    100644 c2f5fe385af1bbc161f6c010bdcf0048ab6671ed 0	.cirrus.yml
    100644 c592dda681fecfaa6bf64fb3f539eafaf4123ed8 0	.clang-format
    100644 f9d819623d832113014dd5d5366e8ee44ac9666a 0	.editorconfig
    ...

into recods of "<objectname> <path>", and each output record will
replay the <path> part from each corresponding input record.

Unless for-each-ref family of commands read the list of refs that it
shows from their standard input (they do not, and I do not think it
makes any sense to teach them to), there is no place to feed the
"rest" information that is associated with each output record.  The
only thing the commands taught about %(rest) by this patch can do is
to parrot the same string into each and every output record.  I am
not seeing what this new feature is attempting to give us.

If anything, I would imagine that it would be a very useful addition
to teach the ref-filter machinery an ability to optionally error out
depending on the caller when the caller attempts to use certain
placeholder.  Then, we can reject "git branch --sort=rest" sensibly,
instead of accepting "git branch --sort=rest --rest=constant", which
is not technically wrong per-se, but smells like a total nonsense from
practical usefulness's point of view.

> -	[--list] [<pattern>...]
> +	[--list] [<pattern>...] [--rest=<rest>]
>  'git branch' [--track | --no-track] [-f] <branchname> [<start-point>]
>  'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
>  'git branch' --unset-upstream [<branchname>]
> @@ -298,6 +298,10 @@ start-point is either a local or remote-tracking branch.
>  	and the object it points at.  The format is the same as
>  	that of linkgit:git-for-each-ref[1].
>  
> +--rest=<rest>::
> +	If given, the `%(rest)` placeholders in the `--format` option
> +	will be replaced.

If not given, what happens?
