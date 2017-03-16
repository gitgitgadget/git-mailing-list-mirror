Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A91720953
	for <e@80x24.org>; Thu, 16 Mar 2017 15:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbdCPPiw (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 11:38:52 -0400
Received: from avasout01.plus.net ([84.93.230.227]:35065 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751321AbdCPPiv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 11:38:51 -0400
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout01 with smtp
        id wfdq1u00322aPyA01fdrDF; Thu, 16 Mar 2017 15:37:51 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=BZKo6vl2 c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=_bx6g-jzuzbEV120i7MA:9 a=QEXdDO2ut3YA:10
 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 4/5] replace snprintf with odb_pack_name()
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20170316142647.t6tthkcgon3rpg4m@sigill.intra.peff.net>
 <20170316142715.zdoikgyy3difeafk@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <1d148aca-9602-200c-2356-7b16b8c32df7@ramsayjones.plus.com>
Date:   Thu, 16 Mar 2017 15:37:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170316142715.zdoikgyy3difeafk@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 16/03/17 14:27, Jeff King wrote:
> In several places we write the name of the pack filename
> into a fixed-size buffer using snprintf(), but do not check
> the return value.  As a result, a very long object directory
> could cause us to quietly truncate the pack filename
> (potentially leading to a corrupted repository, as a newly
> written packfile could be missing its .pack extension).
> 
> We can use odb_pack_name() to do this with a strbuf (and
> shorten the code, as well).
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/index-pack.c | 27 +++++++++++----------------
>  fast-import.c        | 28 +++++++++++++---------------
>  2 files changed, 24 insertions(+), 31 deletions(-)
> 
[snip]

> diff --git a/fast-import.c b/fast-import.c
> index dad697653..41a539f97 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -940,43 +940,40 @@ static const char *create_index(void)
>  
>  static char *keep_pack(const char *curr_index_name)
>  {
> -	static char name[PATH_MAX];
>  	static const char *keep_msg = "fast-import";
> +	struct strbuf name = STRBUF_INIT;
>  	int keep_fd;
>  
> -	snprintf(name, sizeof(name), "%s/pack/pack-%s.keep",
> -		 get_object_directory(), sha1_to_hex(pack_data->sha1));
> -	keep_fd = odb_pack_keep(name);
> +	odb_pack_name(&name, pack_data->sha1, "keep");
> +	keep_fd = odb_pack_keep(name.buf);
>  	if (keep_fd < 0)
>  		die_errno("cannot create keep file");
>  	write_or_die(keep_fd, keep_msg, strlen(keep_msg));
>  	if (close(keep_fd))
>  		die_errno("failed to write keep file");
>  
> -	snprintf(name, sizeof(name), "%s/pack/pack-%s.pack",
> -		 get_object_directory(), sha1_to_hex(pack_data->sha1));
> -	if (finalize_object_file(pack_data->pack_name, name))
> +	odb_pack_name(&name, pack_data->sha1, "pack");
> +	if (finalize_object_file(pack_data->pack_name, name.buf))
>  		die("cannot store pack file");
>  
> -	snprintf(name, sizeof(name), "%s/pack/pack-%s.idx",
> -		 get_object_directory(), sha1_to_hex(pack_data->sha1));
> -	if (finalize_object_file(curr_index_name, name))
> +	odb_pack_name(&name, pack_data->sha1, "idx");
> +	if (finalize_object_file(curr_index_name, name.buf))
>  		die("cannot store index file");
>  	free((void *)curr_index_name);
> -	return name;
> +	return strbuf_detach(&name, NULL);

Hmm, who deletes this, ...

>  }
>  
>  static void unkeep_all_packs(void)
>  {
> -	static char name[PATH_MAX];
> +	struct strbuf name = STRBUF_INIT;
>  	int k;
>  
>  	for (k = 0; k < pack_id; k++) {
>  		struct packed_git *p = all_packs[k];
> -		snprintf(name, sizeof(name), "%s/pack/pack-%s.keep",
> -			 get_object_directory(), sha1_to_hex(p->sha1));
> -		unlink_or_warn(name);
> +		odb_pack_name(&name, p->sha1, "keep");
> +		unlink_or_warn(name.buf);
>  	}
> +	strbuf_release(&name);
>  }
>  
>  static int loosen_small_pack(const struct packed_git *p)
> @@ -1035,6 +1032,7 @@ static void end_packfile(void)
>  			die("core git rejected index %s", idx_name);
>  		all_packs[pack_id] = new_p;
>  		install_packed_git(new_p);
> +		free(idx_name);

Ah, OK. Yep, no leaks here. ;-)

>  
>  		/* Print the boundary */
>  		if (pack_edges) {
> 

ATB,
Ramsay Jones

