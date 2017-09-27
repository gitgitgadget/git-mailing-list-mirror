Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5E5120A29
	for <e@80x24.org>; Wed, 27 Sep 2017 23:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbdI0Xtj (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 19:49:39 -0400
Received: from avasout08.plus.net ([212.159.14.20]:56111 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752357AbdI0Xtj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 19:49:39 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout08 with smtp
        id Enpc1w0080M91Ur01npdKR; Thu, 28 Sep 2017 00:49:37 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=EJl26xRC c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=Z4Rwk6OoAAAA:8 a=PKzvZo6CAAAA:8 a=1XWaLZrsAAAA:8
 a=SmQUNsg3GiOK7-FFx98A:9 a=QEXdDO2ut3YA:10 a=HkZW87K1Qel5hWWM3VKY:22
 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] diff: correct newline in summary for renamed files
To:     Stefan Beller <sbeller@google.com>, peff@peff.net
Cc:     git@vger.kernel.org, gitster@pobox.com,
        torvalds@linux-foundation.org
References: <20170927224909.25dfojhx6wzaqwt7@sigill.intra.peff.net>
 <20170927225126.4836-1-sbeller@google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <094ebbd4-1bc6-8360-222f-55a4a16a6ca3@ramsayjones.plus.com>
Date:   Thu, 28 Sep 2017 00:49:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170927225126.4836-1-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 27/09/17 23:51, Stefan Beller wrote:
> In 146fdb0dfe (diff.c: emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY,
> 2017-06-29), the conversion from direct printing to the symbol emission
> dropped the new line character for renamed, copied and rewritten files.
> 
> Add the emission of a newline, add a test for this case.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
>  Peff, I am undecided about the added 'diff --stat' call as that
>  uses a completely different code path and would not show the mode
>  change, but I guess we can just use it to document the current state.
>  
>  Thanks,
>  Stefan
> 
>  diff.c                                        |  1 +
>  t/t4013-diff-various.sh                       | 12 ++++++++++++
>  t/t4013/diff.diff-tree_--stat_initial_mode    |  4 ++++
>  t/t4013/diff.diff-tree_--summary_initial_mode |  3 +++
>  t/t4013/diff.diff-tree_initial_mode           |  3 +++
>  t/t4013/diff.log_--decorate=full_--all        |  6 ++++++
>  t/t4013/diff.log_--decorate_--all             |  6 ++++++
>  7 files changed, 35 insertions(+)
>  create mode 100644 t/t4013/diff.diff-tree_--stat_initial_mode
>  create mode 100644 t/t4013/diff.diff-tree_--summary_initial_mode
>  create mode 100644 t/t4013/diff.diff-tree_initial_mode
> 
> diff --git a/diff.c b/diff.c
> index 3c6a3e0faa..653bb2e72e 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -5272,6 +5272,7 @@ static void show_mode_change(struct diff_options *opt, struct diff_filepair *p,
>  			strbuf_addch(&sb, ' ');
>  			quote_c_style(p->two->path, &sb, NULL, 0);
>  		}
> +		strbuf_addch(&sb, '\n');
>  		emit_diff_symbol(opt, DIFF_SYMBOL_SUMMARY,
>  				 sb.buf, sb.len, 0);
>  		strbuf_release(&sb);
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index d09acfe48e..c515e3e53f 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -90,6 +90,14 @@ test_expect_success setup '
>  	git commit -m "Rearranged lines in dir/sub" &&
>  	git checkout master &&
>  
> +	GIT_AUTHOR_DATE="2006-06-26 00:06:00 +0000" &&
> +	GIT_COMMITTER_DATE="2006-06-26 00:06:00 +0000" &&
> +	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
> +	git checkout -b mode initial &&
> +	git update-index --chmod=+x file0 &&

would 'test_chmod +x file0 &&' work here?

ATB,
Ramsay Jones

