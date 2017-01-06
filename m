Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C3B620756
	for <e@80x24.org>; Fri,  6 Jan 2017 09:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034937AbdAFJpR (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 04:45:17 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:13484 "EHLO bsmtp5.bon.at"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753283AbdAFJob (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 04:44:31 -0500
Received: from bsmtp3.bon.at (unknown [192.168.181.102])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 3tw0401JC0z5v0d
        for <git@vger.kernel.org>; Fri,  6 Jan 2017 10:43:44 +0100 (CET)
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 3tw02n4hWkz5tlX;
        Fri,  6 Jan 2017 10:42:41 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A036037C;
        Fri,  6 Jan 2017 10:42:40 +0100 (CET)
Subject: Re: [PATCH v2 4/4] mergetool: fix running in subdir when rerere
 enabled
To:     Richard Hansen <hansenr@google.com>
References: <20170104005042.51530-1-hansenr@google.com>
 <20170106010945.79382-1-hansenr@google.com>
 <20170106010945.79382-5-hansenr@google.com>
Cc:     git@vger.kernel.org, davvid@gmail.com, sbeller@google.com,
        simon@ruderich.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <199807ae-844c-57cd-28cf-2c10b3aee7a9@kdbg.org>
Date:   Fri, 6 Jan 2017 10:42:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170106010945.79382-5-hansenr@google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.01.2017 um 02:09 schrieb Richard Hansen:
> If rerere is enabled and no pathnames are given, run cd_to_toplevel
> before running 'git diff --name-only' so that 'git diff --name-only'
> sees the pathnames emitted by 'git rerere remaining'.
>
> Also run cd_to_toplevel before running 'git rerere remaining' in case
> 'git rerere remaining' is ever changed to print pathnames relative to
> the current directory rather than to $GIT_WORK_TREE.
>
> This fixes a regression introduced in
> 57937f70a09c12ef484c290865dac4066d207c9c (v2.11.0).
>
> Signed-off-by: Richard Hansen <hansenr@google.com>
> ---
>  git-mergetool.sh     | 1 +
>  t/t7610-mergetool.sh | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index e52b4e4f2..67ea0d6db 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -456,6 +456,7 @@ main () {
>
>  	if test $# -eq 0 && test -e "$GIT_DIR/MERGE_RR"
>  	then
> +		cd_to_toplevel
>  		set -- $(git rerere remaining)
>  		if test $# -eq 0
>  		then

This cannot be a complete solution. Why do we have another 
cd_to_toplevel later, after `git diff --name-only -- "$@"`?

Maybe it is necessary to revert back to the flow control that we had 
before 57937f70a09c ("mergetool: honor diff.orderFile", 2016-10-07)? It 
did not have `test $# -eq 0` and `test -e "$GIT_DIR/MERGE_RR"` in a 
single condition.

-- Hannes

