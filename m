Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED24D1F454
	for <e@80x24.org>; Fri,  8 Nov 2019 02:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfKHCuO (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 21:50:14 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:50312 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfKHCuO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 21:50:14 -0500
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92.3)
        (envelope-from <mh@glandium.org>)
        id 1iSuLf-0003yP-VT; Fri, 08 Nov 2019 11:50:07 +0900
Date:   Fri, 8 Nov 2019 11:50:07 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com,
        szeder.dev@gmail.com, peff@peff.net, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v5 6/7] revision.c: generation-based topo-order algorithm
Message-ID: <20191108025007.bphr7ynvskeoe6tb@glandium.org>
References: <pull.25.v4.git.gitgitgadget@gmail.com>
 <20181101134623.84055-1-dstolee@microsoft.com>
 <20181101134623.84055-7-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101134623.84055-7-dstolee@microsoft.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replying to this old thread because I have questions regarding the
patch, in the context of problems I had downstream, in git-cinnabar.

On Thu, Nov 01, 2018 at 01:46:22PM +0000, Derrick Stolee wrote:
>  static void init_topo_walk(struct rev_info *revs)
>  {
>  	struct topo_walk_info *info;
> +	struct commit_list *list;
>  	revs->topo_walk_info = xmalloc(sizeof(struct topo_walk_info));

Not directly from this patch, but there's nothing that frees this memory
AFAICS, but then, that's also true for most of the things in struct
rev_info.

> diff --git a/revision.h b/revision.h
> index fd4154ff75..b0b3bb8025 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -24,6 +24,8 @@
>  #define USER_GIVEN	(1u<<25) /* given directly by the user */
>  #define TRACK_LINEAR	(1u<<26)
>  #define ALL_REV_FLAGS	(((1u<<11)-1) | USER_GIVEN | TRACK_LINEAR)
> +#define TOPO_WALK_EXPLORED	(1u<<27)
> +#define TOPO_WALK_INDEGREE	(1u<<28)

Should these two flags be included in ALL_REV_FLAGS?
Should they be reset by reset_revision_walk?

At least for the latter, I'd say yes, otherwise you can end up with
missing revs in a subsequent topo-order revwalk.

Mike
