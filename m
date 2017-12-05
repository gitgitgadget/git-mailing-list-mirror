Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44BDD20A40
	for <e@80x24.org>; Tue,  5 Dec 2017 17:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753173AbdLERDV (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 12:03:21 -0500
Received: from siwi.pair.com ([209.68.5.199]:15316 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753164AbdLERDS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 12:03:18 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8905D844E5;
        Tue,  5 Dec 2017 12:03:17 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0F85E844DE;
        Tue,  5 Dec 2017 12:03:16 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6 12/14] unpack-trees: batch fetching of missing blobs
Date:   Tue,  5 Dec 2017 17:02:52 +0000
Message-Id: <20171205170254.65293-13-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171205170254.65293-1-git@jeffhostetler.com>
References: <20171205170254.65293-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

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
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 fetch-object.c   | 26 ++++++++++++++++++++++----
 fetch-object.h   |  5 +++++
 t/t5601-clone.sh | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c   | 22 ++++++++++++++++++++++
 4 files changed, 101 insertions(+), 4 deletions(-)

diff --git a/fetch-object.c b/fetch-object.c
index 258fcfa..853624f 100644
--- a/fetch-object.c
+++ b/fetch-object.c
@@ -5,11 +5,10 @@
 #include "transport.h"
 #include "fetch-object.h"
 
-void fetch_object(const char *remote_name, const unsigned char *sha1)
+static void fetch_refs(const char *remote_name, struct ref *ref)
 {
 	struct remote *remote;
 	struct transport *transport;
-	struct ref *ref;
 	int original_fetch_if_missing = fetch_if_missing;
 
 	fetch_if_missing = 0;
@@ -18,10 +17,29 @@ void fetch_object(const char *remote_name, const unsigned char *sha1)
 		die(_("Remote with no URL"));
 	transport = transport_get(remote, remote->url[0]);
 
-	ref = alloc_ref(sha1_to_hex(sha1));
-	hashcpy(ref->old_oid.hash, sha1);
 	transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
 	transport_set_option(transport, TRANS_OPT_NO_DEPENDENTS, "1");
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
index f371300..4b269d0 100644
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
index 6d37c6d..13610b7 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -611,6 +611,58 @@ test_expect_success 'partial clone: warn if server does not support object filte
 	test_i18ngrep "filtering not recognized by server" err
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
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+
+	git clone --filter=blob:limit=0 "file://$(pwd)/server" client &&
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
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+
+	# Make sure that it succeeds
+	git clone --filter=blob:limit=0 "file://$(pwd)/server" client
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 71b70cc..73a1cdb 100644
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
2.9.3

