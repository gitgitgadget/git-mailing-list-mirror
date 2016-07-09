Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 500121F744
	for <e@80x24.org>; Sat,  9 Jul 2016 00:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbcGIAbm (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 20:31:42 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33127 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756318AbcGIAbe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 20:31:34 -0400
Received: by mail-pa0-f45.google.com with SMTP id b13so16651492pat.0
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 17:31:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nwaad7beoYhVH7mB72B/SUdGA1ECMUm11Sd+/FPXmB4=;
        b=kRf0aCIqtw8c6j+biTo8//l+gHqMisZkkxcWcioCBMtkDNpFtL6ODZD16jxkorpPQF
         aD/tK5uA1GjEROths743y5Hoo8jPKO+/QYSk8/En2HQX+tycKt57F1wBjjreDaWP34k3
         J5cJpsxSKXTEVVC6rDUBjHsc68JJJaJnNxVmzDYcw4V/t9IbF8uggFDNW6aqWAfefgI5
         wMxmWu/Z+yfw2WPtV9Rcn/qZGb3QGtwngyRWEI0/tASMRfYJjFOg28YYaScz58r/gHKA
         F6ETImeTBJsGa3luKUcKSqQrOlcAKk7Q5iZOxgaiqqhLf5NY806j+dPjbu0NpQ7qOMOC
         Jutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nwaad7beoYhVH7mB72B/SUdGA1ECMUm11Sd+/FPXmB4=;
        b=K9ma/Tamdx2ep6E+YHcPxSWgXuqWaEKHylHDFRQLX4BvF/Kzs6mq/16lYBBHuXLx1n
         P/1fkWgMQYPhFlgXgi0ZruJIl8zy1AdAC9Kq2uVOP0tQmx9No5wj07FnT1gjPZMRmEv1
         95OEV+mRzRsvDrvtBKji4vTKqPfwo4ADlMhQZBl9+tcACBscXOJsnF7bhP96CqD5sfEI
         QldsrME615X/Vh8bpe1BgWjzb98tBiehnMbpp6mkxeckuW6EwG1HxqPutv50kCVt160Y
         3O8reP/Nb3x2DDIjOS/PtgIJrGxWW8NYMLsqpPDI14QzWdQC+1HNjhpw7R/0Nv8QitQD
         fFVA==
X-Gm-Message-State: ALyK8tJBBqJg+nmrUkAt0e8uZNw1jey3/mx+dThSwUH8WYgKby6tg+3yzU+0JdebDnWdmjvz
X-Received: by 10.66.251.170 with SMTP id zl10mr14280069pac.25.1468024285758;
        Fri, 08 Jul 2016 17:31:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ccd7:b4ac:db99:b698])
        by smtp.gmail.com with ESMTPSA id 81sm6869004pfo.74.2016.07.08.17.31.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 08 Jul 2016 17:31:25 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, e@80x24.org, peff@peff.net, dwwang@google.com,
	dennis@kaarsemaker.net, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/4] receive-pack: implement advertising and receiving push options
Date:	Fri,  8 Jul 2016 17:31:11 -0700
Message-Id: <20160709003113.26930-3-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.247.g176c4f7
In-Reply-To: <20160709003113.26930-1-sbeller@google.com>
References: <20160709003113.26930-1-sbeller@google.com>
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
 Documentation/config.txt                          |  9 ++-
 Documentation/technical/pack-protocol.txt         | 10 ++--
 Documentation/technical/protocol-capabilities.txt |  9 +++
 builtin/receive-pack.c                            | 69 +++++++++++++++++++++++
 4 files changed, 91 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e208af1..25b5db1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2410,8 +2410,13 @@ rebase.instructionFormat
 
 receive.advertiseAtomic::
 	By default, git-receive-pack will advertise the atomic push
-	capability to its clients. If you don't want to this capability
-	to be advertised, set this variable to false.
+	capability to its clients. If you don't want to advertise this
+	capability, set this variable to false.
+
+receive.advertisePushOptions::
+	By default, git-receive-pack will advertise the push options
+	capability to its clients. If you don't want to advertise this
+	capability, set this variable to false.
 
 receive.autogc::
 	By default, git-receive-pack will run "git-gc --auto" after
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
index eaab6b4..4c28d3a 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -253,6 +253,15 @@ atomic pushes. If the pushing client requests this capability, the server
 will update the refs in one atomic transaction. Either all refs are
 updated or none.
 
+push-options
+------------
+
+If the server sends the 'push-options' capability it is able to accept
+push options after the update commands have been sent, but before the
+packfile is streamed. If the pushing client requests this capability,
+the server will pass the options to the pre- and post- receive hooks
+that process this push request.
+
 allow-tip-sha1-in-want
 ----------------------
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 236417e..754db6e 100644
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
 
@@ -211,6 +218,8 @@ static void show_ref(const char *path, const unsigned char *sha1)
 			strbuf_addstr(&cap, " ofs-delta");
 		if (push_cert_nonce)
 			strbuf_addf(&cap, " push-cert=%s", push_cert_nonce);
+		if (advertise_push_options)
+			strbuf_addstr(&cap, " push-options");
 		strbuf_addf(&cap, " agent=%s", git_user_agent_sanitized());
 		packet_write(1, "%s %s%c%s\n",
 			     sha1_to_hex(sha1), path, 0, cap.buf);
@@ -1455,6 +1464,9 @@ static struct command *read_head_info(struct sha1_array *shallow)
 			if (advertise_atomic_push
 			    && parse_feature_request(feature_list, "atomic"))
 				use_atomic = 1;
+			if (advertise_push_options
+			    && parse_feature_request(feature_list, "push-options"))
+				use_push_options = 1;
 		}
 
 		if (!strcmp(line, "push-cert")) {
@@ -1487,6 +1499,60 @@ static struct command *read_head_info(struct sha1_array *shallow)
 	return commands;
 }
 
+static struct string_list *read_push_options(void)
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
+		if (len > max_size) {
+			/*
+			 * NEEDSWORK: The error message in die(..) is not
+			 * transmitted in call cases, so ideally all die(..)
+			 * calls are prefixed with rp_error and then we can
+			 * combine rp_error && die into one helper function.
+			 */
+			rp_error("protocol error: server configuration allows push "
+				 "options of size up to %d bytes", max_size);
+			die("protocol error: push options too large");
+		}
+
+		len = strcspn(line, "\n");
+		line[len] = '\0';
+
+		string_list_append(ret, line);
+	}
+	if (i == max_options) {
+		rp_error("protocol error: server configuration only allows up "
+		    "to %d push options", max_options);
+		die("protocol error: push options too large");
+	}
+
+	return ret;
+}
+
 static const char *parse_pack_header(struct pack_header *hdr)
 {
 	switch (read_pack_header(0, hdr)) {
@@ -1774,6 +1840,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		const char *unpack_status = NULL;
 		struct string_list *push_options = NULL;
 
+		if (use_push_options)
+			push_options = read_push_options();
+
 		prepare_shallow_info(&si, &shallow);
 		if (!si.nr_ours && !si.nr_theirs)
 			shallow_update = 0;
-- 
2.9.0.247.g176c4f7

