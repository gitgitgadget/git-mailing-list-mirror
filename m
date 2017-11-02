Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8F5E20281
	for <e@80x24.org>; Thu,  2 Nov 2017 20:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934507AbdKBUbn (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 16:31:43 -0400
Received: from siwi.pair.com ([209.68.5.199]:53388 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934496AbdKBUbm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 16:31:42 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 1EAD9845AE;
        Thu,  2 Nov 2017 16:31:41 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1FFE7845AC;
        Thu,  2 Nov 2017 16:31:39 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 02/14] clone, fetch-pack, index-pack, transport: partial clone
Date:   Thu,  2 Nov 2017 20:31:17 +0000
Message-Id: <20171102203129.59417-3-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171102203129.59417-1-git@jeffhostetler.com>
References: <20171102203129.59417-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/clone.c      |  9 +++++++++
 builtin/fetch-pack.c |  4 ++++
 builtin/index-pack.c | 10 ++++++++++
 fetch-pack.c         | 13 +++++++++++++
 fetch-pack.h         |  2 ++
 transport-helper.c   |  5 +++++
 transport.c          |  4 ++++
 transport.h          |  5 +++++
 8 files changed, 52 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index dbddd98..fceb9e7 100644
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
 
@@ -1073,6 +1076,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			warning(_("--shallow-since is ignored in local clones; use file:// instead."));
 		if (option_not.nr)
 			warning(_("--shallow-exclude is ignored in local clones; use file:// instead."));
+		if (filter_options.choice)
+			warning(_("--filter is ignored in local clones; use file:// instead."));
 		if (!access(mkpath("%s/shallow", path), F_OK)) {
 			if (option_local > 0)
 				warning(_("source repository is shallow, ignoring --local"));
@@ -1104,6 +1109,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK,
 				     option_upload_pack);
 
+	if (filter_options.choice)
+		transport_set_option(transport, TRANS_OPT_LIST_OBJECTS_FILTER,
+				     filter_options.raw_value);
+
 	if (transport->smart_options && !deepen)
 		transport->smart_options->check_self_contained_and_connected = 1;
 
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 9a7ebf6..d0fdaa8 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -153,6 +153,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			args.no_haves = 1;
 			continue;
 		}
+		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
+			parse_list_objects_filter(&args.filter_options, arg);
+			continue;
+		}
 		usage(fetch_pack_usage);
 	}
 	if (deepen_not.nr)
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a0a35e6..31cd5ba 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -222,6 +222,16 @@ static unsigned check_object(struct object *obj)
 	if (!(obj->flags & FLAG_CHECKED)) {
 		unsigned long size;
 		int type = sha1_object_info(obj->oid.hash, &size);
+
+		if (type <= 0) {
+			/*
+			 * TODO Use the promisor code to conditionally
+			 * try to fetch this object -or- assume it is ok.
+			 */
+			obj->flags |= FLAG_CHECKED;
+			return 0;
+		}
+
 		if (type <= 0)
 			die(_("did not receive expected object %s"),
 			      oid_to_hex(&obj->oid));
diff --git a/fetch-pack.c b/fetch-pack.c
index 4640b4e..895e8f9 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -29,6 +29,7 @@ static int deepen_not_ok;
 static int fetch_fsck_objects = -1;
 static int transfer_fsck_objects = -1;
 static int agent_supported;
+static int server_supports_filtering;
 static struct lock_file shallow_lock;
 static const char *alternate_shallow_file;
 
@@ -379,6 +380,8 @@ static int find_common(struct fetch_pack_args *args,
 			if (deepen_not_ok)      strbuf_addstr(&c, " deepen-not");
 			if (agent_supported)    strbuf_addf(&c, " agent=%s",
 							    git_user_agent_sanitized());
+			if (args->filter_options.choice)
+				strbuf_addstr(&c, " filter");
 			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
 			strbuf_release(&c);
 		} else
@@ -407,6 +410,9 @@ static int find_common(struct fetch_pack_args *args,
 			packet_buf_write(&req_buf, "deepen-not %s", s->string);
 		}
 	}
+	if (server_supports_filtering && args->filter_options.choice)
+		packet_buf_write(&req_buf, "filter %s",
+				 args->filter_options.raw_value);
 	packet_buf_flush(&req_buf);
 	state_len = req_buf.len;
 
@@ -967,6 +973,13 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	else
 		prefer_ofs_delta = 0;
 
+	if (server_supports("filter")) {
+		server_supports_filtering = 1;
+		print_verbose(args, _("Server supports filter"));
+	} else if (args->filter_options.choice) {
+		warning("filtering not recognized by server, ignoring");
+	}
+
 	if ((agent_feature = server_feature_value("agent", &agent_len))) {
 		agent_supported = 1;
 		if (agent_len)
diff --git a/fetch-pack.h b/fetch-pack.h
index 84904c3..64661b6 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -3,6 +3,7 @@
 
 #include "string-list.h"
 #include "run-command.h"
+#include "list-objects-filter-options.h"
 
 struct oid_array;
 
@@ -12,6 +13,7 @@ struct fetch_pack_args {
 	int depth;
 	const char *deepen_since;
 	const struct string_list *deepen_not;
+	struct list_objects_filter_options filter_options;
 	unsigned deepen_relative:1;
 	unsigned quiet:1;
 	unsigned keep_pack:1;
diff --git a/transport-helper.c b/transport-helper.c
index c948d52..96823c7 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -671,6 +671,11 @@ static int fetch(struct transport *transport,
 	if (data->transport_options.update_shallow)
 		set_helper_option(transport, "update-shallow", "true");
 
+	if (data->transport_options.filter_options.choice)
+		set_helper_option(
+			transport, "filter",
+			data->transport_options.filter_options.raw_value);
+
 	if (data->fetch)
 		return fetch_with_fetch(transport, nr_heads, to_fetch);
 
diff --git a/transport.c b/transport.c
index 8211f82..d50c73b 100644
--- a/transport.c
+++ b/transport.c
@@ -166,6 +166,9 @@ static int set_git_option(struct git_transport_options *opts,
 	} else if (!strcmp(name, TRANS_OPT_NO_HAVES)) {
 		opts->no_haves = !!value;
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_LIST_OBJECTS_FILTER)) {
+		parse_list_objects_filter(&opts->filter_options, value);
+		return 0;
 	}
 	return 1;
 }
@@ -236,6 +239,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.update_shallow = data->options.update_shallow;
 	args.from_promisor = data->options.from_promisor;
 	args.no_haves = data->options.no_haves;
+	args.filter_options = data->options.filter_options;
 
 	if (!data->got_remote_heads) {
 		connect_setup(transport, 0);
diff --git a/transport.h b/transport.h
index 67428f6..f64aa3a 100644
--- a/transport.h
+++ b/transport.h
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "run-command.h"
 #include "remote.h"
+#include "list-objects-filter-options.h"
 
 struct string_list;
 
@@ -23,6 +24,7 @@ struct git_transport_options {
 	const char *uploadpack;
 	const char *receivepack;
 	struct push_cas_option *cas;
+	struct list_objects_filter_options filter_options;
 };
 
 enum transport_family {
@@ -218,6 +220,9 @@ void transport_check_allowed(const char *type);
 /* Do not send "have" lines */
 #define TRANS_OPT_NO_HAVES "no-haves"
 
+/* Filter objects for partial clone and fetch */
+#define TRANS_OPT_LIST_OBJECTS_FILTER "filter"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
-- 
2.9.3

