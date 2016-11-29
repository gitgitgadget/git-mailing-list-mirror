Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D72AB1FF6D
	for <e@80x24.org>; Tue, 29 Nov 2016 18:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755440AbcK2S5f (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 13:57:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58808 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755391AbcK2S5a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 13:57:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E535F52E93;
        Tue, 29 Nov 2016 13:57:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hf8ifGnmyaq+ZDTfWrhmvdIZ+9A=; b=LH4DCU
        6IeQ3/dEbJx6CMp3Z7B58PeAYJaXvsCWn4BEM5OYJlN0jx9Op4SCxSd0Hd/8+Imw
        GlnMc4yFXyTHdRUHZsH/EQFM0Zahd67fBV9iwJY+EM1fUzQmxT210qJdMuSu7c8R
        +ouwStm5ijUZ7PUN8gs9W6S5xFDwbXQ9zgS7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZdGL5ZLwvr6UnbV51DBwPJPQTLrBd4ye
        9yy4t3u9upzt7ZC1Fb0xk9Qe+7rf0KmDxCfvXKC3oTuD3Vwsqy+cMKKMBhlRbT2u
        yKus/AOYw/RnrGNY1jVEVeqHxz82cjLUdHqRnvSXehLoLutoRKwEgCNgm+4dZv/4
        lrqSyFmLk6Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DBC1052E92;
        Tue, 29 Nov 2016 13:57:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4DD9852E91;
        Tue, 29 Nov 2016 13:57:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Git ML <git@vger.kernel.org>, Dun Peal <dunpealer@gmail.com>
Subject: Re: [PATCH 1/2] mergetool: honor mergetool.$tool.trustExitCode for built-in tools
References: <20161129093807.24637-1-davvid@gmail.com>
Date:   Tue, 29 Nov 2016 10:57:26 -0800
In-Reply-To: <20161129093807.24637-1-davvid@gmail.com> (David Aguilar's
        message of "Tue, 29 Nov 2016 01:38:07 -0800")
Message-ID: <xmqq37iaglm1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC7FC460-B665-11E6-9312-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> Built-in merge tools contain a hard-coded assumption about
> whether or not a tool's exit code can be trusted to determine
> the success or failure of a merge.  Tools whose exit codes are
> not trusted contain calls to check_unchanged() in their
> merge_cmd() functions.
>
> A problem with this is that the trustExitCode configuration is
> not honored for built-in tools.
>
> Teach built-in tools to honor the trustExitCode configuration.
> Extend run_merge_cmd() so that it is responsible for calling
> check_unchanged() when a tool's exit code cannot be trusted.
> Remove check_unchanged() calls from scriptlets since they are no
> longer responsible for calling it.
>
> When no configuration is present, exit_code_trustable() is
> checked to see whether the exit code should be trusted.
> The default implementation returns false.
>
> Tools whose exit codes can be trusted override
> exit_code_trustable() to true.
>
> Reported-by: Dun Peal <dunpealer@gmail.com>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  git-mergetool--lib.sh    | 56 ++++++++++++++++++++++++++++++++++++++----------
>  mergetools/araxis        |  2 --
>  mergetools/bc            |  2 --
>  mergetools/codecompare   |  2 --
>  mergetools/deltawalker   |  6 +++++-
>  mergetools/diffmerge     |  4 ++++
>  mergetools/diffuse       |  2 --
>  mergetools/ecmerge       |  2 --
>  mergetools/emerge        |  4 ++++
>  mergetools/examdiff      |  2 --
>  mergetools/kdiff3        |  4 ++++
>  mergetools/kompare       |  4 ++++
>  mergetools/meld          |  3 +--
>  mergetools/opendiff      |  2 --
>  mergetools/p4merge       |  2 --
>  mergetools/tkdiff        |  4 ++++
>  mergetools/tortoisemerge |  2 --
>  mergetools/vimdiff       |  2 --
>  mergetools/winmerge      |  2 --
>  mergetools/xxdiff        |  2 --
>  20 files changed, 71 insertions(+), 38 deletions(-)


OK, so the idea is that the backends that used to touch $BACKUP and
used to call check_unchanged stop doing these two things, while
other backends override exit_code_trustable().  That makes the
change to the backends very straightforward to understand.

>  # Run a either a configured or built-in merge tool
>  run_merge_cmd () {
> -	merge_cmd "$1"
> +	mergetool_trust_exit_code=$(trust_exit_code "$1")
> +	if test "$mergetool_trust_exit_code" = "true"
> +	then
> +		merge_cmd "$1"
> +	else
> +		touch "$BACKUP"
> +		merge_cmd "$1"
> +		check_unchanged
> +	fi
>  }

Looks sensible.  Thanks.  Will queue.
