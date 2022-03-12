Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D80C433EF
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 09:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiCLJGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Mar 2022 04:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiCLJGO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Mar 2022 04:06:14 -0500
Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B012F2AC6C
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 01:05:09 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4KFxhg2ssqz5tl9;
        Sat, 12 Mar 2022 10:05:07 +0100 (CET)
Message-ID: <d13532cb-4f7d-d211-ff5c-26f90bd1c859@kdbg.org>
Date:   Sat, 12 Mar 2022 10:05:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [GSoC] [PATCH v3 0/2] avoid pipes with Git on LHS
Content-Language: en-US
To:     Shubham Mishra <shivam828787@gmail.com>
Cc:     me@ttaylorr.com, kaartic.sivaraam@gmail.com, git@vger.kernel.org
References: <20220224054720.23996-1-shivam828787@gmail.com>
 <20220312062126.31988-1-shivam828787@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20220312062126.31988-1-shivam828787@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.03.22 um 07:21 schrieb Shubham Mishra:
> changes since v2:
> * t0000: remove git command out of subshell
> * t0030: fix missing redirections to "tmp" file
> Shubham Mishra (2):
>   t0001-t0028: avoid pipes with Git on LHS
>   t0030-t0050: avoid pipes with Git on LHS
> 
>  t/t0000-basic.sh            | 10 +++--
>  t/t0022-crlf-rename.sh      |  4 +-
>  t/t0025-crlf-renormalize.sh |  4 +-
>  t/t0027-auto-crlf.sh        | 12 +++---
>  t/t0030-stripspace.sh       | 75 ++++++++++++++++++++++++-------------
>  t/t0050-filesystem.sh       |  3 +-
>  6 files changed, 66 insertions(+), 42 deletions(-)
> 
> Range-diff against v2:
> 1:  2a219ace42 ! 1:  5e122c0acf t0001-t0028: avoid pipes with Git on LHS
>     @@ t/t0000-basic.sh: test_expect_success 'update-index D/F conflict' '
>       '
>       
>      @@ t/t0000-basic.sh: test_expect_success 'very long name in the index handled sanely' '
>     + 
>       	>path4 &&
>       	git update-index --add path4 &&
>     ++	git ls-files -s path4 >tmp &&
>       	(
>      -		git ls-files -s path4 |
>      -		sed -e "s/	.*/	/" |
>     -+		git ls-files -s path4 >tmp &&
>      +		sed -e "s/	.*/	/" tmp |
>       		tr -d "\012" &&
>       		echo "$a"
> 2:  c90fc271d9 ! 2:  c412380af3 t0030-t0050: avoid pipes with Git on LHS
>     @@ t/t0030-stripspace.sh: test_expect_success \
>      -    ! (printf "$ttt$sss$sss$sss" | git stripspace | grep "  " >/dev/null)
>      +    printf "$ttt$sss" | git stripspace >tmp &&
>      +    ! grep "  " tmp >/dev/null &&
>     -+    printf "$ttt$ttt$sss" | git stripspace &&
>     ++    printf "$ttt$ttt$sss" | git stripspace >tmp &&
>      +    ! grep "  " tmp >/dev/null &&
>     -+    printf "$ttt$ttt$ttt$sss" | git stripspace &&
>     ++    printf "$ttt$ttt$ttt$sss" | git stripspace >tmp &&
>      +    ! grep "  " tmp >/dev/null &&
>     -+    printf "$ttt$sss$sss" | git stripspace &&
>     ++    printf "$ttt$sss$sss" | git stripspace >tmp &&
>      +    ! grep "  " tmp >/dev/null &&
>     -+    printf "$ttt$ttt$sss$sss" | git stripspace &&
>     ++    printf "$ttt$ttt$sss$sss" | git stripspace >tmp &&
>      +    ! grep "  " tmp >/dev/null &&
>     -+    printf "$ttt$sss$sss$sss" | git stripspace &&
>     ++    printf "$ttt$sss$sss$sss" | git stripspace >tmp &&
>      +    ! grep "  " tmp >/dev/null
>       '
>       
>     @@ t/t0030-stripspace.sh: test_expect_success \
>      +    echo "$ttt$sss" | git stripspace >tmp &&
>      +    ! grep "  " tmp >/dev/null &&
>      +    echo "$ttt$ttt$sss" | git stripspace >tmp &&
>     -+    ! grep "  " tmp>/dev/null &&
>     -+    echo "$ttt$ttt$ttt$sss" &&
>     ++    ! grep "  " tmp >/dev/null &&
>     ++    echo "$ttt$ttt$ttt$sss" | git stripspace >tmp &&
>      +    ! grep "  " tmp >/dev/null &&
>      +    echo "$ttt$sss$sss" | git stripspace >tmp &&
>      +    ! grep "  " tmp >/dev/null &&

This round addresses all my comments. Thanks!

-- Hannes
