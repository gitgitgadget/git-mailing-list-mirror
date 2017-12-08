Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95A7820C31
	for <e@80x24.org>; Fri,  8 Dec 2017 15:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754587AbdLHP7X (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 10:59:23 -0500
Received: from siwi.pair.com ([209.68.5.199]:55838 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754578AbdLHP7O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 10:59:14 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8C1F2844F3;
        Fri,  8 Dec 2017 10:59:13 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1295A844DE;
        Fri,  8 Dec 2017 10:59:13 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v7 11/16] clone: partial clone
Date:   Fri,  8 Dec 2017 15:58:46 +0000
Message-Id: <20171208155851.855-12-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171208155851.855-1-git@jeffhostetler.com>
References: <20171208155851.855-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/clone.c  | 22 ++++++++++++++++++++--
 t/t5601-clone.sh | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index dbddd98..f519bd4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -26,6 +26,7 @@
 #include "run-command.h"
 #include "connected.h"
 #include "packfile.h"
+#include "list-objects-filter-options.h"
 
 /*
  * Overall FIXMEs:
@@ -60,6 +61,7 @@ static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
 static int option_dissociate;
 static int max_jobs = -1;
 static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
+static struct list_objects_filter_options filter_options;
 
 static int recurse_submodules_cb(const struct option *opt,
 				 const char *arg, int unset)
@@ -135,6 +137,7 @@ static struct option builtin_clone_options[] = {
 			TRANSPORT_FAMILY_IPV4),
 	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
 			TRANSPORT_FAMILY_IPV6),
+	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 	OPT_END()
 };
 
@@ -886,6 +889,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct refspec *refspec;
 	const char *fetch_pattern;
 
+	fetch_if_missing = 0;
+
 	packet_trace_identity("clone");
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
@@ -1073,6 +1078,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			warning(_("--shallow-since is ignored in local clones; use file:// instead."));
 		if (option_not.nr)
 			warning(_("--shallow-exclude is ignored in local clones; use file:// instead."));
+		if (filter_options.choice)
+			warning(_("--filter is ignored in local clones; use file:// instead."));
 		if (!access(mkpath("%s/shallow", path), F_OK)) {
 			if (option_local > 0)
 				warning(_("source repository is shallow, ignoring --local"));
@@ -1104,7 +1111,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK,
 				     option_upload_pack);
 
-	if (transport->smart_options && !deepen)
+	if (filter_options.choice) {
+		transport_set_option(transport, TRANS_OPT_LIST_OBJECTS_FILTER,
+				     filter_options.filter_spec);
+		transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
+	}
+
+	if (transport->smart_options && !deepen && !filter_options.choice)
 		transport->smart_options->check_self_contained_and_connected = 1;
 
 	refs = transport_get_remote_refs(transport);
@@ -1164,13 +1177,17 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	write_refspec_config(src_ref_prefix, our_head_points_at,
 			remote_head_points_at, &branch_top);
 
+	if (filter_options.choice)
+		partial_clone_register("origin", &filter_options);
+
 	if (is_local)
 		clone_local(path, git_dir);
 	else if (refs && complete_refs_before_fetch)
 		transport_fetch_refs(transport, mapped_refs);
 
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
-			   branch_top.buf, reflog_msg.buf, transport, !is_local);
+			   branch_top.buf, reflog_msg.buf, transport,
+			   !is_local && !filter_options.choice);
 
 	update_head(our_head_points_at, remote_head, reflog_msg.buf);
 
@@ -1191,6 +1208,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	junk_mode = JUNK_LEAVE_REPO;
+	fetch_if_missing = 1;
 	err = checkout(submodule_progress);
 
 	strbuf_release(&reflog_msg);
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 9c56f77..6d37c6d 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -571,4 +571,53 @@ test_expect_success 'GIT_TRACE_PACKFILE produces a usable pack' '
 	git -C replay.git index-pack -v --stdin <tmp.pack
 '
 
+partial_clone () {
+	       SERVER="$1" &&
+	       URL="$2" &&
+
+	rm -rf "$SERVER" client &&
+	test_create_repo "$SERVER" &&
+	test_commit -C "$SERVER" one &&
+	HASH1=$(git hash-object "$SERVER/one.t") &&
+	git -C "$SERVER" revert HEAD &&
+	test_commit -C "$SERVER" two &&
+	HASH2=$(git hash-object "$SERVER/two.t") &&
+	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
+	test_config -C "$SERVER" uploadpack.allowanysha1inwant 1 &&
+
+	git clone --filter=blob:limit=0 "$URL" client &&
+
+	git -C client fsck &&
+
+	# Ensure that unneeded blobs are not inadvertently fetched.
+	test_config -C client extensions.partialclone "not a remote" &&
+	test_must_fail git -C client cat-file -e "$HASH1" &&
+
+	# But this blob was fetched, because clone performs an initial checkout
+	git -C client cat-file -e "$HASH2"
+}
+
+test_expect_success 'partial clone' '
+	partial_clone server "file://$(pwd)/server"
+'
+
+test_expect_success 'partial clone: warn if server does not support object filtering' '
+	rm -rf server client &&
+	test_create_repo server &&
+	test_commit -C server one &&
+
+	git clone --filter=blob:limit=0 "file://$(pwd)/server" client 2> err &&
+
+	test_i18ngrep "filtering not recognized by server" err
+'
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'partial clone using HTTP' '
+	partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/smart/server"
+'
+
+stop_httpd
+
 test_done
-- 
2.9.3

