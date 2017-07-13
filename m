Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBD56202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 17:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbdGMRf6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 13:35:58 -0400
Received: from siwi.pair.com ([209.68.5.199]:11111 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752569AbdGMRfm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 13:35:42 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 16125844F7;
        Thu, 13 Jul 2017 13:35:42 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 67008844E3;
        Thu, 13 Jul 2017 13:35:41 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, ethomson@edwardthomson.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        jeffhost@microsoft.com
Subject: [PATCH v2 15/19] fetch-pack: add object filtering support
Date:   Thu, 13 Jul 2017 17:34:55 +0000
Message-Id: <20170713173459.3559-16-git@jeffhostetler.com>
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
 builtin/fetch-pack.c |  3 +++
 fetch-pack.c         | 28 ++++++++++++++++++++++++++++
 fetch-pack.h         |  2 ++
 transport.c          | 27 +++++++++++++++++++++++++++
 transport.h          |  8 ++++++++
 5 files changed, 68 insertions(+)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 366b9d1..72f9063 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -143,6 +143,9 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			args.update_shallow = 1;
 			continue;
 		}
+		if (object_filter_hand_parse_arg(&args.filter_options, arg, 0, 0)) {
+			continue;
+		}
 		usage(fetch_pack_usage);
 	}
 	if (deepen_not.nr)
diff --git a/fetch-pack.c b/fetch-pack.c
index afb8b05..642077d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -374,6 +374,8 @@ static int find_common(struct fetch_pack_args *args,
 			if (prefer_ofs_delta)   strbuf_addstr(&c, " ofs-delta");
 			if (deepen_since_ok)    strbuf_addstr(&c, " deepen-since");
 			if (deepen_not_ok)      strbuf_addstr(&c, " deepen-not");
+			if (object_filter_enabled(&args->filter_options))
+				strbuf_addstr(&c, (" " PROTOCOL_CAPABILITY_FILTER_OBJECTS));
 			if (agent_supported)    strbuf_addf(&c, " agent=%s",
 							    git_user_agent_sanitized());
 			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
@@ -404,6 +406,18 @@ static int find_common(struct fetch_pack_args *args,
 			packet_buf_write(&req_buf, "deepen-not %s", s->string);
 		}
 	}
+
+	if (args->filter_options.omit_all_blobs)
+		packet_buf_write(&req_buf, PROTOCOL_REQUEST_FILTER_OMIT_ALL_BLOBS);
+	else if (args->filter_options.omit_large_blobs)
+		packet_buf_write(&req_buf,
+				 PROTOCOL_REQUEST_FILTER_OMIT_ALL_BLOBS " %ld",
+				 args->filter_options.large_byte_limit);
+	else if (args->filter_options.use_sparse)
+		packet_buf_write(&req_buf,
+				 PROTOCOL_REQUEST_FILTER_USE_SPARSE " %s",
+				 args->filter_options.sparse_value);
+
 	packet_buf_flush(&req_buf);
 	state_len = req_buf.len;
 
@@ -811,6 +825,15 @@ static int get_pack(struct fetch_pack_args *args,
 					"--keep=fetch-pack %"PRIuMAX " on %s",
 					(uintmax_t)getpid(), hostname);
 		}
+
+		/*
+		 * Relax consistency check to allow missing blobs (presumably
+		 * because they are exactly the set that we requested be
+		 * omitted.
+		 */
+		if (object_filter_enabled(&args->filter_options))
+			argv_array_push(&cmd.args, ("--" CL_ARG_FILTER_RELAX));
+
 		if (args->check_self_contained_and_connected)
 			argv_array_push(&cmd.args, "--check-self-contained-and-connected");
 	}
@@ -924,6 +947,11 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	else
 		prefer_ofs_delta = 0;
 
+	if (server_supports(PROTOCOL_CAPABILITY_FILTER_OBJECTS))
+		print_verbose(args, _("Server supports "PROTOCOL_CAPABILITY_FILTER_OBJECTS));
+	else if (object_filter_enabled(&args->filter_options))
+		die(_("Server does not support "PROTOCOL_CAPABILITY_FILTER_OBJECTS));
+
 	if ((agent_feature = server_feature_value("agent", &agent_len))) {
 		agent_supported = 1;
 		if (agent_len)
diff --git a/fetch-pack.h b/fetch-pack.h
index b6aeb43..5e6bf3b 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -3,6 +3,7 @@
 
 #include "string-list.h"
 #include "run-command.h"
+#include "object-filter.h"
 
 struct oid_array;
 
@@ -12,6 +13,7 @@ struct fetch_pack_args {
 	int depth;
 	const char *deepen_since;
 	const struct string_list *deepen_not;
+	struct object_filter_options filter_options;
 	unsigned deepen_relative:1;
 	unsigned quiet:1;
 	unsigned keep_pack:1;
diff --git a/transport.c b/transport.c
index 4d33138..7abf0b6 100644
--- a/transport.c
+++ b/transport.c
@@ -160,6 +160,32 @@ static int set_git_option(struct git_transport_options *opts,
 	} else if (!strcmp(name, TRANS_OPT_DEEPEN_RELATIVE)) {
 		opts->deepen_relative = !!value;
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_FILTER_OMIT_ALL_BLOBS)) {
+		opts->filter_options.omit_all_blobs = !!value;
+		return 0;
+	} else if (!strcmp(name, TRANS_OPT_FILTER_OMIT_LARGE_BLOBS)) {
+		opts->filter_options.omit_large_blobs = 1;
+		opts->filter_options.large_byte_limit_string = value;
+		if (!value)
+			opts->filter_options.large_byte_limit = 0;
+		else if (!git_parse_ulong(value,
+					  &opts->filter_options.large_byte_limit))
+			die(_("transport: invalid filter value '%s'"), value);
+		return 0;
+	} else if (!strcmp(name, TRANS_OPT_FILTER_USE_SPARSE)) {
+		opts->filter_options.use_sparse = 1;
+		opts->filter_options.sparse_value = value;
+		/*
+		 * We're constrained by the API for this set_ operation and
+		 * only take a single value.  We don't want to do the get_sha1*()
+		 * lookup (possibly for the second time), because the caller
+		 * should already know and normalized the hex OID string
+		 * (assuming that it used the normal parsing methods).  So we
+		 * assume that the above string value is sufficient here and
+		 * can just NULL the binary OID field.
+		 */
+		oidcpy(&opts->filter_options.sparse_oid, &null_oid);
+		return 0;
 	}
 	return 1;
 }
@@ -228,6 +254,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 		data->options.check_self_contained_and_connected;
 	args.cloning = transport->cloning;
 	args.update_shallow = data->options.update_shallow;
+	args.filter_options = data->options.filter_options;
 
 	if (!data->got_remote_heads) {
 		connect_setup(transport, 0);
diff --git a/transport.h b/transport.h
index bc55715..490f827 100644
--- a/transport.h
+++ b/transport.h
@@ -4,6 +4,8 @@
 #include "cache.h"
 #include "run-command.h"
 #include "remote.h"
+#include "fetch-pack.h"
+#include "object-filter.h"
 
 struct string_list;
 
@@ -21,6 +23,7 @@ struct git_transport_options {
 	const char *uploadpack;
 	const char *receivepack;
 	struct push_cas_option *cas;
+	struct object_filter_options filter_options;
 };
 
 enum transport_family {
@@ -210,6 +213,11 @@ void transport_check_allowed(const char *type);
 /* Send push certificates */
 #define TRANS_OPT_PUSH_CERT "pushcert"
 
+/* See Documentation/technical/pack-protocol.txt */
+#define TRANS_OPT_FILTER_OMIT_ALL_BLOBS   "filter-omit-all-blobs"
+#define TRANS_OPT_FILTER_OMIT_LARGE_BLOBS "filter-omit-large-blobs"
+#define TRANS_OPT_FILTER_USE_SPARSE       "filter-use-sparse"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
-- 
2.9.3

