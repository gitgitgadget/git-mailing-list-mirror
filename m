Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E00820A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 10:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbeLKKoH (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 05:44:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:37938 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726114AbeLKKoH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 05:44:07 -0500
Received: (qmail 14536 invoked by uid 109); 11 Dec 2018 10:44:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Dec 2018 10:44:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3952 invoked by uid 111); 11 Dec 2018 10:43:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 11 Dec 2018 05:43:14 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2018 05:43:42 -0500
Date:   Tue, 11 Dec 2018 05:43:42 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 1/3] serve: pass "config context" through to individual
 commands
Message-ID: <20181211104342.GA7233@sigill.intra.peff.net>
References: <20181211104236.GA6899@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181211104236.GA6899@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In protocol v2, instead of just running "upload-pack", we have a generic
"serve" loop which runs command requests from the client. What used to
be "upload-pack" is now generally split into two operations: "ls-refs"
and "fetch". The latter knows it must respect uploadpack.* config, but
the former is not actually specific to a fetch operation (we do not yet
do v2 receive-pack, but eventually we may, and ls-refs would support
both operations).

However, ls-refs does need to know which operation we're performing, in
order to read the correct config (e.g., uploadpack.hiderefs versus
receive.hiderefs; we don't read _either_ right now, but this is the
first step to fixing that).

In the generic "git-serve" program, we don't have that information. But
in the protocol as it is actually used by clients, the client still asks
to run "git-upload-pack", and then issues an "ls-refs" from there. So we
_do_ know at that point that "uploadpack" is the right config context.
This patch teaches the protocol v2 "serve" code to pass that context
through to the individual commands (a future patch will teach ls-refs to
actually use it).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/upload-pack.c | 1 +
 ls-refs.c             | 4 +++-
 ls-refs.h             | 3 ++-
 serve.c               | 9 +++++----
 serve.h               | 7 +++++++
 upload-pack.c         | 4 ++--
 upload-pack.h         | 4 ++--
 7 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index 42dc4da5a1..67192cfa9e 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -52,6 +52,7 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 	case protocol_v2:
 		serve_opts.advertise_capabilities = opts.advertise_refs;
 		serve_opts.stateless_rpc = opts.stateless_rpc;
+		serve_opts.config_context = "uploadpack";
 		serve(&serve_opts);
 		break;
 	case protocol_v1:
diff --git a/ls-refs.c b/ls-refs.c
index a06f12eca8..e8e31475f0 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -69,7 +69,9 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-int ls_refs(struct repository *r, struct argv_array *keys,
+int ls_refs(struct repository *r,
+	    const char *config_section,
+	    struct argv_array *keys,
 	    struct packet_reader *request)
 {
 	struct ls_refs_data data;
diff --git a/ls-refs.h b/ls-refs.h
index b62877e8da..da26fc9824 100644
--- a/ls-refs.h
+++ b/ls-refs.h
@@ -4,7 +4,8 @@
 struct repository;
 struct argv_array;
 struct packet_reader;
-extern int ls_refs(struct repository *r, struct argv_array *keys,
+extern int ls_refs(struct repository *r, const char *config_context,
+		   struct argv_array *keys,
 		   struct packet_reader *request);
 
 #endif /* LS_REFS_H */
diff --git a/serve.c b/serve.c
index bda085f09c..70f89cf0d9 100644
--- a/serve.c
+++ b/serve.c
@@ -48,6 +48,7 @@ struct protocol_capability {
 	 * This field should be NULL for capabilities which are not commands.
 	 */
 	int (*command)(struct repository *r,
+		       const char *config_context,
 		       struct argv_array *keys,
 		       struct packet_reader *request);
 };
@@ -158,7 +159,7 @@ enum request_state {
 	PROCESS_REQUEST_DONE,
 };
 
-static int process_request(void)
+static int process_request(struct serve_options *opts)
 {
 	enum request_state state = PROCESS_REQUEST_KEYS;
 	struct packet_reader reader;
@@ -222,7 +223,7 @@ static int process_request(void)
 	if (!command)
 		die("no command requested");
 
-	command->command(the_repository, &keys, &reader);
+	command->command(the_repository, opts->config_context, &keys, &reader);
 
 	argv_array_clear(&keys);
 	return 0;
@@ -249,10 +250,10 @@ void serve(struct serve_options *options)
 	 * a single request/response exchange
 	 */
 	if (options->stateless_rpc) {
-		process_request();
+		process_request(options);
 	} else {
 		for (;;)
-			if (process_request())
+			if (process_request(options))
 				break;
 	}
 }
diff --git a/serve.h b/serve.h
index fe65ba9f46..d527224cbb 100644
--- a/serve.h
+++ b/serve.h
@@ -8,6 +8,13 @@ extern int has_capability(const struct argv_array *keys, const char *capability,
 struct serve_options {
 	unsigned advertise_capabilities;
 	unsigned stateless_rpc;
+
+	/*
+	 * Some operations may need to know the context when looking up config;
+	 * e.g., set this to "uploadpack" to respect "uploadpack.hiderefs" (as
+	 * opposed to "receive.hiderefs").
+	 */
+	const char *config_context;
 };
 #define SERVE_OPTIONS_INIT { 0 }
 extern void serve(struct serve_options *options);
diff --git a/upload-pack.c b/upload-pack.c
index 5e81f1ff24..914bbb40bc 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1413,8 +1413,8 @@ enum fetch_state {
 	FETCH_DONE,
 };
 
-int upload_pack_v2(struct repository *r, struct argv_array *keys,
-		   struct packet_reader *request)
+int upload_pack_v2(struct repository *r, const char *config_context,
+		   struct argv_array *keys, struct packet_reader *request)
 {
 	enum fetch_state state = FETCH_PROCESS_ARGS;
 	struct upload_pack_data data;
diff --git a/upload-pack.h b/upload-pack.h
index cab2178796..2a9f51197c 100644
--- a/upload-pack.h
+++ b/upload-pack.h
@@ -13,8 +13,8 @@ void upload_pack(struct upload_pack_options *options);
 struct repository;
 struct argv_array;
 struct packet_reader;
-extern int upload_pack_v2(struct repository *r, struct argv_array *keys,
-			  struct packet_reader *request);
+extern int upload_pack_v2(struct repository *r, const char *config_context,
+			  struct argv_array *keys, struct packet_reader *request);
 
 struct strbuf;
 extern int upload_pack_advertise(struct repository *r,
-- 
2.20.0.734.gb4f2c0d2be

