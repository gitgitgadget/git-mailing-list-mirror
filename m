Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A02A1FC3E
	for <e@80x24.org>; Thu, 27 Apr 2017 06:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933603AbdD0GO0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 02:14:26 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:5598 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933192AbdD0GOY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 02:14:24 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wD6922HLSz5tlJ;
        Thu, 27 Apr 2017 08:14:14 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 65ABF303E;
        Thu, 27 Apr 2017 08:14:13 +0200 (CEST)
Subject: Re: [PATCH 06/26] get_mail_commit_oid(): avoid resource leak
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
 <1a12ba40a2db3925534bd2192ed8e9ab9a87215e.1493237937.git.johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ac257961-3133-0de4-d918-cfb8da8fbf89@kdbg.org>
Date:   Thu, 27 Apr 2017 08:14:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1a12ba40a2db3925534bd2192ed8e9ab9a87215e.1493237937.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.04.2017 um 22:19 schrieb Johannes Schindelin:
> When we fail to read, or parse, the file, we still want to close the file
> descriptor and release the strbuf.
>
> Reported via Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/am.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 805f56cec2f..01b700e5e74 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1359,15 +1359,16 @@ static int get_mail_commit_oid(struct object_id *commit_id, const char *mail)
>  	struct strbuf sb = STRBUF_INIT;
>  	FILE *fp = xfopen(mail, "r");
>  	const char *x;
> +	int ret = 0;
>
>  	if (strbuf_getline_lf(&sb, fp))
> -		return -1;
> +		ret = -1;
>
> -	if (!skip_prefix(sb.buf, "From ", &x))
> -		return -1;
> +	if (!ret && !skip_prefix(sb.buf, "From ", &x))
> +		ret = -1;
>
> -	if (get_oid_hex(x, commit_id) < 0)
> -		return -1;
> +	if (!ret && get_oid_hex(x, commit_id) < 0)
> +		ret = -1;
>
>  	strbuf_release(&sb);
>  	fclose(fp);
>

You forgot to 'return ret;', didn't you?

-- Hannes

