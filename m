Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A2B41F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964985AbeB1XXm (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:23:42 -0500
Received: from mail-yb0-f201.google.com ([209.85.213.201]:54756 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964944AbeB1XXg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:23:36 -0500
Received: by mail-yb0-f201.google.com with SMTP id x12-v6so2355246ybm.21
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=WmMoHMJLvOu76Kt/4atMMbA5zfAqcLAZGNNkjuKMWQ8=;
        b=fCF7fYU+yClTGAOP2WKQ77c0O1NNEpLiqAYo5iQkSdFnONCxIIKeMZjxOlwNhg/juT
         4o9b7r/hWC2aYVBgVM1SdY1hrLAcNNdjOt4M9N0wmKieR2u/buVh9GdmlB/I5v6x4CDi
         03vuFzK2cUr4VS6S7Ve0GZhlPkZteHqgz1yGpuzQKDH9GG9giSUO3JZgQz7mHf9AweBR
         H5wLfxTDNvPKu83n0xYz8hgMGFPl48I77gfFz6VXsgyvquyzTByuWa4/WrSv7bEAilYe
         G2od7sXY4fgqaA/XFnwgrgW9QLtgU5EiziQoMwkY+fPcgE4iUDHXGK4O3EqUYQ2HHLot
         GJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=WmMoHMJLvOu76Kt/4atMMbA5zfAqcLAZGNNkjuKMWQ8=;
        b=eQVgNlq8RzTdYPLMLSUStma3FI0OLWSgMfYFTt52P9jOcW6KXBFwCw/+yR36qKRTXo
         Q1RD0vEJll5pMJcygHQWf8cS267NN/fnGjl1Yi43aOoAyAbWhfYL85LRo0oFIdJ4KEP6
         i8xxbAtpQ6IC50Ka/5k2czmE6Ljqhqb5PbEOpUxEkiLdIZxyNi8Hl/BVXKsxH600Q5a1
         0eu9iTmLGt2c6jAr8SgEnv86MetRLBaceGqYw9nKGHv94IsVwzTSCc/96tGpGFYD5w47
         WHsoS7/jT/wlscc9O8cnzXDa/ZFQNNBHTSQROYNS6hL1P50Hkj7MKAeu0Tr0bGUoqZYw
         u1tw==
X-Gm-Message-State: APf1xPCgAP4kCK4fhmbZCb/WrVzMgKUOSFGXEbOGbpbT9IQFN37qzWAa
        XJj5VPmcI34tk6hV21y+Z/O4pMCjeJ2h7qoIRXoh0GDldAwl9TOrPsKEldWg4EIjt7etCCd5MM7
        5D04Wde7to83fqSB+du9xS6PJp6vu65RreaR3xEEtKjDWixzTJPZbeHbg8A==
X-Google-Smtp-Source: AG47ELuHE5+4sS6xx4Fr4uY7T0eyVkJk/vvn4otN/6mggaCpto+w0Z7Ce1Xl2Y5QlGYblEPnC6UPsUxw6sc=
MIME-Version: 1.0
X-Received: by 10.129.242.3 with SMTP id i3mr4665665ywm.19.1519860215131; Wed,
 28 Feb 2018 15:23:35 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:24 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-8-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 07/35] connect: convert get_remote_heads to use struct packet_reader
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to allow for better control flow when protocol_v2 is introduced
convert 'get_remote_heads()' to use 'struct packet_reader' to read
packet lines.  This enables a client to be able to peek the first line
of a server's response (without consuming it) in order to determine the
protocol version its speaking and then passing control to the
appropriate handler.

This is needed because the initial response from a server speaking
protocol_v0 includes the first ref, while subsequent protocol versions
respond with a version line.  We want to be able to read this first line
without consuming the first ref sent in the protocol_v0 case so that the
protocol version the server is speaking can be determined outside of
'get_remote_heads()' in a future patch.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 connect.c | 173 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 95 insertions(+), 78 deletions(-)

diff --git a/connect.c b/connect.c
index c3a014c5b..c82c90b7c 100644
--- a/connect.c
+++ b/connect.c
@@ -48,6 +48,12 @@ int check_ref_type(const struct ref *ref, int flags)
 
 static void die_initial_contact(int unexpected)
 {
+	/*
+	 * A hang-up after seeing some response from the other end
+	 * means that it is unexpected, as we know the other end is
+	 * willing to talk to us.  A hang-up before seeing any
+	 * response does not necessarily mean an ACL problem, though.
+	 */
 	if (unexpected)
 		die(_("The remote end hung up upon initial contact"));
 	else
@@ -56,6 +62,40 @@ static void die_initial_contact(int unexpected)
 		      "and the repository exists."));
 }
 
+static enum protocol_version discover_version(struct packet_reader *reader)
+{
+	enum protocol_version version = protocol_unknown_version;
+
+	/*
+	 * Peek the first line of the server's response to
+	 * determine the protocol version the server is speaking.
+	 */
+	switch (packet_reader_peek(reader)) {
+	case PACKET_READ_EOF:
+		die_initial_contact(0);
+	case PACKET_READ_FLUSH:
+	case PACKET_READ_DELIM:
+		version = protocol_v0;
+		break;
+	case PACKET_READ_NORMAL:
+		version = determine_protocol_version_client(reader->line);
+		break;
+	}
+
+	switch (version) {
+	case protocol_v1:
+		/* Read the peeked version line */
+		packet_reader_read(reader);
+		break;
+	case protocol_v0:
+		break;
+	case protocol_unknown_version:
+		BUG("unknown protocol version");
+	}
+
+	return version;
+}
+
 static void parse_one_symref_info(struct string_list *symref, const char *val, int len)
 {
 	char *sym, *target;
@@ -109,60 +149,21 @@ static void annotate_refs_with_symref_info(struct ref *ref)
 	string_list_clear(&symref, 0);
 }
 
-/*
- * Read one line of a server's ref advertisement into packet_buffer.
- */
-static int read_remote_ref(int in, char **src_buf, size_t *src_len,
-			   int *responded)
+static void process_capabilities(const char *line, int *len)
 {
-	int len = packet_read(in, src_buf, src_len,
-			      packet_buffer, sizeof(packet_buffer),
-			      PACKET_READ_GENTLE_ON_EOF |
-			      PACKET_READ_CHOMP_NEWLINE);
-	const char *arg;
-	if (len < 0)
-		die_initial_contact(*responded);
-	if (len > 4 && skip_prefix(packet_buffer, "ERR ", &arg))
-		die("remote error: %s", arg);
-
-	*responded = 1;
-
-	return len;
-}
-
-#define EXPECTING_PROTOCOL_VERSION 0
-#define EXPECTING_FIRST_REF 1
-#define EXPECTING_REF 2
-#define EXPECTING_SHALLOW 3
-
-/* Returns 1 if packet_buffer is a protocol version pkt-line, 0 otherwise. */
-static int process_protocol_version(void)
-{
-	switch (determine_protocol_version_client(packet_buffer)) {
-	case protocol_v1:
-		return 1;
-	case protocol_v0:
-		return 0;
-	default:
-		die("server is speaking an unknown protocol");
-	}
-}
-
-static void process_capabilities(int *len)
-{
-	int nul_location = strlen(packet_buffer);
+	int nul_location = strlen(line);
 	if (nul_location == *len)
 		return;
-	server_capabilities = xstrdup(packet_buffer + nul_location + 1);
+	server_capabilities = xstrdup(line + nul_location + 1);
 	*len = nul_location;
 }
 
-static int process_dummy_ref(void)
+static int process_dummy_ref(const char *line)
 {
 	struct object_id oid;
 	const char *name;
 
-	if (parse_oid_hex(packet_buffer, &oid, &name))
+	if (parse_oid_hex(line, &oid, &name))
 		return 0;
 	if (*name != ' ')
 		return 0;
@@ -171,20 +172,20 @@ static int process_dummy_ref(void)
 	return !oidcmp(&null_oid, &oid) && !strcmp(name, "capabilities^{}");
 }
 
-static void check_no_capabilities(int len)
+static void check_no_capabilities(const char *line, int len)
 {
-	if (strlen(packet_buffer) != len)
+	if (strlen(line) != len)
 		warning("Ignoring capabilities after first line '%s'",
-			packet_buffer + strlen(packet_buffer));
+			line + strlen(line));
 }
 
-static int process_ref(int len, struct ref ***list, unsigned int flags,
-		       struct oid_array *extra_have)
+static int process_ref(const char *line, int len, struct ref ***list,
+		       unsigned int flags, struct oid_array *extra_have)
 {
 	struct object_id old_oid;
 	const char *name;
 
-	if (parse_oid_hex(packet_buffer, &old_oid, &name))
+	if (parse_oid_hex(line, &old_oid, &name))
 		return 0;
 	if (*name != ' ')
 		return 0;
@@ -200,16 +201,17 @@ static int process_ref(int len, struct ref ***list, unsigned int flags,
 		**list = ref;
 		*list = &ref->next;
 	}
-	check_no_capabilities(len);
+	check_no_capabilities(line, len);
 	return 1;
 }
 
-static int process_shallow(int len, struct oid_array *shallow_points)
+static int process_shallow(const char *line, int len,
+			   struct oid_array *shallow_points)
 {
 	const char *arg;
 	struct object_id old_oid;
 
-	if (!skip_prefix(packet_buffer, "shallow ", &arg))
+	if (!skip_prefix(line, "shallow ", &arg))
 		return 0;
 
 	if (get_oid_hex(arg, &old_oid))
@@ -217,10 +219,17 @@ static int process_shallow(int len, struct oid_array *shallow_points)
 	if (!shallow_points)
 		die("repository on the other end cannot be shallow");
 	oid_array_append(shallow_points, &old_oid);
-	check_no_capabilities(len);
+	check_no_capabilities(line, len);
 	return 1;
 }
 
+enum get_remote_heads_state {
+	EXPECTING_FIRST_REF = 0,
+	EXPECTING_REF,
+	EXPECTING_SHALLOW,
+	EXPECTING_DONE,
+};
+
 /*
  * Read all the refs from the other end
  */
@@ -230,47 +239,55 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 			      struct oid_array *shallow_points)
 {
 	struct ref **orig_list = list;
+	int len = 0;
+	enum get_remote_heads_state state = EXPECTING_FIRST_REF;
+	struct packet_reader reader;
+	const char *arg;
 
-	/*
-	 * A hang-up after seeing some response from the other end
-	 * means that it is unexpected, as we know the other end is
-	 * willing to talk to us.  A hang-up before seeing any
-	 * response does not necessarily mean an ACL problem, though.
-	 */
-	int responded = 0;
-	int len;
-	int state = EXPECTING_PROTOCOL_VERSION;
+	packet_reader_init(&reader, in, src_buf, src_len,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_GENTLE_ON_EOF);
+
+	discover_version(&reader);
 
 	*list = NULL;
 
-	while ((len = read_remote_ref(in, &src_buf, &src_len, &responded))) {
+	while (state != EXPECTING_DONE) {
+		switch (packet_reader_read(&reader)) {
+		case PACKET_READ_EOF:
+			die_initial_contact(1);
+		case PACKET_READ_NORMAL:
+			len = reader.pktlen;
+			if (len > 4 && skip_prefix(reader.line, "ERR ", &arg))
+				die("remote error: %s", arg);
+			break;
+		case PACKET_READ_FLUSH:
+			state = EXPECTING_DONE;
+			break;
+		case PACKET_READ_DELIM:
+			die("invalid packet");
+		}
+
 		switch (state) {
-		case EXPECTING_PROTOCOL_VERSION:
-			if (process_protocol_version()) {
-				state = EXPECTING_FIRST_REF;
-				break;
-			}
-			state = EXPECTING_FIRST_REF;
-			/* fallthrough */
 		case EXPECTING_FIRST_REF:
-			process_capabilities(&len);
-			if (process_dummy_ref()) {
+			process_capabilities(reader.line, &len);
+			if (process_dummy_ref(reader.line)) {
 				state = EXPECTING_SHALLOW;
 				break;
 			}
 			state = EXPECTING_REF;
 			/* fallthrough */
 		case EXPECTING_REF:
-			if (process_ref(len, &list, flags, extra_have))
+			if (process_ref(reader.line, len, &list, flags, extra_have))
 				break;
 			state = EXPECTING_SHALLOW;
 			/* fallthrough */
 		case EXPECTING_SHALLOW:
-			if (process_shallow(len, shallow_points))
+			if (process_shallow(reader.line, len, shallow_points))
 				break;
-			die("protocol error: unexpected '%s'", packet_buffer);
-		default:
-			die("unexpected state %d", state);
+			die("protocol error: unexpected '%s'", reader.line);
+		case EXPECTING_DONE:
+			break;
 		}
 	}
 
-- 
2.16.2.395.g2e18187dfd-goog

