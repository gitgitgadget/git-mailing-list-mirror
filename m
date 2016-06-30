Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B14C20FCF
	for <e@80x24.org>; Thu, 30 Jun 2016 01:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbcF3BIX (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 21:08:23 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34611 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbcF3BIW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 21:08:22 -0400
Received: by mail-pf0-f170.google.com with SMTP id h14so23379429pfe.1
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 18:08:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tWAqsU5Tt6tyJ7DyR9RnoRDeL900XJyxT+cuzpRsACc=;
        b=XrrbE9pDsk/MvzTB/R1aFlHSHuuWTWDPPLeOmn0U/C/HfjzIVQMUouhWY2DI6x4QqP
         z38JVGikjUvzhUs9u7oKarhvpefeyLiQpQmGIsrC+USxZ/p6Tyc6ATw/RNyTOzEts8Bf
         jnrG2ZYvJgOtOksaQtnPFt+zdP5zg9UzZSYNXaYB0sjmEit6EouoLKXkL9Aagtv3V/C9
         gPvzghX0dZaA51DL5P976fI7gquL1ZrssgtmqKoT/tZEv3uMR1jH1yr3NtZEJe/arhFT
         4cpT6h87wh39jckN4WKV2u6S8nktNy6w1TMwh2ZKbW9qwRcK9Ioa3NhW/oTxIvmonZCU
         y5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tWAqsU5Tt6tyJ7DyR9RnoRDeL900XJyxT+cuzpRsACc=;
        b=JgT/0DUvxwFORyhSQU/PnsB/DgBZzb8a41K4Yzi+C4ib2xdyiXTR11gmHpZ76OC5sD
         MqNZzfxmtXFfHiWD4B1ENErxz1xNla+qlpUzRyvfNOXb3W8Ow7bcvg4I8hrkVyRtpigF
         JEo7ONdgyeZrRSNLFAA4+qJZjMd3L1qKnxF7ZuD/sL2qTGcRQlqYeTBZQRyuis8GbTQo
         40zrP7dAEj6BWQgqqQ9O5EP1D+9nI0/p6fKzV80IHGEuUZ1VXhE/acBZLQZovh6hOR4I
         63TxUIh1Q8cO2TBT/Q4n7v6CUX4n+xagWLYpReqeckklHR8Nw0FEddyiAg3d9bkH1NXF
         +Dzw==
X-Gm-Message-State: ALyK8tJ+ldj2yt4HHmvKtuJuVIewmr07RTqW+afG8B3AQHMaANRw7L/AVF1YW5BvO79cl5sB
X-Received: by 10.98.23.20 with SMTP id 20mr16785858pfx.96.1467248413680;
        Wed, 29 Jun 2016 18:00:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4c6d:bc1b:299f:eb0])
        by smtp.gmail.com with ESMTPSA id z88sm713202pfa.59.2016.06.29.18.00.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 29 Jun 2016 18:00:13 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	git@vger.kernel.org, dwwang@google.com
Cc:	Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/4] receive-pack: implement advertising and receiving push options
Date:	Wed, 29 Jun 2016 17:59:49 -0700
Message-Id: <20160630005951.7408-3-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.141.gdd65b60
In-Reply-To: <20160630005951.7408-1-sbeller@google.com>
References: <20160630005951.7408-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The pre/post receive hook may be interested in more information from the
user. This information can be transmitted when both client and server
support the "push-options" capability, which when used is a phase directly
after update commands ended by a flush pkt.

Similar to the atomic option, the server capability can be disabled via
the `receive.advertisePushOptions` config variable. While documenting
this, fix a nit in the `receive.advertiseAtomic` wording.

For now we only accept C strings with no new lines.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt                          |  7 +++-
 Documentation/technical/pack-protocol.txt         | 10 +++---
 Documentation/technical/protocol-capabilities.txt |  8 +++++
 builtin/receive-pack.c                            | 44 +++++++++++++++++++++++
 4 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 626243f..3b199f9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2410,7 +2410,12 @@ rebase.instructionFormat
 
 receive.advertiseAtomic::
 	By default, git-receive-pack will advertise the atomic push
-	capability to its clients. If you don't want to this capability
+	capability to its clients. If you don't want this capability
+	to be advertised, set this variable to false.
+
+receive.advertisePushOptions::
+	By default, git-receive-pack will advertise the push options capability
+	to its clients. If you don't want this capability
 	to be advertised, set this variable to false.
 
 receive.autogc::
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 8b36343..7a2ed30 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -454,7 +454,8 @@ The reference discovery phase is done nearly the same way as it is in the
 fetching protocol. Each reference obj-id and name on the server is sent
 in packet-line format to the client, followed by a flush-pkt.  The only
 real difference is that the capability listing is different - the only
-possible values are 'report-status', 'delete-refs' and 'ofs-delta'.
+possible values are 'report-status', 'delete-refs', 'ofs-delta' and
+'push-options'.
 
 Reference Update Request and Packfile Transfer
 ----------------------------------------------
@@ -465,9 +466,10 @@ that it wants to update, it sends a line listing the obj-id currently on
 the server, the obj-id the client would like to update it to and the name
 of the reference.
 
-This list is followed by a flush-pkt and then the packfile that should
-contain all the objects that the server will need to complete the new
-references.
+This list is followed by a flush-pkt. Then the push options are transmitted
+one per packet followed by another flush-pkt. After that the packfile that
+should contain all the objects that the server will need to complete the new
+references will be sent.
 
 ----
   update-request    =  *shallow ( command-list | push-cert ) [packfile]
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index eaab6b4..b71eda9 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -253,6 +253,14 @@ atomic pushes. If the pushing client requests this capability, the server
 will update the refs in one atomic transaction. Either all refs are
 updated or none.
 
+push-options
+------------
+
+If the server sends the 'push-options' capability it is capable to accept
+push options after the update commands have been sent. If the pushing client
+requests this capability, the server will pass the options to the pre and post
+receive hooks that process this push request.
+
 allow-tip-sha1-in-want
 ----------------------
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 0da6852..68627ed 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -44,10 +44,12 @@ static struct strbuf fsck_msg_types = STRBUF_INIT;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int advertise_atomic_push = 1;
+static int advertise_push_options = 1;
 static int unpack_limit = 100;
 static int report_status;
 static int use_sideband;
 static int use_atomic;
+static int use_push_options;
 static int quiet;
 static int prefer_ofs_delta = 1;
 static int auto_update_server_info;
@@ -193,6 +195,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.advertisepushoptions") == 0) {
+		advertise_push_options = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -207,6 +214,8 @@ static void show_ref(const char *path, const unsigned char *sha1)
 			      "report-status delete-refs side-band-64k quiet");
 		if (advertise_atomic_push)
 			strbuf_addstr(&cap, " atomic");
+		if (advertise_push_options)
+			strbuf_addstr(&cap, " push-options");
 		if (prefer_ofs_delta)
 			strbuf_addstr(&cap, " ofs-delta");
 		if (push_cert_nonce)
@@ -1448,6 +1457,9 @@ static struct command *read_head_info(struct sha1_array *shallow)
 			if (advertise_atomic_push
 			    && parse_feature_request(feature_list, "atomic"))
 				use_atomic = 1;
+			if (advertise_push_options
+			    && parse_feature_request(feature_list, "push-options"))
+				use_push_options = 1;
 		}
 
 		if (!strcmp(line, "push-cert")) {
@@ -1480,6 +1492,35 @@ static struct command *read_head_info(struct sha1_array *shallow)
 	return commands;
 }
 
+static const char *stream_push_options_to_file()
+{
+	static const char *fname = "push-options-XXXXXX";
+	char *ret = xmallocz(strlen(fname));
+	int fd;
+	memcpy(ret, fname, strlen(fname));
+	fd = mkstemp(ret);
+
+	for (;;) {
+		char *line;
+		int len;
+
+		line = packet_read_line(0, &len);
+
+		if (!line)
+			break;
+
+		if (write_in_full(fd, line, len) < 0 ||
+		    write_in_full(fd, "\n", 1) < 0)
+			goto fail;
+	}
+
+	return ret;
+fail:
+	close(fd);
+	free(ret);
+	return NULL;
+}
+
 static const char *parse_pack_header(struct pack_header *hdr)
 {
 	switch (read_pack_header(0, hdr)) {
@@ -1767,6 +1808,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		const char *unpack_status = NULL;
 		const char *push_options_file = NULL;
 
+		if (use_push_options)
+			push_options_file = stream_push_options_to_file();
+
 		prepare_shallow_info(&si, &shallow);
 		if (!si.nr_ours && !si.nr_theirs)
 			shallow_update = 0;
-- 
2.9.0.141.gdd65b60

