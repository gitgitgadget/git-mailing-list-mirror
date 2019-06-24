Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F38551F461
	for <e@80x24.org>; Mon, 24 Jun 2019 12:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbfFXMVs (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 08:21:48 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.57]:43021 "EHLO mta1.cl.cam.ac.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfFXMVr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 08:21:47 -0400
Received: from methi.cl.cam.ac.uk ([2001:630:212:238:fa32:e4ff:fe88:56f3])
        by mta1.cl.cam.ac.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <nwf20@cl.cam.ac.uk>)
        id 1hfNlB-0005z3-Qm; Mon, 24 Jun 2019 12:07:45 +0000
Received: from nwf20 by methi.cl.cam.ac.uk with local (Exim 4.90_1)
        (envelope-from <nwf20@cl.cam.ac.uk>)
        id 1hfNlB-0007EQ-OK; Mon, 24 Jun 2019 13:07:45 +0100
From:   Nathaniel Filardo <nwf20@cl.cam.ac.uk>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, Nathaniel Filardo <nwf20@cl.cam.ac.uk>
Subject: [PATCH v3 1/5] count-objects: report statistics about kept packs
Date:   Mon, 24 Jun 2019 13:07:07 +0100
Message-Id: <20190624120711.27744-2-nwf20@cl.cam.ac.uk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624120711.27744-1-nwf20@cl.cam.ac.uk>
References: <20190624120711.27744-1-nwf20@cl.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Specifically: number of kept packs, size of kept packs (and indexes),
and number of objects in kept packs.

Add documentation of resulting fields.  While here, correct the omission
from ae72f68541 ("count-objects -v: show number of packs as well.",
2006-12-27) of the "packs" field.

Update tests which were searching for the "in-pack" field without
the terminating colon and so were now also picking up the "in-pack-keep"
field.

Signed-off-by: Nathaniel Filardo <nwf20@cl.cam.ac.uk>

update count-objects
---
 Documentation/git-count-objects.txt |  8 ++++++++
 builtin/count-objects.c             | 17 +++++++++++++++--
 t/t5500-fetch-pack.sh               |  8 ++++----
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
index cb9b4d2e46..8d88f87856 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -26,10 +26,18 @@ count: the number of loose objects
 +
 size: disk space consumed by loose objects, in KiB (unless -H is specified)
 +
+packs: the number of pack files
++
+packs-keep: the number of pack files marked kept
++
 in-pack: the number of in-pack objects
 +
+in-pack-keep: the number of objects in packs marked kept
++
 size-pack: disk space consumed by the packs, in KiB (unless -H is specified)
 +
+size-pack-keep: disk space consumed by kept packs, in KiB (unless -H is specified)
++
 prune-packable: the number of loose objects that are also present in
 the packs. These objects could be pruned using `git prune-packed`.
 +
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 3fae474f6f..0309c7907f 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -117,17 +117,24 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 
 	if (verbose) {
 		struct packed_git *p;
-		unsigned long num_pack = 0;
-		off_t size_pack = 0;
+		unsigned long num_pack = 0, num_pack_keep = 0;
+		unsigned long packed_keep = 0;
+		off_t size_pack = 0, size_pack_keep = 0;
 		struct strbuf loose_buf = STRBUF_INIT;
 		struct strbuf pack_buf = STRBUF_INIT;
 		struct strbuf garbage_buf = STRBUF_INIT;
+		struct strbuf pack_keep_buf = STRBUF_INIT;
 
 		for (p = get_all_packs(the_repository); p; p = p->next) {
 			if (!p->pack_local)
 				continue;
 			if (open_pack_index(p))
 				continue;
+			if (p->pack_keep || p->pack_keep_in_core) {
+				packed_keep += p->num_objects;
+				size_pack_keep += p->pack_size + p->index_size;
+				num_pack_keep++;
+			}
 			packed += p->num_objects;
 			size_pack += p->pack_size + p->index_size;
 			num_pack++;
@@ -136,12 +143,15 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 		if (human_readable) {
 			strbuf_humanise_bytes(&loose_buf, loose_size);
 			strbuf_humanise_bytes(&pack_buf, size_pack);
+			strbuf_humanise_bytes(&pack_keep_buf, size_pack_keep);
 			strbuf_humanise_bytes(&garbage_buf, size_garbage);
 		} else {
 			strbuf_addf(&loose_buf, "%lu",
 				    (unsigned long)(loose_size / 1024));
 			strbuf_addf(&pack_buf, "%lu",
 				    (unsigned long)(size_pack / 1024));
+			strbuf_addf(&pack_keep_buf, "%lu",
+				    (unsigned long)(size_pack_keep / 1024));
 			strbuf_addf(&garbage_buf, "%lu",
 				    (unsigned long)(size_garbage / 1024));
 		}
@@ -149,8 +159,11 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 		printf("count: %lu\n", loose);
 		printf("size: %s\n", loose_buf.buf);
 		printf("in-pack: %lu\n", packed);
+		printf("in-pack-keep: %lu\n", packed_keep);
 		printf("packs: %lu\n", num_pack);
+		printf("packs-keep: %lu\n", num_pack_keep);
 		printf("size-pack: %s\n", pack_buf.buf);
+		printf("size-pack-keep: %s\n", pack_keep_buf.buf);
 		printf("prune-packable: %lu\n", packed_loose);
 		printf("garbage: %lu\n", garbage);
 		printf("size-garbage: %s\n", garbage_buf.buf);
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 1c71c0ec77..a1d154a4ee 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -328,7 +328,7 @@ test_expect_success 'clone shallow with --branch' '
 test_expect_success 'clone shallow object count' '
 	echo "in-pack: 3" > count3.expected &&
 	GIT_DIR=shallow3/.git git count-objects -v |
-		grep "^in-pack" > count3.actual &&
+		grep "^in-pack:" > count3.actual &&
 	test_cmp count3.expected count3.actual
 '
 
@@ -357,7 +357,7 @@ EOF
 
 	echo "in-pack: 4" > count6.expected &&
 	GIT_DIR=shallow6/.git git count-objects -v |
-		grep "^in-pack" > count6.actual &&
+		grep "^in-pack:" > count6.actual &&
 	test_cmp count6.expected count6.actual
 '
 
@@ -372,7 +372,7 @@ EOF
 
 	echo "in-pack: 4" > count7.expected &&
 	GIT_DIR=shallow7/.git git count-objects -v |
-		grep "^in-pack" > count7.actual &&
+		grep "^in-pack:" > count7.actual &&
 	test_cmp count7.expected count7.actual
 '
 
@@ -381,7 +381,7 @@ test_expect_success 'clone shallow with packed refs' '
 	git clone --depth 1 --branch A "file://$(pwd)/." shallow8 &&
 	echo "in-pack: 4" > count8.expected &&
 	GIT_DIR=shallow8/.git git count-objects -v |
-		grep "^in-pack" > count8.actual &&
+		grep "^in-pack:" > count8.actual &&
 	test_cmp count8.expected count8.actual
 '
 
-- 
2.17.1

