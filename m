Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0CFC433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 23:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343645AbiCNXTJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 19:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343634AbiCNXTH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 19:19:07 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4E51EADF
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 16:17:56 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C2CE517CA8B;
        Mon, 14 Mar 2022 19:17:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j8UDDHgyOyph6gv98pX0ZJgG4Pezw4BIiKdzfm
        aHvic=; b=KiXkLgKur79jlR1Zn36ihR7IrBt+Fe0Cv9Qd4rx6WUCoa6+43w5dM8
        vhsyp8k6JGjzAPCuC6qKs68eSWrgiVy4QzaLhucQPA4OqDlrVe3yRPWff62FAEbq
        q/BJ18dN3BS1BSPyS1MKAHbK7J0+V1/8dwfmh3Z5PDG3016JnyOZg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BBCAD17CA8A;
        Mon, 14 Mar 2022 19:17:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1C19617CA86;
        Mon, 14 Mar 2022 19:17:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 0/5] Allow 'reset --quiet' to refresh the index, use
 'reset --quiet' in 'stash'
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
        <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
Date:   Mon, 14 Mar 2022 16:17:52 -0700
In-Reply-To: <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com> (Victoria
        Dye via GitGitGadget's message of "Mon, 14 Mar 2022 16:10:25 +0000")
Message-ID: <xmqqlexcjf8f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9451960-A3EC-11EC-A979-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> In the process of working on tests for 'git stash' sparse index integration,
> I found that the '--quiet' option in 'git stash' does not suppress all
> non-error output when used with '--index'. Specifically, this comes from an
> invocation of 'git reset' without the '--quiet' flag in 'reset_head()'. Upon
> enabling that flag, though, I discovered that 1) 'reset' does not refresh
> the index if '--quiet' is specified (as of [1]) and 2) 'git stash' needs the
> index to be refreshed after the reset.
>
> This series aims to decouple the "suppress logging" and "skip index refresh"
> behaviors in 'git reset --mixed', then allow 'stash' to internally use reset
> with logs suppressed but index refresh enabled. This is accomplished by
> introducing the '--[no-]refresh' option and 'reset.refresh' config setting
> to 'git reset'. Additionally, in the spirit of backward-compatibility,
> '--quiet' and/or 'reset.quiet=true' without any specified "refresh"
> option/config will continue to skip 'refresh_index(...)'.
>
> There are also some minor updates to the advice that suggests skipping the
> index refresh:
>
>  * replace recommendation to use "--quiet" with "--no-refresh"
>  * use 'advise()' rather than 'printf()'
>  * rename the advice config setting from 'advice.resetQuiet' to to
>    'advice.resetNoRefresh'
>  * suppress advice if '--quiet' is specified in 'reset'
>
> Finally, tests are added to 't7102-reset.sh' verifying whether index refresh
> happens when expected and to 't3903-stash.sh' verifying that 'apply --quiet'
> no longer prints extraneous logs.

I've read this iteration, too, and except for "we should test not
just 'apply -index' but 'push'" in [5/5], everything looked good.

Thanks.
