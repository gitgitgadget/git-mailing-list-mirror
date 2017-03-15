Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0291202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 22:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbdCOWFX (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 18:05:23 -0400
Received: from avasout01.plus.net ([84.93.230.227]:55088 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752566AbdCOWFV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 18:05:21 -0400
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout01 with smtp
        id wN3w1u00222aPyA01N3xDu; Wed, 15 Mar 2017 22:03:57 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=BZKo6vl2 c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=TmrUauzZN01w56_5tKYA:9 a=QEXdDO2ut3YA:10
 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/6] index-pack: factor out pack/idx finalization
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20170315212617.6x57bvltinuozv4q@sigill.intra.peff.net>
 <20170315212733.73cw22dm36oc5im4@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <f42ba0f5-a879-f63f-1cbd-de268da05966@ramsayjones.plus.com>
Date:   Wed, 15 Mar 2017 22:03:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170315212733.73cw22dm36oc5im4@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 15/03/17 21:27, Jeff King wrote:
> The procedure for moving the ".pack" and the ".idx" files
> into place is the same. Rather than repeat the code, let's
> factor it into a helper function.
> 
> This has the added benefit of clarifying the lifetime of
> "final_pack_name". In the original code it is sometimes
> redirected to our reusable "name" buffer; after we reuse
> that buffer, the contents are nonsense (but nobody looks at
> it, so this is not a bug, just a maintenance issue). In the
> new code, the pointer modification is contained in the
> helper function.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/index-pack.c | 40 +++++++++++++++++++---------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index f4b87c6c9..187c0550c 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1380,6 +1380,23 @@ static void fix_unresolved_deltas(struct sha1file *f)
>  	free(sorted_by_pos);
>  }
>  
> +static void finalize_file(const char *final_name, const char *curr_name,
> +			  unsigned char *sha1, const char *ext)
> +{
> +	if (final_name != curr_name) {
> +		char name[PATH_MAX];
> +		if (!final_name) {
> +			snprintf(name, sizeof(name), "%s/pack/pack-%s.%s",
> +				 get_object_directory(), sha1_to_hex(sha1),
> +				 ext);
> +			final_name = name;
> +		}
> +		if (finalize_object_file(curr_name, final_name))
> +			die(_("cannot store %s file"), ext);
> +	} else if (from_stdin)
> +		chmod(final_name, 0444);
> +}
> +
>  static void final(const char *final_pack_name, const char *curr_pack_name,
>  		  const char *final_index_name, const char *curr_index_name,
>  		  const char *keep_name, const char *keep_msg,
> @@ -1422,27 +1439,8 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
>  		}
>  	}
>  
> -	if (final_pack_name != curr_pack_name) {
> -		if (!final_pack_name) {
> -			snprintf(name, sizeof(name), "%s/pack/pack-%s.pack",
> -				 get_object_directory(), sha1_to_hex(sha1));
> -			final_pack_name = name;
> -		}
> -		if (finalize_object_file(curr_pack_name, final_pack_name))
> -			die(_("cannot store pack file"));
> -	} else if (from_stdin)
> -		chmod(final_pack_name, 0444);
> -
> -	if (final_index_name != curr_index_name) {
> -		if (!final_index_name) {
> -			snprintf(name, sizeof(name), "%s/pack/pack-%s.idx",
> -				 get_object_directory(), sha1_to_hex(sha1));
> -			final_index_name = name;
> -		}
> -		if (finalize_object_file(curr_index_name, final_index_name))
> -			die(_("cannot store index file"));
> -	} else
> -		chmod(final_index_name, 0444);

Is from_stdin always true if final_index_name == curr_index_name?
Was the original asymmetry deliberate?

> +	finalize_file(final_pack_name, curr_pack_name, sha1, "pack");
> +	finalize_file(final_index_name, curr_index_name, sha1, "idx");
>  
>  	if (!from_stdin) {
>  		printf("%s\n", sha1_to_hex(sha1));
> 

ATB,
Ramsay Jones

