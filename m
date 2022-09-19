Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7522C6FA8B
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 23:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiISXKV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 19:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiISXKR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 19:10:17 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13281F2DF
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 16:10:02 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 68F8A142BE6;
        Mon, 19 Sep 2022 19:10:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b/zj/zr2B2vQnRA7l1Hfu49Tb0vDAoYO3Pt3zU
        xDmwM=; b=mKgvZQm3sAPorjPvQ0JtEg8SyK0JA7PrsWe0aySbFUegOudHZn29ZY
        yzuawsDnEmmtcvCfjVP4lZsKp7BHqRnEUeNxVBvJLmdRuTPYtMaCuG7yjA+c+Gww
        Pmgq/+DNS8LC7YP27r72WgXtegYjAHcUlOmHJ258VuDyftibQquIE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59F70142BE3;
        Mon, 19 Sep 2022 19:10:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9F27E142BE2;
        Mon, 19 Sep 2022 19:09:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     Erik Cervin Edin <erik@cervined.in>, git@vger.kernel.org
Subject: Re: [PATCH] sequencer: avoid dropping fixup commit that targets
 self via commit-ish
References: <YyZWDkZWAkS7q+Wf@gmail.com>
        <20220918121053.880225-1-aclopte@gmail.com>
Date:   Mon, 19 Sep 2022 16:09:57 -0700
In-Reply-To: <20220918121053.880225-1-aclopte@gmail.com> (Johannes
        Altmanninger's message of "Sun, 18 Sep 2022 07:10:53 -0500")
Message-ID: <xmqqmtav7ygq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F238324-3870-11ED-A84E-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Altmanninger <aclopte@gmail.com> writes:

> +test_expect_success 'auto squash of fixup commit that matches branch name which points back to fixup commit' '
> ...
> +	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p}" tmp >actual &&

The construct is rejected by sed implementations of BSD descent, it
seems.

https://github.com/git/git/actions/runs/3084784922/jobs/4987337058#step:4:1844

++ sed -ne '/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p}' tmp
sed: 1: "/^[^#]/{s/[0-9a-f]\{7,\ ...": extra characters at the end of p command
error: last command exited with $?=1
not ok 11 - auto squash that matches regex

Here is a fix-up that can be squashed in.

Thanks.

 t/t3415-rebase-autosquash.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 879e628512..d65d2258c3 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -237,7 +237,7 @@ test_expect_success 'auto squash that matches regex' '
 	git commit --allow-empty -m "hay needle hay" &&
 	git commit --allow-empty -m "fixup! :/[n]eedle" &&
 	GIT_SEQUENCE_EDITOR="cat >tmp" git rebase --autosquash -i HEAD^^ &&
-	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p}" tmp >actual &&
+	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p;}" tmp >actual &&
 	cat <<-EOF >expect &&
 	pick HASH hay needle hay # empty
 	fixup HASH fixup! :/[n]eedle # empty
@@ -253,7 +253,7 @@ test_expect_success 'auto squash of fixup commit that matches branch name' '
 	git commit --allow-empty -m "unrelated commit" &&
 	git commit --allow-empty -m "fixup! wip" &&
 	GIT_SEQUENCE_EDITOR="cat >tmp" git rebase --autosquash -i HEAD^^^^ &&
-	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p}" tmp >actual &&
+	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p;}" tmp >actual &&
 	cat <<-EOF >expect &&
 	pick HASH wip commit (just a prefix match so overshadowed by branch) # empty
 	pick HASH tip of wip # empty
@@ -268,7 +268,7 @@ test_expect_success 'auto squash of fixup commit that matches branch name which
 	git commit --allow-empty -m "fixup! self-cycle" &&
 	git branch self-cycle &&
 	GIT_SEQUENCE_EDITOR="cat >tmp" git rebase --autosquash -i HEAD^^ &&
-	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p}" tmp >actual &&
+	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p;}" tmp >actual &&
 	cat <<-EOF >expect &&
 	pick HASH second commit
 	pick HASH fixup! self-cycle # empty
-- 
2.38.0-rc0-146-g9b794391bb

