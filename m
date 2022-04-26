Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BBDC433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 20:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355177AbiDZU60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 16:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355182AbiDZU6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 16:58:24 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD916418
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 13:55:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7737C19581D;
        Tue, 26 Apr 2022 16:55:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nr9l2h43S9K42W/2nNViqipdWz9LQRcKCpb6bB
        PbcAg=; b=CwgU2+291A4I7PxvXDAiLHoUcCx4qVphNjdBOLRaEyzyG169CcQcqB
        GfcCv9MmCeHfze7TaA6sRksZlfxDnnqSg8k9FCEL8qmHTUNA/p9ArlN5tb4A2BZo
        PjvmUV/AsbW6FEfijgzoU3C9BWe1ugDZ8n4Tg28sHR/OCixazkfqU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4B74019581C;
        Tue, 26 Apr 2022 16:55:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A6B9E19581B;
        Tue, 26 Apr 2022 16:55:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Philip Oakley <philipoakley@iee.email>,
        Josh Steadmon <steadmon@google.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/5] Sparse index integration with 'git show'
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
        <pull.1207.v2.git.1651005800.gitgitgadget@gmail.com>
Date:   Tue, 26 Apr 2022 13:55:07 -0700
In-Reply-To: <pull.1207.v2.git.1651005800.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Tue, 26 Apr 2022 20:43:15
        +0000")
Message-ID: <xmqqmtg7pntg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28D46F5A-C5A3-11EC-A070-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This ":" syntax is shared by other commands like "git rev-parse", but we are
> not adding those integrations at this point.

This has been the most curious thing since the initial round.  The
changes in the series are mostly about the code that parses the
":<path>" syntax and yield an object name (when exists) or give an
error messages (otherwise) and die, before the computed object name
gets used by "git show", or any other command that takes an object
name from the command line.

I guess what has been confusing me was the phrase "integration",
that you seem to be using to refer only to the final step of setting
require_full_index to 0, while that is the least interesting part of
a series like this one.  The work done in patches 3/ and 4/ that
paves the way to allow us to set the require_full_index to 0 in any
command that needs to work with the ":<path>" syntax is much more
interesting part of the series, and when viewed from that angle, the
series is not about preparing "show" but about ":<path>" syntax to
work better with the sparse index.

> I know that Victoria intends to submit her 'git stash' integration soon, and
> this provides a way to test if our split of test changes in t1092 are easy
> to merge without conflict. If that is successful, then I will likely submit
> my integration with the 'sparse-checkout' builtin after this series is
> complete. (UPDATE: we inserted a test in the same location of t1092, but
> otherwise there are no textual or semantic conflicts.)

Yeah, I think I already queued Victoria's and the previous round of
this series in 'seen' without problematic conflicts.

Let's take a brief look at the range-diff before I go do something
else...

>  2:  27ab853a9b4 ! 2:  2e9d47ab09b show: integrate with the sparse index
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'show (cached blob
>       -	# does not work as implemented. The error message is
>       -	# different for a full checkout and a sparse checkout
>       -	# when the directory is outside of the cone.
>      -+	# changes depending on the existence of a sparse index.
>      ++	# had different behavior depending on the existence
>      ++	# of a sparse index.
>        	test_all_match test_must_fail git show :deep/ &&
>        	test_must_fail git -C full-checkout show :folder1/ &&
>       -	test_sparse_match test_must_fail git show :folder1/
>  3:  f5da5327673 = 3:  5a7561637f0 object-name: reject trees found in the index
>  4:  99c09ccc240 ! 4:  b730457fccc object-name: diagnose trees in index properly
>      @@ Commit message
>           checkout. The error message from diagnose_invalid_index_path() reports
>           whether the path is on disk or not. The full checkout will have the
>           directory on disk, but the path will not be in the index. The sparse
>      -    checokut could have the directory not exist, specifically when that
>      +    checkout could have the directory not exist, specifically when that
>           directory is outside of the sparse-checkout cone.
>       
>           In the case of a sparse index, we have yet another state: the path can
>      @@ object-name.c: static void diagnose_invalid_index_path(struct repository *r,
>       
>        ## t/t1092-sparse-checkout-compatibility.sh ##
>       @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'show (cached blobs/trees)' '
>      + 	test_all_match git show :deep/a &&
>      + 	test_sparse_match git show :folder1/a &&
>      + 
>      +-	# Asking "git show" for directories in the index
>      +-	# had different behavior depending on the existence
>      +-	# of a sparse index.
>      ++	# The error message differs depending on whether
>      ++	# the directory exists in the worktree.
>      + 	test_all_match test_must_fail git show :deep/ &&
>        	test_must_fail git -C full-checkout show :folder1/ &&
>      - 	test_must_fail git -C sparse-checkout show :folder1/ &&
>      +-	test_must_fail git -C sparse-checkout show :folder1/ &&
>      ++	test_sparse_match test_must_fail git show :folder1/ &&
>        
>       -	test_must_fail git -C sparse-index show :folder1/ 2>err &&
>       -	grep "is in the index, but not at stage 0" err
>      -+	test_sparse_match test_must_fail git show :folder1/ &&
>      -+
>       +	# Change the sparse cone for an extra case:
>       +	run_on_sparse git sparse-checkout set deep/deeper1 &&
>       +
>  -:  ----------- > 5:  69efe637a18 rev-parse: integrate with sparse index

OK, nothing unexpected other than the rev-parse stuff.

Thanks.
