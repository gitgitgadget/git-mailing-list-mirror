Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C4BE202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 20:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754437AbdCHUsF (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 15:48:05 -0500
Received: from siwi.pair.com ([209.68.5.199]:33308 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754358AbdCHUra (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 15:47:30 -0500
Received: from jeffhostetler.2jll4ugiwlvuzhh55dqabi0nia.bx.internal.cloudapp.net (unknown [40.76.14.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DFF8284611;
        Wed,  8 Mar 2017 13:51:01 -0500 (EST)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, peff@peff.net, gitster@pobox.com,
        markbt@efaref.net, benpeart@microsoft.com,
        jonathantanmy@google.com, Jeff Hostetler <git@jeffhostetler.com>
Subject: [PATCH 04/10] upload-pack: add partial (sparse) fetch
Date:   Wed,  8 Mar 2017 18:50:33 +0000
Message-Id: <1488999039-37631-5-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
References: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <git@jeffhostetler.com>

Teach upload-pack to advertise the "partial" capability
in the fetch-pack/upload-pack protocol header and to pass
the value of partial-by-size and partial-special on to
pack-objects.

Update protocol documentation.

This might be used in conjunction with a partial (sparse) clone
or fetch to omit various blobs from the generated packfile.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/pack-protocol.txt         | 14 ++++++++++
 Documentation/technical/protocol-capabilities.txt |  7 +++++
 upload-pack.c                                     | 32 ++++++++++++++++++++++-
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index c59ac99..0032729 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -212,6 +212,7 @@ out of what the server said it could do with the first 'want' line.
   upload-request    =  want-list
 		       *shallow-line
 		       *1depth-request
+		       *partial
 		       flush-pkt
 
   want-list         =  first-want
@@ -223,10 +224,15 @@ out of what the server said it could do with the first 'want' line.
 		       PKT-LINE("deepen-since" SP timestamp) /
 		       PKT-LINE("deepen-not" SP ref)
 
+  partial           =  PKT-LINE("partial-by-size" SP magnitude) /
+		       PKT-LINE("partial-special)  
+
   first-want        =  PKT-LINE("want" SP obj-id SP capability-list)
   additional-want   =  PKT-LINE("want" SP obj-id)
 
   depth             =  1*DIGIT
+
+  magnitude         =  1*DIGIT [ "k" | "m" | "g" ]
 ----
 
 Clients MUST send all the obj-ids it wants from the reference
@@ -249,6 +255,14 @@ complete those commits. Commits whose parents are not received as a
 result are defined as shallow and marked as such in the server. This
 information is sent back to the client in the next step.
 
+The client can optionally request a partial packfile that omits
+various blobs.  The value of "partial-by-size" is a non-negative
+integer with optional units and requests blobs smaller than this
+value.  The "partial-special" command requests git-special files,
+such as ".gitignore".  Using both requests the union of the two.
+These requests are only valid if the server advertises the "partial"
+capability.
+
 Once all the 'want's and 'shallow's (and optional 'deepen') are
 transferred, clients MUST send a flush-pkt, to tell the server side
 that it is done sending the list.
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 26dcc6f..9aa2123 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -309,3 +309,10 @@ to accept a signed push certificate, and asks the <nonce> to be
 included in the push certificate.  A send-pack client MUST NOT
 send a push-cert packet unless the receive-pack server advertises
 this capability.
+
+partial
+-------
+
+If the upload-pack server advertises this capability, fetch-pack
+may send various "partial-*" commands to request a partial clone
+or fetch where the server omits certain blobs from the packfile.
diff --git a/upload-pack.c b/upload-pack.c
index 7597ba3..74f9dfa 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -63,6 +63,11 @@ static int advertise_refs;
 static int stateless_rpc;
 static const char *pack_objects_hook;
 
+static struct strbuf partial_by_size = STRBUF_INIT;
+static int client_requested_partial_capability;
+static int have_partial_by_size;
+static int have_partial_special;
+
 static void reset_timeout(void)
 {
 	alarm(timeout);
@@ -130,6 +135,10 @@ static void create_pack_file(void)
 		argv_array_push(&pack_objects.args, "--delta-base-offset");
 	if (use_include_tag)
 		argv_array_push(&pack_objects.args, "--include-tag");
+	if (have_partial_by_size)
+		argv_array_push(&pack_objects.args, partial_by_size.buf);
+	if (have_partial_special)
+		argv_array_push(&pack_objects.args, "--partial-special");
 
 	pack_objects.in = -1;
 	pack_objects.out = -1;
@@ -793,6 +802,23 @@ static void receive_needs(void)
 			deepen_rev_list = 1;
 			continue;
 		}
+		if (skip_prefix(line, "partial-by-size ", &arg)) {
+			unsigned long s;
+			if (!client_requested_partial_capability)
+				die("git upload-pack: 'partial-by-size' option requires 'partial' capability");
+			if (!git_parse_ulong(arg, &s))
+				die("git upload-pack: invalid partial-by-size value: %s", line);
+			strbuf_addstr(&partial_by_size, "--partial-by-size=");
+			strbuf_addstr(&partial_by_size, arg);
+			have_partial_by_size = 1;
+			continue;
+		}
+		if (skip_prefix(line, "partial-special", &arg)) {
+			if (!client_requested_partial_capability)
+				die("git upload-pack: 'partial-special' option requires 'partial' capability");
+			have_partial_special = 1;
+			continue;
+		}
 		if (!skip_prefix(line, "want ", &arg) ||
 		    get_sha1_hex(arg, sha1_buf))
 			die("git upload-pack: protocol error, "
@@ -820,6 +846,8 @@ static void receive_needs(void)
 			no_progress = 1;
 		if (parse_feature_request(features, "include-tag"))
 			use_include_tag = 1;
+		if (parse_feature_request(features, "partial"))
+			client_requested_partial_capability = 1;
 
 		o = parse_object(sha1_buf);
 		if (!o)
@@ -924,7 +952,9 @@ static int send_ref(const char *refname, const struct object_id *oid,
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow deepen-since deepen-not"
-		" deepen-relative no-progress include-tag multi_ack_detailed";
+		" deepen-relative no-progress include-tag multi_ack_detailed"
+		" partial"
+		;
 	const char *refname_nons = strip_namespace(refname);
 	struct object_id peeled;
 
-- 
2.7.4

