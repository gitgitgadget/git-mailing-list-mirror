Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEED020281
	for <e@80x24.org>; Fri, 29 Sep 2017 20:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbdI2UMg (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 16:12:36 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:45573 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752622AbdI2UMb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 16:12:31 -0400
Received: by mail-pg0-f53.google.com with SMTP id 188so355095pgb.2
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 13:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=dHLs9/UME2iU/FrY3Bb2bga6u1fOEyaib1GmLRxBl5k=;
        b=U3gvqv32R60nL8YL8VC28A2ySIp7SfQT78maT4v4D5X3FwZYQ3o2uMnJ2GzyZXPm+W
         GTlOPZcUB/P7loRtuk+QoNngumL1xj3DTGteiAlh/ZPmwty7JoNOb894Fonycfy9Xmhw
         46tugB7kSORE8SCnWvZgN1GpgTvQF5D4PIAcQq+kdMzCfSgHC37+yzunslPcsXJO69s7
         qG096B3J2cKxZg+bynfJSO0W9ck+BDmH4cNyo45KuH3V8WkdXidrNwymwFd/BWVK4P9F
         SJrwTCel3xdiqXjGfvpaGBhxLKeNnl7zYoDPOIqgk3in6QO+ItZMfih7SFi8q4bQr+re
         UfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=dHLs9/UME2iU/FrY3Bb2bga6u1fOEyaib1GmLRxBl5k=;
        b=bLT2AJvLY19Kjt8LI9BNzpc2dmVZkAoyle2NmN10hofN2pWXMtvFiLk8IQAda5wFDD
         5soUn3YctUmwjsgocau8u44y5Ia0Nshoua23O7EqZvVnCp5dPi1lqXE7e3c7WjUxIFP9
         NzegjDMqBUFq+CIOlmChFskL4uZ1/ONdka+0OK08ZKdjFkCsdInsdqA+x/mhb6AuJdWx
         +cNgblbRIXAlNLSknQ+ga75CJzTcDQB93oTPR+G/Uh+mR7lA34VnBRLjobI5meyDVHgQ
         r/0Pelm8Udei6lyqItO9iYHvwmNL0b06vxbDnxkZCnlAh46uGy46WMmQAmAfKZ7pqDuB
         5Pzw==
X-Gm-Message-State: AHPjjUjSk4bmEn8HiURvEc+0jnTPt3tDxMM1KsS+3ucRP7bUN+yzyfQb
        83oGloScnIp5eTe7vVMbFs8QUZohY8E=
X-Google-Smtp-Source: AOwi7QCaIKoy57UE9KDRQARcqVAwNIE3y1U0JTY8rDpb3HSA1fo6Rljgd36RM6hTovwhBBgXQogXOw==
X-Received: by 10.84.240.137 with SMTP id z9mr8123135plk.114.1506715949669;
        Fri, 29 Sep 2017 13:12:29 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id g5sm9280561pgo.66.2017.09.29.13.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 13:12:28 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        git@jeffhostetler.com, peartben@gmail.com,
        christian.couder@gmail.com
Subject: [PATCH 17/18] unpack-trees: batch fetching of missing blobs
Date:   Fri, 29 Sep 2017 13:11:53 -0700
Message-Id: <73f9648b4c258eae1d02f91f12250ea139b72519.1506714999.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.748.g20475d2c7
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running checkout, first prefetch all blobs that are to be updated
but are missing. This means that only one pack is downloaded during such
operations, instead of one per missing blob.

This operates only on the blob level - if a repository has a missing
tree, they are still fetched one at a time.

This does not use the delayed checkout mechanism introduced in commit
2841e8f ("convert: add "status=delayed" to filter process protocol",
2017-06-30) due to significant conceptual differences - in particular,
for partial clones, we already know what needs to be fetched based on
the contents of the local repo alone, whereas for status=delayed, it is
the filter process that tells us what needs to be checked in the end.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-object.c   | 27 +++++++++++++++++++++++----
 fetch-object.h   |  5 +++++
 t/t5601-clone.sh | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c   | 22 ++++++++++++++++++++++
 4 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/fetch-object.c b/fetch-object.c
index 369b61c0e..21b4dfafc 100644
--- a/fetch-object.c
+++ b/fetch-object.c
@@ -3,12 +3,12 @@
 #include "pkt-line.h"
 #include "strbuf.h"
 #include "transport.h"
+#include "fetch-object.h"
 
-void fetch_object(const char *remote_name, const unsigned char *sha1)
+static void fetch_refs(const char *remote_name, struct ref *ref)
 {
 	struct remote *remote;
 	struct transport *transport;
-	struct ref *ref;
 	int original_fetch_if_missing = fetch_if_missing;
 
 	fetch_if_missing = 0;
@@ -17,10 +17,29 @@ void fetch_object(const char *remote_name, const unsigned char *sha1)
 		die(_("Remote with no URL"));
 	transport = transport_get(remote, remote->url[0]);
 
-	ref = alloc_ref(sha1_to_hex(sha1));
-	hashcpy(ref->old_oid.hash, sha1);
 	transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
 	transport_set_option(transport, TRANS_OPT_NO_HAVES, "1");
 	transport_fetch_refs(transport, ref);
 	fetch_if_missing = original_fetch_if_missing;
 }
+
+void fetch_object(const char *remote_name, const unsigned char *sha1)
+{
+	struct ref *ref = alloc_ref(sha1_to_hex(sha1));
+	hashcpy(ref->old_oid.hash, sha1);
+	fetch_refs(remote_name, ref);
+}
+
+void fetch_objects(const char *remote_name, const struct oid_array *to_fetch)
+{
+	struct ref *ref = NULL;
+	int i;
+
+	for (i = 0; i < to_fetch->nr; i++) {
+		struct ref *new_ref = alloc_ref(oid_to_hex(&to_fetch->oid[i]));
+		oidcpy(&new_ref->old_oid, &to_fetch->oid[i]);
+		new_ref->next = ref;
+		ref = new_ref;
+	}
+	fetch_refs(remote_name, ref);
+}
diff --git a/fetch-object.h b/fetch-object.h
index f371300c8..4b269d07e 100644
--- a/fetch-object.h
+++ b/fetch-object.h
@@ -1,6 +1,11 @@
 #ifndef FETCH_OBJECT_H
 #define FETCH_OBJECT_H
 
+#include "sha1-array.h"
+
 extern void fetch_object(const char *remote_name, const unsigned char *sha1);
 
+extern void fetch_objects(const char *remote_name,
+			  const struct oid_array *to_fetch);
+
 #endif
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 951b1ffa8..0ca24c215 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -611,6 +611,58 @@ test_expect_success 'partial clone: warn if server does not support blob-max-byt
 	test_i18ngrep "blob-max-bytes not recognized by server" err
 '
 
+test_expect_success 'batch missing blob request during checkout' '
+	rm -rf server client &&
+
+	test_create_repo server &&
+	echo a >server/a &&
+	echo b >server/b &&
+	git -C server add a b &&
+
+	git -C server commit -m x &&
+	echo aa >server/a &&
+	echo bb >server/b &&
+	git -C server add a b &&
+	git -C server commit -m x &&
+
+	test_config -C server uploadpack.advertiseblobmaxbytes 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+
+	git clone --blob-max-bytes=0 "file://$(pwd)/server" client &&
+
+	# Ensure that there is only one negotiation by checking that there is
+	# only "done" line sent. ("done" marks the end of negotiation.)
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client checkout HEAD^ &&
+	grep "git> done" trace >done_lines &&
+	test_line_count = 1 done_lines
+'
+
+test_expect_success 'batch missing blob request does not inadvertently try to fetch gitlinks' '
+	rm -rf server client &&
+
+	test_create_repo repo_for_submodule &&
+	test_commit -C repo_for_submodule x &&
+
+	test_create_repo server &&
+	echo a >server/a &&
+	echo b >server/b &&
+	git -C server add a b &&
+	git -C server commit -m x &&
+
+	echo aa >server/a &&
+	echo bb >server/b &&
+	# Also add a gitlink pointing to an arbitrary repository
+	git -C server submodule add "$(pwd)/repo_for_submodule" c &&
+	git -C server add a b c &&
+	git -C server commit -m x &&
+
+	test_config -C server uploadpack.advertiseblobmaxbytes 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+
+	# Make sure that it succeeds
+	git clone --blob-max-bytes=0 "file://$(pwd)/server" client
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 71b70ccb1..73a1cdb43 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -14,6 +14,7 @@
 #include "dir.h"
 #include "submodule.h"
 #include "submodule-config.h"
+#include "fetch-object.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -369,6 +370,27 @@ static int check_updates(struct unpack_trees_options *o)
 		load_gitmodules_file(index, &state);
 
 	enable_delayed_checkout(&state);
+	if (repository_format_partial_clone && o->update && !o->dry_run) {
+		/*
+		 * Prefetch the objects that are to be checked out in the loop
+		 * below.
+		 */
+		struct oid_array to_fetch = OID_ARRAY_INIT;
+		int fetch_if_missing_store = fetch_if_missing;
+		fetch_if_missing = 0;
+		for (i = 0; i < index->cache_nr; i++) {
+			struct cache_entry *ce = index->cache[i];
+			if ((ce->ce_flags & CE_UPDATE) &&
+			    !S_ISGITLINK(ce->ce_mode)) {
+				if (!has_object_file(&ce->oid))
+					oid_array_append(&to_fetch, &ce->oid);
+			}
+		}
+		if (to_fetch.nr)
+			fetch_objects(repository_format_partial_clone,
+				      &to_fetch);
+		fetch_if_missing = fetch_if_missing_store;
+	}
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
-- 
2.14.2.822.g60be5d43e6-goog

