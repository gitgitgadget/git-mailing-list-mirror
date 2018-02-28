Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01DAE1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965022AbeB1XYU (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:24:20 -0500
Received: from mail-yw0-f201.google.com ([209.85.161.201]:52644 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965014AbeB1XYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:24:16 -0500
Received: by mail-yw0-f201.google.com with SMTP id y196so2366890ywg.19
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=EJYRr9BdiwP8LKMvIQS+JMD4cnnIxoMKS6AQ6+rkR/E=;
        b=NXVvl2qTua8p4fmdvQhFY7s0LNTYcMQDjMbVx9/LshA4ZA1peN3Hb5WjFMx04mKAO/
         q1sSdXy4c1XeeT9tfSrez/pmh4JVmIy+oTa+p8gAlDFduztDjcXDkVkL6Kwb2XsCJCiw
         b5vItf0KIEc2oXZlKiZ1cCeuHO36AZrJN9MUWd0wGvfIT9Tw/YI949N3xY6ukAGs0y6K
         IHjbG+4W4FmxMGo6TmTkpKdPrW3dBn9Pd2NaeGxTbi+5AYRbnqh7SJjEq1Nms2CaYXFe
         Y3enDQrEgb1bwBLGUaisfWt4eXB3tEFcJNVXd53MAolhAQ+p0gSzaF5vHAGLUMIOiZa6
         mCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=EJYRr9BdiwP8LKMvIQS+JMD4cnnIxoMKS6AQ6+rkR/E=;
        b=gNugGY1+g9mUyL+/xQiaxaHAMrYj5YDFwL1mdhXnQkgA4JSKg6RR07EJiaMjzJ5qm3
         /7oiqeuibj+eGIguMaRaGXIR3BAzzDr6eIsCKkY7W+rtn0pjNOtJo1jp517tYdnG89Y9
         EQC+YcpJvWaQ/x+uV9zJvetKOjFbITyB/sjYJEURmF/O4ejfhAeje82t3wKwL3j8o8Xu
         CnxYWqj++NpXn/DEAEqULE/uzkwtS9cekj7V5cuSwhL97UjoQ+NA6zUvKHbYGFrOP+A2
         l3h3VvOZkMuHHjrRZ0nj1DCi3rHIHLyk2YvWnlLMDTV3wE4HUknB05THKVpmx2diQNep
         AqjQ==
X-Gm-Message-State: APf1xPAwgZGjvYDnIAe5PLx7b0e6Dz5dPsfCop0lWNeaZzieZ/PezKV1
        60HH7qyxOELvtaWCGAb+DA8sIp99GpipucuFWEwgZK7yWDSAU73cb6dK4dqL9SXYaOWZIglZ5ih
        0Ij+lqj/GCy4/Qur/AnyGfQyz0ZcyQQ487O2+tABeFVE4ODBVksD3qbVeuA==
X-Google-Smtp-Source: AG47ELtHI0pV+rRP3GwLLEU/rv8MzbKdr49pEdhrG63xtqqO8i+D/qabGwWNj+QMM+AjdE2gBAUTEWicvEU=
MIME-Version: 1.0
X-Received: by 2002:a25:850e:: with SMTP id w14-v6mr10605823ybk.9.1519860256080;
 Wed, 28 Feb 2018 15:24:16 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:39 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-23-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 22/35] fetch-pack: support shallow requests
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

Enable shallow clones and deepen requests using protocol version 2 if
the server 'fetch' command supports the 'shallow' feature.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 connect.c    | 22 ++++++++++++++++
 connect.h    |  2 ++
 fetch-pack.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/connect.c b/connect.c
index 6203ce576..66a9443c8 100644
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
index 8898d4495..0e69c6709 100644
--- a/connect.h
+++ b/connect.h
@@ -17,5 +17,7 @@ struct packet_reader;
 extern enum protocol_version discover_version(struct packet_reader *reader);
 
 extern int server_supports_v2(const char *c, int die_on_error);
+extern int server_supports_feature(const char *c, const char *feature,
+				   int die_on_error);
 
 #endif
diff --git a/fetch-pack.c b/fetch-pack.c
index dffcfd66a..837e1fd21 100644
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
2.16.2.395.g2e18187dfd-goog

