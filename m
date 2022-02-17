Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45088C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 01:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiBQBPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 20:15:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiBQBPg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 20:15:36 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D54429B9E7
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 17:15:22 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09923FA89E;
        Wed, 16 Feb 2022 20:15:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nu/HMBveKGdM1iFTEpUDVBlnXNjTs6FpMk0rS/
        7QqP0=; b=hcxXTRPA3JR/ZyXckt88iEHJTLUOX/Mo0xZYQoPqSuucWGPxekW2Eo
        FZYNafNB5UlbJmM2V7TV42Do7WLnqT/3qXjwZwMr9RUj6gl1FONMyWOkoEPazn/r
        lD16mNnnpXEzit1Eu0lOCyoLro6lJzMicB5IjupJCzlNm8J9jbRuY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F38DFFA89D;
        Wed, 16 Feb 2022 20:15:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 57321FA89C;
        Wed, 16 Feb 2022 20:15:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 24/30] t/perf/p7519: speed up test on Windows
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <fcf843a0d42f3a6b1d226b42014835c3e410fc7d.1644612979.git.gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 17:15:18 -0800
In-Reply-To: <fcf843a0d42f3a6b1d226b42014835c3e410fc7d.1644612979.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Fri, 11 Feb 2022
        20:56:13 +0000")
Message-ID: <xmqqk0dub8ex.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 126BE026-8F8F-11EC-8207-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +touch_files () {
> +	n=$1
> +	d="$n"_files
> +
> +	(cd $d ; test_seq 1 $n | xargs touch )
> +}
> +
>  test_expect_success "one time repo setup" '
>  	# set untrackedCache depending on the environment
>  	if test -n "$GIT_PERF_7519_UNTRACKED_CACHE"
> @@ -119,10 +126,11 @@ test_expect_success "one time repo setup" '
>  	fi &&
>  
>  	mkdir 1_file 10_files 100_files 1000_files 10000_files &&
> -	for i in $(test_seq 1 10); do touch 10_files/$i || return 1; done &&
> -	for i in $(test_seq 1 100); do touch 100_files/$i || return 1; done &&
> -	for i in $(test_seq 1 1000); do touch 1000_files/$i || return 1; done &&
> -	for i in $(test_seq 1 10000); do touch 10000_files/$i || return 1; done &&
> +	touch_files 1 &&

This causes touch_files to chdir to 1_files and run "touch 1" in
there, but because there is no such directory (we have 1_file/
directory, but not 1_files/ directory), it would fail.

> +	touch_files 10 &&
> +	touch_files 100 &&
> +	touch_files 1000 &&
> +	touch_files 10000 &&

Apparently nobody has run this perf script recently since part #2
was posted.

>  	git add 1_file 10_files 100_files 1000_files 10000_files &&

The original introduced at bb7cc7e7 (t/perf/fsmonitor: separate one
time repo initialization, 2020-10-26) created an empty directory 1_file
and without creating anything in it, ran "git add" on it.

If we are not doing anything to 1_file directory anyway, perhaps we
can get rid of it to avoid the breakage in "make perf"?

If we have a chance to reroll this series, we can squash in
something like this, perhaps (it does not deserve to be a separate
step).

--- >8 ---
Subject: [PATCH] p7519: leave 1_file directory empty

The step "t/perf/p7519: speed up test on Windows" in the topic
builtin-fsmonitor-part-2 (not in 'next' yet) attempts to create one
file in 1_files directory, but the original introduced at bb7cc7e7
(t/perf/fsmonitor: separate one time repo initialization,
2020-10-26):

 (1) created 1_file directory,

 (2) left the directory empty, and

 (3) a later test expected (and still expects) that there is nothing
     in the directory.

Revert the behaviour back to what the original wanted to do.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/perf/p7519-fsmonitor.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 9a2288a622..a1c552129c 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -126,7 +126,7 @@ test_expect_success "one time repo setup" '
 	fi &&
 
 	mkdir 1_file 10_files 100_files 1000_files 10000_files &&
-	touch_files 1 &&
+	: 1_file directory should be left empty &&
 	touch_files 10 &&
 	touch_files 100 &&
 	touch_files 1000 &&
-- 
2.35.1-193-g45fe28c951

