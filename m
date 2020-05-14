Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67420C433DF
	for <git@archiver.kernel.org>; Thu, 14 May 2020 18:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C67120657
	for <git@archiver.kernel.org>; Thu, 14 May 2020 18:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgENSBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 14:01:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:46632 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726035AbgENSBv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 14:01:51 -0400
Received: (qmail 16495 invoked by uid 109); 14 May 2020 18:01:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 May 2020 18:01:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3061 invoked by uid 111); 14 May 2020 18:01:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 May 2020 14:01:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 May 2020 14:01:50 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 5/8] builtin/commit-graph.c: dereference tags in
 builtin
Message-ID: <20200514180150.GB2430834@coredump.intra.peff.net>
References: <cover.1588641176.git.me@ttaylorr.com>
 <cover.1589407014.git.me@ttaylorr.com>
 <56403dd377b996d21a4da1e01ffd6e691ac120bd.1589407014.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56403dd377b996d21a4da1e01ffd6e691ac120bd.1589407014.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 03:59:44PM -0600, Taylor Blau wrote:

> -static int read_one_commit(struct oidset *commits, const char *hash)
> +static int read_one_commit(struct oidset *commits, struct progress *progress,
> +			   const char *hash)
>  {
> +	struct commit *result;
>  	struct object_id oid;
>  	const char *end;
>  
>  	if (parse_oid_hex(hash, &oid, &end))
>  		return error(_("unexpected non-hex object ID: %s"), hash);
>  
> -	oidset_insert(commits, &oid);
> +	result = lookup_commit_reference_gently(the_repository, &oid, 1);
> +	if (result)
> +		oidset_insert(commits, &result->object.oid);
> +	else
> +		return error(_("invalid commit object id: %s"), hash);
> +
> +	display_progress(progress, oidset_size(commits));
> +

I expected this to switch to deref_tag() here, but it looks like you do
it in the final commit. That makes sense, since this step is really just
copying the existing logic.

> @@ -249,6 +265,8 @@ static int graph_write(int argc, const char **argv)
>  cleanup:
>  	UNLEAK(pack_indexes);
>  	strbuf_release(&buf);
> +	if (progress)
> +		stop_progress(&progress);
>  	return result;

Really minor nit, but stop_progress(), like display_progress(), handles
NULL already. So you can lose the "if" here.

-Peff
