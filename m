Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9527C433F5
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 05:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AC7D6108E
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 05:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhJQFkR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Oct 2021 01:40:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61141 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhJQFkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Oct 2021 01:40:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89715F613E;
        Sun, 17 Oct 2021 01:38:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=uHoYXSD8aH1LfS80hVlySWCTY0ljIiuCsRte9OVY8QM=; b=w5ea
        duvEHK4Fg5baE7jRMmsseSAQNSp6z7SaO47zS25QUMeoZCwWDknIUqeUcZTOKPwg
        oDOAg86Fz+Tkxwk1uB6QYLEL6x8ZUagtyOehGAc+ugO37diy8GbWm69IK3UF4R5r
        yN57z/CrWriQIqjp0Mocwxs7j9Atjsyip2LvL+8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E7ECF613D;
        Sun, 17 Oct 2021 01:38:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F877F6139;
        Sun, 17 Oct 2021 01:38:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4] sparse index: fix use-after-free bug in
 cache_tree_verify()
References: <pull.1053.v3.git.1633630041829.gitgitgadget@gmail.com>
        <pull.1053.v4.git.1634375229338.gitgitgadget@gmail.com>
Date:   Sat, 16 Oct 2021 22:38:04 -0700
Message-ID: <xmqqilxw1a9v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 670AA380-2F0C-11EC-9DCF-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     [RFC] sparse index: fix use-after-free bug in cache_tree_verify()
>     
>     Changes since V3
>     
>      * removed "-q" from the test [1]. This is the same as V2 with a typo
>        fixed in the commit message
>     
>     [1] https://lore.kernel.org/git/
>     e281c2e2-2044-1a11-e2bc-5ab3ee92c300@gmail.com/

Thanks.  Unfortunately I've already merged the previosu version on
the 11th, so I took the liberty of turning this round into an
incremental.  How does this look?

----- >8 --------- >8 --------- >8 --------- >8 -----
From: Phillip Wood <phillip.wood@dunelm.org.uk>
Date: Sat, 16 Oct 2021 09:07:09 +0000
Subject: [PATCH] t1092: run "rebase --apply" without "-q" in the test

We run a few Git subcommands and make sure they produce identical
results with and without sparse-index.  To this set of subcommands,
an earlier commit added "rebase --apply", but did so with the "-q"
option, in order to work around a breakge caused by a version used
at Microsoft with some unreleased changes.

Because we would want to make sure the commands produce indentical
results, including reports given to the output that lists which
commits were picked, use of "-q" loses too much interesting
information.  Let's drop "-q" from the command invocation and
revisit the issue when the problematic changes are upstreamed.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 80c77bb432..85d5279b33 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -484,7 +484,7 @@ test_expect_success 'checkout and reset (mixed) [sparse]' '
 test_expect_success 'merge, cherry-pick, and rebase' '
 	init_repos &&
 
-	for OPERATION in "merge -m merge" cherry-pick "rebase --apply -q" "rebase --merge"
+	for OPERATION in "merge -m merge" cherry-pick "rebase --apply" "rebase --merge"
 	do
 		test_all_match git checkout -B temp update-deep &&
 		test_all_match git $OPERATION update-folder1 &&
-- 
2.33.1-877-g9d049ddf90

