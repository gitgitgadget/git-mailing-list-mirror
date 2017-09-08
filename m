Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22BF11FAD6
	for <e@80x24.org>; Fri,  8 Sep 2017 19:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756812AbdIHTBl (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 15:01:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64323 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756303AbdIHTBk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 15:01:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E4D0A16A4;
        Fri,  8 Sep 2017 15:01:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xQxCC4zkUGG8UgQBSj36vaFd6M8=; b=yHwZIE
        SDXKY7DuQVVhvREjU9AUVvsm1BWtzHzvHKmN+5S5nVDtKW+YqBIMykonMOSSEPq0
        HPETPR+PnREpJKP2o+OOJ9qbJk/1pQrBgTJYthIgbWuoWWuaDXvDgHO1sspj6nIC
        QPSyfgWFYjsGA/z2NWiKqzFaTCCYJeYnanUss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sFUaujVyvEEYYGsmwQWZ+tPd795c86wq
        5J/FbhlkGcSCTPygupSraEeGAcwf4ELsftK/49W0xTqi5K/GUHalbbipLH4JeZcz
        aOj8u6ugUiQexOsPk/BDK6qI/6qxCoc9iT+CdNZ8HJh/+YIj35wzkain0x5pZ/LV
        LcOMV6/yIPY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05C5FA16A3;
        Fri,  8 Sep 2017 15:01:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6A216A16A0;
        Fri,  8 Sep 2017 15:01:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     git@vger.kernel.org, peff@peff.net, pclouds@gmail.com
Subject: Re: [PATCH 1/1] reset: fix reset when using the sparse-checkout feature.
References: <20170908180050.25188-1-kewillf@microsoft.com>
        <20170908180050.25188-2-kewillf@microsoft.com>
Date:   Sat, 09 Sep 2017 04:01:37 +0900
In-Reply-To: <20170908180050.25188-2-kewillf@microsoft.com> (Kevin Willford's
        message of "Fri, 8 Sep 2017 12:00:50 -0600")
Message-ID: <xmqq4lsdypym.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 247B12C6-94C8-11E7-8FF3-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Willford <kewillf@microsoft.com> writes:

> diff --git a/builtin/reset.c b/builtin/reset.c
> index d72c7d1c96..1b8bb45989 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -24,6 +24,7 @@
>  #include "cache-tree.h"
>  #include "submodule.h"
>  #include "submodule-config.h"
> +#include "dir.h"
>  
>  static const char * const git_reset_usage[] = {
>  	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
> @@ -124,8 +125,32 @@ static void update_index_from_diff(struct diff_queue_struct *q,
>  
>  	for (i = 0; i < q->nr; i++) {
>  		struct diff_filespec *one = q->queue[i]->one;
> +		struct diff_filespec *two = q->queue[i]->two;
> +		int pos;
>  		int is_missing = !(one->mode && !is_null_oid(&one->oid));
> +		int was_missing = !two->mode && is_null_oid(&two->oid);
>  		struct cache_entry *ce;
> +		struct cache_entry *ceBefore;
> +		struct checkout state = CHECKOUT_INIT;

The five new variables are only used in the new block, so it
probably is better to limit their scope to the "we do something
unusual when sparse checkout is in effect" block as well.  The scope
for the latter two can further be narrowed down to "we do need to
force a checkout of this entry" block.

We prefer to name our variables with underscore (e.g. ce_before)
over camelCase (e.g. ceBefore) unless there is a compelling reason
(e.g. a platform specific code in compat/ layer to match platform
convention).

> +
> +		if (core_apply_sparse_checkout && !file_exists(two->path)) {
> +			pos = cache_name_pos(two->path, strlen(two->path));
> +			if ((pos >= 0 && ce_skip_worktree(active_cache[pos])) &&
> +			    (is_missing || !was_missing))
> +			{
> +				state.force = 1;
> +				state.refresh_cache = 1;
> +				state.istate = &the_index;
> +				ceBefore = make_cache_entry(two->mode,
> +							    two->oid.hash,
> +							    two->path, 0, 0);
> +				if (!ceBefore)
> +					die(_("make_cache_entry failed for path '%s'"),
> +						two->path);
> +
> +				checkout_entry(ceBefore, &state, NULL);
> +			}
> +		}

Can we tell between the case where the reason why the path was not
there in the working tree was due to the path being excluded by the
sparse checkout and the path being removed manually by the end user?

I guess ce_skip_worktree() check is sufficient; we force checkout only
when the path is marked to be skipped due to "sparse" thing.

Do we have to worry about the reverse case, in which file_exists(two->path)
is true (i.e. the user created a file there manually) even though
the path is marked to be skipped due to "sparse" setting?

Other than that, the patch looks quite cleanly done and well explained.

Thanks.

> diff --git a/t/t7114-reset-sparse-checkout.sh b/t/t7114-reset-sparse-checkout.sh
> new file mode 100755
> index 0000000000..f2a5426847
> --- /dev/null
> +++ b/t/t7114-reset-sparse-checkout.sh
> @@ -0,0 +1,60 @@
> +#!/bin/sh
> +
> +test_description='reset when using a sparse-checkout'
> +
> +. ./test-lib.sh
> +
> +# reset using a sparse-checkout file
> +
> +test_expect_success 'setup' '
> +	test_tick &&
> +	echo "checkout file" >c &&
> +	echo "modify file" >m &&
> +	echo "delete file" >d &&
> +	git add . &&
> +	git commit -m "initial commit" &&
> +	echo "added file" >a &&
> +	echo "modification of a file" >m &&
> +	git rm d &&
> +	git add . &&
> +	git commit -m "second commit" &&
> +	git checkout -b endCommit
> +'
> +
> +test_expect_success 'reset when there is a sparse-checkout' '
> +	echo "/c" >.git/info/sparse-checkout &&
> +	test_config core.sparsecheckout true &&
> +	git checkout -b resetBranch &&
> +	test_path_is_missing m &&
> +	test_path_is_missing a &&
> +	test_path_is_missing d &&
> +	git reset HEAD~1 &&
> +	test "checkout file" = "$(cat c)" &&
> +	test "modification of a file" = "$(cat m)" &&
> +	test "added file" = "$(cat a)" &&
> +	test_path_is_missing d
> +'
> +
> +test_expect_success 'reset after deleting file without skip-worktree bit' '
> +	git checkout -f endCommit &&
> +	git clean -xdf &&
> +	cat >.git/info/sparse-checkout <<-\EOF &&
> +	/c
> +	/m
> +	EOF
> +	test_config core.sparsecheckout true &&
> +	git checkout -b resetAfterDelete &&
> +	test_path_is_file m &&
> +	test_path_is_missing a &&
> +	test_path_is_missing d &&
> +	rm -f m &&
> +	git reset HEAD~1 &&
> +	test "checkout file" = "$(cat c)" &&
> +	test "added file" = "$(cat a)" &&
> +	test_path_is_missing m &&
> +	test_path_is_missing d
> +'
> +
> +
> +
> +test_done
