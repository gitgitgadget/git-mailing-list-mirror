Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E628B1F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 14:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966362AbcIYOHa (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 10:07:30 -0400
Received: from avasout02.plus.net ([212.159.14.17]:52072 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966241AbcIYOHa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 10:07:30 -0400
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout02 with smtp
        id nq7P1t00B0zhorE01q7Qyz; Sun, 25 Sep 2016 15:07:27 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=G/5eKJs5 c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=N659UExz7-8A:10 a=yPCof4ZbAAAA:8 a=8g43MHvMHfh0Z69teiIA:9 a=pILNOxqGKmIA:10
 a=2lfDSYhZ3Z6b8uxcDO-Z:22
X-AUTH: ramsayjones@:2500
Subject: Re: [RFC PATCH v2] revision: new rev^-n shorthand for rev^n..rev
To:     Vegard Nossum <vegard.nossum@oracle.com>, git@vger.kernel.org
References: <20160925085511.12515-1-vegard.nossum@oracle.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Santi_B=c3=a9jar?= <sbejar@gmail.com>,
        Kevin Bracey <kevin@bracey.fi>,
        Philip Oakley <philipoakley@iee.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <b4fda9ca-7dab-dee7-d963-0555a372b345@ramsayjones.plus.com>
Date:   Sun, 25 Sep 2016 15:07:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160925085511.12515-1-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 25/09/16 09:55, Vegard Nossum wrote:
> I use rev^..rev daily, and I'm surely not the only one. To save typing
> (or copy-pasting, if the rev is long -- like a full SHA-1 or branch name)
> we can make rev^- a shorthand for that.
> 
> The existing syntax rev^! seems like it should do the same, but it
> doesn't really do the right thing for merge commits (it gives only the
> merge itself).
> 
> As a natural generalisation, we also accept rev^-n where n excludes the
> nth parent of rev, although this is expected to be generally less useful.
> 
> [v2: Use ^- instead of % as suggested by Junio Hamano and use some
>  common helper functions for parsing.]

I would place this v2 commentary below the '---' marker (so that it
won't appear in the commit message) ...

> 
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---

... here.

>  Documentation/revisions.txt | 14 +++++++
>  builtin/rev-parse.c         | 28 ++++++++++++++
>  revision.c                  | 91 +++++++++++++++++++++++++++++++++++++++++++++
>  revision.h                  |  1 +
>  4 files changed, 134 insertions(+)
> 
> diff --git Documentation/revisions.txt Documentation/revisions.txt
> index 4bed5b1..6e33801 100644
> --- Documentation/revisions.txt
> +++ Documentation/revisions.txt
> @@ -281,6 +281,14 @@ is a shorthand for 'HEAD..origin' and asks "What did the origin do since
>  I forked from them?"  Note that '..' would mean 'HEAD..HEAD' which is an
>  empty range that is both reachable and unreachable from HEAD.
>  
> +Parent Exclusion Notation
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +The '<rev>{caret}-{<n>}', Parent Exclusion Notation::
> +Shorthand for '<rev>{caret}<n>..<rev>', with '<n>' = 1 if not
> +given. This is typically useful for merge commits where you
> +can just pass '<commit>{caret}-' to get all the commits in the branch
> +that was merged in merge commit '<commit>'.
> +
>  Other <rev>{caret} Parent Shorthand Notations
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  Two other shorthands exist, particularly useful for merge commits,
> @@ -316,6 +324,10 @@ Revision Range Summary
>  	<rev2> but exclude those that are reachable from both.  When
>  	either <rev1> or <rev2> is omitted, it defaults to `HEAD`.
>  
> +'<rev>{caret}-{<n>}', e.g. 'HEAD{caret}, HEAD{caret}-2'::

missing '-' ------------------------------^

> +	Equivalent to '<rev>{caret}<n>..<rev>', with '<n>' = 1 if not
> +	given.
> +
>  '<rev>{caret}@', e.g. 'HEAD{caret}@'::
>    A suffix '{caret}' followed by an at sign is the same as listing
>    all parents of '<rev>' (meaning, include anything reachable from
> @@ -339,6 +351,8 @@ spelt out:
>     C                            I J F C
>     B..C   = ^B C                C
>     B...C  = B ^F C              G H D E B C
> +   B^-    = B^..B
> +	  = B ^B^1              E I J F B
>     C^@    = C^1
>  	  = F                   I J F
>     B^@    = B^1 B^2 B^3
> diff --git builtin/rev-parse.c builtin/rev-parse.c
> index 76cf05e..ad5e6ac 100644
> --- builtin/rev-parse.c
> +++ builtin/rev-parse.c
> @@ -292,6 +292,32 @@ static int try_difference(const char *arg)
>  	return 0;
>  }
>  
> +static int try_parent_exclusion(const char *arg)
> +{
> +	int ret = 0;
> +	char *to_rev = NULL;
> +	char *from_rev = NULL;
> +	unsigned char to_sha1[20];
> +	unsigned char from_sha1[20];

As Matthieu already mentioned, maybe use 'struct object_id' here.

> +
> +	if (parse_parent_exclusion(arg, &to_rev, &from_rev))
> +		goto out;
> +	if (get_sha1_committish(to_rev, to_sha1))

... then 'to_sha1.hash' here, etc ...

ATB,
Ramsay Jones

