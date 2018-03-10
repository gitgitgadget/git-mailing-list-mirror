Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F62E1F404
	for <e@80x24.org>; Sat, 10 Mar 2018 12:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752191AbeCJMfS (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Mar 2018 07:35:18 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45028 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752166AbeCJMfR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Mar 2018 07:35:17 -0500
Received: by mail-pf0-f194.google.com with SMTP id 17so2404031pfw.11
        for <git@vger.kernel.org>; Sat, 10 Mar 2018 04:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rdd9PzTXqzSrLPG54sAYKdx/O6/Yf7MoNiZdcVL1ClE=;
        b=YBkDwdRvliw7iJJwXgF2d/XDUX3ELT6su2qC6urW3ohO6k2e+Tjokw4gWAUPMuMJml
         DSTiYSI6WFZ7FHU8/GjBMdFOBSjMxkJ7od8s/NCZx07E/TCuaG7FcIhpjPUyKIDhn5B5
         tPbXXE3Ol79Te+W1j+hKKcZYuYyonLtolxX5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rdd9PzTXqzSrLPG54sAYKdx/O6/Yf7MoNiZdcVL1ClE=;
        b=mUpJnoE1O8F3a95u7oOfbpspxQPQSyAmEaJ3TyJ1F6Nb2Z0Mqb70RlkHuywJRS7g4Z
         gszasebNyb5TdyxGEJ4u1Miztt+KYwzUPJZsuU/IpOkJ6hEFdrbJmEGMZ6Py/AMe6Bxg
         d/itTDCVGGxhdZKn0NMAe2iew2BOV5AEyRnUQdJm1GTjigimiIP+GRzf29N56sDE1MoL
         /hhuKLvKAlxQQnOObCO+41ikuUV5YLCV0fWaOtkZyq3H6/m4xN7m2QOgDyQj6mS/e3h8
         jQINN+suo4aMUSsTdnDdGFLANpwFTuwnJl3MJJRWsMaW1St3cxoUJWiz3+a0ZQZaIX9D
         RG5g==
X-Gm-Message-State: AElRT7HvQvbuW/rvoSzErMpV0MaDPviTstIG9HTxZ/+CKG63cQf1KnVO
        3PdZcjvW0RKIzDLM8pNW+bfV12OPjNM=
X-Google-Smtp-Source: AG47ELsjnUS9xMgh/SehWQLM86HvIRpRrhlhmK/xh8LARndyqB1ZAC9PPDTE5jmIPVMN0sIJhxmUDA==
X-Received: by 10.101.87.132 with SMTP id b4mr1565407pgr.282.1520685317034;
        Sat, 10 Mar 2018 04:35:17 -0800 (PST)
Received: from tikuta.tok.corp.google.com ([2401:fa00:4:1002:bd1d:996:abff:29d])
        by smtp.gmail.com with ESMTPSA id b123sm7660789pfb.179.2018.03.10.04.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Mar 2018 04:35:16 -0800 (PST)
From:   Takuto Ikuta <tikuta@chromium.org>
To:     git@vger.kernel.org
Cc:     Takuto Ikuta <tikuta@chromium.org>
Subject: [PATCH v4] fetch-pack.c: use oidset to check existence of loose object
Date:   Sat, 10 Mar 2018 21:34:45 +0900
Message-Id: <20180310123445.79609-1-tikuta@chromium.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309132655.224308-1-tikuta@chromium.org>
References: <20180309132655.224308-1-tikuta@chromium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In repository having large number of remote refs, because to check
existence of each refs in local repository to packed and loose objects,
'git fetch' ends up doing a lot of lstat(2) to non-existing loose form,
which makes it slow.

Instead of making as many lstat(2) calls as the refs the remote side
advertised to see if these objects exist in the loose form, first
enumerate all the existing loose objects in hashmap beforehand and use
it to check existence of them if the number of refs is larger than the
number of loose objects.

With this patch, the number of lstat(2) calls in `git fetch` is reduced
from 411412 to 13794 for chromium repository, it has more than 480000
remote refs.

I took time stat of `git fetch` disabling quickfetch, so that fetch-pack
runs, for chromium repository 3 time on linux with SSD.
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
2.16.2

