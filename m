Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A85BC2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 17:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6534060C41
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 17:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhFVRLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 13:11:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:36166 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhFVRLo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 13:11:44 -0400
Received: (qmail 6101 invoked by uid 109); 22 Jun 2021 17:09:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Jun 2021 17:09:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28817 invoked by uid 111); 22 Jun 2021 17:09:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Jun 2021 13:09:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Jun 2021 13:09:26 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 5/5] load_ref_decorations(): avoid parsing non-tag objects
Message-ID: <YNIZRlTic6K+6rvf@coredump.intra.peff.net>
References: <YNIJw/8p0F3cPfzd@coredump.intra.peff.net>
 <YNILCDz3LpHX7OX0@coredump.intra.peff.net>
 <a93690bc-1d33-0fe0-5ca8-0e8baa9c66e6@gmail.com>
 <YNIYqFFFti73UT5+@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YNIYqFFFti73UT5+@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 22, 2021 at 01:06:48PM -0400, Jeff King wrote:

> > Do you mean "if (objtype < 0)" here? There is a 'type' variable,
> > but it is an enum decoration_type and I can't find a reason why
> > it would be negative. oid_object_info() _does_ return -1 if there
> > is a problem loading the object, so that would make sense.
> 
> Whoops, thanks for catching that. I originally called it "enum
> object_type type", but then of course the compiler informed that there
> was already a "type" variable in the function. So I renamed it to
> "objtype" but missed updating that line. But it still compiled. Yikes. :)
> 
> It doesn't trigger in the test suite because it only happens if the
> repository is corrupted.

I'm tempted by this as a cleanup on top (I don't want to do it inline,
since the diff is so noisy). But I'm also content to leave it.

-- >8 --
Subject: [PATCH] add_ref_decoration(): rename s/type/deco_type/

Now that we have two types (a decoration type and an object type) in the
function, let's give them both unique names to avoid accidentally using
one instead of the other.

Signed-off-by: Jeff King <peff@peff.net>
---
 log-tree.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index c3c8e7e1df..4f69ed176d 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -135,7 +135,7 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 {
 	struct object *obj;
 	enum object_type objtype;
-	enum decoration_type type = DECORATION_NONE;
+	enum decoration_type deco_type = DECORATION_NONE;
 	struct decoration_filter *filter = (struct decoration_filter *)cb_data;
 
 	if (filter && !ref_filter_match(refname, filter))
@@ -162,17 +162,17 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 	obj = lookup_object_by_type(the_repository, oid, objtype);
 
 	if (starts_with(refname, "refs/heads/"))
-		type = DECORATION_REF_LOCAL;
+		deco_type = DECORATION_REF_LOCAL;
 	else if (starts_with(refname, "refs/remotes/"))
-		type = DECORATION_REF_REMOTE;
+		deco_type = DECORATION_REF_REMOTE;
 	else if (starts_with(refname, "refs/tags/"))
-		type = DECORATION_REF_TAG;
+		deco_type = DECORATION_REF_TAG;
 	else if (!strcmp(refname, "refs/stash"))
-		type = DECORATION_REF_STASH;
+		deco_type = DECORATION_REF_STASH;
 	else if (!strcmp(refname, "HEAD"))
-		type = DECORATION_REF_HEAD;
+		deco_type = DECORATION_REF_HEAD;
 
-	add_name_decoration(type, refname, obj);
+	add_name_decoration(deco_type, refname, obj);
 	while (obj->type == OBJ_TAG) {
 		obj = ((struct tag *)obj)->tagged;
 		if (!obj)
-- 
2.32.0.352.gff02c21e72

