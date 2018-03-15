Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BCF71F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752606AbeCORct (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:32:49 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:50488 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbeCORck (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:32:40 -0400
Received: by mail-yw0-f201.google.com with SMTP id b7so7625041ywe.17
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=t5u7cn0HLp6IH1tJO9xTrXmTN8y4bgTzDE7MvN0Xgkg=;
        b=duemCqm8eP+DaxLfPuF7BFYAjwA93UX/Px3GBK/INZHsya0/4FPMv8vwB9pJkhIRZN
         5vKN+Q+fGkOAQcqZZakZUfzfe8wlLeDQ2qgU/h/epqjXdq9+lrjAO4WXvc9NjuJh6OrP
         2tPb3nlQDJ8q+jtKj7+ib4vgV2y7UWRBPa+TitXs0+UD8qJ4mMa00MogWndiMyCGqHxk
         4z1O9HvnHVXMryBy5xumTfiWAKnYLgePbc8r+bHBsjOvg1zoHbGHs2pN9M9CWCzDtxvp
         ftKPF31G6jFFTcimrsra6wHmD2zMo0iovKfuINrdC+1J3XZCBdG7lhique6eb3AenTGa
         baGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=t5u7cn0HLp6IH1tJO9xTrXmTN8y4bgTzDE7MvN0Xgkg=;
        b=htHtJuykCggKIQpAPTU/7Ea70sya3VzAiZvClEc0+3wTWuxLLbGtbg5dQQKhPklJNb
         DnM/Hx4ndVdXCir3RWlQodklIkU8pZxUigDWG+9RWCjqnWNZG37B+6jL7BN6KUbrizC9
         rKNXrbYNyglKRgIUfca8lmxzGSzRq4EEL9FQpefMZmxZVdkPbkLMCrqXe2LSdeFE7eLn
         tOBzvdwrElXEPRm36D1jtvd9cJ7NJ8SgKTUkv34nZrE8nI8ulrpbUt/sGH7grm0BoGGD
         +xGtno+Pd8T76rRO1ava1tFeLIWkDweuQnWxUSIPQ4OLxBZXojqfeh/6v5oYenDTPPax
         BHCg==
X-Gm-Message-State: AElRT7HyWUZ7txTWhyBMlERJEVCcN8su3z4blLA31R6OcI36LlnAVPRO
        HV8pDrRXgyi9bzmPtBWIVPDTbSyCyt2SSdJfYIV6Qj9SxKgE6OYMCCp9meOwlaszI7SYUrqeC8X
        3F3+TIxW9TEHcq7CYBOH7WRAbKEYwmYxiJaYQWd6Jet6bc9O3dvAiHI22ZA==
X-Google-Smtp-Source: AG47ELuJlWX7MjtVq5RoaOHVCQ0RfpcfhhO+UO1KwwYgjmhk4MEDaBEZbQsjt/gljAb+mrqHgPv21L57OGg=
MIME-Version: 1.0
X-Received: by 2002:a25:6c45:: with SMTP id h66-v6mr4093940ybc.41.1521135159753;
 Thu, 15 Mar 2018 10:32:39 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:29 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-23-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 22/35] fetch-pack: support shallow requests
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enable shallow clones and deepen requests using protocol version 2 if
the server 'fetch' command supports the 'shallow' feature.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/technical/protocol-v2.txt | 18 ++++---
 connect.c                               | 22 ++++++++
 connect.h                               |  2 +
 fetch-pack.c                            | 71 ++++++++++++++++++++++++-
 4 files changed, 105 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 4f7f251569..136179d7d8 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -255,6 +255,10 @@ A `fetch` request can take the following arguments:
 	to its base by position in pack rather than by an oid.  That is,
 	they can read OBJ_OFS_DELTA (ake type 6) in a packfile.
 
+If the 'shallow' feature is advertised the following arguments can be
+included in the clients request as well as the potential addition of the
+'shallow-info' section in the server's response as explained below.
+
     shallow <oid>
 	A client must notify the server of all commits for which it only
 	has shallow copies (meaning that it doesn't have the parents of
@@ -338,13 +342,13 @@ header.
 	  further negotiation is needed.
 
     shallow-info section
-	If the client has requested a shallow fetch/clone, a shallow
-	client requests a fetch or the server is shallow then the
-	server's response may include a shallow-info section.  The
-	shallow-info section will be included if (due to one of the
-	above conditions) the server needs to inform the client of any
-	shallow boundaries or adjustments to the clients already
-	existing shallow boundaries.
+	* If the client has requested a shallow fetch/clone, a shallow
+	  client requests a fetch or the server is shallow then the
+	  server's response may include a shallow-info section.  The
+	  shallow-info section will be included if (due to one of the
+	  above conditions) the server needs to inform the client of any
+	  shallow boundaries or adjustments to the clients already
+	  existing shallow boundaries.
 
 	* Always begins with the section header "shallow-info"
 
diff --git a/connect.c b/connect.c
index e42d779f71..5bb9d34844 100644
--- a/connect.c
+++ b/connect.c
@@ -82,6 +82,28 @@ int server_supports_v2(const char *c, int die_on_error)
 	return 0;
 }
 
+int server_supports_feature(const char *c, const char *feature,
+			    int die_on_error)
+{
+	int i;
+
+	for (i = 0; i < server_capabilities_v2.argc; i++) {
+		const char *out;
+		if (skip_prefix(server_capabilities_v2.argv[i], c, &out) &&
+		    (!*out || *(out++) == '=')) {
+			if (parse_feature_request(out, feature))
+				return 1;
+			else
+				break;
+		}
+	}
+
+	if (die_on_error)
+		die("server doesn't support feature '%s'", feature);
+
+	return 0;
+}
+
 static void process_capabilities_v2(struct packet_reader *reader)
 {
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL)
diff --git a/connect.h b/connect.h
index 8898d44952..0e69c6709c 100644
--- a/connect.h
+++ b/connect.h
@@ -17,5 +17,7 @@ struct packet_reader;
 extern enum protocol_version discover_version(struct packet_reader *reader);
 
 extern int server_supports_v2(const char *c, int die_on_error);
+extern int server_supports_feature(const char *c, const char *feature,
+				   int die_on_error);
 
 #endif
diff --git a/fetch-pack.c b/fetch-pack.c
index dffcfd66a5..837e1fd21d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1008,6 +1008,26 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	return ref;
 }
 
+static void add_shallow_requests(struct strbuf *req_buf,
+				 const struct fetch_pack_args *args)
+{
+	if (is_repository_shallow())
+		write_shallow_commits(req_buf, 1, NULL);
+	if (args->depth > 0)
+		packet_buf_write(req_buf, "deepen %d", args->depth);
+	if (args->deepen_since) {
+		timestamp_t max_age = approxidate(args->deepen_since);
+		packet_buf_write(req_buf, "deepen-since %"PRItime, max_age);
+	}
+	if (args->deepen_not) {
+		int i;
+		for (i = 0; i < args->deepen_not->nr; i++) {
+			struct string_list_item *s = args->deepen_not->items + i;
+			packet_buf_write(req_buf, "deepen-not %s", s->string);
+		}
+	}
+}
+
 static void add_wants(const struct ref *wants, struct strbuf *req_buf)
 {
 	for ( ; wants ; wants = wants->next) {
@@ -1093,6 +1113,12 @@ static int send_fetch_request(int fd_out, const struct fetch_pack_args *args,
 	if (prefer_ofs_delta)
 		packet_buf_write(&req_buf, "ofs-delta");
 
+	/* Add shallow-info and deepen request */
+	if (server_supports_feature("fetch", "shallow", 0))
+		add_shallow_requests(&req_buf, args);
+	else if (is_repository_shallow() || args->deepen)
+		die(_("Server does not support shallow requests"));
+
 	/* add wants */
 	add_wants(wants, &req_buf);
 
@@ -1122,7 +1148,7 @@ static int process_section_header(struct packet_reader *reader,
 	int ret;
 
 	if (packet_reader_peek(reader) != PACKET_READ_NORMAL)
-		die("error reading packet");
+		die("error reading section header '%s'", section);
 
 	ret = !strcmp(reader->line, section);
 
@@ -1177,6 +1203,43 @@ static int process_acks(struct packet_reader *reader, struct oidset *common)
 	return received_ready ? 2 : (received_ack ? 1 : 0);
 }
 
+static void receive_shallow_info(struct fetch_pack_args *args,
+				 struct packet_reader *reader)
+{
+	process_section_header(reader, "shallow-info", 0);
+	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
+		const char *arg;
+		struct object_id oid;
+
+		if (skip_prefix(reader->line, "shallow ", &arg)) {
+			if (get_oid_hex(arg, &oid))
+				die(_("invalid shallow line: %s"), reader->line);
+			register_shallow(&oid);
+			continue;
+		}
+		if (skip_prefix(reader->line, "unshallow ", &arg)) {
+			if (get_oid_hex(arg, &oid))
+				die(_("invalid unshallow line: %s"), reader->line);
+			if (!lookup_object(oid.hash))
+				die(_("object not found: %s"), reader->line);
+			/* make sure that it is parsed as shallow */
+			if (!parse_object(&oid))
+				die(_("error in object: %s"), reader->line);
+			if (unregister_shallow(&oid))
+				die(_("no shallow found: %s"), reader->line);
+			continue;
+		}
+		die(_("expected shallow/unshallow, got %s"), reader->line);
+	}
+
+	if (reader->status != PACKET_READ_FLUSH &&
+	    reader->status != PACKET_READ_DELIM)
+		die("error processing shallow info: %d", reader->status);
+
+	setup_alternate_shallow(&shallow_lock, &alternate_shallow_file, NULL);
+	args->deepen = 1;
+}
+
 enum fetch_state {
 	FETCH_CHECK_LOCAL = 0,
 	FETCH_SEND_REQUEST,
@@ -1209,6 +1272,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			/* v2 supports these by default */
 			allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
 			use_sideband = 2;
+			if (args->depth > 0 || args->deepen_since || args->deepen_not)
+				args->deepen = 1;
 
 			if (marked)
 				for_each_ref(clear_marks, NULL);
@@ -1245,6 +1310,10 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			}
 			break;
 		case FETCH_GET_PACK:
+			/* Check for shallow-info section */
+			if (process_section_header(&reader, "shallow-info", 1))
+				receive_shallow_info(args, &reader);
+
 			/* get the pack */
 			process_section_header(&reader, "packfile", 0);
 			if (get_pack(args, fd, pack_lockfile))
-- 
2.16.2.804.g6dcf76e118-goog

