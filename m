Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E79AC5479D
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 18:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbjAKS0p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 13:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbjAKS0l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 13:26:41 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CA962EA
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 10:26:24 -0800 (PST)
Received: (qmail 29964 invoked by uid 109); 11 Jan 2023 18:26:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Jan 2023 18:26:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7715 invoked by uid 111); 11 Jan 2023 18:26:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Jan 2023 13:26:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Jan 2023 13:26:23 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 0/5] cleaning up read_object() family of functions
Message-ID: <Y77/T8dktee3wOA5@coredump.intra.peff.net>
References: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
 <f1028cba-5fc6-3584-3f21-545550012e9d@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f1028cba-5fc6-3584-3f21-545550012e9d@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 09, 2023 at 10:09:32AM -0500, Derrick Stolee wrote:

> I did think that requiring callers to create their own object_info
> structs (which takes at least four lines) would be too much, but
> the number of new callers is so low that I think this is a fine place
> to stop.

Yeah, that was my feeling. I do wonder if there's a way to make it
easier for callers of oid_object_info_extended(), but I couldn't come up
with anything that's nice enough to merit the complexity.

For example, here's an attempt to let the caller use designated
initializers to set up the query struct:

diff --git a/object-file.c b/object-file.c
index 80b08fc389..60ca75d755 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1700,13 +1700,12 @@ void *repo_read_object_file(struct repository *r,
 			    enum object_type *type,
 			    unsigned long *size)
 {
-	struct object_info oi = OBJECT_INFO_INIT;
 	unsigned flags = OBJECT_INFO_DIE_IF_CORRUPT | OBJECT_INFO_LOOKUP_REPLACE;
 	void *data;
+	struct object_info oi = OBJECT_INFO(.typep = type,
+					    .sizep = size,
+					    .contentp = &data);
 
-	oi.typep = type;
-	oi.sizep = size;
-	oi.contentp = &data;
 	if (oid_object_info_extended(r, oid, &oi, flags))
 	    return NULL;
 
diff --git a/object-store.h b/object-store.h
index 1a713d89d7..e894cee61b 100644
--- a/object-store.h
+++ b/object-store.h
@@ -418,7 +418,8 @@ struct object_info {
  * Initializer for a "struct object_info" that wants no items. You may
  * also memset() the memory to all-zeroes.
  */
-#define OBJECT_INFO_INIT { 0 }
+#define OBJECT_INFO(...) { 0, __VA_ARGS__ }
+#define OBJECT_INFO_INIT OBJECT_INFO()
 
 /* Invoke lookup_replace_object() on the given hash */
 #define OBJECT_INFO_LOOKUP_REPLACE 1

But:

  - it actually triggers a gcc warning, since OBJECT_INFO(.typep = foo)
    sets typep twice (once for the default "0", and once by name). In
    this case the "0" is superfluous, since that's the default, and we
    could just do:

      #define OBJECT_INFO(...) { __VA_ARGS__ }
      #define OBJECT_INFO_INIT OBJECT_INFO(0)

    but I was hoping to find a general technique for object
    initializers.

  - it's not really that much shorter than the existing code. The real
    benefit of "data = read_object(oid, type, size)" is the implicit
    number and names of the parameters. And the way to get that is to
    provide an extra function.

So I think we are better off with the code that is longer but totally
obvious, unless we really want to add a function wrapper for common
queries as syntactic sugar.

-Peff
