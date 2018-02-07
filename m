Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 370D11F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932247AbeBGBOJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:14:09 -0500
Received: from mail-ot0-f202.google.com ([74.125.82.202]:36405 "EHLO
        mail-ot0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932237AbeBGBOH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:14:07 -0500
Received: by mail-ot0-f202.google.com with SMTP id g9so2163844otc.3
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=PxPopYV27Mg88pumGcfl8L4jQ0ozZR89gqhgY0mobf0=;
        b=Nbmq3ppgfvaUNDIq+FeNNaiR8bAAlSTS1rL/nSMg+X2/jEYcgOCmeP1SycA9XA3IB2
         Z2z5udOgF6uKlcVB43Ip0O6o4hE3F212gJrqu52iSSwmmwzGhcvunzbPWsA32vyFtXU0
         Fzo6z3q9B9vyJtplHtdgmUTtxOStjWwompmy/hNrIMyhLYuqpOTT3ZfXLGTgYg3cw2Fq
         GTgcMTxz0lGWHZoZFrEZKWFv59i5d2pg5BDAJ3nMCfDbnOgGK5TToQpm025IE4A25KaK
         CFCpF5TS3LrmO5UUZhBBvAW0znpML49xtg8STaZpojcdnVEgtUXDRTdR2fusVSS8BBI7
         J2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=PxPopYV27Mg88pumGcfl8L4jQ0ozZR89gqhgY0mobf0=;
        b=s2PdyKDSxbXk+CcbJWRX8yQ8X19xA2E5LosWd5S7OGmgxJal2NwOHcq8yep6JkSnHY
         f8JaN5Nm7G6CbQhPsfUbftXnBusrhXqOuzvNAcfjBVobTgLOI5Yn7xCmqi5okqubeRfn
         etH+RVvKY4t6c1oTAwqxPmk/Ll2YmZScGn7WbtZ+H7hPRs0XRSZTbY3l+VB2bNSKHIbp
         r8Zovoo+3R8w5/kWmAkFpcnqrYl+xXyk7KpP67CQAxME8CS/wNYxb5dXMfBUnnAUsbfx
         D6kCE7w1hg1+eY/0qrWHck2PC7C13PJxZUZxEwSSFZMAbU8+DVAa1JrnHSAyujimbM/q
         R3ZA==
X-Gm-Message-State: APf1xPDtSSuMdGdgwLBK5ooPHDHWYj6gAmtMpMkCL1Njgr28AwVjUAWK
        HurmfK+le6TtnYZpaFyGxbM/Gt6/CMqVQyf7+HsEJDFgeOH0aRR6hO5lcWxEWQRyoOUHS4HyH1s
        SWmDCFm6LdZX2drKCGK32I/XfcI3AIbjn/3++UaITh5JdHEMjnmqSGoBgtg==
X-Google-Smtp-Source: AH8x226HWtghHVwMU9vhE66s7ggPnHxezgfLEjyAljWUoTVl74Op8TYWN3LaVXMeuCGO4IdReaEpYqVKD6Y=
MIME-Version: 1.0
X-Received: by 10.202.231.130 with SMTP id e124mr2037681oih.78.1517966046549;
 Tue, 06 Feb 2018 17:14:06 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:12:59 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-23-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 22/35] upload-pack: support shallow requests
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the 'shallow' feature to the protocol version 2 command 'fetch'
which indicates that the server supports shallow clients and deepen
requets.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/technical/protocol-v2.txt |  67 +++++++++++++++-
 serve.c                                 |   2 +-
 t/t5701-git-serve.sh                    |   2 +-
 upload-pack.c                           | 138 +++++++++++++++++++++++---------
 upload-pack.h                           |   3 +
 5 files changed, 173 insertions(+), 39 deletions(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 4d5096dae..fedeb6b77 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -201,12 +201,42 @@ packet-lines:
 	to its base by position in pack rather than by an oid.  That is,
 	they can read OBJ_OFS_DELTA (ake type 6) in a packfile.
 
+    shallow <oid>
+	A client must notify the server of all objects for which it only
+	has shallow copies of (meaning that it doesn't have the parents
+	of a commit) by supplying a 'shallow <oid>' line for each such
+	object so that the serve is aware of the limitations of the
+	client's history.
+
+    deepen <depth>
+	Request that the fetch/clone should be shallow having a commit depth of
+	<depth> relative to the remote side.
+
+    deepen-relative
+	Requests that the semantics of the "deepen" command be changed
+	to indicate that the depth requested is relative to the clients
+	current shallow boundary, instead of relative to the remote
+	refs.
+
+    deepen-since <timestamp>
+	Requests that the shallow clone/fetch should be cut at a
+	specific time, instead of depth.  Internally it's equivalent of
+	doing "rev-list --max-age=<timestamp>". Cannot be used with
+	"deepen".
+
+    deepen-not <rev>
+	Requests that the shallow clone/fetch should be cut at a
+	specific revision specified by '<rev>', instead of a depth.
+	Internally it's equivalent of doing "rev-list --not <rev>".
+	Cannot be used with "deepen", but can be used with
+	"deepen-since".
+
 The response of `fetch` is broken into a number of sections separated by
 delimiter packets (0001), with each section beginning with its section
 header.
 
     output = *section
-    section = (acknowledgments | packfile)
+    section = (acknowledgments | shallow-info | packfile)
 	      (flush-pkt | delim-pkt)
 
     acknowledgments = PKT-LINE("acknowledgments" LF)
@@ -215,6 +245,11 @@ header.
     nak = PKT-LINE("NAK" LF)
     ack = PKT-LINE("ACK" SP obj-id LF)
 
+    shallow-info = PKT-LINE("shallow-info" LF)
+		   *PKT-LINE((shallow | unshallow) LF)
+    shallow = "shallow" SP obj-id
+    unshallow = "unshallow" SP obj-id
+
     packfile = PKT-LINE("packfile" LF)
 	       [PACKFILE]
 
@@ -247,6 +282,36 @@ header.
 	  determined the objects it plans to send to the client and no
 	  further negotiation is needed.
 
+----
+    shallow-info section
+	If the client has requested a shallow fetch/clone, a shallow
+	client requests a fetch or the server is shallow then the
+	server's response may include a shallow-info section.  The
+	shallow-info section will be include if (due to one of the above
+	conditions) the server needs to inform the client of any shallow
+	boundaries or adjustments to the clients already existing
+	shallow boundaries.
+
+	* Always begins with the section header "shallow-info"
+
+	* If a positive depth is requested, the server will compute the
+	  set of commits which are no deeper than the desired depth.
+
+	* The server sends a "shallow obj-id" line for each commit whose
+	  parents will not be sent in the following packfile.
+
+	* The server sends an "unshallow obj-id" line for each commit
+	  which the client has indicated is shallow, but is no longer
+	  shallow as a result of the fetch (due to its parents being
+	  sent in the following packfile).
+
+	* The server MUST NOT send any "unshallow" lines for anything
+	  which the client has not indicated was shallow as a part of
+	  its request.
+
+	* This section is only included if a packfile section is also
+	  included in the response.
+
 ----
     packfile section
 	* Always begins with the section header "packfile"
diff --git a/serve.c b/serve.c
index 05cc434cf..c3e58c1e7 100644
--- a/serve.c
+++ b/serve.c
@@ -53,7 +53,7 @@ struct protocol_capability {
 static struct protocol_capability capabilities[] = {
 	{ "agent", agent_advertise, NULL },
 	{ "ls-refs", always_advertise, ls_refs },
-	{ "fetch", always_advertise, upload_pack_v2 },
+	{ "fetch", upload_pack_advertise, upload_pack_v2 },
 };
 
 static void advertise_capabilities(void)
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 202cb782d..491adc693 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -9,7 +9,7 @@ test_expect_success 'test capability advertisement' '
 	version 2
 	agent=git/$(git version | cut -d" " -f3)
 	ls-refs
-	fetch
+	fetch=shallow
 	0000
 	EOF
 
diff --git a/upload-pack.c b/upload-pack.c
index c6518a24d..a7e4f9e9c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -710,7 +710,6 @@ static void deepen(int depth, int deepen_relative,
 	}
 
 	send_unshallow(shallows);
-	packet_flush(1);
 }
 
 static void deepen_by_rev_list(int ac, const char **av,
@@ -722,7 +721,52 @@ static void deepen_by_rev_list(int ac, const char **av,
 	send_shallow(result);
 	free_commit_list(result);
 	send_unshallow(shallows);
-	packet_flush(1);
+}
+
+static int send_shallow_list(int depth, int deepen_rev_list,
+			     timestamp_t deepen_since,
+			     struct string_list *deepen_not,
+			     struct object_array *shallows)
+{
+	int ret = 0;
+
+	if (depth > 0 && deepen_rev_list)
+		die("git upload-pack: deepen and deepen-since (or deepen-not) cannot be used together");
+	if (depth > 0) {
+		deepen(depth, deepen_relative, shallows);
+		ret = 1;
+	} else if (deepen_rev_list) {
+		struct argv_array av = ARGV_ARRAY_INIT;
+		int i;
+
+		argv_array_push(&av, "rev-list");
+		if (deepen_since)
+			argv_array_pushf(&av, "--max-age=%"PRItime, deepen_since);
+		if (deepen_not->nr) {
+			argv_array_push(&av, "--not");
+			for (i = 0; i < deepen_not->nr; i++) {
+				struct string_list_item *s = deepen_not->items + i;
+				argv_array_push(&av, s->string);
+			}
+			argv_array_push(&av, "--not");
+		}
+		for (i = 0; i < want_obj.nr; i++) {
+			struct object *o = want_obj.objects[i].item;
+			argv_array_push(&av, oid_to_hex(&o->oid));
+		}
+		deepen_by_rev_list(av.argc, av.argv, shallows);
+		argv_array_clear(&av);
+		ret = 1;
+	} else {
+		if (shallows->nr > 0) {
+			int i;
+			for (i = 0; i < shallows->nr; i++)
+				register_shallow(&shallows->objects[i].item->oid);
+		}
+	}
+
+	shallow_nr += shallows->nr;
+	return ret;
 }
 
 static int process_shallow(const char *line, struct object_array *shallows)
@@ -884,40 +928,10 @@ static void receive_needs(void)
 
 	if (depth == 0 && !deepen_rev_list && shallows.nr == 0)
 		return;
-	if (depth > 0 && deepen_rev_list)
-		die("git upload-pack: deepen and deepen-since (or deepen-not) cannot be used together");
-	if (depth > 0)
-		deepen(depth, deepen_relative, &shallows);
-	else if (deepen_rev_list) {
-		struct argv_array av = ARGV_ARRAY_INIT;
-		int i;
 
-		argv_array_push(&av, "rev-list");
-		if (deepen_since)
-			argv_array_pushf(&av, "--max-age=%"PRItime, deepen_since);
-		if (deepen_not.nr) {
-			argv_array_push(&av, "--not");
-			for (i = 0; i < deepen_not.nr; i++) {
-				struct string_list_item *s = deepen_not.items + i;
-				argv_array_push(&av, s->string);
-			}
-			argv_array_push(&av, "--not");
-		}
-		for (i = 0; i < want_obj.nr; i++) {
-			struct object *o = want_obj.objects[i].item;
-			argv_array_push(&av, oid_to_hex(&o->oid));
-		}
-		deepen_by_rev_list(av.argc, av.argv, &shallows);
-		argv_array_clear(&av);
-	}
-	else
-		if (shallows.nr > 0) {
-			int i;
-			for (i = 0; i < shallows.nr; i++)
-				register_shallow(&shallows.objects[i].item->oid);
-		}
-
-	shallow_nr += shallows.nr;
+	if (send_shallow_list(depth, deepen_rev_list, deepen_since,
+			      &deepen_not, &shallows))
+		packet_flush(1);
 	object_array_clear(&shallows);
 }
 
@@ -1071,6 +1085,13 @@ struct upload_pack_data {
 	struct object_array wants;
 	struct oid_array haves;
 
+	struct object_array shallows;
+	struct string_list deepen_not;
+	int depth;
+	timestamp_t deepen_since;
+	int deepen_rev_list;
+	int deepen_relative;
+
 	unsigned stateless_rpc : 1;
 
 	unsigned use_thin_pack : 1;
@@ -1080,12 +1101,14 @@ struct upload_pack_data {
 	unsigned done : 1;
 };
 
-#define UPLOAD_PACK_DATA_INIT { OBJECT_ARRAY_INIT, OID_ARRAY_INIT, 0, 0, 0, 0, 0, 0 }
+#define UPLOAD_PACK_DATA_INIT { OBJECT_ARRAY_INIT, OID_ARRAY_INIT, OBJECT_ARRAY_INIT, STRING_LIST_INIT_DUP, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
 
 static void upload_pack_data_clear(struct upload_pack_data *data)
 {
 	object_array_clear(&data->wants);
 	oid_array_clear(&data->haves);
+	object_array_clear(&data->shallows);
+	string_list_clear(&data->deepen_not, 0);
 }
 
 static int parse_want(const char *line)
@@ -1170,6 +1193,22 @@ static void process_args(struct argv_array *args, struct upload_pack_data *data)
 			continue;
 		}
 
+		/* Shallow related arguments */
+		if (process_shallow(arg, &data->shallows))
+			continue;
+		if (process_deepen(arg, &data->depth))
+			continue;
+		if (process_deepen_since(arg, &data->deepen_since,
+					 &data->deepen_rev_list))
+			continue;
+		if (process_deepen_not(arg, &data->deepen_not,
+				       &data->deepen_rev_list))
+			continue;
+		if (!strcmp(arg, "deepen-relative")) {
+			data->deepen_relative = 1;
+			continue;
+		}
+
 		/* ignore unknown lines maybe? */
 		die("unexpect line: '%s'", arg);
 	}
@@ -1284,6 +1323,23 @@ static int process_haves_and_send_acks(struct upload_pack_data *data)
 	return ret;
 }
 
+static void send_shallow_info(struct upload_pack_data *data)
+{
+	/* No shallow info needs to be sent */
+	if (!data->depth && !data->deepen_rev_list && !data->shallows.nr &&
+	    !is_repository_shallow())
+		return;
+
+	packet_write_fmt(1, "shallow-info\n");
+
+	if (!send_shallow_list(data->depth, data->deepen_rev_list,
+			       data->deepen_since, &data->deepen_not,
+			       &data->shallows) && is_repository_shallow())
+		deepen(INFINITE_DEPTH, data->deepen_relative, &data->shallows);
+
+	packet_delim(1);
+}
+
 enum fetch_state {
 	FETCH_PROCESS_ARGS = 0,
 	FETCH_READ_HAVES,
@@ -1334,6 +1390,8 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 				state = FETCH_DONE;
 			break;
 		case FETCH_SEND_PACK:
+			send_shallow_info(&data);
+
 			packet_write_fmt(1, "packfile\n");
 			create_pack_file();
 			state = FETCH_DONE;
@@ -1346,3 +1404,11 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 	upload_pack_data_clear(&data);
 	return 0;
 }
+
+int upload_pack_advertise(struct repository *r,
+			  struct strbuf *value)
+{
+	if (value)
+		strbuf_addstr(value, "shallow");
+	return 1;
+}
diff --git a/upload-pack.h b/upload-pack.h
index 6b7890238..7720f2142 100644
--- a/upload-pack.h
+++ b/upload-pack.h
@@ -14,5 +14,8 @@ struct repository;
 struct argv_array;
 extern int upload_pack_v2(struct repository *r, struct argv_array *keys,
 			  struct argv_array *args);
+struct strbuf;
+extern int upload_pack_advertise(struct repository *r,
+				 struct strbuf *value);
 
 #endif /* UPLOAD_PACK_H */
-- 
2.16.0.rc1.238.g530d649a79-goog

