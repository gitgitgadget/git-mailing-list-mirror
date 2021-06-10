Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369BDC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 16:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C049613D8
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 16:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhFJQQK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 12:16:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:51508 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230117AbhFJQQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 12:16:09 -0400
Received: (qmail 8288 invoked by uid 109); 10 Jun 2021 16:14:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Jun 2021 16:14:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31708 invoked by uid 111); 10 Jun 2021 16:14:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Jun 2021 12:14:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Jun 2021 12:14:12 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/2] ll_union_merge(): rename path_unused parameter
Message-ID: <YMI6VADKYmK+aV/C@coredump.intra.peff.net>
References: <YMIKwsEFnkqz6PWa@coredump.intra.peff.net>
 <YMIMg+uXDjzS70g5@coredump.intra.peff.net>
 <CABPp-BFu0dJa=KxVtzzDG0RrcPo6bGCVx8P8VhB9sV8OjaYQNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFu0dJa=KxVtzzDG0RrcPo6bGCVx8P8VhB9sV8OjaYQNQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 10, 2021 at 08:19:02AM -0700, Elijah Newren wrote:

> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> >  ll-merge.c            | 2 +-
> >  t/t6406-merge-attr.sh | 3 ++-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/ll-merge.c b/ll-merge.c
> > index 145deb12fa..0ee34d8a01 100644
> > --- a/ll-merge.c
> > +++ b/ll-merge.c
> > @@ -151,7 +151,7 @@ static int ll_union_merge(const struct ll_merge_driver *drv_unused,
> >         o = *opts;
> >         o.variant = XDL_MERGE_FAVOR_UNION;
> >         return ll_xdl_merge(drv_unused, result, path_unused,
> 
> Should we also rename 'path_unused' to 'path', since it is actually used?

That seems reasonable, but I'd prefer to do it as a separate patch. So
here that is.

Ironically, orig_path was unused both before this patch (where we threw
it away and passed NULL instead) and after (where we pass it into the
xdl merge, but the union merge should ignore it completely). But I
prefer not to go too wild with these kind of annotations, as they can
easily become inaccurate or out of date. If we're passing it, then we
shouldn't make too many assumptions about what xdl_merge() is doing
under the hood.

So we could also rename drv_unused mentioned below, but I didn't here.

-- >8 --
Subject: [PATCH] ll_union_merge(): rename path_unused parameter

The "path" parameter to ll_union_merge() is named "path_unused", since
we don't ourselves use it. But we do pass it to ll_xdl_merge(), which
may look at it (it gets passed to ll_binary_merge(), which may pass it
to warning()). Let's rename it to correct this inaccuracy (both of the
other functions correctly do not call this "unused").

Note that we also pass drv_unused, but it truly is unused by the rest of
the stack (it only exists at all to provide a generic interface that
matches what ll_ext_merge() needs).

Reported-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 ll-merge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ll-merge.c b/ll-merge.c
index 0ee34d8a01..261657578c 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -138,7 +138,7 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 
 static int ll_union_merge(const struct ll_merge_driver *drv_unused,
 			  mmbuffer_t *result,
-			  const char *path_unused,
+			  const char *path,
 			  mmfile_t *orig, const char *orig_name,
 			  mmfile_t *src1, const char *name1,
 			  mmfile_t *src2, const char *name2,
@@ -150,7 +150,7 @@ static int ll_union_merge(const struct ll_merge_driver *drv_unused,
 	assert(opts);
 	o = *opts;
 	o.variant = XDL_MERGE_FAVOR_UNION;
-	return ll_xdl_merge(drv_unused, result, path_unused,
+	return ll_xdl_merge(drv_unused, result, path,
 			    orig, orig_name, src1, name1, src2, name2,
 			    &o, marker_size);
 }
-- 
2.32.0.529.g079a794268

