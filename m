Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89EDD202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 20:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754481AbdCHUra (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 15:47:30 -0500
Received: from siwi.pair.com ([209.68.5.199]:29633 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754230AbdCHUr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 15:47:29 -0500
Received: from jeffhostetler.2jll4ugiwlvuzhh55dqabi0nia.bx.internal.cloudapp.net (unknown [40.76.14.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 67A3684615;
        Wed,  8 Mar 2017 13:51:02 -0500 (EST)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, peff@peff.net, gitster@pobox.com,
        markbt@efaref.net, benpeart@microsoft.com,
        jonathantanmy@google.com, Jeff Hostetler <git@jeffhostetler.com>
Subject: [PATCH 07/10] index-pack: add --allow-partial option to relax blob existence checks
Date:   Wed,  8 Mar 2017 18:50:36 +0000
Message-Id: <1488999039-37631-8-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
References: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <git@jeffhostetler.com>

Teach index-pack to optionally not complain when there are missing
blobs.  This is for use following a partial clone or fetch when
the server omitted certain blobs.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/index-pack.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f4b87c6..8f99408 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -13,7 +13,7 @@
 #include "thread-utils.h"
 
 static const char index_pack_usage[] =
-"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
+"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--verify] [--allow-partial] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
 
 struct object_entry {
 	struct pack_idx_entry idx;
@@ -81,6 +81,9 @@ static int show_resolving_progress;
 static int show_stat;
 static int check_self_contained_and_connected;
 
+static int allow_partial;
+static struct trace_key trace_partial = TRACE_KEY_INIT(PARTIAL);
+
 static struct progress *progress;
 
 /* We always read in 4kB chunks. */
@@ -220,9 +223,18 @@ static unsigned check_object(struct object *obj)
 	if (!(obj->flags & FLAG_CHECKED)) {
 		unsigned long size;
 		int type = sha1_object_info(obj->oid.hash, &size);
-		if (type <= 0)
+		if (type <= 0) {
+			if (allow_partial > 0 && obj->type == OBJ_BLOB) {
+				/* Assume a previous partial clone/fetch omitted it. */
+				trace_printf_key(
+					&trace_partial, "omitted blob '%s'\n",
+					oid_to_hex(&obj->oid));
+				obj->flags |= FLAG_CHECKED;
+				return 0;
+			}
 			die(_("did not receive expected object %s"),
 			      oid_to_hex(&obj->oid));
+		}
 		if (type != obj->type)
 			die(_("object %s: expected type %s, found %s"),
 			    oid_to_hex(&obj->oid),
@@ -1718,6 +1730,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 					die(_("bad %s"), arg);
 			} else if (skip_prefix(arg, "--max-input-size=", &arg)) {
 				max_input_size = strtoumax(arg, NULL, 10);
+			} else if (!strcmp(arg, "--allow-partial")) {
+				allow_partial = 1;
+			} else if (!strcmp(arg, "--no-allow-partial")) {
+				allow_partial = 0;
 			} else
 				usage(index_pack_usage);
 			continue;
-- 
2.7.4

