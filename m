Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF35AC433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 18:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238844AbiDASMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 14:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbiDASMc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 14:12:32 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522C212F17D
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 11:10:42 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72BE011ECB4;
        Fri,  1 Apr 2022 14:10:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9wd6heQSouyTyITJHQSEFOoEyPiN5Fkocrw+e6
        i8kgI=; b=KBV1RZW+Fgr05IRGlDoTgM/R2jJp/3HfVme9ACPnkCmkZziMc2LQmS
        yT+F4xuURT02VjXtSpiocsN2iGVFxcD8m7ER6rrqiLdnnbfUXyKTTf5ibyyQT39+
        vR3i/kWELUhKrvCTTLtbrLqW84g9ymdpPzR7AG7wBDa/pj/lwmpwk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 691EB11ECB3;
        Fri,  1 Apr 2022 14:10:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C91A911ECB2;
        Fri,  1 Apr 2022 14:10:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Labnann <khalid.masum.92@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com
Subject: Re: [PATCH v2 2/3] t3501: don't ignore "git <cmd>" exit code
References: <220331.86bkxnt77a.gmgdl@evledraar.gmail.com>
        <20220331191525.17927-1-khalid.masum.92@gmail.com>
        <20220331191525.17927-3-khalid.masum.92@gmail.com>
Date:   Fri, 01 Apr 2022 11:10:37 -0700
In-Reply-To: <20220331191525.17927-3-khalid.masum.92@gmail.com> (Labnann's
        message of "Thu, 31 Mar 2022 19:15:24 +0000")
Message-ID: <xmqqilrswu76.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09036462-B1E7-11EC-9A76-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Labnann <khalid.masum.92@gmail.com> writes:

> without this change this test will become flaky e.g under
> SANITIZE=leak if some (but not all) memory leaks revealed by
> these commands, according to c419562860e

The body of the proposed log message is *not* a continuation (the
latter half) of a sentence that the title started, but should be a
full sentence on its own.  Capitalize the first word as usual.

Also, the leak check should not be the primary reason to do this
change.  We do not want to miss "git rev-parse" used in these tests
starts to fail, regardless of why they fail.  Perhaps like this
instead?

    Otherwise, we would not notice when "git rev-parse" starts
    segfaulting without emitting any output.  The 'test' command
    would end up being just "test =", which yields success.

> +test_cmp_rev_parse () {
> +	git rev-parse $1 >expect &&
> +	git rev-parse $2 >actual &&
> +	test_cmp expect actual
> +}

To me, it looks like we can just use test_cmp_rev that already
exists, but am I missing some subtlety?

If not (then we need to explain why in the proposed commit log
message), at least we should place $1 and $2 inside a pair of
double-quotes.  For the current callers, what they pass happen not
to need such quoting, but once we write a helper function, we are
helping _future_ callers as well, and we should be reasonably
prepared for them.

>  test_expect_success 'cherry-pick --nonsense' '
>  
>  	pos=$(git rev-parse HEAD) &&
> @@ -66,7 +72,7 @@ test_expect_success 'cherry-pick after renaming branch' '
>  
>  	git checkout rename2 &&
>  	git cherry-pick added &&
> -	test $(git rev-parse HEAD^) = $(git rev-parse rename2) &&
> +	test_cmp_rev_parse HEAD^ rename2 &&

OK.

>  	test_path_is_file opos &&
>  	grep "Add extra line at the end" opos &&
>  	git reflog -1 | grep cherry-pick
> @@ -77,7 +83,7 @@ test_expect_success 'revert after renaming branch' '
>  
>  	git checkout rename1 &&
>  	git revert added &&
> -	test $(git rev-parse HEAD^) = $(git rev-parse rename1) &&
> +	test_cmp_rev_parse HEAD^ rename1 &&

OK.

>  	test_path_is_file spoo &&
>  	! grep "Add extra line at the end" spoo &&
>  	git reflog -1 | grep revert

Thanks.
