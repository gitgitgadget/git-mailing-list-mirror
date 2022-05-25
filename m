Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38CDC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 21:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbiEYVm5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 17:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiEYVm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 17:42:56 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47E92FE47
        for <git@vger.kernel.org>; Wed, 25 May 2022 14:42:54 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F068D1305FE;
        Wed, 25 May 2022 17:42:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rBG/iAfWHVXhCd+FJ0i9+ojHWhQdAyQoJ+qz5A
        FNvL4=; b=xg+E9qfmKIj4IciU3f1WRqUboCM+E1y5EMeetruo4lfMszl+B1qsw2
        h6yLImoyZn1ITIAwsZSX3BhnSy5YZBec4BwlZxuVXyhOFcUudWkhcmW4p+MhCWf7
        qCYQzi92r+VN6wLnYjE9xdpOaBSMm6YStGWCro26SwBqYcHB8B00Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E6ED11305FD;
        Wed, 25 May 2022 17:42:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5FCE61305FC;
        Wed, 25 May 2022 17:42:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>, rsbecker@nexbridge.com,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 2/7] archive --add-virtual-file: allow paths
 containing colons
References: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
        <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
        <7eebcf27b45eb13541d4abae70a374a0e35ab6b8.1653145696.git.gitgitgadget@gmail.com>
        <xmqq5ylt7473.fsf@gitster.g>
Date:   Wed, 25 May 2022 14:42:52 -0700
In-Reply-To: <xmqq5ylt7473.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        25 May 2022 13:22:24 -0700")
Message-ID: <xmqq4k1d5lwj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1B6CDFA-DC73-11EC-B3C5-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> But in _this_ particular case, the "defensive" measure necessary is
> merely just to quote the shell variables properly, which nobody
> sensible would say too onerous.  I couldn't come up with anything
> remotely plausible to fill "for such and such reasons" myself when I
> tried to justify leaving the variables unquoted.
>
> Regardless of the quoting issue, we probably want to comment on what
> value exactly is in PATHNAME before the assignment, by the way.
>
> E.g.
>
> 	# The PATHNAME variable holds a filename encoded like a
> 	# string constant in C language (e.g. "\060" is digit "0")
> 	if test_have_prereq FUNNYNAMES
> 	then
> 		PATHNAME=quoted:colon:\\060zero
> 	else
> 		PATHNAME=quoted\\060zero
> 	fi
>
> That would not just protect only one aspect (i.e. we can pass a
> colon into the resulting filename) this change but the path goes
> through the c-unquoting rules.

Actually, I _think_ that pushes us beyond the "reasonably defensive
for the current need".  We'd need to prepare how the pathname is
expected to be unquoted for the later test

	test_path_is_file "$PATHNAME"

to work.  So here is what I queued as a fixup for this step on top
of the series.

 t/t5003-archive-zip.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git c/t/t5003-archive-zip.sh w/t/t5003-archive-zip.sh
index 3a5a052e8c..6addb6c684 100755
--- c/t/t5003-archive-zip.sh
+++ w/t/t5003-archive-zip.sh
@@ -209,19 +209,19 @@ check_added with_untracked untracked untracked
 test_expect_success UNZIP 'git archive --format=zip --add-virtual-file' '
 	if test_have_prereq FUNNYNAMES
 	then
-		PATHNAME=quoted:colon
+		PATHNAME="pathname with : colon"
 	else
-		PATHNAME=quoted
+		PATHNAME="pathname without colon"
 	fi &&
 	git archive --format=zip >with_file_with_content.zip \
-		--add-virtual-file=\"$PATHNAME\": \
+		--add-virtual-file=\""$PATHNAME"\": \
 		--add-virtual-file=hello:world $EMPTY_TREE &&
 	test_when_finished "rm -rf tmp-unpack" &&
 	mkdir tmp-unpack && (
 		cd tmp-unpack &&
 		"$GIT_UNZIP" ../with_file_with_content.zip &&
 		test_path_is_file hello &&
-		test_path_is_file $PATHNAME &&
+		test_path_is_file "$PATHNAME" &&
 		test world = $(cat hello)
 	)
 '
