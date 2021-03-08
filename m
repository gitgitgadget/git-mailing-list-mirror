Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BDDC433E6
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 19:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A9D65288
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 19:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhCHTMu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 14:12:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:55890 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231226AbhCHTM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 14:12:26 -0500
Received: (qmail 26689 invoked by uid 109); 8 Mar 2021 19:12:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Mar 2021 19:12:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20685 invoked by uid 111); 8 Mar 2021 19:12:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Mar 2021 14:12:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 8 Mar 2021 14:12:25 -0500
From:   Jeff King <peff@peff.net>
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH 3/7] clone: free or UNLEAK further pointers when finished
Message-ID: <YEZ3Gf0f/NfXiwW2@coredump.intra.peff.net>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
 <107e98d00e1685e0144ee2415b8220c53542e5a3.1615228580.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <107e98d00e1685e0144ee2415b8220c53542e5a3.1615228580.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 08, 2021 at 06:36:16PM +0000, Andrzej Hunt via GitGitGadget wrote:

> @@ -1017,9 +1017,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	repo_name = argv[0];
>  
>  	path = get_repo_path(repo_name, &is_bundle);
> -	if (path)
> +	if (path) {
> +		free(path);
>  		repo = absolute_pathdup(repo_name);

You mentioned that "path" gets reused again later. Should we use
FREE_AND_NULL() to make sure that nobody tries to look at it in the
meantime?

> @@ -1393,6 +1394,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	strbuf_release(&reflog_msg);
>  	strbuf_release(&branch_top);
>  	strbuf_release(&key);
> +	free_refs(mapped_refs);
> +	free_refs((void *)remote_head_points_at);

We should avoid casting away constness when possible (because it is
often a sign that sometimes the variable _isn't_ pointing to owned
memory). In this case, I think freeing is the right thing; our
guess_remote_head() returns a copy of the struct (which is non-const).
Should remote_head_points_at just be declared without const?

> +	free_refs((void *)refs);

This one is more questionable to me. It comes from
transport_get_remote_refs(), which does return a const pointer. And it
looks like that memory is owned by the transport struct. So presumably
we need to tell the transport code to clean itself up (or mark it with
UNLEAK). Or perhaps there's a bug in the transport code (e.g., should it
be freeing transport->remote_refs in transport_disconnect()? You'd want
to make sure that no other callers expect the ref list to live on past
the disconnect).

> +	UNLEAK(repo);

This one could be done with the idiom I mentioned earlier:

  repo = absolute_repo = absolute_pathdup(repo_name);
  ...
  free(absolute_repo);

but I think this is a perfect use of UNLEAK().

-Peff
