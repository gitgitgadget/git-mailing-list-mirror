Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA5AC43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 08:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F24320714
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 08:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgC0IDj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:03:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:53270 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726027AbgC0IDj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 04:03:39 -0400
Received: (qmail 9382 invoked by uid 109); 27 Mar 2020 08:03:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 27 Mar 2020 08:03:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23041 invoked by uid 111); 27 Mar 2020 08:13:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Mar 2020 04:13:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 27 Mar 2020 04:03:38 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] upload-pack: handle unexpected delim packets
Message-ID: <20200327080338.GB605934@coredump.intra.peff.net>
References: <20200327080210.GA604725@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200327080210.GA604725@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When processing the arguments list for a v2 ls-refs or fetch command, we
loop like this:

  while (packet_reader_read(request) != PACKET_READ_FLUSH) {
          const char *arg = request->line;
	  ...handle arg...
  }

to read and handle packets until we see a flush. The hidden assumption
here is that anything except PACKET_READ_FLUSH will give us valid packet
data to read. But that's not true; PACKET_READ_DELIM or PACKET_READ_EOF
will leave packet->line as NULL, and we'll segfault trying to look at
it.

Instead, we should follow the more careful model demonstrated on the
client side (e.g., in process_capabilities_v2): keep looping as long
as we get normal packets, and then make sure that we broke out of the
loop due to a real flush. That fixes the segfault and correctly
diagnoses any unexpected input from the client.

Signed-off-by: Jeff King <peff@peff.net>
---
 ls-refs.c                      |  5 ++++-
 t/t5704-protocol-violations.sh | 33 +++++++++++++++++++++++++++++++++
 upload-pack.c                  |  5 ++++-
 3 files changed, 41 insertions(+), 2 deletions(-)
 create mode 100755 t/t5704-protocol-violations.sh

diff --git a/ls-refs.c b/ls-refs.c
index 818aef70a0..50d86866c6 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -93,7 +93,7 @@ int ls_refs(struct repository *r, struct argv_array *keys,
 
 	git_config(ls_refs_config, NULL);
 
-	while (packet_reader_read(request) != PACKET_READ_FLUSH) {
+	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
 		const char *arg = request->line;
 		const char *out;
 
@@ -105,6 +105,9 @@ int ls_refs(struct repository *r, struct argv_array *keys,
 			argv_array_push(&data.prefixes, out);
 	}
 
+	if (request->status != PACKET_READ_FLUSH)
+		die(_("expected flush after ls-refs arguments"));
+
 	head_ref_namespaced(send_ref, &data);
 	for_each_namespaced_ref(send_ref, &data);
 	packet_flush(1);
diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
new file mode 100755
index 0000000000..950cfb21fe
--- /dev/null
+++ b/t/t5704-protocol-violations.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+test_description='Test responses to violations of the network protocol. In most
+of these cases it will generally be acceptable for one side to break off
+communications if the other side says something unexpected. We are mostly
+making sure that we do not segfault or otherwise behave badly.'
+. ./test-lib.sh
+
+test_expect_success 'extra delim packet in v2 ls-refs args' '
+	{
+		packetize command=ls-refs &&
+		printf 0001 &&
+		# protocol expects 0000 flush here
+		printf 0001
+	} >input &&
+	test_must_fail env GIT_PROTOCOL=version=2 \
+		git upload-pack . <input 2>err &&
+	test_i18ngrep "expected flush after ls-refs arguments" err
+'
+
+test_expect_success 'extra delim packet in v2 fetch args' '
+	{
+		packetize command=fetch &&
+		printf 0001 &&
+		# protocol expects 0000 flush here
+		printf 0001
+	} >input &&
+	test_must_fail env GIT_PROTOCOL=version=2 \
+		git upload-pack . <input 2>err &&
+	test_i18ngrep "expected flush after fetch arguments" err
+'
+
+test_done
diff --git a/upload-pack.c b/upload-pack.c
index c53249cac1..902d0ad5e1 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1252,7 +1252,7 @@ static void process_args(struct packet_reader *request,
 			 struct upload_pack_data *data,
 			 struct object_array *want_obj)
 {
-	while (packet_reader_read(request) != PACKET_READ_FLUSH) {
+	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
 		const char *arg = request->line;
 		const char *p;
 
@@ -1321,6 +1321,9 @@ static void process_args(struct packet_reader *request,
 		/* ignore unknown lines maybe? */
 		die("unexpected line: '%s'", arg);
 	}
+
+	if (request->status != PACKET_READ_FLUSH)
+		die(_("expected flush after fetch arguments"));
 }
 
 static int process_haves(struct oid_array *haves, struct oid_array *common,
-- 
2.26.0.581.g322f77c0ee
