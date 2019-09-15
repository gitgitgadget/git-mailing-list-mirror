Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F5931F463
	for <e@80x24.org>; Sun, 15 Sep 2019 16:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbfIOQv6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Sep 2019 12:51:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:50780 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725904AbfIOQv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Sep 2019 12:51:58 -0400
Received: (qmail 402 invoked by uid 109); 15 Sep 2019 16:51:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 15 Sep 2019 16:51:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32088 invoked by uid 111); 15 Sep 2019 16:54:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Sep 2019 12:54:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 15 Sep 2019 12:51:56 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jon Simons <jon@jonsimons.org>, git@vger.kernel.org,
        me@ttaylorr.com, sunshine@sunshineco.com, stolee@gmail.com
Subject: [PATCH 4/3] list-objects-filter: use empty string instead of NULL
 for sparse "base"
Message-ID: <20190915165156.GA28436@sigill.intra.peff.net>
References: <20190829231925.15223-1-jon@jonsimons.org>
 <20190829231925.15223-2-jon@jonsimons.org>
 <xmqqr252y199.fsf@gitster-ct.c.googlers.com>
 <20190904045424.GA6488@sigill.intra.peff.net>
 <xmqqv9u6po4j.fsf@gitster-ct.c.googlers.com>
 <f32d2e8c-abec-0ec1-daa7-4c10470c5553@jeffhostetler.com>
 <20190909170823.GA30470@sigill.intra.peff.net>
 <20190915010942.GA19787@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190915010942.GA19787@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 14, 2019 at 09:09:42PM -0400, Jeff King wrote:

> On Mon, Sep 09, 2019 at 01:08:24PM -0400, Jeff King wrote:
> 
> > I'll work up what I sent earlier into a real patch, and include some of
> > this discussion.
> 
> Here it is. I pulled Jon's tests out into their own patch (mostly
> because it makes it easier to give credit). Then patch 2 is my fix, and
> patch 3 is the message fixups he had done.
> 
> This replaces what's queued in js/partial-clone-sparse-blob.
> 
>   [1/3]: t5616: test cloning/fetching with sparse:oid=<oid> filter
>   [2/3]: list-objects-filter: delay parsing of sparse oid
>   [3/3]: list-objects-filter: give a more specific error sparse parsing error

And here's a bonus patch that I found while running under ASan/UBSan
(since I wanted to double-check the memory handling of patch 2 when
merged with 'next').

-- >8 --
Subject: list-objects-filter: use empty string instead of NULL for sparse "base"

We use add_excludes_from_blob_to_list() to parse a sparse blob. Since
we don't have a base path, we pass NULL and 0 for the base and baselen,
respectively. But the rest of the exclude code passes a literal empty
string instead of NULL for this case. And indeed, we eventually end up
with match_pathname() calling fspathncmp(), which then calls the system
strncmp(path, base, baselen).

This works on many platforms, which notice that baselen is 0 and do not
look at the bytes of "base" at all. But it does violate the C standard,
and building with SANITIZE=undefined will complain. You can also see it
by instrumenting fspathncmp like this:

	diff --git a/dir.c b/dir.c
	index d021c908e5..4bb3d3ec96 100644
	--- a/dir.c
	+++ b/dir.c
	@@ -71,6 +71,8 @@ int fspathcmp(const char *a, const char *b)

	 int fspathncmp(const char *a, const char *b, size_t count)
	 {
	+	if (!a || !b)
	+		BUG("null fspathncmp arguments");
	 	return ignore_case ? strncasecmp(a, b, count) : strncmp(a, b, count);
	 }

We could perhaps be more defensive in match_pathname(), but even if we
did so, it makes sense for this code to match the rest of the exclude
callers.

Signed-off-by: Jeff King <peff@peff.net>
---
 list-objects-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index 50f0c6d07b..83c788e8b5 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -472,7 +472,7 @@ static void *filter_sparse_oid__init(
 		die(_("unable to access sparse blob in '%s'"),
 		    filter_options->sparse_oid_name);
 	d->omits = omitted;
-	if (add_excludes_from_blob_to_list(&sparse_oid, NULL, 0, &d->el) < 0)
+	if (add_excludes_from_blob_to_list(&sparse_oid, "", 0, &d->el) < 0)
 		die(_("unable to parse sparse filter data in %s"),
 		    oid_to_hex(&sparse_oid));
 
-- 
2.23.0.667.gcccf1fbb03

