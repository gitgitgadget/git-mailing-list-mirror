Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D064202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 20:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754494AbdCHUro (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 15:47:44 -0500
Received: from siwi.pair.com ([209.68.5.199]:33649 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754203AbdCHUra (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 15:47:30 -0500
Received: from jeffhostetler.2jll4ugiwlvuzhh55dqabi0nia.bx.internal.cloudapp.net (unknown [40.76.14.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4073584614;
        Wed,  8 Mar 2017 13:51:02 -0500 (EST)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, peff@peff.net, gitster@pobox.com,
        markbt@efaref.net, benpeart@microsoft.com,
        jonathantanmy@google.com, Jeff Hostetler <git@jeffhostetler.com>
Subject: [PATCH 06/10] rev-list: add --allow-partial option to relax connectivity checks
Date:   Wed,  8 Mar 2017 18:50:35 +0000
Message-Id: <1488999039-37631-7-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
References: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <git@jeffhostetler.com>

Teach rev-list to optionally not complain when there are missing
blobs.  This is for use following a partial clone or fetch when
the server omitted certain blobs.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/rev-list.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 0aa93d5..50c49ba 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -45,6 +45,7 @@ static const char rev_list_usage[] =
 "    --left-right\n"
 "    --count\n"
 "  special purpose:\n"
+"    --allow-partial\n"
 "    --bisect\n"
 "    --bisect-vars\n"
 "    --bisect-all"
@@ -53,6 +54,9 @@ static const char rev_list_usage[] =
 static struct progress *progress;
 static unsigned progress_counter;
 
+static int allow_partial;
+static struct trace_key trace_partial = TRACE_KEY_INIT(PARTIAL);
+
 static void finish_commit(struct commit *commit, void *data);
 static void show_commit(struct commit *commit, void *data)
 {
@@ -178,8 +182,16 @@ static void finish_commit(struct commit *commit, void *data)
 static void finish_object(struct object *obj, const char *name, void *cb_data)
 {
 	struct rev_list_info *info = cb_data;
-	if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid))
+	if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid)) {
+		if (allow_partial) {
+			/* Assume a previous partial clone/fetch omitted it. */
+			trace_printf_key(
+				&trace_partial, "omitted blob '%s' '%s'\n",
+				oid_to_hex(&obj->oid), name);
+			return;
+		}
 		die("missing blob object '%s'", oid_to_hex(&obj->oid));
+	}
 	if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
 		parse_object(obj->oid.hash);
 }
@@ -329,6 +341,14 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			show_progress = arg;
 			continue;
 		}
+		if (!strcmp(arg, "--allow-partial")) {
+			allow_partial = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--no-allow-partial")) {
+			allow_partial = 0;
+			continue;
+		}
 		usage(rev_list_usage);
 
 	}
-- 
2.7.4

