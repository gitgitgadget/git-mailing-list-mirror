Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E218C32793
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 06:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240671AbiHWGaR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 02:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240517AbiHWGaL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 02:30:11 -0400
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F30491EF
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 23:30:09 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4MBfV534vJz5tlF;
        Tue, 23 Aug 2022 08:30:03 +0200 (CEST)
Message-ID: <103fa5ac-d67c-82a7-11b2-0ffee7570349@kdbg.org>
Date:   Tue, 23 Aug 2022 08:30:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/3] t: detect and signal failure within loop
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <pull.1312.git.git.1661192802.gitgitgadget@gmail.com>
 <31a962fd5070d68964e545fb5506d795e8845ec3.1661192802.git.gitgitgadget@gmail.com>
 <xmqqwnb0av09.fsf@gitster.g> <xmqqfshoataq.fsf@gitster.g>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqfshoataq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.08.22 um 22:59 schrieb Junio C Hamano:
> t5329: notice a failure within a loop
> 
> We try to write "|| return 1" at the end of a sequence of &&-chained
> command in a loop of our tests, so that a failure of any step during
> the earlier iteration of the loop can properly be caught.
> 
> There is one loop in this test script that is used to compute the
> expected result, that will be later compared with an actual output
> produced by the "test-tool pack-mtimes" command.  This particular
> loop, however, is placed on the upstream side of a pipe, whose
> non-zero exit code does not get noticed.
> 
> Emit a line that will never be produced by the "test-tool pack-mtimes"
> to cause the later comparison to fail.  As we use test_cmp to compare
> this "expected output" file with the "actual output", the "error
> message" we are emitting into the expected output stream will stand
> out and shown to the tester.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t5329-pack-objects-cruft.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git c/t/t5329-pack-objects-cruft.sh w/t/t5329-pack-objects-cruft.sh
> index 6049e2c1d7..43d752acc7 100755
> --- c/t/t5329-pack-objects-cruft.sh
> +++ w/t/t5329-pack-objects-cruft.sh
> @@ -29,7 +29,8 @@ basic_cruft_pack_tests () {
>  				while read oid
>  				do
>  					path="$objdir/$(test_oid_to_path "$oid")" &&
> -					printf "%s %d\n" "$oid" "$(test-tool chmtime --get "$path")"
> +					printf "%s %d\n" "$oid" "$(test-tool chmtime --get "$path")" ||
> +					echo "object list generation failed for $obj"

This looks like the right thing to do. But write $oid, not $obj.

>  				done |
>  				sort -k1
>  			) >expect &&
> 
> 

-- Hannes
