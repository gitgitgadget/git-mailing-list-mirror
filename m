Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A37D320281
	for <e@80x24.org>; Thu,  2 Nov 2017 20:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934541AbdKBUcB (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 16:32:01 -0400
Received: from siwi.pair.com ([209.68.5.199]:14642 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934526AbdKBUb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 16:31:57 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6D9C9845AF;
        Thu,  2 Nov 2017 16:31:57 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 7100E845AC;
        Thu,  2 Nov 2017 16:31:56 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 14/14] index-pack: silently assume missing objects are promisor
Date:   Thu,  2 Nov 2017 20:31:29 +0000
Message-Id: <20171102203129.59417-15-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171102203129.59417-1-git@jeffhostetler.com>
References: <20171102203129.59417-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach index-pack to not complain about missing objects
when the --promisor flag is given.  The assumption is that
index-pack is currently building the idx and promisor data
and the is_promisor_object() query would fail anyway.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/index-pack.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 31cd5ba..51693dc 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -82,6 +82,7 @@ static int verbose;
 static int show_resolving_progress;
 static int show_stat;
 static int check_self_contained_and_connected;
+static int arg_promisor_given;
 
 static struct progress *progress;
 
@@ -223,10 +224,11 @@ static unsigned check_object(struct object *obj)
 		unsigned long size;
 		int type = sha1_object_info(obj->oid.hash, &size);
 
-		if (type <= 0) {
+		if (type <= 0 && arg_promisor_given) {
 			/*
-			 * TODO Use the promisor code to conditionally
-			 * try to fetch this object -or- assume it is ok.
+			 * Assume this missing object is promised.  We can't
+			 * confirm it because we are indexing the packfile
+			 * that omitted it.
 			 */
 			obj->flags |= FLAG_CHECKED;
 			return 0;
@@ -1717,8 +1719,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				keep_msg = arg + 7;
 			} else if (!strcmp(arg, "--promisor")) {
 				promisor_msg = "";
+				arg_promisor_given = 1;
 			} else if (starts_with(arg, "--promisor=")) {
 				promisor_msg = arg + strlen("--promisor=");
+				arg_promisor_given = 1;
 			} else if (starts_with(arg, "--threads=")) {
 				char *end;
 				nr_threads = strtoul(arg+10, &end, 0);
-- 
2.9.3

