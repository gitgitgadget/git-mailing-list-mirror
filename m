Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B9442070F
	for <e@80x24.org>; Thu,  7 Jul 2016 01:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbcGGBMo (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 21:12:44 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35847 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbcGGBMn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 21:12:43 -0400
Received: by mail-pa0-f41.google.com with SMTP id uj8so1257880pab.3
        for <git@vger.kernel.org>; Wed, 06 Jul 2016 18:12:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hy/KzoLf7GNTRGjyv+Q0jjw9t1sbcbDrp6v2gJ1oIJw=;
        b=QzQiuicKeiiu0R7z0O31CUjQE7Z3lDfian9pyEeO+o+cprzf5RCJ2izckQoIKvKI2c
         gJ/3lLbTWl7ZkprNa+2qEKLTS/Q/ne4NtdvAFbQyv0UNPP7GHFHBVFzc3R2MA861Chbm
         r1m2pfGMQb+snTluX01p/BBN1YNPoLzvlSwJcr3Xgd3tciSWo0KQD74sZCTit83baBYm
         6D6PZwCaVbfpBfF9qkfAEdbWHXqbM9tBL512yACB/umBBer6sOSFKM6Y7J6twRhPakmL
         YffwubxbgbiZYB76vzKkMPeXo5Z4whifmD8M/SmdMT993oxbDhsMyk7KZ2JPYMeXKe1/
         A0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hy/KzoLf7GNTRGjyv+Q0jjw9t1sbcbDrp6v2gJ1oIJw=;
        b=keYPAZ59WEM7aS2h8Oy/XGjb6oSIRePAZ83WY+7EQbiYY5DmKXzKPfRAE/qm/1v5+r
         GNeb7dTH2zwEGHDKmCv+x0bsF+z6X3hBUN3+0QyqRCvWNzfT4QSScsBcEXotD9inzpWo
         Sd8dpwRhWG30qtHAQsynT6t6WQc1bFm3KIrZL95gVPd1XiYZYcrlYDHsA8B309r5X863
         tYFk9tQDtnQurqjWp6mOxOieWdpkMg36IA8cHXf/Fr6MCw0JdJgng3K6NygUeIwpU/sg
         lHV7/+AZFGfJreyTTQhJlCo8Oo22P4+yhLDsXv+2109NilbLdrytEjTl1mVVrbWzAZ9W
         pQRw==
X-Gm-Message-State: ALyK8tLjvVFlnSQO36DeXloL7VbvUWeSewiymvM0NnS3Z7gb02ojxB2UR1rfEcYsrpoFo5Cl
X-Received: by 10.66.134.52 with SMTP id ph20mr19377093pab.72.1467853962432;
        Wed, 06 Jul 2016 18:12:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:7518:e836:5c9c:93dd])
        by smtp.gmail.com with ESMTPSA id jh3sm307855pac.14.2016.07.06.18.12.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 06 Jul 2016 18:12:41 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, e@80x24.org, peff@peff.net, dwwang@google.com,
	dennis@kaarsemaker.net, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/4] receive-pack: implement advertising and receiving push options
Date:	Wed,  6 Jul 2016 18:12:16 -0700
Message-Id: <20160707011218.3690-3-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.141.gd59d3e9.dirty
In-Reply-To: <20160707011218.3690-1-sbeller@google.com>
References: <20160707011218.3690-1-sbeller@google.com>
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

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt                          |  7 ++-
 Documentation/technical/pack-protocol.txt         | 10 ++--
 Documentation/technical/protocol-capabilities.txt |  8 +++
 builtin/receive-pack.c                            | 59 +++++++++++++++++++++++
 4 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e208af1..df1b314 100644
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
index edbf81e..e71041a 100644
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
@@ -1454,6 +1463,9 @@ static struct command *read_head_info(struct sha1_array *shallow)
 			if (advertise_atomic_push
 			    && parse_feature_request(feature_list, "atomic"))
 				use_atomic = 1;
+			if (advertise_push_options
+			    && parse_feature_request(feature_list, "push-options"))
+				use_push_options = 1;
 		}
 
 		if (!strcmp(line, "push-cert")) {
@@ -1486,6 +1498,50 @@ static struct command *read_head_info(struct sha1_array *shallow)
 	return commands;
 }
 
+static struct string_list *read_push_options()
+{
+	int i;
+	struct string_list *ret = xmalloc(sizeof(*ret));
+	string_list_init(ret, 1);
+
+	/* NEEDSWORK: expose the limitations to be configurable. */
+	int max_options = 32;
+
+	/*
+	 * NEEDSWORK: expose the limitations to be configurable;
+	 * Once the limit can be lifted, include a way for payloads
+	 * larger than one pkt, e.g allow a payload of up to
+	 * LARGE_PACKET_MAX - 1 only, and reserve the last byte
+	 * to indicate whether the next pkt continues with this
+	 * push option.
+	 */
+	int max_size = 1024;
+
+	for (i = 0; i < max_options; i++) {
+		char *line;
+		int len;
+
+		line = packet_read_line(0, &len);
+
+		if (!line)
+			break;
+
+		if (len > max_size)
+			die("protocol error: server configuration allows push "
+			    "options of size up to %d bytes", max_size);
+
+		len = strcspn(line, "\n");
+		line[len] = '\0';
+
+		string_list_append(ret, line);
+	}
+	if (i == max_options)
+		die("protocol error: server configuration only allows up "
+		    "to %d push options", max_options);
+
+	return ret;
+}
+
 static const char *parse_pack_header(struct pack_header *hdr)
 {
 	switch (read_pack_header(0, hdr)) {
@@ -1773,6 +1829,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		const char *unpack_status = NULL;
 		struct string_list *push_options = NULL;
 
+		if (use_push_options)
+			push_options = read_push_options();
+
 		prepare_shallow_info(&si, &shallow);
 		if (!si.nr_ours && !si.nr_theirs)
 			shallow_update = 0;
-- 
2.9.0.141.gd59d3e9.dirty

