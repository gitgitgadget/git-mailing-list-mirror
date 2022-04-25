Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85533C433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 20:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239512AbiDYU7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 16:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiDYU7e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 16:59:34 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987171DA57
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 13:56:27 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E5FF11CF09;
        Mon, 25 Apr 2022 16:56:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qAQwvfo1qi87HnPF2p1S6sGRClgJAxauCr4hsW
        76+J8=; b=ykxufp6lHtLL0Mo4NnFi8ucAgosfBTM/0G/+QtDE4TcMXWmdoX5l0f
        9XJyLCyX8VRDmidZGGb2wO1B/Y9EFU2YBULiPMVyNhQTpMB48FqUUcxQtalrj6lQ
        X42laoTupDGSHCCCuwCYwg8syx+QvolhXujrQ+fykFYKl45Skj0uQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7663E11CF08;
        Mon, 25 Apr 2022 16:56:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E2B2211CF07;
        Mon, 25 Apr 2022 16:56:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2] submodule--helper: fix initialization of
 warn_if_uninitialized
References: <pull.1258.git.git.1650781575173.gitgitgadget@gmail.com>
        <pull.1258.v2.git.git.1650890741430.gitgitgadget@gmail.com>
        <xmqq35i1vx3y.fsf@gitster.g>
Date:   Mon, 25 Apr 2022 13:56:24 -0700
In-Reply-To: <xmqq35i1vx3y.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        25 Apr 2022 11:25:37 -0700")
Message-ID: <xmqqtuagvq4n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BDCD300-C4DA-11EC-8085-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Is this a fix we can protect from future breakge by adding a test or
> tweaking an existing test?  It is kind of surprising if we did not
> have any test that runs "git submodule update" in a superproject
> with initialized and uninitialized submodule(s) and make sure only
> the initialized ones are updated.  It may be the matter of examining
> the warning output that is currently ignored in such a test, if
> there is one.

Here is a quick-and-dirty one I came up with.  The superproject
"super" has a handful of submodules ("submodule" and "rebasing"
being two of them), so the new tests clone the superproject and
initializes only one submodule.  Then we see how "submodule update"
with pathspec works with these two submodules (one initialied and
the other not).  In another test, we see how "submodule update"
without pathspec works.

I'll queue this on top of your fix for now tentatively.  If nobody
finds flaws in them, I'll just squash it in soonish before merging
the whole thing for the maintenance track.

Thanks.

 t/t7406-submodule-update.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git c/t/t7406-submodule-update.sh w/t/t7406-submodule-update.sh
index 000e055811..43f779d751 100755
--- c/t/t7406-submodule-update.sh
+++ w/t/t7406-submodule-update.sh
@@ -670,6 +670,39 @@ test_expect_success 'submodule update --init skips submodule with update=none' '
 	)
 '
 
+test_expect_success 'submodule update with pathspec warns against uninitialized ones' '
+	test_when_finished "rm -fr selective" &&
+	git clone super selective &&
+	(
+		cd selective &&
+		git submodule init submodule &&
+
+		git submodule update submodule 2>err &&
+		! grep "Submodule path .* not initialized" err &&
+
+		git submodule update rebasing 2>err &&
+		grep "Submodule path .rebasing. not initialized" err &&
+
+		test_path_exists submodule/.git &&
+		test_path_is_missing rebasing/.git
+	)
+
+'
+
+test_expect_success 'submodule update without pathspec updates only initialized ones' '
+	test_when_finished "rm -fr selective" &&
+	git clone super selective &&
+	(
+		cd selective &&
+		git submodule init submodule &&
+		git submodule update 2>err &&
+		test_path_exists submodule/.git &&
+		test_path_is_missing rebasing/.git &&
+		! grep "Submodule path .* not initialized" err
+	)
+
+'
+
 test_expect_success 'submodule update continues after checkout error' '
 	(cd super &&
 	 git reset --hard HEAD &&
