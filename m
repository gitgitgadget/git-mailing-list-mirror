Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73C78201A7
	for <e@80x24.org>; Tue, 16 May 2017 04:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750852AbdEPEEV (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 00:04:21 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33096 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbdEPEEV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 00:04:21 -0400
Received: by mail-qk0-f195.google.com with SMTP id o85so20729704qkh.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 21:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tg0JgK/GfzR1wX5CqwX3dJt74wvspK/yI8jBdrG5GsA=;
        b=RHbJzqHflhMSblnK2EWOlu5+j1Hc6SLYP7KLeJbG3hzf0ztw9nH3ZmxuhMvHK4WJL3
         hw7RFbQiH9u7ExVt4vY6tGrqEI1ngNZuyCJRix/gZRzQ8TzHWpMaRTIGZ8jc3rwS8fLK
         9N5eiJ4M/G/GqrgENSf9wkToTTcPYUWsHYeo5PmKu1rn3lhbxnN3fvb6uFkSBAxCayQd
         Lut66HUyM1tRuawgIqVBWe2z7NEPLgoOIF++qrdtDhMz0p9mk6ATCjr/IzsxHmz97g+b
         HmPOdIebr1JLfSoIjCDJzrW0djnf6ZoJZsvRKBFdLLsXFimkMyBqVnuGMhKlBb2v4Mln
         Olww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tg0JgK/GfzR1wX5CqwX3dJt74wvspK/yI8jBdrG5GsA=;
        b=ZKrKUN/MHZ9pP9WfO0UhEVwfJHHmfHdHZPFH1ejiTnkjcXFLHyhL8MmphAvnVIZ0O5
         eGzzSVd8NYCd4eRIO+tjLK88QEgz5dHYvG+mbEUMvTu7aAFobgRbZuUp2QbuxDuBXJ2S
         qCrW4ezK9qsnxFChKePEUKXmCiOSEP7BzuxuwsOnwdkSSY2dNRs6sOj21PlwM5nZwDlk
         Xc4IXIKi4SwQsBLUONe4h/BMhoF9zcy4V297fwRLgNs7RQ9dJrHGerXAYyPHJEjLWuCP
         vqyTfaWgOxgL7FlroNEeq6yfIS3qv74KRAWASJxjXFn1JY4oV1uaGB2Y9v9IpNQloh/E
         MIGQ==
X-Gm-Message-State: AODbwcAeOec7r6Y+HJf4Gd7hGPE2LefewJPCfDF+1CH/1SrTofb4cEE0
        Y9thRJLP/lxjkSmK
X-Received: by 10.55.75.7 with SMTP id y7mr7802199qka.2.1494907459858;
        Mon, 15 May 2017 21:04:19 -0700 (PDT)
Received: from localhost.localdomain ([189.62.40.36])
        by smtp.gmail.com with ESMTPSA id x49sm4735467qth.5.2017.05.15.21.04.18
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 21:04:19 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     Daniel Ferreira <bnmvco@gmail.com>
Subject: Implementation of sorted hashmap iteration
Date:   Tue, 16 May 2017 01:04:09 -0300
Message-Id: <1494907449-29216-1-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
Hi there! When implementing a patch series to port git-add--interactive
from Perl to C[1] I ended up implementing this quirk to iterate through
a hashmap in the order elements were added to it. In the end, it did
not make it into the series but I figured I'd share it anyway if it
interests anyone.

[1]: https://public-inbox.org/git/1494907234-28903-1-git-send-email-bnmvco@gmail.com/T/#t

-- Daniel.

 hashmap.c | 25 +++++++++++++++++++++++++
 hashmap.h | 12 ++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/hashmap.c b/hashmap.c
index 7d1044e..948576c 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -196,6 +196,7 @@ void hashmap_add(struct hashmap *map, void *entry)
 	unsigned int b = bucket(map, entry);

 	/* add entry */
+	((struct hashmap_entry *) entry)->index = map->size;
 	((struct hashmap_entry *) entry)->next = map->table[b];
 	map->table[b] = entry;

@@ -254,6 +255,30 @@ void *hashmap_iter_next(struct hashmap_iter *iter)
 	}
 }

+void hashmap_iter_init_sorted(struct hashmap *map,
+		struct hashmap_iter_sorted *iter)
+{
+	hashmap_iter_init(map, (struct hashmap_iter *)iter);
+	iter->pos = 0;
+	iter->sorted_entries = xcalloc(map->size,
+			sizeof(struct hashmap_entry *));
+
+	struct hashmap_entry *ent;
+	while ((ent = hashmap_iter_next((struct hashmap_iter *)iter))) {
+		iter->sorted_entries[ent->index] = ent;
+	}
+}
+
+void *hashmap_iter_next_sorted(struct hashmap_iter_sorted *iter)
+{
+	return iter->sorted_entries[iter->pos++];
+}
+
+void hashmap_iter_free_sorted(struct hashmap_iter_sorted *iter)
+{
+	free(iter->sorted_entries);
+}
+
 struct pool_entry {
 	struct hashmap_entry ent;
 	size_t len;
diff --git a/hashmap.h b/hashmap.h
index de6022a..f2a5d36 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -30,6 +30,7 @@ static inline unsigned int sha1hash(const unsigned char *sha1)
 struct hashmap_entry {
 	struct hashmap_entry *next;
 	unsigned int hash;
+	unsigned int index;
 };

 typedef int (*hashmap_cmp_fn)(const void *entry, const void *entry_or_key,
@@ -48,6 +49,12 @@ struct hashmap_iter {
 	unsigned int tablepos;
 };

+struct hashmap_iter_sorted {
+	struct hashmap_iter base;
+	struct hashmap_entry **sorted_entries;
+	unsigned int pos;
+};
+
 /* hashmap functions */

 extern void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
@@ -112,6 +119,11 @@ static inline void *hashmap_iter_first(struct hashmap *map,
 	return hashmap_iter_next(iter);
 }

+extern void hashmap_iter_init_sorted(struct hashmap *map,
+		struct hashmap_iter_sorted *iter);
+extern void *hashmap_iter_next_sorted(struct hashmap_iter_sorted *iter);
+extern void hashmap_iter_free_sorted(struct hashmap_iter_sorted *iter);
+
 /* string interning */

 extern const void *memintern(const void *data, size_t len);
--
2.7.4 (Apple Git-66)

