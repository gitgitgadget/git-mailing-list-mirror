Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2A3C07E9D
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 17:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiIWRiN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 13:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiIWRhh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 13:37:37 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AA715624F
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 10:36:46 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1E87151E5B;
        Fri, 23 Sep 2022 13:36:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nbk8a8XlEYW2CbShzYCx91vbJWigiOj2FIBD3k
        5qLYY=; b=fzapmtUSblpiMSSx9iGBlId6CEAgvj0jKSMJVx/Cgd3UnUsMSAlRBZ
        YRkSkBNYHtRDklS9ddrGwLZM0hIPnbKw0cxBk0Y5m+1OgId0wjecGQVK4Av2Awnq
        8gkYDN49UkjEVzuUQSNH7bjTP6yrtxPozHNpyThL2l0VCea3/6in4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8FCF151E5A;
        Fri, 23 Sep 2022 13:36:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 241B0151E59;
        Fri, 23 Sep 2022 13:36:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, me@ttaylorr.com,
        chakrabortyabhradeep79@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] pack-bitmap: remove trace2 region from hot path
References: <pull.1365.git.1663938034607.gitgitgadget@gmail.com>
Date:   Fri, 23 Sep 2022 10:36:44 -0700
In-Reply-To: <pull.1365.git.1663938034607.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Fri, 23 Sep 2022 13:00:34
        +0000")
Message-ID: <xmqq7d1uuh5f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B2308E4-3B66-11ED-8073-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     I noticed this while trying to backport the Abhradeep's lookup table
>     work into GitHub's fork. Something went wrong in that process, causing
>     this region to significantly slow down. It turns out that slow down does
>     not reproduce on current 'master', which is good. I must have missed
>     something while I was backporting.
>     
>     Regardless, the use of trace2_region_enter() here should be removed or
>     replaced. For the sake of 2.38.0, this simple removal is safe enough.

Well, not doing this removal is even safer, if we know that it is
not hurting in the -rc code.  It would be better than breaking our
tests without knowing ;-)  I am not upset that the patch broke the
test, by the way.  Compared to things silently breaking without
surfacing, a loud breakage in tests is a much easier thing to
handle.

My test run with the attached just finished, so that's what I am
going to queue tentatively on top.

Thanks.

 pack-bitmap.c           | 1 +
 t/t5310-pack-bitmaps.sh | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git c/pack-bitmap.c w/pack-bitmap.c
index 13457dd77e..a2bbbbd811 100644
--- c/pack-bitmap.c
+++ w/pack-bitmap.c
@@ -830,6 +830,7 @@ struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
 		if (!bitmap_git->table_lookup)
 			return NULL;
 
+		/* this is a fairly hot codepath - no trace2_region please */
 		/* NEEDSWORK: cache misses aren't recorded */
 		bitmap = lazy_bitmap_for_commit(bitmap_git, commit);
 		if (!bitmap)
diff --git c/t/t5310-pack-bitmaps.sh w/t/t5310-pack-bitmaps.sh
index 7e50f8e765..2b1efc923b 100755
--- c/t/t5310-pack-bitmaps.sh
+++ w/t/t5310-pack-bitmaps.sh
@@ -455,7 +455,7 @@ test_expect_success 'verify writing bitmap lookup table when enabled' '
 	grep "\"label\":\"writing_lookup_table\"" trace2
 '
 
-test_expect_success 'lookup table is actually used to traverse objects' '
+: test_expect_success 'lookup table is actually used to traverse objects' '
 	git repack -adb &&
 	GIT_TRACE2_EVENT="$(pwd)/trace3" \
 		git rev-list --use-bitmap-index --count --all &&
