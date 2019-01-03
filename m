Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45DE31F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 01:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfACBTb (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 20:19:31 -0500
Received: from avasout04.plus.net ([212.159.14.19]:50169 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfACBTb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 20:19:31 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id erfUgpa0pAOoyerfVgxujs; Thu, 03 Jan 2019 01:19:29 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Rdm+9Wlv c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=w0RzvLSWAAAA:20 a=pGLkceISAAAA:8 a=dIu3SnmMAAAA:8
 a=ybZZDoGAAAAA:8 a=4v7Y4pUpwEBW1T5nccUA:9 a=QEXdDO2ut3YA:10
 a=Ua9G7VpiFza3u12uuhVB:22 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v17 0/7] git bisect: convert from shell to C
To:     Tanushree Tumane via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
 <pull.101.v17.git.gitgitgadget@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <d64492dc-4643-823b-c804-3c152c4d9090@ramsayjones.plus.com>
Date:   Thu, 3 Jan 2019 01:19:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <pull.101.v17.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMgN/FfwiUF/iijDJl08v9mFiGvf8RvkMVIFSbB0890kBmZi1pk+yTwtK7ceNsOQ2Shqul3w7ijjfox3W9WqsBDxBkTmlXCrmonBZTHz5qOe7OhcxOr+
 4GICMSHZVzRJd/1Pf/5m8OAZUYFS59JgYf3xuUZe7S+FFn+72BW1xVgG+/lruXDIxKjx0xhC06TRDw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 02/01/2019 15:38, Tanushree Tumane via GitGitGadget wrote:
[snip]
> base-commit: 7f4e64169352e03476b0ea64e7e2973669e491a2
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-101%2Ftanushree27%2Fgit-bisect_part2_fixup-v17
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-101/tanushree27/git-bisect_part2_fixup-v17
> Pull-Request: https://github.com/gitgitgadget/git/pull/101

I didn't look at the patches, only the range-diff below, and the
only thing I noticed was ...

> 
> Range-diff vs v16:
> 
>  1:  f1e89ba517 ! 1:  338ebdc97a bisect--helper: `bisect_reset` shell function in C
>      @@ -16,8 +16,9 @@
>       
>           Mentored-by: Lars Schneider <larsxschneider@gmail.com>
>           Mentored-by: Christian Couder <chriscool@tuxfamily.org>
>      +    Mentored by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>           Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>      -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>      +    Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
>       
>        diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>        --- a/builtin/bisect--helper.c
>      @@ -53,8 +54,10 @@
>       +	struct strbuf branch = STRBUF_INIT;
>       +
>       +	if (!commit) {
>      -+		if (strbuf_read_file(&branch, git_path_bisect_start(), 0) < 1)
>      -+			return !printf(_("We are not bisecting.\n"));
>      ++		if (strbuf_read_file(&branch, git_path_bisect_start(), 0) < 1) {
>      ++			printf(_("We are not bisecting.\n"));
>      ++			return 0;
>      ++		}
>       +		strbuf_rtrim(&branch);
>       +	} else {
>       +		struct object_id oid;
>      @@ -69,11 +72,11 @@
>       +
>       +		argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
>       +		if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
>      -+			error(_("Could not check out original HEAD '%s'. Try "
>      -+				"'git bisect reset <commit>'."), branch.buf);
>       +			strbuf_release(&branch);
>       +			argv_array_clear(&argv);
>      -+			return -1;
>      ++			return error(_("could not check out original"
>      ++				       " HEAD '%s'. Try 'git bisect"
>      ++				       "reset <commit>'."), branch.buf);

... this 'branch.buf' will refer to the empty 'slopbuf', since
the call to 'strbuf_release(&branch)' now precedes this call
to error().

ATB,
Ramsay Jones
