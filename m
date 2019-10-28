Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D0DC1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 02:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbfJ1CDc (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 22:03:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61984 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbfJ1CDc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Oct 2019 22:03:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB9E526DED;
        Sun, 27 Oct 2019 22:03:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S0EuqOO58z7BeuMg5UCWwWlmyZo=; b=wNYlSe
        r1QMXp2I916JUK4FqwFR6LH6gMmUF1t7uu4YJaSdgx15sSX3VEFp+aTNIzFwmwC0
        T2uO3bbf5FuDMW2i3FSrgy2qwZh78NtonyEghMNLsdUyPwGTquIcGtrssbijDHx6
        adcBfPn5ThcvYQu2xAatmbDanYbRp19ROo0vo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I6yaTB21WBPE1P3UrxkR6qhOAKMYxplD
        nFH49dL48rnU4FUshbM67pva3ZmF2heGes0Ighpkytg7IWMRtOisbjzzWxWjIsba
        8hoH0wOnchkIFWgduyaHvSSED8CO7bDAUfF5N0IIJScEflKenr9AB0MNP2Wv6Uva
        5kGPoCotZho=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C459526DEC;
        Sun, 27 Oct 2019 22:03:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 343FA26DEB;
        Sun, 27 Oct 2019 22:03:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "qusielle via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] add: respect `--ignore-errors` when `lstat()` reports errors
References: <pull.432.git.1572127149.gitgitgadget@gmail.com>
        <fd022f88f54f6cf0feb61965b2dc47bca64c0937.1572127149.git.gitgitgadget@gmail.com>
Date:   Mon, 28 Oct 2019 11:03:28 +0900
In-Reply-To: <fd022f88f54f6cf0feb61965b2dc47bca64c0937.1572127149.git.gitgitgadget@gmail.com>
        (qusielle via GitGitGadget's message of "Sat, 26 Oct 2019 21:59:09
        +0000")
Message-ID: <xmqq36fdbp8v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22AC8284-F927-11E9-A6FF-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"qusielle via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: qusielle <31454380+qusielle@users.noreply.github.com>
>
> "git add --ignore-errors" command fails immediately when lstat returns
> an error, despite the ignore errors' flag is enabled.
> ...
> diff --git a/read-cache.c b/read-cache.c
> index 133f790fa4..67237ecd29 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -801,7 +801,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
>  int add_file_to_index(struct index_state *istate, const char *path, int flags)
>  {
>  	struct stat st;
> -	if (lstat(path, &st))
> +	if (lstat(path, &st) && !(flags & ADD_CACHE_IGNORE_ERRORS))
>  		die_errno(_("unable to stat '%s'"), path);
>  	return add_to_index(istate, path, &st, flags);
>  }

The only callers of this function that matter calls it and then
responds to an error return like so:

(in builtin/add.c::update_callback())

	if (add_file_to_index(&the_index, path,	data->flags)) {
		if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
			die(_("updating files failed"));


(in builtin/add.c::add_files(), where ignore_add_errors was used to
set the ADD_CACHE_IGNORE_ERRORS to flags in its caller)

	if (add_file_to_index(&the_index, dir->entries[i]->name, flags)) {
		if (!ignore_add_errors)
			die(_("adding files failed"));

So you correctly identified what is the right place to fix.  We
should not "die_errno()"; we should give the control back to the
caller instead.

But after a failed stat, the code with your patch still calls
add_to_index() using the now undefined stat data, which would
contaminate the in-core index with wrong data.  

I think we should instead return without touching the index for the
path we had trouble lstat()ing.

IOW

	if (lstat(path, &st)) {
		if (flags & ADD_CACHE_IGNORE_ERRORS)
			return -1;
		else
			die_errno(_("unable to ..."));
	}
	return add_to_index(...);

