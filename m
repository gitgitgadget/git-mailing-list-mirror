Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C40C5202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 17:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbdGMRfp (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 13:35:45 -0400
Received: from siwi.pair.com ([209.68.5.199]:11127 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752614AbdGMRfo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 13:35:44 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id ADE9F84516;
        Thu, 13 Jul 2017 13:35:43 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0C184844E3;
        Thu, 13 Jul 2017 13:35:42 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, ethomson@edwardthomson.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        jeffhost@microsoft.com
Subject: [PATCH v2 17/19] clone: add filter arguments
Date:   Thu, 13 Jul 2017 17:34:57 +0000
Message-Id: <20170713173459.3559-18-git@jeffhostetler.com>
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
 builtin/clone.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index a6ae7d6..1408396 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -24,6 +24,7 @@
 #include "remote.h"
 #include "run-command.h"
 #include "connected.h"
+#include "object-filter.h"
 
 /*
  * Overall FIXMEs:
@@ -57,6 +58,7 @@ static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
 static int option_dissociate;
 static int max_jobs = -1;
 static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
+static struct object_filter_options filter_options;
 
 static int recurse_submodules_cb(const struct option *opt,
 				 const char *arg, int unset)
@@ -130,6 +132,14 @@ static struct option builtin_clone_options[] = {
 			TRANSPORT_FAMILY_IPV4),
 	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
 			TRANSPORT_FAMILY_IPV6),
+
+	OPT_PARSE_FILTER_OMIT_ALL_BLOBS(&filter_options),
+	OPT_PARSE_FILTER_OMIT_LARGE_BLOBS(&filter_options),
+	OPT_PARSE_FILTER_USE_SPARSE(&filter_options),
+
+	/* OPT_PARSE_FILTER_PRINT_MANIFEST(&filter_options), */
+	/* OPT_PARSE_FILTER_RELAX(&filter_options), */
+
 	OPT_END()
 };
 
@@ -643,6 +653,13 @@ static void update_remote_refs(const struct ref *refs,
 	if (check_connectivity) {
 		struct check_connected_options opt = CHECK_CONNECTED_INIT;
 
+		/*
+		 * Relax consistency check to allow missing blobs (presumably
+		 * because they are exactly the set that we requested be
+		 * omitted.
+		 */
+		opt.filter_relax = object_filter_enabled(&filter_options);
+
 		opt.transport = transport;
 		opt.progress = transport->progress;
 
@@ -1059,6 +1076,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			warning(_("--shallow-since is ignored in local clones; use file:// instead."));
 		if (option_not.nr)
 			warning(_("--shallow-exclude is ignored in local clones; use file:// instead."));
+		if (object_filter_enabled(&filter_options))
+			warning(_("--filter-* options are ignored in local clones; use file:// instead."));
 		if (!access(mkpath("%s/shallow", path), F_OK)) {
 			if (option_local > 0)
 				warning(_("source repository is shallow, ignoring --local"));
@@ -1090,6 +1109,15 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK,
 				     option_upload_pack);
 
+	if (filter_options.omit_all_blobs)
+		transport_set_option(transport, TRANS_OPT_FILTER_OMIT_ALL_BLOBS, "1");
+	if (filter_options.omit_large_blobs)
+		transport_set_option(transport, TRANS_OPT_FILTER_OMIT_LARGE_BLOBS,
+				     filter_options.large_byte_limit_string);
+	if (filter_options.use_sparse)
+		transport_set_option(transport, TRANS_OPT_FILTER_USE_SPARSE,
+				     filter_options.sparse_value);
+
 	if (transport->smart_options && !deepen)
 		transport->smart_options->check_self_contained_and_connected = 1;
 
-- 
2.9.3

