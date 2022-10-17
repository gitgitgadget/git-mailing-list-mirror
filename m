Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C257C433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 13:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiJQNgo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiJQNgm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 09:36:42 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3F0B7C1
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:36:41 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3420F1B04B4;
        Mon, 17 Oct 2022 09:36:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=2elEUEFFSgBjDi40BaFNg+BA8ml+VXWrwWcAvYCYd9U=; b=PmtO
        1OtInUkIuzRF/XOP1jhVvyoYKrBNE42/sntz5v62UUCZqjxK4FQVnKUexfUwmbdP
        Pcvm4wjjE1URzhA9PikoonwSup1Tb7kngbnN90SNYAhl+fml9oWwE9NiyoLrY1p7
        VJvoDbXV1ddQ6jr54BP0pWqzTJJaKda6p1lmUGg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D11E1B04B2;
        Mon, 17 Oct 2022 09:36:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 68AFA1B04B1;
        Mon, 17 Oct 2022 09:36:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heather Lapointe via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
Subject: Re: [PATCH v3 3/9] tree: increase test coverage for tree.c
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
        <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
        <9a07c6932f4c7ef844df1fc4f5b6b9feb1810135.1665973401.git.gitgitgadget@gmail.com>
Date:   Mon, 17 Oct 2022 06:36:37 -0700
Message-ID: <xmqqy1te1sii.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9FA2578-4E20-11ED-A1FD-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heather Lapointe via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/t1023-tree-read-tree-at.sh b/t/t1023-tree-read-tree-at.sh
> new file mode 100755
> index 00000000000..9e5ce3abb4b
> --- /dev/null
> +++ b/t/t1023-tree-read-tree-at.sh
> @@ -0,0 +1,65 @@
> +#!/bin/sh
> +
> +# tests for tree.c (not read-tree.c)
> +test_description='Test read_tree / read_tree_at'
> +. ./test-lib.sh
> +
> +test_expect_success 'read_tree basic' '
> +	rm -rf walk_tree_basic &&
> +	git init walk_tree_basic &&
> +	(
> +		cd walk_tree_basic &&
> +		set -x &&

Do we need this, when we have '-x' option alongside with '-v', '-i',
and '-d' available in the test harness already?

> +		mkdir -p dir1/dirA &&
> +		mkdir -p dir1/dirB &&
> +		mkdir -p dir2 &&

Can't we have these three done by the same single "mkdir -p" process?

> +		echo "file1" > file1.txt &&
> +		echo "file2" > file2.txt &&

Lose the SP between redirection operator ">" and its target, i.e.

		echo file1 >file1.txt

cf. Documentation/CodingGuidelines

Also you do not necessarily have to have dq around a single token.

> +		# uncommitted
> +		echo "file3" > file3.txt &&
> +
> +		echo "file1A1" > dir1/dirA/file1.txt &&
> +		git add file1.txt file2.txt dir1/dirA/file1.txt &&
> +		git commit -m "initial commit" &&
> +
> +		test-tool tree-read-tree-at . > walk1.txt &&
> +		grep " file1.txt" walk1.txt &&
> +		! grep " file3.txt" walk1.txt &&
> +		! grep " dir1/dirB" walk1.txt &&
> +		grep " dir1/dirA/file1.txt" walk1.txt
> +	)
> +'
> +
> +test_expect_success 'read_tree submodules' '
> +	rm -rf walk_tree_submodules &&

Curious why the above does not clean "submodule1", too.  After all,
all the "rm -rf" we saw in this script above are removing what its
earlier steps would never have created (but will create), just in
case.  Why not do the same?

If the pattern is to "remove what we will need to create immediately
before we actually try to create, just in case", then shouldn't the
above be removing "submodule1", and we should have another "rm -rf"
for "walk_tree_submodules" immediately before we do "git init" on
it several lines below?

> +	git init submodule1 &&
> +	(
> +		cd submodule1 &&
> +		mkdir -p dir1/dirA &&
> +		echo "dir2/sub1/file1.txt" > file1.txt &&
> +		echo "dir2/sub1/file1A1.txt" > dir1/dirA/file1.txt &&
> +		git add file1.txt dir1/dirA/file1.txt &&
> +		git commit -m "initial commit"
> +	) &&
> +	git init walk_tree_submodules &&
> +	(
> +		cd walk_tree_submodules &&
> +
> +		mkdir -p dir2 &&
> +		echo "file1" > file1.txt &&
> +		echo "dir2/file2" > dir2/file2.txt &&
> +		git add file1.txt dir2/file2.txt &&
> +		git commit -m "initial commit" &&
> +
> +		git submodule add ../submodule1 dir2/sub1 &&
> +		git commit -m "add submodule1" &&
> +
> +		test-tool tree-read-tree-at . > walk2.txt &&
> +		grep " file1.txt" walk2.txt &&
> +		grep " dir2/sub1/file1.txt" walk2.txt &&
> +		grep " dir2/sub1/dir1/dirA/file1.txt" walk2.txt
> +	)
> +'
> +
> +test_done
