Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 185C31F404
	for <e@80x24.org>; Sun,  1 Apr 2018 22:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754029AbeDAWuV (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Apr 2018 18:50:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:50376 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753998AbeDAWuT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Apr 2018 18:50:19 -0400
Received: (qmail 4944 invoked by uid 109); 1 Apr 2018 22:50:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 01 Apr 2018 22:50:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14405 invoked by uid 111); 1 Apr 2018 22:51:19 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 01 Apr 2018 18:51:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 01 Apr 2018 18:50:17 -0400
Date:   Sun, 1 Apr 2018 18:50:17 -0400
From:   Jeff King <peff@peff.net>
To:     Dan Aloni <alonid@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] builtin/commit.c: prevent bad commits
Message-ID: <20180401225016.GA21634@sigill.intra.peff.net>
References: <20180401140650.18928-1-alonid@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180401140650.18928-1-alonid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 01, 2018 at 05:06:50PM +0300, Dan Aloni wrote:

> These commits which have hashes starting with the hex string 'bad',
> always give me the chills. Why should a perfectly good commit be
> jinxed?
> 
> Statistically, one of 4096 commits may be 'bad'. This change adds a
> '--prevent-bad' switch to the commit command in order to prevent such
> commit hashes from being generated. Internally, the commit is retried
> with a slight commit meta-data modification - a newline is added to the
> end of the commit message. The meta-data change results in a different
> hash, that if we are lucky enough (4095/4096 chance) may not be 'bad'.
> 
> Note that this change does not affect actual software quality maintained
> using Git. Thus, it is recommended keep testing all generated versions
> regardless of commit hash jinxes.

Cute.

A while back we had patches to generate "desirable" commit prefixes, and
they were focused on making the brute-forcing as fast as possible. I
don't think I've seen this reverse case, but it's much easier: we can be
fairly slow since the probability of hitting the bad case repeatedly is
low.

> @@ -1583,12 +1585,34 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		append_merge_tag_headers(parents, &tail);
>  	}
>  
> -	if (commit_tree_extended(sb.buf, sb.len, &active_cache_tree->oid,
> -				 parents, &oid, author_ident.buf, sign_commit,
> -				 extra)) {
> -		rollback_index_files();
> -		die(_("failed to write commit object"));
> +	for (;;) {
> +		char *oid_hex;
> +		struct commit_list *copy_parents;
> +
> +		copy_parents = copy_commit_list(parents);
> +
> +		if (commit_tree_extended(sb.buf, sb.len, &active_cache_tree->oid,
> +					 parents, &oid, author_ident.buf, sign_commit,
> +					 extra)) {
> +			rollback_index_files();
> +			die(_("failed to write commit object"));
> +		}

You could still have a "bad" tree. :)

-Peff
