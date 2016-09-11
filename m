Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3B4E1FCA9
	for <e@80x24.org>; Sun, 11 Sep 2016 23:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753651AbcIKXYQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 19:24:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58986 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752789AbcIKXYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 19:24:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 774DE3EBB1;
        Sun, 11 Sep 2016 19:24:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SV/FLmqJfIHXBC0+XldIP2cX7ew=; b=JTWkbM
        tue2H8YRoSCcjHjA3tEs2UXj1ACneEo8IML88yeUGtYa8rAXU7JzHiSO7ELl1TSM
        Aa/hiVzsE439m/7slUoH546EGbU78lgwc/1GmvMFSPVa7IavKHZ0sPB9b7la8qTE
        FrgDJKxaPMw7I1AFcvshPoakY0O1WFXzywAnU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sVZUmo2RPOMojaKSylvZuya2nquR+0iy
        uQ4jcAKyOsWh0YB+Py9inRjbtRnTABY5dJib56/scRUAg6FjgOMCluLdRWGBqTnG
        ZkWXRSPJoAj5CC7iQ8eSMsLIrDz7xnOTIhCBuz1l0UjhrPCNP8WpqW0wI7lLAwGh
        cvA1UA6auWk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EF1A3EBB0;
        Sun, 11 Sep 2016 19:24:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E765E3EBAF;
        Sun, 11 Sep 2016 19:24:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mikhail Filippov <mikhail@filippov.me>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Do not record unstaged deleted file upon recursive merge if file was moved outside of working tree with enabled sparse-checkout.
References: <1473625505-7641-1-git-send-email-mikhail@filippov.me>
Date:   Sun, 11 Sep 2016 16:24:11 -0700
In-Reply-To: <1473625505-7641-1-git-send-email-mikhail@filippov.me> (Mikhail
        Filippov's message of "Sun, 11 Sep 2016 23:25:05 +0300")
Message-ID: <xmqqeg4q6mw4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9F57570-7876-11E6-8DC5-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mikhail Filippov <mikhail@filippov.me> writes:

> ---

You'd need a lot more explanation on why this is needed
(i.e. without it what behaviour you would get, and why that
behaviour is wrong).

>  merge-recursive.c                    |  9 +++++---
>  t/t6042-merge-rename-corner-cases.sh | 42 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+), 3 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index e349126..25dc701 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1724,9 +1724,12 @@ static int merge_content(struct merge_options *o,
>  		 */
>  		path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
>  		if (!path_renamed_outside_HEAD) {
> -			add_cacheinfo(o, mfi.mode, &mfi.oid, path,
> -				      0, (!o->call_depth), 0);
> -			return mfi.clean;
> +			struct stat st;
> +			if (lstat(path, &st) == 0) {
> +				add_cacheinfo(o, mfi.mode, &mfi.oid, path,
> +					      0, (!o->call_depth), 0);
> +				return mfi.clean;
> +			}

I cannot guess what you are trying to achieve without explanation in
the proposed log message, but I can say that this unconditional
checking of a working tree file cannot be correct (there may or may
not be other things that are wrong with this change, which cannot be
judged without more information).

Imagine your o->call_depth is not zero, i.e. we are making a virtual
common ancestor with this merge, in which case any of the three
trees involved may have nothing to do with the current working tree
files.

> +test_expect_success 'move file/sparse-checkout/merge should not delete moved file' '
> +	git rm -rf . &&
> +	git clean -fdqx &&
> +	rm -rf .git &&
> +	git init &&

Yuck.  This is inherited from existing tests but I think they need
to be cleaned up.  It is not your fault, and it is not in the scope
of this change.

> +	git status >output &&
> +	cp output /tmp/a &&

Huh?

> +	test_i18ngrep "nothing to commit" output
> +'
> +
>  test_done
