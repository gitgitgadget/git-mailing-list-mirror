Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD474202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 17:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbdGMRfu (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 13:35:50 -0400
Received: from siwi.pair.com ([209.68.5.199]:11117 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752642AbdGMRfo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 13:35:44 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7FCAB844E5;
        Thu, 13 Jul 2017 13:35:44 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D1D76844E3;
        Thu, 13 Jul 2017 13:35:43 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, ethomson@edwardthomson.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        jeffhost@microsoft.com
Subject: [PATCH v2 18/19] index-pack: relax consistency checks for omitted objects
Date:   Thu, 13 Jul 2017 17:34:58 +0000
Message-Id: <20170713173459.3559-19-git@jeffhostetler.com>
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
 builtin/index-pack.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 4ff567d..30ff409 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -11,6 +11,7 @@
 #include "exec_cmd.h"
 #include "streaming.h"
 #include "thread-utils.h"
+#include "object-filter.h"
 
 static const char index_pack_usage[] =
 "git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
@@ -80,6 +81,7 @@ static int verbose;
 static int show_resolving_progress;
 static int show_stat;
 static int check_self_contained_and_connected;
+static int filter_relax;
 
 static struct progress *progress;
 
@@ -220,6 +222,17 @@ static unsigned check_object(struct object *obj)
 	if (!(obj->flags & FLAG_CHECKED)) {
 		unsigned long size;
 		int type = sha1_object_info(obj->oid.hash, &size);
+
+		if (type <= 0 && filter_relax) {
+			/*
+			 * Relax consistency checks to not complain about
+			 * omitted objects (presumably caused by use of
+			 * the 'filter-objects' feature).
+			 */
+			obj->flags |= FLAG_CHECKED;
+			return 0;
+		}
+
 		if (type <= 0)
 			die(_("did not receive expected object %s"),
 			      oid_to_hex(&obj->oid));
@@ -1721,6 +1734,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 					die(_("bad %s"), arg);
 			} else if (skip_prefix(arg, "--max-input-size=", &arg)) {
 				max_input_size = strtoumax(arg, NULL, 10);
+			} else if (!strcmp(arg, ("--"CL_ARG_FILTER_RELAX))) {
+				filter_relax = 1;
 			} else
 				usage(index_pack_usage);
 			continue;
-- 
2.9.3

