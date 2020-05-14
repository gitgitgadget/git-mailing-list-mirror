Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28290C433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 18:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E41252065D
	for <git@archiver.kernel.org>; Thu, 14 May 2020 18:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgENSJt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 14:09:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:46662 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726073AbgENSJs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 14:09:48 -0400
Received: (qmail 16564 invoked by uid 109); 14 May 2020 18:09:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 May 2020 18:09:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3251 invoked by uid 111); 14 May 2020 18:09:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 May 2020 14:09:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 May 2020 14:09:47 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 8/8] commit-graph: drop COMMIT_GRAPH_WRITE_CHECK_OIDS
 flag
Message-ID: <20200514180947.GC2430834@coredump.intra.peff.net>
References: <cover.1588641176.git.me@ttaylorr.com>
 <cover.1589407014.git.me@ttaylorr.com>
 <3cb0bd306cbb971715f84db07a8d1acac658f2d0.1589407015.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3cb0bd306cbb971715f84db07a8d1acac658f2d0.1589407015.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 03:59:55PM -0600, Taylor Blau wrote:

> -	result = lookup_commit_reference_gently(the_repository, &oid, 1);
> -	if (result)
> -		oidset_insert(commits, &result->object.oid);
> -	else
> -		return error(_("invalid commit object id: %s"), hash);
> +	result = deref_tag(the_repository, parse_object(the_repository, &oid),
> +			   NULL, 0);
> +	if (!result)
> +		return error(_("invalid object: %s"), hash);

OK. As you noted earlier, this is really "we don't have that object"
_or_ "we don't have an object it points to". But since either is a
corruption, and I'd expect parse_object() to produce a more detailed
message anyway, I don't think it's worth trying to get more specific
here.

> +	else if (object_as_type(the_repository, result, OBJ_COMMIT, 1))
> +		oidset_insert(commits, &result->oid);

I suspect this could just be "if (result->type == OBJ_COMMIT)", as we'd
never see OBJ_NONE from a tag deref (which would have required the
casting behavior), but I don't think it hurts to use this function to be
on the safe side.

-Peff
