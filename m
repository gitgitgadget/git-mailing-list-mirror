Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB5DC433E3
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 21:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88CB61962
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 21:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhCUV6r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 17:58:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55908 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhCUV6S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 17:58:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 47873C5875;
        Sun, 21 Mar 2021 17:58:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IDB/IpI8TqQIzdPRg+5xraYc97c=; b=Ex6s1j
        +PDA/7McE7BiqFD3H9e1vQKcQL3dA3rGTM3/ESr1VOtRziQ6vZfKtQjWt3nzIyhX
        8RqTEwKzOaJYuqXPLXVH/fAUO2WZi9sdUnfV6oy1i2Glt9p13nHq0PkDClVbdeNY
        Fs/3grcoqAUyCFyaZVaTOqCFCEOUAitxqJyuw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K1mikVaaYEU095W1kuF327Ep80An4gBX
        2s82JC3EZYXWjGRxSVihAD077Jm/IIO1k7uxiA6URfwjMuY6iqmrB09T1GMD6c33
        0exhMBk/KE1K3uOq/wwaGlynd5S+dHPT0pAboFMB5N8HxiFXE9edC7zol9IuKMo6
        lv+q2hjWXmw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FB1DC5874;
        Sun, 21 Mar 2021 17:58:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE38BC5873;
        Sun, 21 Mar 2021 17:58:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Madhu <enometh@meer.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] init: don't reset core.filemode on git-new-workdirs.
References: <20210321.175821.1385189088303987287.enometh@meer.net>
Date:   Sun, 21 Mar 2021 14:58:16 -0700
In-Reply-To: <20210321.175821.1385189088303987287.enometh@meer.net> (Madhu's
        message of "Sun, 21 Mar 2021 17:58:21 +0530 (IST)")
Message-ID: <xmqq1rc89nk7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A77D3A4-8A90-11EB-980F-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Madhu <enometh@meer.net> writes:

> From: Madhu <enometh@net.meer>
>
> If the .git/config file is a symlink (as is the case of a .git created
> by the contrib/workdir/git-new-workdir script) then the filemode tests
> fail, and the filemode is reset to be false.  To avoid this only munge
> core.filemode if .git/config is a regular file.

Hmph, what's the sequence of events?  You let "git new-workdir" to
create a cheap copy of a working tree and then?  When new-workdir
returns, you already have a functional working tree with .git/
directory (in which there are many symbolic links).  So who wants or
needs to run "git init" there in the directory in the first place?

Is the problem being solved that running an unnecessary "git init"
in an already initialized repository does an unnecessary filemode
check?

If that is the case, I am not sure if asking "is it a symlink?" to
avoid the filemode trustability check is a good approach.  At that
point in the code you are patching, we have already determined if we
are running the "git init" in an already initialized repository
(i.e. "reinit"), so shouldn't we be basing the decision on it
instead?

I see that in a later part of the same function, we test if the
filesystem supports symbolic links but do so only when we are
running "git init" afresh.  Perhaps the filemode trustability check
and the config-set to record core.filemode should all be moved there
inside the "if (!reinit)" block.

All of the above assumes that the problem being solved is about what
happens when "git init" is run in an already functioning working
tree.  If I misread what problem you are trying to solve, then none
of what I suggested in the above may apply.

> ---
>  builtin/init-db.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Missing sign-off; please review Documentation/SubmittingPatches


> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index dcc45bef51..b053107336 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -285,7 +285,8 @@ static int create_default_files(const char *template_path,
>  	/* Check filemode trustability */
>  	path = git_path_buf(&buf, "config");
>  	filemode = TEST_FILEMODE;
> -	if (TEST_FILEMODE && !lstat(path, &st1)) {
> +	if (TEST_FILEMODE && !lstat(path, &st1)
> +	    && (st1.st_mode & S_IFMT) == S_IFREG) {
>  		struct stat st2;
>  		filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
>  				!lstat(path, &st2) &&
