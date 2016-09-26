Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E719E209AA
	for <e@80x24.org>; Mon, 26 Sep 2016 12:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965716AbcIZMAc (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 08:00:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:48039 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965590AbcIZMAc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 08:00:32 -0400
Received: (qmail 18720 invoked by uid 109); 26 Sep 2016 12:00:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 12:00:31 +0000
Received: (qmail 4426 invoked by uid 111); 26 Sep 2016 12:00:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 08:00:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2016 08:00:29 -0400
Date:   Mon, 26 Sep 2016 08:00:29 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 08/10] sha1_array: let callbacks interrupt iteration
Message-ID: <20160926120029.zuyasa3hph372beb@sigill.intra.peff.net>
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The callbacks for iterating a sha1_array must have a void
return.  This is unlike our usual for_each semantics, where
a callback may interrupt iteration and have its value
propagated. Let's switch it to the usual form, which will
enable its use in more places (e.g., where we are replacing
an existing iteration with a different data structure).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-sha1-array.txt | 8 ++++++--
 builtin/cat-file.c                         | 3 ++-
 builtin/receive-pack.c                     | 3 ++-
 sha1-array.c                               | 8 ++++++--
 sha1-array.h                               | 8 ++++----
 submodule.c                                | 3 ++-
 t/helper/test-sha1-array.c                 | 3 ++-
 7 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/Documentation/technical/api-sha1-array.txt b/Documentation/technical/api-sha1-array.txt
index 3e75497..dcc5294 100644
--- a/Documentation/technical/api-sha1-array.txt
+++ b/Documentation/technical/api-sha1-array.txt
@@ -38,16 +38,20 @@ Functions
 `sha1_array_for_each_unique`::
 	Efficiently iterate over each unique element of the list,
 	executing the callback function for each one. If the array is
-	not sorted, this function has the side effect of sorting it.
+	not sorted, this function has the side effect of sorting it. If
+	the callback returns a non-zero value, the iteration ends
+	immediately and the callback's return is propagated; otherwise,
+	0 is returned.
 
 Examples
 --------
 
 -----------------------------------------
-void print_callback(const unsigned char sha1[20],
+int print_callback(const unsigned char sha1[20],
 		    void *data)
 {
 	printf("%s\n", sha1_to_hex(sha1));
+	return 0; /* always continue */
 }
 
 void some_func(void)
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 94e67eb..cca97a8 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -401,11 +401,12 @@ struct object_cb_data {
 	struct expand_data *expand;
 };
 
-static void batch_object_cb(const unsigned char sha1[20], void *vdata)
+static int batch_object_cb(const unsigned char sha1[20], void *vdata)
 {
 	struct object_cb_data *data = vdata;
 	hashcpy(data->expand->oid.hash, sha1);
 	batch_object_write(NULL, data->opt, data->expand);
+	return 0;
 }
 
 static int batch_loose_object(const unsigned char *sha1,
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 896b16f..f7cd180 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -268,9 +268,10 @@ static int show_ref_cb(const char *path_full, const struct object_id *oid,
 	return 0;
 }
 
-static void show_one_alternate_sha1(const unsigned char sha1[20], void *unused)
+static int show_one_alternate_sha1(const unsigned char sha1[20], void *unused)
 {
 	show_ref(".have", sha1);
+	return 0;
 }
 
 static void collect_one_alternate_ref(const struct ref *ref, void *data)
diff --git a/sha1-array.c b/sha1-array.c
index 6f4a224..af1d7d5 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -42,7 +42,7 @@ void sha1_array_clear(struct sha1_array *array)
 	array->sorted = 0;
 }
 
-void sha1_array_for_each_unique(struct sha1_array *array,
+int sha1_array_for_each_unique(struct sha1_array *array,
 				for_each_sha1_fn fn,
 				void *data)
 {
@@ -52,8 +52,12 @@ void sha1_array_for_each_unique(struct sha1_array *array,
 		sha1_array_sort(array);
 
 	for (i = 0; i < array->nr; i++) {
+		int ret;
 		if (i > 0 && !hashcmp(array->sha1[i], array->sha1[i-1]))
 			continue;
-		fn(array->sha1[i], data);
+		ret = fn(array->sha1[i], data);
+		if (ret)
+			return ret;
 	}
+	return 0;
 }
diff --git a/sha1-array.h b/sha1-array.h
index 72bb33b..b3230be 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -14,10 +14,10 @@ void sha1_array_append(struct sha1_array *array, const unsigned char *sha1);
 int sha1_array_lookup(struct sha1_array *array, const unsigned char *sha1);
 void sha1_array_clear(struct sha1_array *array);
 
-typedef void (*for_each_sha1_fn)(const unsigned char sha1[20],
-				 void *data);
-void sha1_array_for_each_unique(struct sha1_array *array,
-				for_each_sha1_fn fn,
+typedef int (*for_each_sha1_fn)(const unsigned char sha1[20],
 				void *data);
+int sha1_array_for_each_unique(struct sha1_array *array,
+			       for_each_sha1_fn fn,
+			       void *data);
 
 #endif /* SHA1_ARRAY_H */
diff --git a/submodule.c b/submodule.c
index 0ef2ff4..aba94dd 100644
--- a/submodule.c
+++ b/submodule.c
@@ -728,9 +728,10 @@ void check_for_new_submodule_commits(unsigned char new_sha1[20])
 	sha1_array_append(&ref_tips_after_fetch, new_sha1);
 }
 
-static void add_sha1_to_argv(const unsigned char sha1[20], void *data)
+static int add_sha1_to_argv(const unsigned char sha1[20], void *data)
 {
 	argv_array_push(data, sha1_to_hex(sha1));
+	return 0;
 }
 
 static void calculate_changed_submodule_paths(void)
diff --git a/t/helper/test-sha1-array.c b/t/helper/test-sha1-array.c
index 09f7790..f7a53c4 100644
--- a/t/helper/test-sha1-array.c
+++ b/t/helper/test-sha1-array.c
@@ -1,9 +1,10 @@
 #include "cache.h"
 #include "sha1-array.h"
 
-static void print_sha1(const unsigned char sha1[20], void *data)
+static int print_sha1(const unsigned char sha1[20], void *data)
 {
 	puts(sha1_to_hex(sha1));
+	return 0;
 }
 
 int cmd_main(int argc, const char **argv)
-- 
2.10.0.492.g14f803f

