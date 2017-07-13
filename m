Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DC4A202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 17:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbdGMRfx (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 13:35:53 -0400
Received: from siwi.pair.com ([209.68.5.199]:11100 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752642AbdGMRfw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 13:35:52 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 43228844F5;
        Thu, 13 Jul 2017 13:35:41 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 94A85844E3;
        Thu, 13 Jul 2017 13:35:40 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, ethomson@edwardthomson.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        jeffhost@microsoft.com
Subject: [PATCH v2 14/19] upload-pack: add object filtering
Date:   Thu, 13 Jul 2017 17:34:54 +0000
Message-Id: <20170713173459.3559-15-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170713173459.3559-1-git@jeffhostetler.com>
References: <20170713173459.3559-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 upload-pack.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/upload-pack.c b/upload-pack.c
index ffb028d..c709054 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -17,6 +17,7 @@
 #include "parse-options.h"
 #include "argv-array.h"
 #include "prio-queue.h"
+#include "object-filter.h"
 
 static const char * const upload_pack_usage[] = {
 	N_("git upload-pack [<options>] <dir>"),
@@ -63,6 +64,9 @@ static int advertise_refs;
 static int stateless_rpc;
 static const char *pack_objects_hook;
 
+static int capability_filter_objects_requested;
+static struct object_filter_options filter_options;
+
 static void reset_timeout(void)
 {
 	alarm(timeout);
@@ -131,6 +135,30 @@ static void create_pack_file(void)
 	if (use_include_tag)
 		argv_array_push(&pack_objects.args, "--include-tag");
 
+	if (filter_options.omit_all_blobs)
+		argv_array_push(&pack_objects.args,
+				("--" CL_ARG_FILTER_OMIT_ALL_BLOBS));
+	else if (filter_options.omit_large_blobs) {
+		if (filter_options.large_byte_limit_string)
+			argv_array_pushf(&pack_objects.args, "--%s=%s",
+					 CL_ARG_FILTER_OMIT_LARGE_BLOBS,
+					 filter_options.large_byte_limit_string);
+		else
+			argv_array_pushf(&pack_objects.args, "--%s=%ld",
+					 CL_ARG_FILTER_OMIT_LARGE_BLOBS,
+					 filter_options.large_byte_limit);
+	}
+	else if (filter_options.use_sparse) {
+		if (!oidcmp(&filter_options.sparse_oid, &null_oid))
+			argv_array_pushf(&pack_objects.args, "--%s=%s",
+					 CL_ARG_FILTER_USE_SPARSE,
+					 oid_to_hex(&filter_options.sparse_oid));
+		else
+			argv_array_pushf(&pack_objects.args, "--%s=%s",
+					 CL_ARG_FILTER_USE_SPARSE,
+					 filter_options.sparse_value);
+	}
+
 	pack_objects.in = -1;
 	pack_objects.out = -1;
 	pack_objects.err = -1;
@@ -793,6 +821,12 @@ static void receive_needs(void)
 			deepen_rev_list = 1;
 			continue;
 		}
+		if (object_filter_hand_parse_protocol(&filter_options, line, 0, 0)) {
+			if (!capability_filter_objects_requested)
+				die("git upload-pack: object filtering requires '%s' capability",
+				    PROTOCOL_CAPABILITY_FILTER_OBJECTS);
+			continue;
+		}
 		if (!skip_prefix(line, "want ", &arg) ||
 		    get_sha1_hex(arg, sha1_buf))
 			die("git upload-pack: protocol error, "
@@ -820,6 +854,8 @@ static void receive_needs(void)
 			no_progress = 1;
 		if (parse_feature_request(features, "include-tag"))
 			use_include_tag = 1;
+		if (parse_feature_request(features, PROTOCOL_CAPABILITY_FILTER_OBJECTS))
+			capability_filter_objects_requested = 1;
 
 		o = parse_object(sha1_buf);
 		if (!o) {
@@ -928,7 +964,8 @@ static int send_ref(const char *refname, const struct object_id *oid,
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow deepen-since deepen-not"
-		" deepen-relative no-progress include-tag multi_ack_detailed";
+		" deepen-relative no-progress include-tag multi_ack_detailed"
+		" " PROTOCOL_CAPABILITY_FILTER_OBJECTS;
 	const char *refname_nons = strip_namespace(refname);
 	struct object_id peeled;
 
-- 
2.9.3

