Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86286C77B73
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 21:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjDNV0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 17:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjDNVZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 17:25:57 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A898472AB
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 14:25:29 -0700 (PDT)
Received: (qmail 22445 invoked by uid 109); 14 Apr 2023 21:25:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Apr 2023 21:25:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31719 invoked by uid 111); 14 Apr 2023 21:25:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Apr 2023 17:25:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Apr 2023 17:25:20 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jonas Haag <jonas@lophus.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: [PATCH v3 7/7] v0 protocol: use size_t for capability length/offset
Message-ID: <20230414212520.GG639756@coredump.intra.peff.net>
References: <20230414212404.GA639653@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230414212404.GA639653@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When parsing server capabilities, we use "int" to store lengths and
offsets. At first glance this seems like a spot where our parser may be
confused by integer overflow if somebody sent us a malicious response.

In practice these strings are all bounded by the 64k limit of a
pkt-line, so using "int" is OK. However, it makes the code simpler to
audit if they just use size_t everywhere. Note that because we take
these parameters as pointers, this also forces many callers to update
their declared types.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c |  2 +-
 connect.c              | 22 +++++++++++-----------
 connect.h              |  4 ++--
 fetch-pack.c           |  4 ++--
 send-pack.c            |  2 +-
 transport.c            |  2 +-
 upload-pack.c          |  2 +-
 7 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9109552533..3b495ecc84 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2093,7 +2093,7 @@ static struct command *read_head_info(struct packet_reader *reader,
 			const char *feature_list = reader->line + linelen + 1;
 			const char *hash = NULL;
 			const char *client_sid;
-			int len = 0;
+			size_t len = 0;
 			if (parse_feature_request(feature_list, "report-status"))
 				report_status = 1;
 			if (parse_feature_request(feature_list, "report-status-v2"))
diff --git a/connect.c b/connect.c
index b7ba5f5727..c54adc652f 100644
--- a/connect.c
+++ b/connect.c
@@ -22,7 +22,7 @@
 
 static char *server_capabilities_v1;
 static struct strvec server_capabilities_v2 = STRVEC_INIT;
-static const char *next_server_feature_value(const char *feature, int *len, int *offset);
+static const char *next_server_feature_value(const char *feature, size_t *len, size_t *offset);
 
 static int check_ref(const char *name, unsigned int flags)
 {
@@ -205,10 +205,10 @@ static void parse_one_symref_info(struct string_list *symref, const char *val, i
 static void annotate_refs_with_symref_info(struct ref *ref)
 {
 	struct string_list symref = STRING_LIST_INIT_DUP;
-	int offset = 0;
+	size_t offset = 0;
 
 	while (1) {
-		int len;
+		size_t len;
 		const char *val;
 
 		val = next_server_feature_value("symref", &len, &offset);
@@ -231,7 +231,7 @@ static void annotate_refs_with_symref_info(struct ref *ref)
 static void process_capabilities(struct packet_reader *reader, int *linelen)
 {
 	const char *feat_val;
-	int feat_len;
+	size_t feat_len;
 	const char *line = reader->line;
 	int nul_location = strlen(line);
 	if (nul_location == *linelen)
@@ -596,10 +596,10 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	return list;
 }
 
-const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp, int *offset)
+const char *parse_feature_value(const char *feature_list, const char *feature, size_t *lenp, size_t *offset)
 {
 	const char *orig_start = feature_list;
-	int len;
+	size_t len;
 
 	if (!feature_list)
 		return NULL;
@@ -623,7 +623,7 @@ const char *parse_feature_value(const char *feature_list, const char *feature, i
 			}
 			/* feature with a value (e.g., "agent=git/1.2.3") */
 			else if (*value == '=') {
-				int end;
+				size_t end;
 
 				value++;
 				end = strcspn(value, " \t\n");
@@ -645,8 +645,8 @@ const char *parse_feature_value(const char *feature_list, const char *feature, i
 
 int server_supports_hash(const char *desired, int *feature_supported)
 {
-	int offset = 0;
-	int len;
+	size_t offset = 0;
+	size_t len;
 	const char *hash;
 
 	hash = next_server_feature_value("object-format", &len, &offset);
@@ -670,12 +670,12 @@ int parse_feature_request(const char *feature_list, const char *feature)
 	return !!parse_feature_value(feature_list, feature, NULL, NULL);
 }
 
-static const char *next_server_feature_value(const char *feature, int *len, int *offset)
+static const char *next_server_feature_value(const char *feature, size_t *len, size_t *offset)
 {
 	return parse_feature_value(server_capabilities_v1, feature, len, offset);
 }
 
-const char *server_feature_value(const char *feature, int *len)
+const char *server_feature_value(const char *feature, size_t *len)
 {
 	return parse_feature_value(server_capabilities_v1, feature, len, NULL);
 }
diff --git a/connect.h b/connect.h
index f41a0b4c1f..1645126c17 100644
--- a/connect.h
+++ b/connect.h
@@ -12,14 +12,14 @@ int finish_connect(struct child_process *conn);
 int git_connection_is_socket(struct child_process *conn);
 int server_supports(const char *feature);
 int parse_feature_request(const char *features, const char *feature);
-const char *server_feature_value(const char *feature, int *len_ret);
+const char *server_feature_value(const char *feature, size_t *len_ret);
 int url_is_local_not_ssh(const char *url);
 
 struct packet_reader;
 enum protocol_version discover_version(struct packet_reader *reader);
 
 int server_supports_hash(const char *desired, int *feature_supported);
-const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp, int *offset);
+const char *parse_feature_value(const char *feature_list, const char *feature, size_t *lenp, size_t *offset);
 int server_supports_v2(const char *c);
 void ensure_server_supports_v2(const char *c);
 int server_feature_v2(const char *c, const char **v);
diff --git a/fetch-pack.c b/fetch-pack.c
index 368f2ed25a..97a44ed582 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1099,7 +1099,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	struct ref *ref = copy_ref_list(orig_ref);
 	struct object_id oid;
 	const char *agent_feature;
-	int agent_len;
+	size_t agent_len;
 	struct fetch_negotiator negotiator_alloc;
 	struct fetch_negotiator *negotiator;
 
@@ -1117,7 +1117,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		agent_supported = 1;
 		if (agent_len)
 			print_verbose(args, _("Server version is %.*s"),
-				      agent_len, agent_feature);
+				      (int)agent_len, agent_feature);
 	}
 
 	if (!server_supports("session-id"))
diff --git a/send-pack.c b/send-pack.c
index f81bbb28d7..97344b629e 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -538,7 +538,7 @@ int send_pack(struct send_pack_args *args,
 		die(_("the receiving end does not support this repository's hash algorithm"));
 
 	if (args->push_cert != SEND_PACK_PUSH_CERT_NEVER) {
-		int len;
+		size_t len;
 		push_cert_nonce = server_feature_value("push-cert", &len);
 		if (push_cert_nonce) {
 			reject_invalid_nonce(push_cert_nonce, len);
diff --git a/transport.c b/transport.c
index 89a220425e..6223dc3de2 100644
--- a/transport.c
+++ b/transport.c
@@ -317,7 +317,7 @@ static struct ref *handshake(struct transport *transport, int for_push,
 	struct git_transport_data *data = transport->data;
 	struct ref *refs = NULL;
 	struct packet_reader reader;
-	int sid_len;
+	size_t sid_len;
 	const char *server_sid;
 
 	connect_setup(transport, for_push);
diff --git a/upload-pack.c b/upload-pack.c
index e23f16dfdd..565e46058f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1067,7 +1067,7 @@ static void receive_needs(struct upload_pack_data *data,
 		const char *features;
 		struct object_id oid_buf;
 		const char *arg;
-		int feature_len;
+		size_t feature_len;
 
 		reset_timeout(data->timeout);
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
-- 
2.40.0.515.gdfb9e78b42
