Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26EBC20A40
	for <e@80x24.org>; Tue,  5 Dec 2017 17:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbdLEQ76 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 11:59:58 -0500
Received: from siwi.pair.com ([209.68.5.199]:45185 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752616AbdLEQ7R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 11:59:17 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A4C53844E5;
        Tue,  5 Dec 2017 11:59:16 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 29B29844DE;
        Tue,  5 Dec 2017 11:59:16 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        christian.couder@gmail.com
Subject: [PATCH v6 08/12] sha1_file: support lazily fetching missing objects
Date:   Tue,  5 Dec 2017 16:58:50 +0000
Message-Id: <20171205165854.64979-9-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171205165854.64979-1-git@jeffhostetler.com>
References: <20171205165854.64979-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Teach sha1_file to fetch objects from the remote configured in
extensions.partialclone whenever an object is requested but missing.

The fetching of objects can be suppressed through a global variable.
This is used by fsck and index-pack.

However, by default, such fetching is not suppressed. This is meant as a
temporary measure to ensure that all Git commands work in such a
situation. Future patches will update some commands to either tolerate
missing objects (without fetching them) or be more efficient in fetching
them.

In order to determine the code changes in sha1_file.c necessary, I
investigated the following:
 (1) functions in sha1_file.c that take in a hash, without the user
     regarding how the object is stored (loose or packed)
 (2) functions in packfile.c (because I need to check callers that know
     about the loose/packed distinction and operate on both differently,
     and ensure that they can handle the concept of objects that are
     neither loose nor packed)

(1) is handled by the modification to sha1_object_info_extended().

For (2), I looked at for_each_packed_object and others.  For
for_each_packed_object, the callers either already work or are fixed in
this patch:
 - reachable - only to find recent objects
 - builtin/fsck - already knows about missing objects
 - builtin/cat-file - warning message added in this commit

Callers of the other functions do not need to be changed:
 - parse_pack_index
   - http - indirectly from http_get_info_packs
   - find_pack_entry_one
     - this searches a single pack that is provided as an argument; the
       caller already knows (through other means) that the sought object
       is in a specific pack
 - find_sha1_pack
   - fast-import - appears to be an optimization to not store a file if
     it is already in a pack
   - http-walker - to search through a struct alt_base
   - http-push - to search through remote packs
 - has_sha1_pack
   - builtin/fsck - already knows about promisor objects
   - builtin/count-objects - informational purposes only (check if loose
     object is also packed)
   - builtin/prune-packed - check if object to be pruned is packed (if
     not, don't prune it)
   - revision - used to exclude packed objects if requested by user
   - diff - just for optimization

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/cat-file.c       |  2 ++
 builtin/fetch-pack.c     |  2 ++
 builtin/fsck.c           |  3 +++
 builtin/index-pack.c     |  6 ++++++
 cache.h                  |  8 ++++++++
 fetch-object.c           |  3 +++
 sha1_file.c              | 38 ++++++++++++++++++++++++------------
 t/t0410-partial-clone.sh | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 100 insertions(+), 13 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f5fa4fd..cf9ea5c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -475,6 +475,8 @@ static int batch_objects(struct batch_options *opt)
 
 		for_each_loose_object(batch_loose_object, &sa, 0);
 		for_each_packed_object(batch_packed_object, &sa, 0);
+		if (repository_format_partial_clone)
+			warning("This repository has extensions.partialClone set. Some objects may not be loaded.");
 
 		cb.opt = opt;
 		cb.expand = &data;
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 02abe72..15eeed7 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -53,6 +53,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	struct oid_array shallow = OID_ARRAY_INIT;
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
 
+	fetch_if_missing = 0;
+
 	packet_trace_identity("fetch-pack");
 
 	memset(&args, 0, sizeof(args));
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 578a7c8..3b76c0e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -678,6 +678,9 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	int i;
 	struct alternate_object_database *alt;
 
+	/* fsck knows how to handle missing promisor objects */
+	fetch_if_missing = 0;
+
 	errors_found = 0;
 	check_replace_refs = 0;
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 24c2f05..a0a35e6 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1657,6 +1657,12 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	unsigned foreign_nr = 1;	/* zero is a "good" value, assume bad */
 	int report_end_of_input = 0;
 
+	/*
+	 * index-pack never needs to fetch missing objects, since it only
+	 * accesses the repo to do hash collision checks
+	 */
+	fetch_if_missing = 0;
+
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(index_pack_usage);
 
diff --git a/cache.h b/cache.h
index c76f2e9..6980072 100644
--- a/cache.h
+++ b/cache.h
@@ -1727,6 +1727,14 @@ struct object_info {
 #define OBJECT_INFO_QUICK 8
 extern int sha1_object_info_extended(const unsigned char *, struct object_info *, unsigned flags);
 
+/*
+ * Set this to 0 to prevent sha1_object_info_extended() from fetching missing
+ * blobs. This has a difference only if extensions.partialClone is set.
+ *
+ * Its default value is 1.
+ */
+extern int fetch_if_missing;
+
 /* Dumb servers support */
 extern int update_server_info(int);
 
diff --git a/fetch-object.c b/fetch-object.c
index 08e91ce..258fcfa 100644
--- a/fetch-object.c
+++ b/fetch-object.c
@@ -10,7 +10,9 @@ void fetch_object(const char *remote_name, const unsigned char *sha1)
 	struct remote *remote;
 	struct transport *transport;
 	struct ref *ref;
+	int original_fetch_if_missing = fetch_if_missing;
 
+	fetch_if_missing = 0;
 	remote = remote_get(remote_name);
 	if (!remote->url[0])
 		die(_("Remote with no URL"));
@@ -21,4 +23,5 @@ void fetch_object(const char *remote_name, const unsigned char *sha1)
 	transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
 	transport_set_option(transport, TRANS_OPT_NO_DEPENDENTS, "1");
 	transport_fetch_refs(transport, ref);
+	fetch_if_missing = original_fetch_if_missing;
 }
diff --git a/sha1_file.c b/sha1_file.c
index 10c3a00..fc7718a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -29,6 +29,7 @@
 #include "mergesort.h"
 #include "quote.h"
 #include "packfile.h"
+#include "fetch-object.h"
 
 const unsigned char null_sha1[GIT_MAX_RAWSZ];
 const struct object_id null_oid;
@@ -1144,6 +1145,8 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	return (status < 0) ? status : 0;
 }
 
+int fetch_if_missing = 1;
+
 int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
 {
 	static struct object_info blank_oi = OBJECT_INFO_INIT;
@@ -1152,6 +1155,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
 				    lookup_replace_object(sha1) :
 				    sha1;
+	int already_retried = 0;
 
 	if (!oi)
 		oi = &blank_oi;
@@ -1176,28 +1180,36 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		}
 	}
 
-	if (!find_pack_entry(real, &e)) {
-		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(real, oi, flags))
-			return 0;
+retry:
+	if (find_pack_entry(real, &e))
+		goto found_packed;
 
-		/* Not a loose object; someone else may have just packed it. */
-		if (flags & OBJECT_INFO_QUICK) {
-			return -1;
-		} else {
-			reprepare_packed_git();
-			if (!find_pack_entry(real, &e))
-				return -1;
-		}
+	/* Most likely it's a loose object. */
+	if (!sha1_loose_object_info(real, oi, flags))
+		return 0;
+
+	/* Not a loose object; someone else may have just packed it. */
+	reprepare_packed_git();
+	if (find_pack_entry(real, &e))
+		goto found_packed;
+
+	/* Check if it is a missing object */
+	if (fetch_if_missing && repository_format_partial_clone &&
+	    !already_retried) {
+		fetch_object(repository_format_partial_clone, real);
+		already_retried = 1;
+		goto retry;
 	}
 
+	return -1;
+
+found_packed:
 	if (oi == &blank_oi)
 		/*
 		 * We know that the caller doesn't actually need the
 		 * information below, so return early.
 		 */
 		return 0;
-
 	rtype = packed_object_info(e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real);
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index e96f436..8a90f6a 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -138,4 +138,55 @@ test_expect_success 'missing CLI object, but promised, passes fsck' '
 	git -C repo fsck "$A"
 '
 
+test_expect_success 'fetching of missing objects' '
+	rm -rf repo &&
+	test_create_repo server &&
+	test_commit -C server foo &&
+	git -C server repack -a -d --write-bitmap-index &&
+
+	git clone "file://$(pwd)/server" repo &&
+	HASH=$(git -C repo rev-parse foo) &&
+	rm -rf repo/.git/objects/* &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "origin" &&
+	git -C repo cat-file -p "$HASH" &&
+
+	# Ensure that the .promisor file is written, and check that its
+	# associated packfile contains the object
+	ls repo/.git/objects/pack/pack-*.promisor >promisorlist &&
+	test_line_count = 1 promisorlist &&
+	IDX=$(cat promisorlist | sed "s/promisor$/idx/") &&
+	git verify-pack --verbose "$IDX" | grep "$HASH"
+'
+
+LIB_HTTPD_PORT=12345  # default port, 410, cannot be used as non-root
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'fetching of missing objects from an HTTP server' '
+	rm -rf repo &&
+	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
+	test_create_repo "$SERVER" &&
+	test_commit -C "$SERVER" foo &&
+	git -C "$SERVER" repack -a -d --write-bitmap-index &&
+
+	git clone $HTTPD_URL/smart/server repo &&
+	HASH=$(git -C repo rev-parse foo) &&
+	rm -rf repo/.git/objects/* &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "origin" &&
+	git -C repo cat-file -p "$HASH" &&
+
+	# Ensure that the .promisor file is written, and check that its
+	# associated packfile contains the object
+	ls repo/.git/objects/pack/pack-*.promisor >promisorlist &&
+	test_line_count = 1 promisorlist &&
+	IDX=$(cat promisorlist | sed "s/promisor$/idx/") &&
+	git verify-pack --verbose "$IDX" | grep "$HASH"
+'
+
+stop_httpd
+
 test_done
-- 
2.9.3

