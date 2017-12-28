Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21EDD1F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753380AbdL1EPG (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:15:06 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:33693 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753327AbdL1EOV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:21 -0500
Received: by mail-io0-f193.google.com with SMTP id t63so89221iod.0
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g9P4iziO15fvtO2AeOdGZ7akJru6+S+/nAXIO5RdP0Y=;
        b=jppHquApFGCycgyKyNmUPU0a0ZH2nmoJeUmHtWUc07cmDJLlNJ1tj08J4Toh/22Af4
         RYlfCQnED9S16HTKUKwitD/crpiOYaOrmsw+zY+zNA+Pc51k/nGhW2przgAajUugg4dR
         BRgFhzqxfxZSSVcXt1qXbmlJz0wJaa94exi2PNqLIcopn5S5n8bZnaIOcrdDJN5/9ECT
         NeSqx6bkazU2USDw7UmgcP4SvGzbfEXr7ofO0jUWEl0ocq4t1r7Rdi/YloAq7IHUDcc4
         hDyBoFOTFBzlw6dvLjgz90tn1AiTlgz7s+nU0bW3/sNZ0vOi2dwv6R0Aa8WHsoZBkAzq
         kjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g9P4iziO15fvtO2AeOdGZ7akJru6+S+/nAXIO5RdP0Y=;
        b=J8Kt/7lSEe356e6NpmiH57fMmCEbQevx7NO/6fGx+XUQ4JPFt5nQtluxFNz1ZnciyK
         9dctifkDfncLqNfwNu29M8YqvR1wv28C7QVJqUK2NQknlnpfC0HYQJJuUCxd4V3Z4SyZ
         as48PxUvPo8sRUtEMks03Rk6OwU5z9bTuqitZqru4QoKXeR/YLWlDN3fn0QukketgGol
         r7XB6mCUya1NxXW5JVV/cNsNtSG64kbrKSIoM84a1e7PAxMdj5jLUuB6xs2F7jx0lWT5
         Q72B1ilfxY0oUietuuIhfaRCYPNQ9UyU2bQd6QF5cptHvjIFnF3xsK0LnjgALKRrAMMi
         AGBA==
X-Gm-Message-State: AKGB3mJalFbnjb9OnZSJJnom9b2gsyup+JsbGyQjXGr94qtifLfD4Rfn
        8AeZj4yon0W/mGfgFg242BKzjA==
X-Google-Smtp-Source: ACJfBouPcNeaq8ua1J+DQNYoKfm+nbBKA6aAdvd+qA0zBwUf2gCXncAr6hFe/skEKt01kfJa8J6PSw==
X-Received: by 10.107.55.3 with SMTP id e3mr25443852ioa.82.1514434460916;
        Wed, 27 Dec 2017 20:14:20 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:20 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 20/34] merge-recursive: add a new hashmap for storing directory renames
Date:   Wed, 27 Dec 2017 20:13:38 -0800
Message-Id: <20171228041352.27880-21-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This just adds dir_rename_entry and the associated functions; code using
these will be added in subsequent commits.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 35 +++++++++++++++++++++++++++++++++++
 merge-recursive.h |  8 ++++++++
 2 files changed, 43 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index 4adff2d53..0cb27c66e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -49,6 +49,41 @@ static unsigned int path_hash(const char *path)
 	return ignore_case ? strihash(path) : strhash(path);
 }
 
+static struct dir_rename_entry *dir_rename_find_entry(struct hashmap *hashmap,
+						      char *dir)
+{
+	struct dir_rename_entry key;
+
+	if (dir == NULL)
+		return NULL;
+	hashmap_entry_init(&key, strhash(dir));
+	key.dir = dir;
+	return hashmap_get(hashmap, &key, NULL);
+}
+
+static int dir_rename_cmp(void *unused_cmp_data,
+			  const struct dir_rename_entry *e1,
+			  const struct dir_rename_entry *e2,
+			  const void *unused_keydata)
+{
+	return strcmp(e1->dir, e2->dir);
+}
+
+static void dir_rename_init(struct hashmap *map)
+{
+	hashmap_init(map, (hashmap_cmp_fn) dir_rename_cmp, NULL, 0);
+}
+
+static void dir_rename_entry_init(struct dir_rename_entry *entry,
+				  char *directory)
+{
+	hashmap_entry_init(entry, strhash(directory));
+	entry->dir = directory;
+	entry->non_unique_new_dir = 0;
+	strbuf_init(&entry->new_dir, 0);
+	string_list_init(&entry->possible_new_dirs, 0);
+}
+
 static void flush_output(struct merge_options *o)
 {
 	if (o->buffer_output < 2 && o->obuf.len) {
diff --git a/merge-recursive.h b/merge-recursive.h
index 80d69d140..d7f4cc80c 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -29,6 +29,14 @@ struct merge_options {
 	struct string_list df_conflict_file_set;
 };
 
+struct dir_rename_entry {
+	struct hashmap_entry ent; /* must be the first member! */
+	char *dir;
+	unsigned non_unique_new_dir:1;
+	struct strbuf new_dir;
+	struct string_list possible_new_dirs;
+};
+
 /* merge_trees() but with recursive ancestor consolidation */
 int merge_recursive(struct merge_options *o,
 		    struct commit *h1,
-- 
2.15.0.408.g8e199d483

