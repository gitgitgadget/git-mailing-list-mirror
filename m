Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76CEF200B9
	for <e@80x24.org>; Thu,  3 May 2018 16:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751741AbeECQbA (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 12:31:00 -0400
Received: from avasout04.plus.net ([212.159.14.19]:34836 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbeECQa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 12:30:59 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id EH8DfDZwTsD7bEH8EfYkHn; Thu, 03 May 2018 17:30:58 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=5kEWciQYd5VufjT58f8A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 03/18] branch-diff: first rudimentary implementation
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <ec51c71779a325263c1b705a6b1bfb003fcd528a.1525361419.git.johannes.schindelin@gmx.de>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <24af8d6e-da6f-2d0b-22a0-6a2a215ac55f@ramsayjones.plus.com>
Date:   Thu, 3 May 2018 17:30:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ec51c71779a325263c1b705a6b1bfb003fcd528a.1525361419.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNfCndNPRfD+vM97j+M0KE2P0/Jh34R9cyU2LoGBEZmRy9sDHmFmQ+kBnG82kSrUNb0hG6w52wgIVcVG0xoyxH2dahkmP3SE0vTRFjIuP1oJ+lkL4WLU
 1uKBu7h7hFBsifhVI+1iN9qpcI/1T9k6nU7P01W/wG0tEiU74DzPRe5Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 03/05/18 16:30, Johannes Schindelin wrote:
> At this stage, `git branch-diff` can determine corresponding commits of
> two related commit ranges. This makes use of the recently introduced
> implementation of the Hungarian algorithm.
> 
> The core of this patch is a straight port of the ideas of tbdiff, the
> seemingly dormant project at https://github.com/trast/tbdiff.
> 
> The output does not at all match `tbdiff`'s output yet, as this patch
> really concentrates on getting the patch matching part right.
> 
> Note: due to differences in the diff algorithm (`tbdiff` uses the
> Pythong module `difflib`, Git uses its xdiff fork), the cost matrix
> calculated by `branch-diff` is different (but very similar) to the one
> calculated by `tbdiff`. Therefore, it is possible that they find
> different matching commits in corner cases (e.g. when a patch was split
> into two patches of roughly equal length).
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/branch-diff.c | 337 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 334 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
> index 97266cd326d..02dc06a57ca 100644
> --- a/builtin/branch-diff.c
> +++ b/builtin/branch-diff.c
> @@ -1,13 +1,17 @@
>  #include "cache.h"
>  #include "parse-options.h"
> +#include "string-list.h"
> +#include "run-command.h"
> +#include "argv-array.h"
> +#include "hashmap.h"
> +#include "xdiff-interface.h"
> +#include "hungarian.h"
>  
>  static const char * const builtin_branch_diff_usage[] = {
>  	N_("git rebase--helper [<options>] ( A..B C..D | A...B | base A B )"),
>  	NULL
>  };
>  
> -#define COLOR_DUAL_MODE 2
> -

This #define was introduced in the previous patch, without being
used in that patch, and is now deleted here.

ATB,
Ramsay Jones
