Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25F56208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 17:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753374AbdHOR7Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 13:59:24 -0400
Received: from siwi.pair.com ([209.68.5.199]:30021 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752465AbdHOR7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 13:59:24 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 23F4F844E5;
        Tue, 15 Aug 2017 13:59:23 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E75B7844E2;
        Tue, 15 Aug 2017 13:59:22 -0400 (EDT)
Subject: Re: tsan: t3008: hashmap_add touches size from multiple threads
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <cover.1502780343.git.martin.agren@gmail.com>
 <adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <cff383c2-ca57-caba-5a46-7dec4abc25a4@jeffhostetler.com>
Date:   Tue, 15 Aug 2017 13:59:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/15/2017 8:53 AM, Martin Ågren wrote:
> Using SANITIZE=thread made t3008-ls-files-lazy-init-name-hash.sh hit
> the potential race below.
> 
> What seems to happen is, threaded_lazy_init_name_hash ends up using
> hashmap_add on the_index.dir_hash from two threads in a way that tsan
> considers racy. While the buckets each have their own mutex, the "size"
> does not. So it might end up with the wrong (lower) value. The size is
> used to determine when to resize, but that should be fine, since
> resizing is turned off due to threading anyway.
 >
> If the size is ever used for something else, the consequences might
> range from cosmetic error to devastating. I have a "feeling" the size is
> not used at the time, although maybe it is, in some roundabout way which
> I'm not seeing.

Good catch!  Yes, the size field is unguarded.  The only references to
it that I found were used in _add() and _remove() in the need-to-rehash
check.

Since auto-rehash is turned off, this shouldn't be a problem, but it
does feel odd to have a possibly incorrect size due to races.

Rather than adding something like (a cross-platform version of)
InterlockedIncrement(), I'm wondering if it would be better to
disable/invalidate the size field when auto-rehash is turned off
so we don't have to worry about it.

Something like this:


$ git diff
diff --git a/hashmap.c b/hashmap.c
index 9b6a12859b..be97642daa 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -205,6 +205,9 @@ void hashmap_add(struct hashmap *map, void *entry)
         ((struct hashmap_entry *) entry)->next = map->table[b];
         map->table[b] = entry;

+       if (map->disallow_rehash)
+               return;
+
         /* fix size and rehash if appropriate */
         map->size++;
         if (map->size > map->grow_at)
@@ -223,6 +226,9 @@ void *hashmap_remove(struct hashmap *map, const void 
*key, const void *keydata)
         *e = old->next;
         old->next = NULL;

+       if (map->disallow_rehash)
+               return;
+
         /* fix size and rehash if appropriate */
         map->size--;
         if (map->size < map->shrink_at)
diff --git a/hashmap.h b/hashmap.h
index 7a8fa7fa3d..ec9541b981 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -183,7 +183,8 @@ struct hashmap {
         const void *cmpfn_data;

         /* total number of entries (0 means the hashmap is empty) */
-       unsigned int size;
+       /* -1 means size is unknown for threading reasons */
+       int size;

         /*
          * tablesize is the allocated size of the hash table. A non-0 value
@@ -360,6 +361,15 @@ int hashmap_bucket(const struct hashmap *map, 
unsigned int hash);
  static inline void hashmap_disallow_rehash(struct hashmap *map, 
unsigned value)
  {
         map->disallow_rehash = value;
+       if (value) {
+               /*
+                * Assume threaded operations starting, so don't
+                * try to keep size current.
+                */
+               size = -1;
+       } else {
+               /* TODO count items in all buckets and set size. */
+       }
  }

  /*


Jeff
