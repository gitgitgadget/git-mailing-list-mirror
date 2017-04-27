Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7F10207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 17:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753712AbdD0RYZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 13:24:25 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:38773 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751355AbdD0RYX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 13:24:23 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wDP2F5ntYz5tlJ;
        Thu, 27 Apr 2017 19:24:20 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9605743E;
        Thu, 27 Apr 2017 19:24:20 +0200 (CEST)
Subject: Re: [PATCH 22/26] add_reflog_for_walk: avoid memory leak
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
 <aeb46b9436b1f5f54322cb818519db97801b9d7a.1493237937.git.johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <74da6153-2ce4-4224-d8d4-5be7481431ef@kdbg.org>
Date:   Thu, 27 Apr 2017 19:24:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <aeb46b9436b1f5f54322cb818519db97801b9d7a.1493237937.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.04.2017 um 22:21 schrieb Johannes Schindelin:
> We free()d the `log` buffer when dwim_log() returned 1, but not when it
> returned a larger value (which meant that it still allocated the buffer
> but we simply ignored it).
>
> Identified by Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  reflog-walk.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/reflog-walk.c b/reflog-walk.c
> index 99679f58255..ec66f2b16e6 100644
> --- a/reflog-walk.c
> +++ b/reflog-walk.c
> @@ -183,7 +183,11 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
>  		if (!reflogs || reflogs->nr == 0) {
>  			struct object_id oid;
>  			char *b;
> -			if (dwim_log(branch, strlen(branch), oid.hash, &b) == 1) {
> +			int ret = dwim_log(branch, strlen(branch),
> +					   oid.hash, &b);
> +			if (ret > 1)
> +				free(b);
> +			else if (ret == 1) {
>  				if (reflogs) {
>  					free(reflogs->ref);
>  					free(reflogs);
>

Right after this hunk, there is another conditional that looks like it 
forgets to free reflogs.

-- Hannes

