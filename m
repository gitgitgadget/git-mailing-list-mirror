Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB0C6202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 17:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754065AbdCHRqY (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 12:46:24 -0500
Received: from siwi.pair.com ([209.68.5.199]:64316 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754075AbdCHRqD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 12:46:03 -0500
Received: from jeffhostetler.2jll4ugiwlvuzhh55dqabi0nia.bx.internal.cloudapp.net (unknown [40.76.14.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id F0DDA8464E;
        Wed,  8 Mar 2017 12:38:46 -0500 (EST)
From:   Jeff Hostetler <jeffhost@microsoft.com>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, peff@peff.net, gitster@pobox.com,
        markbt@efaref.net, benpeart@microsoft.com,
        jonathantanmy@google.com, Jeff Hostetler <git@jeffhostetler.com>
Subject: [PATCH 09/10] clone: add partial-by-size and partial-special arguments
Date:   Wed,  8 Mar 2017 17:38:04 +0000
Message-Id: <1488994685-37403-10-git-send-email-jeffhost@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
References: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <git@jeffhostetler.com>

Teach clone to accept --partial-by-size=n and --partial-special
arguments to request that the server omit certain blobs from
the generated packfile.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/clone.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 3f63edb..e5a5904 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -56,6 +56,8 @@ static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
 static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
 static int option_dissociate;
 static int max_jobs = -1;
+static const char *partial_by_size;
+static int partial_special;
 
 static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
@@ -112,6 +114,11 @@ static struct option builtin_clone_options[] = {
 			TRANSPORT_FAMILY_IPV4),
 	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
 			TRANSPORT_FAMILY_IPV6),
+	OPT_STRING(0, "partial-by-size", &partial_by_size,
+			   N_("size"),
+			   N_("only include blobs smaller than this")),
+	OPT_BOOL(0, "partial-special", &partial_special,
+			 N_("only include blobs for git special files")),
 	OPT_END()
 };
 
@@ -625,6 +632,9 @@ static void update_remote_refs(const struct ref *refs,
 	if (check_connectivity) {
 		struct check_connected_options opt = CHECK_CONNECTED_INIT;
 
+		if (partial_by_size || partial_special)
+			opt.allow_partial = 1;
+
 		opt.transport = transport;
 		opt.progress = transport->progress;
 
@@ -1021,6 +1031,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			warning(_("--shallow-since is ignored in local clones; use file:// instead."));
 		if (option_not.nr)
 			warning(_("--shallow-exclude is ignored in local clones; use file:// instead."));
+		if (partial_by_size)
+			warning(_("--partial-by-size is ignored in local clones; use file:// instead."));
+		if (partial_special)
+			warning(_("--partial-special is ignored in local clones; use file:// instead."));
 		if (!access(mkpath("%s/shallow", path), F_OK)) {
 			if (option_local > 0)
 				warning(_("source repository is shallow, ignoring --local"));
@@ -1052,6 +1066,18 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK,
 				     option_upload_pack);
 
+	if (partial_by_size) {
+		transport_set_option(transport, TRANS_OPT_PARTIAL_BY_SIZE,
+				     partial_by_size);
+		if (transport->smart_options)
+			transport->smart_options->partial_by_size = partial_by_size;
+	}
+	if (partial_special) {
+		transport_set_option(transport, TRANS_OPT_PARTIAL_SPECIAL, "yes");
+		if (transport->smart_options)
+			transport->smart_options->partial_special = 1;
+	}
+
 	if (transport->smart_options && !deepen)
 		transport->smart_options->check_self_contained_and_connected = 1;
 
-- 
2.7.4

