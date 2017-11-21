Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C257A2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 21:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbdKUVPn (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 16:15:43 -0500
Received: from siwi.pair.com ([209.68.5.199]:37533 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751339AbdKUVPm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 16:15:42 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8AF2B844F1;
        Tue, 21 Nov 2017 16:15:41 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1B88B844D5;
        Tue, 21 Nov 2017 16:15:41 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v5 01/14] upload-pack: add object filtering for partial clone
Date:   Tue, 21 Nov 2017 21:15:15 +0000
Message-Id: <20171121211528.21891-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171121211528.21891-1-git@jeffhostetler.com>
References: <20171121211528.21891-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach upload-pack to negotiate object filtering over the protocol and
to send filter parameters to pack-objects.  This is intended for partial
clone and fetch.

The idea to make upload-pack configurable using uploadpack.allowFilter
comes from Jonathan Tan's work in [1].

[1] https://public-inbox.org/git/f211093280b422c32cc1b7034130072f35c5ed51.1506714999.git.jonathantanmy@google.com/

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/config.txt                          |  4 ++++
 Documentation/technical/pack-protocol.txt         |  8 ++++++++
 Documentation/technical/protocol-capabilities.txt |  8 ++++++++
 list-objects-filter-options.c                     |  1 +
 upload-pack.c                                     | 22 +++++++++++++++++++++-
 5 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1ac0ae6..e528210 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3268,6 +3268,10 @@ uploadpack.packObjectsHook::
 	was run. I.e., `upload-pack` will feed input intended for
 	`pack-objects` to the hook, and expects a completed packfile on
 	stdout.
+
+uploadpack.allowFilter::
+	If this option is set, `upload-pack` will advertise partial
+	clone and partial fetch object filtering.
 +
 Note that this configuration variable is ignored if it is seen in the
 repository-level config (this is a safety measure against fetching from
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index ed1eae8..a43a113 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -212,6 +212,7 @@ out of what the server said it could do with the first 'want' line.
   upload-request    =  want-list
 		       *shallow-line
 		       *1depth-request
+		       [filter-request]
 		       flush-pkt
 
   want-list         =  first-want
@@ -227,6 +228,8 @@ out of what the server said it could do with the first 'want' line.
   additional-want   =  PKT-LINE("want" SP obj-id)
 
   depth             =  1*DIGIT
+
+  filter-request    =  PKT-LINE("filter" SP filter-spec)
 ----
 
 Clients MUST send all the obj-ids it wants from the reference
@@ -249,6 +252,11 @@ complete those commits. Commits whose parents are not received as a
 result are defined as shallow and marked as such in the server. This
 information is sent back to the client in the next step.
 
+The client can optionally request that pack-objects omit various
+objects from the packfile using one of several filtering techniques.
+These are intended for use with partial clone and partial fetch
+operations.  See `rev-list` for possible "filter-spec" values.
+
 Once all the 'want's and 'shallow's (and optional 'deepen') are
 transferred, clients MUST send a flush-pkt, to tell the server side
 that it is done sending the list.
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 26dcc6f..332d209 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -309,3 +309,11 @@ to accept a signed push certificate, and asks the <nonce> to be
 included in the push certificate.  A send-pack client MUST NOT
 send a push-cert packet unless the receive-pack server advertises
 this capability.
+
+filter
+------
+
+If the upload-pack server advertises the 'filter' capability,
+fetch-pack may send "filter" commands to request a partial clone
+or partial fetch and request that the server omit various objects
+from the packfile.
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 9b28322..c6bfc11 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -79,3 +79,4 @@ int opt_parse_list_objects_filter(const struct option *opt,
 
 	return parse_list_objects_filter(filter_options, arg);
 }
+
diff --git a/upload-pack.c b/upload-pack.c
index e25f725..eb07429 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -10,6 +10,8 @@
 #include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "list-objects-filter.h"
+#include "list-objects-filter-options.h"
 #include "run-command.h"
 #include "connect.h"
 #include "sigchain.h"
@@ -64,6 +66,10 @@ static int advertise_refs;
 static int stateless_rpc;
 static const char *pack_objects_hook;
 
+static int filter_capability_requested;
+static int filter_advertise;
+static struct list_objects_filter_options filter_options;
+
 static void reset_timeout(void)
 {
 	alarm(timeout);
@@ -131,6 +137,9 @@ static void create_pack_file(void)
 		argv_array_push(&pack_objects.args, "--delta-base-offset");
 	if (use_include_tag)
 		argv_array_push(&pack_objects.args, "--include-tag");
+	if (filter_options.choice)
+		argv_array_pushf(&pack_objects.args, "--%s=%s", CL_ARG__FILTER,
+				 filter_options.filter_spec);
 
 	pack_objects.in = -1;
 	pack_objects.out = -1;
@@ -794,6 +803,12 @@ static void receive_needs(void)
 			deepen_rev_list = 1;
 			continue;
 		}
+		if (skip_prefix(line, "filter ", &arg)) {
+			if (!filter_capability_requested)
+				die("git upload-pack: filtering capability not negotiated");
+			parse_list_objects_filter(&filter_options, arg);
+			continue;
+		}
 		if (!skip_prefix(line, "want ", &arg) ||
 		    get_oid_hex(arg, &oid_buf))
 			die("git upload-pack: protocol error, "
@@ -821,6 +836,8 @@ static void receive_needs(void)
 			no_progress = 1;
 		if (parse_feature_request(features, "include-tag"))
 			use_include_tag = 1;
+		if (parse_feature_request(features, "filter"))
+			filter_capability_requested = 1;
 
 		o = parse_object(&oid_buf);
 		if (!o) {
@@ -940,7 +957,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 		struct strbuf symref_info = STRBUF_INIT;
 
 		format_symref_info(&symref_info, cb_data);
-		packet_write_fmt(1, "%s %s%c%s%s%s%s%s agent=%s\n",
+		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s agent=%s\n",
 			     oid_to_hex(oid), refname_nons,
 			     0, capabilities,
 			     (allow_unadvertised_object_request & ALLOW_TIP_SHA1) ?
@@ -949,6 +966,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 				     " allow-reachable-sha1-in-want" : "",
 			     stateless_rpc ? " no-done" : "",
 			     symref_info.buf,
+			     filter_advertise ? " filter" : "",
 			     git_user_agent_sanitized());
 		strbuf_release(&symref_info);
 	} else {
@@ -1027,6 +1045,8 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 	} else if (current_config_scope() != CONFIG_SCOPE_REPO) {
 		if (!strcmp("uploadpack.packobjectshook", var))
 			return git_config_string(&pack_objects_hook, var, value);
+	} else if (!strcmp("uploadpack.allowfilter", var)) {
+		filter_advertise = git_config_bool(var, value);
 	}
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
-- 
2.9.3

