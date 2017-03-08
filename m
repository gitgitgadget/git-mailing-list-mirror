Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61DC2202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 17:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753990AbdCHRpx (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 12:45:53 -0500
Received: from siwi.pair.com ([209.68.5.199]:36838 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753952AbdCHRps (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 12:45:48 -0500
Received: from jeffhostetler.2jll4ugiwlvuzhh55dqabi0nia.bx.internal.cloudapp.net (unknown [40.76.14.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E1B738462D;
        Wed,  8 Mar 2017 12:38:39 -0500 (EST)
From:   Jeff Hostetler <jeffhost@microsoft.com>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, peff@peff.net, gitster@pobox.com,
        markbt@efaref.net, benpeart@microsoft.com,
        jonathantanmy@google.com, Jeff Hostetler <git@jeffhostetler.com>
Subject: [PATCH 05/10] fetch-pack: add partial-by-size and partial-special
Date:   Wed,  8 Mar 2017 17:38:00 +0000
Message-Id: <1488994685-37403-6-git-send-email-jeffhost@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
References: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <git@jeffhostetler.com>

Teach fetch-pack to take --partial-by-size and --partial-special
arguments and pass them via the transport to upload-pack to
request that certain blobs be omitted from the resulting packfile.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fetch-pack.c |  9 +++++++++
 fetch-pack.c         | 17 +++++++++++++++++
 fetch-pack.h         |  2 ++
 transport.c          |  8 ++++++++
 transport.h          |  8 ++++++++
 5 files changed, 44 insertions(+)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index cfe9e44..324d7b2 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -8,6 +8,7 @@
 static const char fetch_pack_usage[] =
 "git fetch-pack [--all] [--stdin] [--quiet | -q] [--keep | -k] [--thin] "
 "[--include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] "
+"[--partial-by-size=<n>] [--partial-special] "
 "[--no-progress] [--diag-url] [-v] [<host>:]<directory> [<refs>...]";
 
 static void add_sought_entry(struct ref ***sought, int *nr, int *alloc,
@@ -143,6 +144,14 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			args.update_shallow = 1;
 			continue;
 		}
+		if (skip_prefix(arg, "--partial-by-size=", &arg)) {
+			args.partial_by_size = xstrdup(arg);
+			continue;
+		}
+		if (!strcmp("--partial-special", arg)) {
+			args.partial_special = 1;
+			continue;
+		}
 		usage(fetch_pack_usage);
 	}
 	if (deepen_not.nr)
diff --git a/fetch-pack.c b/fetch-pack.c
index e0f5d5c..e355c38 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -372,6 +372,8 @@ static int find_common(struct fetch_pack_args *args,
 			if (prefer_ofs_delta)   strbuf_addstr(&c, " ofs-delta");
 			if (deepen_since_ok)    strbuf_addstr(&c, " deepen-since");
 			if (deepen_not_ok)      strbuf_addstr(&c, " deepen-not");
+			if (args->partial_by_size || args->partial_special)
+				strbuf_addstr(&c, " partial");
 			if (agent_supported)    strbuf_addf(&c, " agent=%s",
 							    git_user_agent_sanitized());
 			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
@@ -402,6 +404,12 @@ static int find_common(struct fetch_pack_args *args,
 			packet_buf_write(&req_buf, "deepen-not %s", s->string);
 		}
 	}
+
+	if (args->partial_by_size)
+		packet_buf_write(&req_buf, "partial-by-size %s", args->partial_by_size);
+	if (args->partial_special)
+		packet_buf_write(&req_buf, "partial-special");
+
 	packet_buf_flush(&req_buf);
 	state_len = req_buf.len;
 
@@ -807,6 +815,10 @@ static int get_pack(struct fetch_pack_args *args,
 					"--keep=fetch-pack %"PRIuMAX " on %s",
 					(uintmax_t)getpid(), hostname);
 		}
+
+		if (args->partial_by_size || args->partial_special)
+			argv_array_push(&cmd.args, "--allow-partial");
+
 		if (args->check_self_contained_and_connected)
 			argv_array_push(&cmd.args, "--check-self-contained-and-connected");
 	}
@@ -920,6 +932,11 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	else
 		prefer_ofs_delta = 0;
 
+	if (server_supports("partial"))
+		print_verbose(args, _("Server supports partial"));
+	else if (args->partial_by_size || args->partial_special)
+		die(_("Server does not support 'partial'"));
+
 	if ((agent_feature = server_feature_value("agent", &agent_len))) {
 		agent_supported = 1;
 		if (agent_len)
diff --git a/fetch-pack.h b/fetch-pack.h
index c912e3d..b8a26e0 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -12,6 +12,7 @@ struct fetch_pack_args {
 	int depth;
 	const char *deepen_since;
 	const struct string_list *deepen_not;
+	const char *partial_by_size;
 	unsigned deepen_relative:1;
 	unsigned quiet:1;
 	unsigned keep_pack:1;
@@ -29,6 +30,7 @@ struct fetch_pack_args {
 	unsigned cloning:1;
 	unsigned update_shallow:1;
 	unsigned deepen:1;
+	unsigned partial_special:1;
 };
 
 /*
diff --git a/transport.c b/transport.c
index 5828e06..45f35a4 100644
--- a/transport.c
+++ b/transport.c
@@ -160,6 +160,12 @@ static int set_git_option(struct git_transport_options *opts,
 	} else if (!strcmp(name, TRANS_OPT_DEEPEN_RELATIVE)) {
 		opts->deepen_relative = !!value;
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_PARTIAL_BY_SIZE)) {
+		opts->partial_by_size = xstrdup(value);
+		return 0;
+	} else if (!strcmp(name, TRANS_OPT_PARTIAL_SPECIAL)) {
+		opts->partial_special = !!value;
+		return 0;
 	}
 	return 1;
 }
@@ -227,6 +233,8 @@ static int fetch_refs_via_pack(struct transport *transport,
 		data->options.check_self_contained_and_connected;
 	args.cloning = transport->cloning;
 	args.update_shallow = data->options.update_shallow;
+	args.partial_by_size = data->options.partial_by_size;
+	args.partial_special = data->options.partial_special;
 
 	if (!data->got_remote_heads) {
 		connect_setup(transport, 0);
diff --git a/transport.h b/transport.h
index bc55715..c3f2d52 100644
--- a/transport.h
+++ b/transport.h
@@ -15,12 +15,14 @@ struct git_transport_options {
 	unsigned self_contained_and_connected : 1;
 	unsigned update_shallow : 1;
 	unsigned deepen_relative : 1;
+	unsigned partial_special : 1;
 	int depth;
 	const char *deepen_since;
 	const struct string_list *deepen_not;
 	const char *uploadpack;
 	const char *receivepack;
 	struct push_cas_option *cas;
+	const char *partial_by_size;
 };
 
 enum transport_family {
@@ -210,6 +212,12 @@ void transport_check_allowed(const char *type);
 /* Send push certificates */
 #define TRANS_OPT_PUSH_CERT "pushcert"
 
+/* Partial fetch to only include small files */
+#define TRANS_OPT_PARTIAL_BY_SIZE "partial-by-size"
+
+/* Partial fetch to only include special files, like ".gitignore" */
+#define TRANS_OPT_PARTIAL_SPECIAL "partial-special"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
-- 
2.7.4

