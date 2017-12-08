Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D0CB20C31
	for <e@80x24.org>; Fri,  8 Dec 2017 15:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754395AbdLHP7v (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 10:59:51 -0500
Received: from siwi.pair.com ([209.68.5.199]:55821 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754492AbdLHP7K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 10:59:10 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B8CFC844F3;
        Fri,  8 Dec 2017 10:59:09 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 418A3844DE;
        Fri,  8 Dec 2017 10:59:09 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v7 05/16] fetch-pack, index-pack, transport: partial clone
Date:   Fri,  8 Dec 2017 15:58:40 +0000
Message-Id: <20171208155851.855-6-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171208155851.855-1-git@jeffhostetler.com>
References: <20171208155851.855-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fetch-pack.c |  4 ++++
 fetch-pack.c         | 13 +++++++++++++
 fetch-pack.h         |  2 ++
 transport-helper.c   |  5 +++++
 transport.c          |  4 ++++
 transport.h          |  5 +++++
 6 files changed, 33 insertions(+)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 15eeed7..7957807 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -153,6 +153,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			args.no_dependents = 1;
 			continue;
 		}
+		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
+			parse_list_objects_filter(&args.filter_options, arg);
+			continue;
+		}
 		usage(fetch_pack_usage);
 	}
 	if (deepen_not.nr)
diff --git a/fetch-pack.c b/fetch-pack.c
index 0798e0b..3c5f064 100644
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
+				 args->filter_options.filter_spec);
 	packet_buf_flush(&req_buf);
 	state_len = req_buf.len;
 
@@ -969,6 +975,13 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
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
index aeac152..3e224a1 100644
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
index c948d52..0650ca0 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -671,6 +671,11 @@ static int fetch(struct transport *transport,
 	if (data->transport_options.update_shallow)
 		set_helper_option(transport, "update-shallow", "true");
 
+	if (data->transport_options.filter_options.choice)
+		set_helper_option(
+			transport, "filter",
+			data->transport_options.filter_options.filter_spec);
+
 	if (data->fetch)
 		return fetch_with_fetch(transport, nr_heads, to_fetch);
 
diff --git a/transport.c b/transport.c
index f2fbc6f..cce50f5 100644
--- a/transport.c
+++ b/transport.c
@@ -166,6 +166,9 @@ static int set_git_option(struct git_transport_options *opts,
 	} else if (!strcmp(name, TRANS_OPT_NO_DEPENDENTS)) {
 		opts->no_dependents = !!value;
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
 	args.no_dependents = data->options.no_dependents;
+	args.filter_options = data->options.filter_options;
 
 	if (!data->got_remote_heads) {
 		connect_setup(transport, 0);
diff --git a/transport.h b/transport.h
index c49a8ed..31b1936 100644
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
@@ -221,6 +223,9 @@ void transport_check_allowed(const char *type);
  */
 #define TRANS_OPT_NO_DEPENDENTS "no-dependents"
 
+/* Filter objects for partial clone and fetch */
+#define TRANS_OPT_LIST_OBJECTS_FILTER "filter"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
-- 
2.9.3

