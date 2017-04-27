Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31A3B207E4
	for <e@80x24.org>; Thu, 27 Apr 2017 06:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162122AbdD0G1t (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 02:27:49 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:24968 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162110AbdD0G1p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 02:27:45 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wD6SZ3CkSz5tlH;
        Thu, 27 Apr 2017 08:27:42 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 77FB2303E;
        Thu, 27 Apr 2017 08:27:41 +0200 (CEST)
Subject: Re: [PATCH 14/26] setup_bare_git_dir(): fix memory leak
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
 <042b3e98e9e5b8850c35103cc56cf651b2fb3f6e.1493237937.git.johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <51f2bd16-7c55-7ba0-c963-6f725b2f79e5@kdbg.org>
Date:   Thu, 27 Apr 2017 08:27:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <042b3e98e9e5b8850c35103cc56cf651b2fb3f6e.1493237937.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.04.2017 um 22:20 schrieb Johannes Schindelin:
> Reported by Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/setup.c b/setup.c
> index 0309c278218..0320a9ad14c 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -748,7 +748,7 @@ static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
>
>  	/* --work-tree is set without --git-dir; use discovered one */
>  	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
> -		const char *gitdir;
> +		static const char *gitdir;
>
>  		gitdir = offset == cwd->len ? "." : xmemdupz(cwd->buf, offset);
>  		if (chdir(cwd->buf))
>

Whoa! Look what values are assigned to the variable: Either a static 
string or allocated memory. I suspect that this does not fix a memory 
leak at all, but only shuts up Coverity.

-- Hannes

PS: stopping here as I'm running out of time.

