Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E2BD1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 04:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbeILJRD (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 05:17:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:46648 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725737AbeILJRD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 05:17:03 -0400
Received: (qmail 5546 invoked by uid 109); 12 Sep 2018 04:14:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Sep 2018 04:14:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23905 invoked by uid 111); 12 Sep 2018 04:14:41 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 12 Sep 2018 00:14:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Sep 2018 00:14:25 -0400
Date:   Wed, 12 Sep 2018 00:14:25 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller@google.com" <sbeller@google.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: Re: [PATCH v2 17/18] commit-reach: make can_all_from_reach... linear
Message-ID: <20180912041425.GA10472@sigill.intra.peff.net>
References: <pull.10.git.gitgitgadget@gmail.com>
 <20180720163227.105950-1-dstolee@microsoft.com>
 <20180720163227.105950-18-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180720163227.105950-18-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 04:33:28PM +0000, Derrick Stolee wrote:

> The can_all_from_reach_with_flags() algorithm is currently quadratic in
> the worst case, because it calls the reachable() method for every 'from'
> without tracking which commits have already been walked or which can
> already reach a commit in 'to'.
> 
> Rewrite the algorithm to walk each commit a constant number of times.

I got a segfault in upload-pack from 'next' today which bisected to this
patch (which became 4fbcca4eff). I think the problem is the line at the
bottom of this hunk:

>  int can_all_from_reach_with_flag(struct object_array *from,
>  				 unsigned int with_flag,
>  				 unsigned int assign_flag,
> -				 time_t min_commit_date)
> +				 time_t min_commit_date,
> +				 uint32_t min_generation)
>  {
> +	struct commit **list = NULL;
>  	int i;
> +	int result = 1;
>  
> +	ALLOC_ARRAY(list, from->nr);
>  	for (i = 0; i < from->nr; i++) {
> -		struct object *from_one = from->objects[i].item;
> +		list[i] = (struct commit *)from->objects[i].item;

Some of the objects in my array are not commits, but rather tags, so
this is a bogus cast.

You can see that the original code peeled them and threw away
non-commits:

>  
> -		if (from_one->flags & assign_flag)
> -			continue;
> -		from_one = deref_tag(the_repository, from_one, "a from object", 0);
> -		if (!from_one || from_one->type != OBJ_COMMIT) {
> -			/* no way to tell if this is reachable by
> -			 * looking at the ancestry chain alone, so
> -			 * leave a note to ourselves not to worry about
> -			 * this object anymore.
> -			 */
> -			from->objects[i].item->flags |= assign_flag;
> -			continue;
> -		}

So presumably we'd need to do something similar.

I think when we're called from can_all_from_reach(), we feed only
commits. But in this case the stack trace is:

  #0  can_all_from_reach_with_flag (from=0x55f95ff42f80 <want_obj>, with_flag=2048, assign_flag=16384, 
      min_commit_date=1513037626, min_generation=0) at commit-reach.c:567
  #1  0x000055f95fe20e92 in ok_to_give_up () at upload-pack.c:346
  #2  0x000055f95fe20efa in get_common_commits () at upload-pack.c:369
  #3  0x000055f95fe22ce9 in upload_pack (options=0x7fff7c1b81f0) at upload-pack.c:1065
  #4  0x000055f95fcdc11b in cmd_upload_pack (argc=1, argv=0x7fff7c1b8498, prefix=0x0)
      at builtin/upload-pack.c:67
  #5  0x000055f95fc39574 in run_builtin (p=0x55f95ff02248 <commands+2760>, argc=2, argv=0x7fff7c1b8498)
      at git.c:417
  #6  0x000055f95fc3987c in handle_builtin (argc=2, argv=0x7fff7c1b8498) at git.c:633
  #7  0x000055f95fc39b02 in cmd_main (argc=2, argv=0x7fff7c1b8498) at git.c:732
  #8  0x000055f95fce044b in main (argc=2, argv=0x7fff7c1b8498) at common-main.c:45

and my client was fetching some tags (though it would similarly break
with other object types). So I'd think the easy reproduction would be
just fetching a tag, but a trivial case didn't seem to trigger (it
probably needs a more substantial negotiation).

-Peff
