Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FE801F453
	for <e@80x24.org>; Tue,  2 Oct 2018 15:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeJBV5I (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 17:57:08 -0400
Received: from avasout02.plus.net ([212.159.14.17]:43278 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbeJBV5I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 17:57:08 -0400
Received: from [10.0.2.15] ([80.189.70.193])
        by smtp with ESMTPA
        id 7MMKgs4azkHg47MMMgRBsj; Tue, 02 Oct 2018 16:13:14 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Q9b8Hb+a c=1 sm=1 tr=0
 a=wSR+GDtF+fsrIzE5OYgxVg==:117 a=wSR+GDtF+fsrIzE5OYgxVg==:17
 a=IkcTkHD0fZMA:10 a=3Job1O-c_WliRMcLOQ8A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v4 4/4] transport.c: introduce core.alternateRefsPrefixes
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1538446826.git.me@ttaylorr.com>
 <0d3521e92a55377d3e37ecd24ff7667dab50d61d.1538446827.git.me@ttaylorr.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <aeee4d8f-b224-2b1b-40fb-d484dbaabae3@ramsayjones.plus.com>
Date:   Tue, 2 Oct 2018 16:13:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0d3521e92a55377d3e37ecd24ff7667dab50d61d.1538446827.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJgKUkli1rhzHwx8gn3LRJfKr8UK34qKoWfvohRvBXvwIA7AeAVP9fMF33zQb807kmKmxAQxj5NYNAnPvKu3SW1e9fpJY6FFHdnvOMq5C1unCW4fF7fa
 hjwbr0rXT+gZ2cyelbdqvk4633GKYI0OOUam/msoNGs7MlUvBvq7uE8s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 02/10/18 03:24, Taylor Blau wrote:
[snip]
> diff --git a/t/t5410-receive-pack-alternates.sh b/t/t5410-receive-pack-alternates.sh
> index 49d0fe44fb..94794c35da 100755
> --- a/t/t5410-receive-pack-alternates.sh
> +++ b/t/t5410-receive-pack-alternates.sh
> @@ -30,4 +30,12 @@ test_expect_success 'with core.alternateRefsCommand' '
>  	test_cmp expect actual.haves
>  '
>  
> +test_expect_success 'with core.alternateRefsPrefixes' '
> +	test_config -C fork core.alternateRefsPrefixes "refs/heads/private" &&
> +	git rev-parse private/branch expect &&

s/expect/>expect/ ?

ATB,
Ramsay Jones

> +	printf "0000" | git receive-pack fork >actual &&
> +	extract_haves <actual >actual.haves &&
> +	test_cmp expect actual.haves
> +'
> +
>  test_done
> diff --git a/transport.c b/transport.c
> index e271b66603..83474add28 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1341,6 +1341,11 @@ static void fill_alternate_refs_command(struct child_process *cmd,
>  		argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
>  		argv_array_push(&cmd->args, "for-each-ref");
>  		argv_array_push(&cmd->args, "--format=%(objectname)");
> +
> +		if (!git_config_get_value("core.alternateRefsPrefixes", &value)) {
> +			argv_array_push(&cmd->args, "--");
> +			argv_array_split(&cmd->args, value);
> +		}
>  	}
>  
>  	cmd->env = local_repo_env;
> 
