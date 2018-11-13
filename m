Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF5571F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 02:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbeKMMHz (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 07:07:55 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63360 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeKMMHz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 07:07:55 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 685EA3775E;
        Mon, 12 Nov 2018 21:12:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/NytQyPXgmUi/1oqh0h4TaZks5A=; b=eVWLVx
        S6oVV0TT9rtjT2Hx+hYnSW+4/JH2bqu8J1ZgHnTpWVMlX3rk1tjl2YCOGH+/yUUe
        3KE4d/NZL7QUeVy7/ZcmfFdlgQrF/W+AYd8tgqvy29QotOV3oaW6bb8hSfut62sZ
        sUhyST2MMp52cDInj8g1HnlZunr0I2Kmeoj2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pCQQrnUqZRKRYyZUwIlLyActWwowi5q0
        8EXKyPUblDGbUnRsB2++jPwGEs9fRg9Wn2i0TveZgu1QRbgnQ9SnkQuCG9vUb12h
        GJwbGbWVVOKjWo1SDqrKY7ivtC2BV0KaAHS4p6J+q+6MfP5xR76s9L8hHTsDdNAK
        z1j1EOTxf6U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 604383775D;
        Mon, 12 Nov 2018 21:12:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7209D3775A;
        Mon, 12 Nov 2018 21:11:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/5] built-in rebase --skip/--abort: clean up stale .git/<name> files
References: <pull.75.git.gitgitgadget@gmail.com>
        <8d1dec51b704c45bf36af24f657cc40f006989e2.1542065154.git.gitgitgadget@gmail.com>
Date:   Tue, 13 Nov 2018 11:11:55 +0900
In-Reply-To: <8d1dec51b704c45bf36af24f657cc40f006989e2.1542065154.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 12 Nov 2018
        15:26:01 -0800 (PST)")
Message-ID: <xmqqlg5xybdg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F731A74-E6E9-11E8-A7D5-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The scripted version of the rebase used to execute `git reset --hard`
> when skipping or aborting. When we ported this to C, we did update the
> worktree and some reflogs, but we failed to imitate `git reset --hard`'s
> behavior regarding files in .git/ such as MERGE_HEAD.
>
> Let's address this oversight.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/rebase.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 0ee06aa363..017dce1b50 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -23,6 +23,7 @@
>  #include "revision.h"
>  #include "commit-reach.h"
>  #include "rerere.h"
> +#include "branch.h"
>  
>  static char const * const builtin_rebase_usage[] = {
>  	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
> @@ -1002,6 +1003,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  
>  		if (reset_head(NULL, "reset", NULL, 0, NULL, NULL) < 0)
>  			die(_("could not discard worktree changes"));
> +		remove_branch_state();
>  		if (read_basic_state(&options))
>  			exit(1);
>  		goto run_rebase;
> @@ -1019,6 +1021,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			       options.head_name, 0, NULL, NULL) < 0)
>  			die(_("could not move back to %s"),
>  			    oid_to_hex(&options.orig_head));
> +		remove_branch_state();

Hmph.  Among 5 or so callsites of reset_head(), only these two
places need it, so reset_head() is clearly not a substitute for
"reset --hard HEAD", and it sometimes used to switch branches or
something?  Perhaps we may need to rename it to avoid confusion but
it can wait until we actually decide to make it externally
available.  Until then, it's OK as-is, I would think.

>  		ret = finish_rebase(&options);
>  		goto cleanup;
>  	}
