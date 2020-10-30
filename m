Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032BEC4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 13:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CB752076E
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 13:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgJ3NfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 09:35:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:42472 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgJ3NfT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 09:35:19 -0400
Received: (qmail 7056 invoked by uid 109); 30 Oct 2020 13:35:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Oct 2020 13:35:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21383 invoked by uid 111); 30 Oct 2020 13:35:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Oct 2020 09:35:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 30 Oct 2020 09:35:18 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 03/10] hashmap: allow re-use after hashmap_free()
Message-ID: <20201030133518.GC3277724@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
 <a686d0758a2652c91363dcf68da7726093d00c23.1602549650.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a686d0758a2652c91363dcf68da7726093d00c23.1602549650.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 12:40:43AM +0000, Elijah Newren via GitGitGadget wrote:

> Previously, once map->table had been freed, any calls to hashmap_put(),
> hashmap_get(), or hashmap_remove() would cause a NULL pointer
> dereference (since hashmap_free_() also zeros the memory; without that
> zeroing, calling these functions would cause a use-after-free problem).
> 
> Modify these functions to check for a NULL table and automatically
> allocate as needed.

Unsurprisingly, I like this direction. The code looks correct to me,
though I think you could reduce duplication slightly by checking
map->table in find_entry_ptr(). That covers both hashmap_get() and
hashmap_remove(). But I'm happy either way.

> I also thought about creating a HASHMAP_INIT macro to allow initializing
> hashmaps on the stack without calling hashmap_init(), but virtually all
> uses of hashmap specify a usecase-specific equals_function which defeats
> the utility of such a macro.

This part I disagree with. If we did:

  #define HASHMAP_INIT(fn, data) = { .cmpfn = cmpfn, cmpfn_data = data }

then many callers could avoid handling the lazy-init themselves. E.g.:

 attr.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/attr.c b/attr.c
index a826b2ef1f..55a2783f1b 100644
--- a/attr.c
+++ b/attr.c
@@ -57,7 +57,9 @@ static inline void hashmap_unlock(struct attr_hashmap *map)
  * is a singleton object which is shared between threads.
  * Access to this dictionary must be surrounded with a mutex.
  */
-static struct attr_hashmap g_attr_hashmap;
+static struct attr_hashmap g_attr_hashmap = {
+	HASHMAP_INIT(attr_hash_entry_cmp, NULL)
+};
 
 /* The container for objects stored in "struct attr_hashmap" */
 struct attr_hash_entry {
@@ -80,12 +82,6 @@ static int attr_hash_entry_cmp(const void *unused_cmp_data,
 	return (a->keylen != b->keylen) || strncmp(a->key, b->key, a->keylen);
 }
 
-/* Initialize an 'attr_hashmap' object */
-static void attr_hashmap_init(struct attr_hashmap *map)
-{
-	hashmap_init(&map->map, attr_hash_entry_cmp, NULL, 0);
-}
-
 /*
  * Retrieve the 'value' stored in a hashmap given the provided 'key'.
  * If there is no matching entry, return NULL.
@@ -96,9 +92,6 @@ static void *attr_hashmap_get(struct attr_hashmap *map,
 	struct attr_hash_entry k;
 	struct attr_hash_entry *e;
 
-	if (!map->map.tablesize)
-		attr_hashmap_init(map);
-
 	hashmap_entry_init(&k.ent, memhash(key, keylen));
 	k.key = key;
 	k.keylen = keylen;
@@ -114,9 +107,6 @@ static void attr_hashmap_add(struct attr_hashmap *map,
 {
 	struct attr_hash_entry *e;
 
-	if (!map->map.tablesize)
-		attr_hashmap_init(map);
-
 	e = xmalloc(sizeof(struct attr_hash_entry));
 	hashmap_entry_init(&e->ent, memhash(key, keylen));
 	e->key = key;
