Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974FAC2BA19
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 03:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDA820A8B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 03:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgDJDEL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:04:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:39166 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726659AbgDJDEL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 23:04:11 -0400
Received: (qmail 24137 invoked by uid 109); 10 Apr 2020 03:04:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Apr 2020 03:04:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26480 invoked by uid 111); 10 Apr 2020 03:14:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Apr 2020 23:14:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Apr 2020 23:04:11 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4lyaWNv?= Rolim <erico.erc@gmail.com>,
        git@vger.kernel.org
Subject: Re: Re* [BUG] segmentation fault in git-diff
Message-ID: <20200410030411.GA48173@coredump.intra.peff.net>
References: <CAFDeuWO+2JEGudtnHZvSsSUOVRR83U9ziLEjSoDyMWxYhvDMKg@mail.gmail.com>
 <xmqqh7xsmg7j.fsf@gitster.c.googlers.com>
 <xmqqd08gmg3s.fsf@gitster.c.googlers.com>
 <xmqq4ktsmfnn.fsf@gitster.c.googlers.com>
 <20200409234152.GA42330@coredump.intra.peff.net>
 <xmqqv9m8kxzy.fsf_-_@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv9m8kxzy.fsf_-_@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 09, 2020 at 05:03:45PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But there are a bunch of other commits around the same time replacing
> > the_repository, and it seems like an easy mistake to make. Perhaps we
> > should rename the "refs" member of "struct repository" to something more
> > clearly private, which would force callers to use the access method.
> 
> Here is the final version that I am going to apply and merge to
> 'jch' branch.  This is an ancient regression in Git timescale, so
> its fix is not all that urgent, though.

Agreed. The patch looks good to me.

I prepared the patch below on top. I mostly wanted it as an auditing
tool to find similar cases, but there were none. It may still be worth
applying to protect ourselves in the future.

-- >8 --
Subject: [PATCH] repository: mark the "refs" pointer as private

The "refs" pointer in a struct repository starts life as NULL, but then
is lazily initialized when it is accessed via get_main_ref_store().
However, it's easy for calling code to forget this and access it
directly, leading to code which works _some_ of the time, but fails if
it is called before anybody else accesses the refs.

This was the cause of the bug fixed by 5ff4b920eb (sha1-name: do not
assume that the ref store is initialized, 2020-04-09). In order to
prevent similar bugs, let's more clearly mark the "refs" field as
private.

In addition to helping future code, the name change will help us audit
any existing direct uses. Besides get_main_ref_store() itself, it turns
out there is only one. But we know it's OK as it is on the line directly
after the fix from 5ff4b920eb, which will have initialized the pointer.
However it's still a good idea for it to model the proper use of the
accessing function, so we'll convert it.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c       | 8 ++++----
 repository.h | 8 ++++++--
 sha1-name.c  | 2 +-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 1ab0bb54d3..b8759116cd 100644
--- a/refs.c
+++ b/refs.c
@@ -1852,14 +1852,14 @@ static struct ref_store *ref_store_init(const char *gitdir,
 
 struct ref_store *get_main_ref_store(struct repository *r)
 {
-	if (r->refs)
-		return r->refs;
+	if (r->refs_private)
+		return r->refs_private;
 
 	if (!r->gitdir)
 		BUG("attempting to get main_ref_store outside of repository");
 
-	r->refs = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
-	return r->refs;
+	r->refs_private = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
+	return r->refs_private;
 }
 
 /*
diff --git a/repository.h b/repository.h
index 040057dea6..6534fbb7b3 100644
--- a/repository.h
+++ b/repository.h
@@ -67,8 +67,12 @@ struct repository {
 	 */
 	struct parsed_object_pool *parsed_objects;
 
-	/* The store in which the refs are held. */
-	struct ref_store *refs;
+	/*
+	 * The store in which the refs are held. This should generally only be
+	 * accessed via get_main_ref_store(), as that will lazily initialize
+	 * the ref object.
+	 */
+	struct ref_store *refs_private;
 
 	/*
 	 * Contains path to often used file names.
diff --git a/sha1-name.c b/sha1-name.c
index 878553b132..fccc97fa7a 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1816,7 +1816,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			cb.repo = repo;
 			cb.list = &list;
 			refs_for_each_ref(get_main_ref_store(repo), handle_one_ref, &cb);
-			refs_head_ref(repo->refs, handle_one_ref, &cb);
+			refs_head_ref(get_main_ref_store(repo), handle_one_ref, &cb);
 			commit_list_sort_by_date(&list);
 			return get_oid_oneline(repo, name + 2, oid, list);
 		}
-- 
2.26.0.414.ge3a6455e3d

