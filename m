Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E1FF2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 21:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbdKUVPw (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 16:15:52 -0500
Received: from siwi.pair.com ([209.68.5.199]:38433 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751339AbdKUVPo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 16:15:44 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0C1E8844F6;
        Tue, 21 Nov 2017 16:15:44 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8EF07844D5;
        Tue, 21 Nov 2017 16:15:43 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v5 05/14] remote-curl: add object filtering for partial clone
Date:   Tue, 21 Nov 2017 21:15:19 +0000
Message-Id: <20171121211528.21891-6-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171121211528.21891-1-git@jeffhostetler.com>
References: <20171121211528.21891-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/gitremote-helpers.txt |  4 ++++
 remote-curl.c                       | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 96feb4e..c2b3abf 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -472,6 +472,10 @@ set by Git if the remote helper has the 'option' capability.
 'option no-haves' {'true'|'false'}::
 	Do not send "have" lines.
 
+'option filter <filter-spec>'::
+	An object filter specification for partial clone or fetch
+	as described in rev-list.
+
 SEE ALSO
 --------
 linkgit:git-remote[1]
diff --git a/remote-curl.c b/remote-curl.c
index 34a81b8..31a3d8d 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -13,6 +13,7 @@
 #include "credential.h"
 #include "sha1-array.h"
 #include "send-pack.h"
+#include "list-objects-filter-options.h"
 
 static struct remote *remote;
 /* always ends with a trailing slash */
@@ -22,6 +23,7 @@ struct options {
 	int verbosity;
 	unsigned long depth;
 	char *deepen_since;
+	char *partial_clone_filter;
 	struct string_list deepen_not;
 	struct string_list push_options;
 	unsigned progress : 1,
@@ -165,6 +167,9 @@ static int set_option(const char *name, const char *value)
 	} else if (!strcmp(name, "no-haves")) {
 		options.no_haves = 1;
 		return 0;
+	} else if (!strcmp(name, "filter")) {
+		options.partial_clone_filter = xstrdup(value);
+		return 0;
 	} else {
 		return 1 /* unsupported */;
 	}
@@ -834,6 +839,13 @@ static int fetch_git(struct discovery *heads,
 		argv_array_push(&args, "--from-promisor");
 	if (options.no_haves)
 		argv_array_push(&args, "--no-haves");
+	if (options.partial_clone_filter) {
+		struct list_objects_filter_options filter_options;
+		parse_list_objects_filter(&filter_options,
+					  options.partial_clone_filter);
+		argv_array_pushf(&args, "--%s=%s", CL_ARG__FILTER,
+				 filter_options.filter_spec);
+	}
 	argv_array_push(&args, url.buf);
 
 	for (i = 0; i < nr_heads; i++) {
-- 
2.9.3

