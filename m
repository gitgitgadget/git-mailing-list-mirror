Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56ACE92FC0
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 21:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjJEVpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 17:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjJEVpj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 17:45:39 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DC095
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 14:45:36 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F1971AE1D0;
        Thu,  5 Oct 2023 17:45:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=KI6WKvqe1tqAPF6xS6+yMM1s2+gbjpvSmiOzaP
        VctBA=; b=bPevLq80Rel9+CJVe9Rc0yNVava4gOXQ6FmP/qUQAuZ4lliYfjCS1h
        eNKR61fmFInBOQyaqhxVVsmjL3X2NE3ifBZDVZgqLoXtvEnYnfvFntNvyc7CU5xy
        pQ4pZ983IuRLcCzT0HeSLDqjyCQKmDCFXPTV9LBpKNc+24TNYiWdw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 46C7A1AE1CF;
        Thu,  5 Oct 2023 17:45:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A9F451AE1CE;
        Thu,  5 Oct 2023 17:45:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] diff-merges: introduce '--dd' option
In-Reply-To: <20231004214558.210339-3-sorganov@gmail.com> (Sergey Organov's
        message of "Thu, 5 Oct 2023 00:45:57 +0300")
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20231004214558.210339-1-sorganov@gmail.com>
        <20231004214558.210339-3-sorganov@gmail.com>
Date:   Thu, 05 Oct 2023 14:45:33 -0700
Message-ID: <xmqqr0m8eoaq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 842B9DAA-63C8-11EE-900C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> This option provides a shortcut to request diff with respect to first
> parent for any kind of commit, universally. It's implemented as pure
> synonym for "--diff-merges=first-parent --patch".

That explains what the patch does, but it does not tell us why it is
useful [*].

> NOTE: originally proposed as '-d', and renamed to '--dd' due to Junio
> request to keep "short-and-sweet" '-d' reserved for other uses.

The note is not grammatical, and more importantly, readers of "git
log" 6 months down the road would not care.  I'd rather not see it
in the proposed log message.  It is suitable material to place after
the three-dash line, or in the cover letter for the iteration.

> diff --git a/diff-merges.c b/diff-merges.c
> index ec97616db1df..45507588a279 100644
> --- a/diff-merges.c
> +++ b/diff-merges.c
> @@ -131,6 +131,9 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
>  	} else if (!strcmp(arg, "--cc")) {
>  		set_dense_combined(revs);
>  		revs->merges_imply_patch = 1;
> +	} else if (!strcmp(arg, "--dd")) {
> +		set_first_parent(revs);
> +		revs->merges_imply_patch = 1;

Quite straight-forward as expected.  I do not think "--dd" clicks
for many people as "first parent diffs all over", though.

>  	} else if (!strcmp(arg, "--remerge-diff")) {
>  		set_remerge_diff(revs);
>  		revs->merges_imply_patch = 1;
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 5de1d190759f..4b474808311e 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -473,6 +473,14 @@ test_expect_success 'log --diff-merges=on matches --diff-merges=separate' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'log --dd matches --diff-merges=1 -p' '
> +	git log --diff-merges=1 -p master >result &&
> +	process_diffs result >expected &&
> +	git log --dd master >result &&
> +	process_diffs result >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'deny wrong log.diffMerges config' '
>  	test_config log.diffMerges wrong-value &&
>  	test_expect_code 128 git log

Looking good.

Thanks.


[Footnote]

* As I said elsewhere, I do not think it is a good idea to encourage
  users' to adopt a screwed-up worldview in which first parent is
  special but not special, and does the wrong thing for reverse
  merges.  If the option were short-hand for "--first-parent -p",
  at least I would be more sympathetic.
