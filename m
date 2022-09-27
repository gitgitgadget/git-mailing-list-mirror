Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4AEC32771
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 01:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiI0Bj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 21:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiI0Bjw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 21:39:52 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044A317E0C
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 18:39:49 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1DC941CF417;
        Mon, 26 Sep 2022 21:39:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YUpi2Hl4n+FlnNYX8rGihGjUO4UUdI4u0dgsu1
        98d1o=; b=Vm19jboBOgHi5D7yg/veECq3D642VVnq6HSdoF0XHFLEcreZg3/sNw
        5hFtZu6lt4lTo8oiJpT8aEBBiLpcR9Ol4elryhP0JqimP3Xd2OESz4QmAunLX79g
        niBrS6S1iOZJmK7JO+DRo+5y8DfDS3dpf1+PwL3e0BGX79KY7/C5s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 163711CF416;
        Mon, 26 Sep 2022 21:39:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BDB4B1CF415;
        Mon, 26 Sep 2022 21:39:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] tmp-objdir: do not opendir() when handling a signal
References: <pull.1348.git.git.1664236383785.gitgitgadget@gmail.com>
Date:   Mon, 26 Sep 2022 18:39:44 -0700
In-Reply-To: <pull.1348.git.git.1664236383785.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Mon, 26 Sep 2022 23:53:03 +0000")
Message-ID: <xmqqill9a93z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 442D2EB0-3E05-11ED-86E6-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     tmp-objdir: do not closedir() when handling a signal
>     
>     We have recently observed a Git process hanging around for weeks. A
>     backtrace revealed that a git-receive-pack(1) process was deadlocked
>     when trying to remove the quarantine directory "incoming." It turns out
>     that the tmp_objdir API calls opendir(3) and closedir(3) to observe a
>     directory's contents in order to remove all the contents before removing
>     the directory itself. These functions are not async signal save as they
>     allocate and free memory.
>     
>     The fix is to avoid calling these functions when handling a signal in
>     order to avoid a deadlock. The implication of such a fix however, is
>     that temporary object directories may not get cleaned up properly when a
>     signal is being handled. The tradeoff this fix is making is to prevent
>     deadlocks at the cost of temporary object directory cleanup.
>     
>     This is similar to 58d4d7f1c5 (2022-01-07 fetch: fix deadlock when
>     cleaning up lockfiles in async signals)

Hmph, is it really similar?  That one, even though the lockfiles
won't be cleaned up inside signal handler, they will eventually be
cleaned, won't they?  As opposed to here, once we punt, we punt and
do not revisit when we re-raise and eventually exit, no?

Leaving temporary directories behind is MUCH MUCH better than
getting stuck in a deadlock, so it is much better than the status
quo, of course.

>  static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
>  {
> -	DIR *dir;
> +	DIR *dir = NULL;
>  	struct dirent *e;
>  	int ret = 0, original_len = path->len, len, kept_down = 0;
>  	int only_empty = (flag & REMOVE_DIR_EMPTY_ONLY);
> @@ -3261,7 +3261,10 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
>  	}
>  
>  	flag &= ~REMOVE_DIR_KEEP_TOPLEVEL;
> -	dir = opendir(path->buf);
> +
> +	if ((flag & REMOVE_DIR_SIGNAL) == 0)
> +		dir = opendir(path->buf);
> +
>  	if (!dir) {
>  		if (errno == ENOENT)
>  			return keep_toplevel ? -1 : 0;
> diff --git a/dir.h b/dir.h
> index 674747d93af..ba159f4abeb 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -498,6 +498,9 @@ int get_sparse_checkout_patterns(struct pattern_list *pl);
>  /* Remove the_original_cwd too */
>  #define REMOVE_DIR_PURGE_ORIGINAL_CWD 0x08
>  
> +/* Indicates a signal is being handled */
> +#define REMOVE_DIR_SIGNAL 0x16
> +
>  /*
>   * Remove path and its contents, recursively. flags is a combination
>   * of the above REMOVE_DIR_* constants. Return 0 on success.
> diff --git a/tmp-objdir.c b/tmp-objdir.c

The fix looks quite straight-forward.

Thanks for spotting and working on this issue.

