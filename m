Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC3A21F404
	for <e@80x24.org>; Sat, 10 Mar 2018 12:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752181AbeCJMq6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Mar 2018 07:46:58 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46506 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbeCJMq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Mar 2018 07:46:57 -0500
Received: by mail-pl0-f65.google.com with SMTP id y8-v6so6731382pll.13
        for <git@vger.kernel.org>; Sat, 10 Mar 2018 04:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rq2+rcEdq8cu9v3Tz1r3HE2g2/2x/TDLtlzS5IGq2bw=;
        b=BgglfUjPhz5oN9f6gRb+080zBNULMnfKOZA62csBdZlG5qFoGpOosz+5rrBHVAOFGw
         NV/r+3HU8t0e2e4aTtR2/loju0OaZe1dYjDKDbTGOyHwz6Ag0DFF0he+8VcPb575fQC2
         VmR0MaBkG4VXC7dm0EvZJXtuyWNrn7WkZi54g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rq2+rcEdq8cu9v3Tz1r3HE2g2/2x/TDLtlzS5IGq2bw=;
        b=RpanoZJk0K00ccWzTHkyfvGFOPIaD6rFNNjbbNAd1G2U309TXuT+Euu7/LydxkbB67
         aU/RZHpxj2gxsH/72Co6DrZ5Lj5asB0TlErL9HC6aBRIrTNcxzPvsTxqMFK8d3jFu0iB
         THQRwlBgqcGCDvqPUVwc6FdWPCDgjWOdCeV5pLx0apPx8EFC9GJg7ylXNd8lBY7b4G73
         TlFpztsJKBe/PRYkBi0FL1R1VJKubG+JI94LNy1SFXX6zx719hopmmIhfNt1vdqixfdw
         i+ltSmk8D3tSgJ+36xk4qYGBJhb+2QC6n99o/Ffmoc/k3ZNDMm0FBig5V49Y8az4MEfx
         sXeg==
X-Gm-Message-State: AElRT7FRjXGy3f8KUyJMjxjCI2Au+YR1rpc96xY+Nx7He6J9v6YKXj9n
        8dPQBEFQYTDA9dPw8O5b/+z9mrOnZLE=
X-Google-Smtp-Source: AG47ELt6sxW+sXZnlEVqYPCvxhKhZr8iAIn5VfTdv+hvHBsxuO6Rr+z1STEqbp88RbAA8fntZsoeJA==
X-Received: by 2002:a17:902:67c8:: with SMTP id g8-v6mr2007529pln.106.1520686017025;
        Sat, 10 Mar 2018 04:46:57 -0800 (PST)
Received: from tikuta.tok.corp.google.com ([2401:fa00:4:1002:bd1d:996:abff:29d])
        by smtp.gmail.com with ESMTPSA id c15sm8426636pfm.114.2018.03.10.04.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Mar 2018 04:46:56 -0800 (PST)
From:   Takuto Ikuta <tikuta@chromium.org>
To:     git@vger.kernel.org
Cc:     Takuto Ikuta <tikuta@chromium.org>
Subject: [PATCH v5] fetch-pack.c: use oidset to check existence of loose object
Date:   Sat, 10 Mar 2018 21:46:43 +0900
Message-Id: <20180310124643.82666-1-tikuta@chromium.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310123445.79609-1-tikuta@chromium.org>
References: <20180310123445.79609-1-tikuta@chromium.org>
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
2.16.2

