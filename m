Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57D941F404
	for <e@80x24.org>; Wed, 14 Mar 2018 06:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753274AbeCNGGW (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 02:06:22 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46068 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbeCNGGV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 02:06:21 -0400
Received: by mail-pg0-f65.google.com with SMTP id s13so947789pgn.12
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 23:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qXJM1ErVVysQxph2WuxV9NYiw/TS2/CEjujJ0ZeSV4c=;
        b=e2Riw51O2WGbVN+mdFhyKeYKLMX3Tqu8RSctwJTxtUiP5O8Jqo0lU6VOWXkBGRE/m1
         eaPjmgOgDlFMFN8a9+7U4KwQhMyQkkwTTdLB3gw0DNuHXpHt46zWRFES/6pCWXCWQcJg
         F1gFC9VmZVJkkKx82jM1CxCugFcOP19nVWe6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qXJM1ErVVysQxph2WuxV9NYiw/TS2/CEjujJ0ZeSV4c=;
        b=X7obABzouwvtf1gxOct9WO4bOhKORnqU4bPokRWge3+d/LZoyV470d/Mpl7IjfYrXr
         a5gWidFxMHXyOn6hGouaijcN3wCs/dVBCxMnb8kXX9pv7DyJJZAsZvboaue9OKqtyP0X
         DwGEJ+decraLdh925uXIaqdCx+NAkg6Egh3QHNafcs7JMgGfevOOnzIQJ9luqD4RoQ6W
         pAvzkarWQabeOc/Ds3smEi6l+/NltKOE0ayoID2ydEr5uoIvQW7YbKcVYqP+amdYLcAu
         yN2ZZaMub4UNEoVYFelTeOV4nZUdNymiASEmJE6J4jJ/jcNsr4/OjE9tQ9jvIoWeFjVo
         pGHA==
X-Gm-Message-State: AElRT7HLD9dd9rrZGSeuOCeGdGOg4hgFI5y80G0tE6MOcRCiuTf/4F7W
        /94cxvwtScezdaYK3kEsA2U14LW59ys=
X-Google-Smtp-Source: AG47ELs+M5A0QwMWpXWVti+FDuWRd9NQ3tRZg/2bBX/qyiJSvKWGhRK+b9y+i4tAosh/KVw2uqunVw==
X-Received: by 10.99.117.68 with SMTP id f4mr946648pgn.369.1521007581142;
        Tue, 13 Mar 2018 23:06:21 -0700 (PDT)
Received: from tikuta.tok.corp.google.com ([2401:fa00:4:1002:bd1d:996:abff:29d])
        by smtp.gmail.com with ESMTPSA id p12sm2586952pgn.91.2018.03.13.23.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Mar 2018 23:06:20 -0700 (PDT)
From:   Takuto Ikuta <tikuta@chromium.org>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Takuto Ikuta <tikuta@chromium.org>
Subject: [PATCH v6] fetch-pack.c: use oidset to check existence of loose object
Date:   Wed, 14 Mar 2018 15:05:11 +0900
Message-Id: <20180314060511.257985-1-tikuta@chromium.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310123445.79609-1-tikuta@chromium.org>
References: <20180310123445.79609-1-tikuta@chromium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fetching from a repository with large number of refs, because to
check existence of each refs in local repository to packed and loose
objects, 'git fetch' ends up doing a lot of lstat(2) to non-existing
loose form, which makes it slow.

Instead of making as many lstat(2) calls as the refs the remote side
advertised to see if these objects exist in the loose form, first
enumerate all the existing loose objects in hashmap beforehand and use
it to check existence of them if the number of refs is larger than the
number of loose objects.

With this patch, the number of lstat(2) calls in `git fetch` is reduced
from 411412 to 13794 for chromium repository, it has more than 480000
remote refs.

I took time stat of `git fetch` when fetch-pack happens for chromium
repository 3 times on linux with SSD.
* with this patch
8.105s
8.309s
7.640s
avg: 8.018s

* master
12.287s
11.175s
12.227s
avg: 11.896s

On my MacBook Air which has slower lstat(2).
* with this patch
14.501s

* master
1m16.027s

`git fetch` on slow disk will be improved largely.

Signed-off-by: Takuto Ikuta <tikuta@chromium.org>
---
 cache.h      |  2 ++
 fetch-pack.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 sha1_file.c  |  3 +++
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index d06932ed0..6a72f54d7 100644
--- a/cache.h
+++ b/cache.h
@@ -1773,6 +1773,8 @@ struct object_info {
 #define OBJECT_INFO_SKIP_CACHED 4
 /* Do not retry packed storage after checking packed and loose storage */
 #define OBJECT_INFO_QUICK 8
+/* Do not check loose object */
+#define OBJECT_INFO_IGNORE_LOOSE 16
 extern int sha1_object_info_extended(const unsigned char *, struct object_info *, unsigned flags);
 
 /*
diff --git a/fetch-pack.c b/fetch-pack.c
index d97461296..92b9bb4d9 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -711,6 +711,28 @@ static void mark_alternate_complete(struct object *obj)
 	mark_complete(&obj->oid);
 }
 
+struct loose_object_iter {
+	struct oidset *loose_object_set;
+	struct ref *refs;
+};
+
+/*
+ *  If the number of refs is not larger than the number of loose objects,
+ *  this function stops inserting and returns false.
+ */
+static int add_loose_objects_to_set(const struct object_id *oid,
+				    const char *path,
+				    void *data)
+{
+	struct loose_object_iter *iter = data;
+	oidset_insert(iter->loose_object_set, oid);
+	if (iter->refs == NULL)
+		return 1;
+
+	iter->refs = iter->refs->next;
+	return 0;
+}
+
 static int everything_local(struct fetch_pack_args *args,
 			    struct ref **refs,
 			    struct ref **sought, int nr_sought)
@@ -719,16 +741,31 @@ static int everything_local(struct fetch_pack_args *args,
 	int retval;
 	int old_save_commit_buffer = save_commit_buffer;
 	timestamp_t cutoff = 0;
+	struct oidset loose_oid_set = OIDSET_INIT;
+	int use_oidset = 0;
+	struct loose_object_iter iter = {&loose_oid_set, *refs};
+
+	/* Enumerate all loose objects or know refs are not so many. */
+	use_oidset = !for_each_loose_object(add_loose_objects_to_set,
+					    &iter, 0);
 
 	save_commit_buffer = 0;
 
 	for (ref = *refs; ref; ref = ref->next) {
 		struct object *o;
+		unsigned int flags = OBJECT_INFO_QUICK;
 
-		if (!has_object_file_with_flags(&ref->old_oid,
-						OBJECT_INFO_QUICK))
-			continue;
+		if (use_oidset &&
+		    !oidset_contains(&loose_oid_set, &ref->old_oid)) {
+			/*
+			 * I know this does not exist in the loose form,
+			 * so check if it exists in a non-loose form.
+			 */
+			flags |= OBJECT_INFO_IGNORE_LOOSE;
+		}
 
+		if (!has_object_file_with_flags(&ref->old_oid, flags))
+			continue;
 		o = parse_object(&ref->old_oid);
 		if (!o)
 			continue;
@@ -744,6 +781,8 @@ static int everything_local(struct fetch_pack_args *args,
 		}
 	}
 
+	oidset_clear(&loose_oid_set);
+
 	if (!args->no_dependents) {
 		if (!args->deepen) {
 			for_each_ref(mark_complete_oid, NULL);
diff --git a/sha1_file.c b/sha1_file.c
index 1b94f39c4..c0a197947 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1262,6 +1262,9 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		if (find_pack_entry(real, &e))
 			break;
 
+		if (flags & OBJECT_INFO_IGNORE_LOOSE)
+			return -1;
+
 		/* Most likely it's a loose object. */
 		if (!sha1_loose_object_info(real, oi, flags))
 			return 0;
-- 
2.16.2.804.g6dcf76e118-goog

