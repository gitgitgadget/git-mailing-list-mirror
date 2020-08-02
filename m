Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BE1C433E0
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 00:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2AED20725
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 00:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uJoQ6FOi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgHBAbc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Aug 2020 20:31:32 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57872 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHBAbb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Aug 2020 20:31:31 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 117D1DE99A;
        Sat,  1 Aug 2020 20:31:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sZ/43kfG7VWWGvgdsJEq3PBS9yw=; b=uJoQ6F
        OinhvC3bEdXmdLnjfyajt8m8t2FlpPoeQ+gquqsvzZ6APxMwvPvWi8SAh45Lo2C1
        DlkGvHbqiA5zZtekiWy6y8k6gf5XDdFSHBbvoBWfKFlCWm3QXj2jAUsZA4ghmmXR
        hUusIqt74cbsWGg4pjG6ITNnhTQ5AsrO9fq0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xxx8r3B7CoC/rgnXBAln8juByKBPf2WV
        etETu+g/Ha2Zd5RSXU1r2Mrvx62GWqBbpwY7JbJHzZ8Ib3QH/rj54qN4bGCT3dS8
        VtP0FTn8Obk49h9Qmc8WKWQzrl7Te5Xd86FJLpme4xnH3AChID0G9/BSwGhZL5Ab
        u19k/Pj2D7Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 09B8FDE999;
        Sat,  1 Aug 2020 20:31:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4D9E3DE998;
        Sat,  1 Aug 2020 20:31:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH] diff: teach --stat to ignore uninteresting modifications
References: <pull.689.git.1596324796918.gitgitgadget@gmail.com>
Date:   Sat, 01 Aug 2020 17:31:25 -0700
In-Reply-To: <pull.689.git.1596324796918.gitgitgadget@gmail.com> (Matthew
        Rogers via GitGitGadget's message of "Sat, 01 Aug 2020 23:33:16
        +0000")
Message-ID: <xmqqv9i128iq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 809E8C6E-D457-11EA-81E8-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +		if (DIFF_FILE_VALID(one) && DIFF_FILE_VALID(two)) {
> +			struct diffstat_file *file = 
> +				diffstat->files[diffstat->nr - 1];
> +			/*
> +			 * Omit diffstats of modified files where nothing changed. 
> +			 * Even if !same_contents, this might be the case due to
> +			 * ignoring whitespace changes, etc.
> +			 * 
> +			 * But note that we special-case additions and deletions,
> +			 * as adding an empty file, for example is still of interest.
> +			 */
> +			if (p->status == DIFF_STATUS_MODIFIED 
> +				&& !file->added
> +				&& !file->deleted) {
> +				free_diffstat_file(file);
> +				diffstat->nr--;
> +			}
> +		}
>  	}
> 
>  	diff_free_filespec_data(one);

There are some "trailing whitespace" errors detected by "git am/apply".

> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index 88d3026894..32c1b967f9 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -789,7 +789,7 @@ test_expect_success 'checkdiff allows new blank lines' '
>  	git diff --check
>  '
>  
> -test_expect_success 'whitespace-only changes not reported' '
> +test_expect_success 'whitespace-only changes not reported (diff)' '
>  	git reset --hard &&
>  	echo >x "hello world" &&
>  	git add x &&
> @@ -799,6 +799,12 @@ test_expect_success 'whitespace-only changes not reported' '
>  	test_must_be_empty actual
>  '
>  
> +test_expect_success 'whitespace-only changes not reported (diffstat)' '
> +	# reuse state from previous test
> +	git diff --stat -b >actual &&
> +	test_must_be_empty actual
> +'
> +

This is a "let's show off our shiny new toy" test, which shows that
the code change covered the case you are interested in changing.
We'd also need tests that makes sure that the effect of the code
change is not seen when it should not trigger.

For example, if we further change mode bits of file 'x' (which has a
whitespace-only changes applied in the test in the previous hunk),
e.g.

	git update-index --chmod=+x x &&
	git diff --stat -b --cached >actual

should that be counted as a file with 0-line change that is worth
reporting, or is it hidden?  I _think_ the new code will do a wrong
thing here.  That is,

 - If the change truly is only mode bits and one and two have
   "same_contents", the new code is bypassed, and we'll continue to
   show "0 lines changed, but the file is worth reporting".

 - If the change is whitespace-only change plus mode bits, i.e. one
   and two do not have "same_contents", the new code triggers and
   the stat output is suppressed for the path.



