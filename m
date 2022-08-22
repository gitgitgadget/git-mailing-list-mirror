Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252FCC28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 20:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbiHVU7d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 16:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237712AbiHVU7b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 16:59:31 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111364D141
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 13:59:27 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B745713554D;
        Mon, 22 Aug 2022 16:59:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9B3/iErwYDOByYWN48IUEstsgc/QnKT81j2uer
        +2EVw=; b=V80pOgxqgVUeGwiS42Y3hyFryP/36p0G+xrUvAhbMGcpkiPoIGd6Pl
        HIpgh3icQmSC3vMj7VJqe3Vi7fbYK1lz1arj7qQVKvQQ8izc+HZ2ZMzO0Qzu8gJt
        zdngrKUaH4B2O0ET4lv88jB3K2HIC54AJUhbwVhzyoT2/W/L9qTvk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADED813554C;
        Mon, 22 Aug 2022 16:59:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1B60413554B;
        Mon, 22 Aug 2022 16:59:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] t: detect and signal failure within loop
References: <pull.1312.git.git.1661192802.gitgitgadget@gmail.com>
        <31a962fd5070d68964e545fb5506d795e8845ec3.1661192802.git.gitgitgadget@gmail.com>
        <xmqqwnb0av09.fsf@gitster.g>
Date:   Mon, 22 Aug 2022 13:59:25 -0700
In-Reply-To: <xmqqwnb0av09.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        22 Aug 2022 13:22:30 -0700")
Message-ID: <xmqqfshoataq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E6B1E0A-225D-11ED-810A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
>> index 8968f7a08d8..6049e2c1d78 100755
>> --- a/t/t5329-pack-objects-cruft.sh
>> +++ b/t/t5329-pack-objects-cruft.sh
>> @@ -29,7 +29,7 @@ basic_cruft_pack_tests () {
>>  				while read oid
>>  				do
>>  					path="$objdir/$(test_oid_to_path "$oid")" &&
>> -					printf "%s %d\n" "$oid" "$(test-tool chmtime --get "$path")"
>> +					printf "%s %d\n" "$oid" "$(test-tool chmtime --get "$path")" || exit 1
>>  				done |
>>  				sort -k1
>>  			) >expect &&
>
> With the loop being on the upstream of a pipe, does the added "exit
> 1" have any effect?

And the answer is "no".  Without use of rhetorical question:

    The loop is on the upstream side of a pipe, so "exit 1" will be
    lost.  "sort -k1" will get a shortened output, unless the
    failure happens at the last iteration, so it is likely that the
    test may fail, but relying on the "expect" (what is supposed to
    have the _right_ answer) file not being right to get our
    breakage noticed does not sound right.

> Everything else in these three patches looked very sensible, but
> this one I found questionable.

As to the questionable one, we could probably do something like the
attached patch if we really wanted to.  We can guarantee that this
"expect" will never match any "actual", which is output from
pack-mtimes test tool command.  Whatever "tricky/ugly" approach we
choose to take, I think this one deserves to be done in a single
patch on its own with an explanation.

----- >8 --------- >8 --------- >8 --------- >8 ----
t5329: notice a failure within a loop

We try to write "|| return 1" at the end of a sequence of &&-chained
command in a loop of our tests, so that a failure of any step during
the earlier iteration of the loop can properly be caught.

There is one loop in this test script that is used to compute the
expected result, that will be later compared with an actual output
produced by the "test-tool pack-mtimes" command.  This particular
loop, however, is placed on the upstream side of a pipe, whose
non-zero exit code does not get noticed.

Emit a line that will never be produced by the "test-tool pack-mtimes"
to cause the later comparison to fail.  As we use test_cmp to compare
this "expected output" file with the "actual output", the "error
message" we are emitting into the expected output stream will stand
out and shown to the tester.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5329-pack-objects-cruft.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git c/t/t5329-pack-objects-cruft.sh w/t/t5329-pack-objects-cruft.sh
index 6049e2c1d7..43d752acc7 100755
--- c/t/t5329-pack-objects-cruft.sh
+++ w/t/t5329-pack-objects-cruft.sh
@@ -29,7 +29,8 @@ basic_cruft_pack_tests () {
 				while read oid
 				do
 					path="$objdir/$(test_oid_to_path "$oid")" &&
-					printf "%s %d\n" "$oid" "$(test-tool chmtime --get "$path")"
+					printf "%s %d\n" "$oid" "$(test-tool chmtime --get "$path")" ||
+					echo "object list generation failed for $obj"
 				done |
 				sort -k1
 			) >expect &&

