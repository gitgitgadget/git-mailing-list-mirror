Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF83720C45
	for <e@80x24.org>; Tue,  5 Dec 2017 16:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbdLEQum (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 11:50:42 -0500
Received: from siwi.pair.com ([209.68.5.199]:43570 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752582AbdLEQuf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 11:50:35 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A4C36844E9;
        Tue,  5 Dec 2017 11:50:34 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1A3CE844E4;
        Tue,  5 Dec 2017 11:50:34 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        christian.couder@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6 3/3] rev-list: support --no-filter argument
Date:   Tue,  5 Dec 2017 16:50:14 +0000
Message-Id: <20171205165014.64488-4-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171205165014.64488-1-git@jeffhostetler.com>
References: <20171205165014.64488-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach rev-list to support --no-filter to override a
previous --filter=<filter_spec> argument.  This is
to be consistent with commands that use OPT_PARSE
macros.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/rev-list-options.txt | 15 ++++++++++-----
 builtin/rev-list.c                 |  4 ++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 11bb87f..8d8b7f4 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -715,16 +715,21 @@ ifdef::git-rev-list[]
 The form '--filter=blob:none' omits all blobs.
 +
 The form '--filter=blob:limit=<n>[kmg]' omits blobs larger than n bytes
-or units.  The value may be zero.
+or units.  n may be zero.  The suffixes k, m, and g can be used to name
+units in KiB, MiB, or GiB.  For example, 'blob:limit=1k' is the same
+as 'blob:limit=1024'.
 +
-The form '--filter=sparse:oid=<oid-ish>' uses a sparse-checkout
-specification contained in the object (or the object that the expression
-evaluates to) to omit blobs that would not be not required for a
-sparse checkout on the requested refs.
+The form '--filter=sparse:oid=<blob-ish>' uses a sparse-checkout
+specification contained in the blob (or blob-expression) '<blob-ish>'
+to omit blobs that would not be not required for a sparse checkout on
+the requested refs.
 +
 The form '--filter=sparse:path=<path>' similarly uses a sparse-checkout
 specification contained in <path>.
 
+--no-filter::
+	Turn off any previous `--filter=` argument.
+
 --filter-print-omitted::
 	Only useful with `--filter=`; prints a list of the objects omitted
 	by the filter.	Object IDs are prefixed with a ``~'' character.
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 4700473..547a3e0 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -403,6 +403,10 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 				    filter_options.filter_spec);
 			continue;
 		}
+		if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
+			list_objects_filter_release(&filter_options);
+			continue;
+		}
 		if (!strcmp(arg, "--filter-print-omitted")) {
 			arg_print_omitted = 1;
 			continue;
-- 
2.9.3

