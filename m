Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A64DE1F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753375AbdL1EPD (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:15:03 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:43458 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753321AbdL1EO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:26 -0500
Received: by mail-it0-f66.google.com with SMTP id u62so26972074ita.2
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2PknibdcmRlkGf4C8xpjVo+zkx3BipFwx0CiJg33deQ=;
        b=YhZba3apwGeG9uvOsL48N3y+MXpMME3UMHktALgdzA0Ac8UTLo/lFYxxPl0FumP4Fu
         F3kXum/25B3JE9FlNkVoszdGu9yvEcef4m7u6uJihqg9RDh4jDd1zFW5iBAbyvLLlzg3
         biqkSQNm7F4bPmHeSkgxh+IT/mwzIlovjIkph057rF6sa6/ndikMPw0+dUhO7NlPatEJ
         +HUHSzepeKlSLbkjDNnYBz9Q1QQ8eIx4rgzzwzB9miEbrc7Wobx9fLLa1h8ggmANIGtc
         UE/le0VEgefLArPRCWiVJNaNEEfqqgJxo9BOhcUiu/1KwHQ0SdDZQBSsCIYimwq+nB8i
         5USQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2PknibdcmRlkGf4C8xpjVo+zkx3BipFwx0CiJg33deQ=;
        b=rBkak912LYofJ2lkkAt34iFmqolyuJkf30ufix6eO+DJDSgRgm5GmdWO/1wvng3d03
         zkPb2n6r6wVi5BuAJa5aRRGgTnPrXo/X4JKbTq/LDc674JTQzlgQeLoH58mMgNLDv4i3
         PWvL6BPCvXToB1+F8/x8p177eamYyryb1XTeuEeeB4M3jezJbTqJXiahhR3AKPJVzfuh
         XZ0VxF7UfWAz/xdfpyOqZ21rtiryobY6ZcvqoYiYkUVkQ8VcggNSi4yEbMh3wgDrxOcF
         zpffId6gUX29+iQoPJ5Ikesj/DT6Twva1JUbW6jF17V3D5Nmx+Yo0kCE5pGvnhaMWRys
         Cgyw==
X-Gm-Message-State: AKGB3mIIUzx7P02us5kkoiqugZPf5M2dkeKBW5pQb6oIdMtAOT1LVZgh
        /CKVi94R15xRQ2wl02axJhfPZg==
X-Google-Smtp-Source: ACJfBotINr9t2Lyu3MoWu4fVWFZXvJHiDlXIA6+8jPzcnFc+jw7/g5pFhMe2o70264iJAU7W2JQ5TQ==
X-Received: by 10.36.148.6 with SMTP id j6mr40127485ite.104.1514434465398;
        Wed, 27 Dec 2017 20:14:25 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:24 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 24/34] merge-recursive: add a new hashmap for storing file collisions
Date:   Wed, 27 Dec 2017 20:13:42 -0800
Message-Id: <20171228041352.27880-25-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Directory renames with the ability to merge directories opens up the
possibility of add/add/add/.../add conflicts, if each of the N
directories being merged into one target directory all had a file with
the same name.  We need a way to check for and report on such
collisions; this hashmap will be used for this purpose.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 23 +++++++++++++++++++++++
 merge-recursive.h |  7 +++++++
 2 files changed, 30 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index d92fba277..6bd4f34d5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -84,6 +84,29 @@ static void dir_rename_entry_init(struct dir_rename_entry *entry,
 	string_list_init(&entry->possible_new_dirs, 0);
 }
 
+static struct collision_entry *collision_find_entry(struct hashmap *hashmap,
+						    char *target_file)
+{
+	struct collision_entry key;
+
+	hashmap_entry_init(&key, strhash(target_file));
+	key.target_file = target_file;
+	return hashmap_get(hashmap, &key, NULL);
+}
+
+static int collision_cmp(void *unused_cmp_data,
+			 const struct collision_entry *e1,
+			 const struct collision_entry *e2,
+			 const void *unused_keydata)
+{
+	return strcmp(e1->target_file, e2->target_file);
+}
+
+static void collision_init(struct hashmap *map)
+{
+	hashmap_init(map, (hashmap_cmp_fn) collision_cmp, NULL, 0);
+}
+
 static void flush_output(struct merge_options *o)
 {
 	if (o->buffer_output < 2 && o->obuf.len) {
diff --git a/merge-recursive.h b/merge-recursive.h
index d7f4cc80c..e1be27f57 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -37,6 +37,13 @@ struct dir_rename_entry {
 	struct string_list possible_new_dirs;
 };
 
+struct collision_entry {
+	struct hashmap_entry ent; /* must be the first member! */
+	char *target_file;
+	struct string_list source_files;
+	unsigned reported_already:1;
+};
+
 /* merge_trees() but with recursive ancestor consolidation */
 int merge_recursive(struct merge_options *o,
 		    struct commit *h1,
-- 
2.15.0.408.g8e199d483

