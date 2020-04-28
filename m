Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2F3C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 19:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B4D220731
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 19:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KPYbh7br"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgD1TfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:35:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55391 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbgD1TfW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 15:35:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 31996CF546;
        Tue, 28 Apr 2020 15:35:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+5lMFYkcSMmL2nqeZEX1CPpYdF4=; b=KPYbh7
        brciPicRf7h/aJjIY/w5981jiVrhUUBUp+R9C2lrsBYJx21/A3m2oN1emGocquGr
        mmO18OhEI7i++FID+2LRiQ7xhN+MyWFRTInf15/Rb1qTT5ykeBnWg/Wvf5TqT452
        zPrqGD/3EYwivL24dMTYKcUYipGyXX6rqlppg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Wt9Oabr45NyZnW3Vwvv+KhnKcU4PAL5N
        D0KM4mWEBJpd6iDopLq95c5Y8mnJQ8XYS+SXYElRFsp2GNdPuSKDDAIDICuZWUXX
        SBhh0Jpe00hRUdjhbb1e0JG1pnx3r3bKBE426CNh0RhGRaMR5opWuNGcJIwcDsmz
        lfrJVE3H3ZY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 28F05CF545;
        Tue, 28 Apr 2020 15:35:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 68CE2CF544;
        Tue, 28 Apr 2020 15:35:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] rebase: save autostash entry into stash reflog on --quit
References: <353a67567a90aea8a90bce1de05d005c61b3b670.1588066252.git.liu.denton@gmail.com>
Date:   Tue, 28 Apr 2020 12:35:15 -0700
In-Reply-To: <353a67567a90aea8a90bce1de05d005c61b3b670.1588066252.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 28 Apr 2020 05:31:31 -0400")
Message-ID: <xmqqv9lj1k0c.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63B2554C-8987-11EA-8C86-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In a03b55530a (merge: teach --autostash option, 2020-04-07), the
> --autostash option was introduced for `git merge`. Notably, when
> `git merge --quit` is run with an autostash entry present, it is saved
> into the stash reflog. This is contrasted with the current behaviour of
> `git rebase --quit` where the autostash entry is simply just dropped out
> of existence.
>
> Adopt the behaviour of `git merge --quit` in `git rebase --quit` and
> save the autostash entry into the stash reflog instead of just deleting
> it.

The goal is wrothy, I would think, but I do not think we would
explain it in terms of "stash reflog".  It is true that what "stash
list" shows, the list of stasn entries, happens to be implemented as
reflog entries of a single ref, but the end users would not view
them as reflog entries, I suspect.  Do you know anybody who would do
"git reflog stash@{now}"?

It is less bad to explain with "reflog of stash ref" in the log
message, meant to be read by our future developers, but ...


> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index f7a6033607..7d0c89a184 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -256,7 +256,8 @@ See also INCOMPATIBLE OPTIONS below.
>  --quit::
>  	Abort the rebase operation but HEAD is not reset back to the
>  	original branch. The index and working tree are also left
> -	unchanged as a result.
> +	unchanged as a result. If a temporary stash entry was created
> +	using --autostash, it will be saved to the stash reflog.

... let's not do so for end-user facing documentation.  "..., it
will be stashed away".  Or we may not even want to say anything; any
"--autostash" user would expect that the changes that were stashed
before "rebase" started would not be discarded, and this change may
just be a bugfix.

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index bc4fc69906..71aec532b1 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1556,6 +1556,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		goto cleanup;
>  	}
>  	case ACTION_QUIT: {
> +		save_autostash(state_dir_path("autostash", &options));
>  		if (options.type == REBASE_MERGE) {
>  			struct replay_opts replay = REPLAY_OPTS_INIT;

Nice to see a fix as simple a this one ;-)
