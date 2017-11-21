Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A21A2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 21:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751591AbdKUVQf (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 16:16:35 -0500
Received: from siwi.pair.com ([209.68.5.199]:38416 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751345AbdKUVPn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 16:15:43 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id CE9F8844F0;
        Tue, 21 Nov 2017 16:15:42 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6C9E8844D5;
        Tue, 21 Nov 2017 16:15:42 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com
Subject: [PATCH v5 03/14] fetch: refactor calculation of remote list
Date:   Tue, 21 Nov 2017 21:15:17 +0000
Message-Id: <20171121211528.21891-4-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171121211528.21891-1-git@jeffhostetler.com>
References: <20171121211528.21891-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Separate out the calculation of remotes to be fetched from and the
actual fetching. This will allow us to include an additional step before
the actual fetching in a subsequent commit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 225c734..1b1f039 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1322,7 +1322,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	struct string_list list = STRING_LIST_INIT_DUP;
-	struct remote *remote;
+	struct remote *remote = NULL;
 	int result = 0;
 	struct argv_array argv_gc_auto = ARGV_ARRAY_INIT;
 
@@ -1367,17 +1367,14 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		else if (argc > 1)
 			die(_("fetch --all does not make sense with refspecs"));
 		(void) for_each_remote(get_one_remote_for_fetch, &list);
-		result = fetch_multiple(&list);
 	} else if (argc == 0) {
 		/* No arguments -- use default remote */
 		remote = remote_get(NULL);
-		result = fetch_one(remote, argc, argv);
 	} else if (multiple) {
 		/* All arguments are assumed to be remotes or groups */
 		for (i = 0; i < argc; i++)
 			if (!add_remote_or_group(argv[i], &list))
 				die(_("No such remote or remote group: %s"), argv[i]);
-		result = fetch_multiple(&list);
 	} else {
 		/* Single remote or group */
 		(void) add_remote_or_group(argv[0], &list);
@@ -1385,14 +1382,19 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			/* More than one remote */
 			if (argc > 1)
 				die(_("Fetching a group and specifying refspecs does not make sense"));
-			result = fetch_multiple(&list);
 		} else {
 			/* Zero or one remotes */
 			remote = remote_get(argv[0]);
-			result = fetch_one(remote, argc-1, argv+1);
+			argc--;
+			argv++;
 		}
 	}
 
+	if (remote)
+		result = fetch_one(remote, argc, argv);
+	else
+		result = fetch_multiple(&list);
+
 	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
 		struct argv_array options = ARGV_ARRAY_INIT;
 
-- 
2.9.3

