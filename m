Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7344C201B0
	for <e@80x24.org>; Mon, 20 Feb 2017 08:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750985AbdBTIJb (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 03:09:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:58637 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750842AbdBTIJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 03:09:29 -0500
Received: (qmail 7435 invoked by uid 109); 20 Feb 2017 08:09:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Feb 2017 08:09:04 +0000
Received: (qmail 7275 invoked by uid 111); 20 Feb 2017 08:09:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Feb 2017 03:09:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Feb 2017 03:09:02 -0500
Date:   Mon, 20 Feb 2017 03:09:02 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 03/19] builtin/diff-tree: convert to struct object_id
Message-ID: <20170220080902.vkexezd5solnhrhb@sigill.intra.peff.net>
References: <20170220001031.559931-1-sandals@crustytoothpaste.net>
 <20170220001031.559931-4-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170220001031.559931-4-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 20, 2017 at 12:10:15AM +0000, brian m. carlson wrote:

>  /* Diff one or more commits. */
> -static int stdin_diff_commit(struct commit *commit, char *line, int len)
> +static int stdin_diff_commit(struct commit *commit, const char *p)
>  {
> -	unsigned char sha1[20];
> -	if (isspace(line[40]) && !get_sha1_hex(line+41, sha1)) {
> +	struct object_id oid;
> +	if (isspace(*p++) && !parse_oid_hex(p, &oid, &p)) {
>  		/* Graft the fake parents locally to the commit */
> -		int pos = 41;
>  		struct commit_list **pptr;
>  
>  		/* Free the real parent list */
>  		free_commit_list(commit->parents);
>  		commit->parents = NULL;
>  		pptr = &(commit->parents);
> -		while (line[pos] && !get_sha1_hex(line + pos, sha1)) {
> -			struct commit *parent = lookup_commit(sha1);
> +		while (isspace(*p++) && !parse_oid_hex(p, &oid, &p)) {
> +			struct commit *parent = lookup_commit(oid.hash);
>  			if (parent) {
>  				pptr = &commit_list_insert(parent, pptr)->next;
>  			}
> -			pos += 41;
>  		}
>  	}

Are you sure this is right? The first "if" will advance the "p" pointer,
and we'll miss it in the inner loop.

IOW, the original looked something like:

  1. see if we have any parents after the initial commit sha1

  2. if so, then free the original parent list, so we can parse the new
     ones

  3. starting at pos 41 (the same one we parsed in the conditional!),
     loop and parse each parent sha1

The conditional in step 1 can't advance our pointer, or we miss the
first parent in step 3.

It's silly to parse the same sha1 twice, though. You could solve it by
adding the first "oid" from the conditional to the new parent list. In
my "something like this" patch, I solved it by dropping the conditional,
and just having the inner loop. It lazily drops the old parent list on
the first iteration.

It's a little disturbing that we do not seem to have even a basic test
of:

  git rev-list --parents HEAD | git diff-tree --stdin

which would exercise this code.

-Peff
