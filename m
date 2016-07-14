Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 185D5203BD
	for <e@80x24.org>; Thu, 14 Jul 2016 21:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbcGNVuC (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 17:50:02 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34466 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbcGNVt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 17:49:57 -0400
Received: by mail-pa0-f54.google.com with SMTP id fi15so32219830pac.1
        for <git@vger.kernel.org>; Thu, 14 Jul 2016 14:49:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I3Okhri3tw25UdOdwoCvxnyGJcdYg9q68dVjdIXnZfU=;
        b=NBJDUx30cXlMZze5HnzLGsKsOGFAJthrVhlF0PwaSeYubCaL8qVgdsqWFS5NU+CFvy
         YrGPZDiJy+n4+XLuPkMbJ/2hGdhcCsgL0XIu9EDgu1IYe+eyGQmdbqKOfoHjq0X4IN8L
         H2Ti18+AtZTYYfbMMWLqdRmu/soIzPvJbT6tLXGa7ekLF8EgMN5EAcsuNhApkF9le1VN
         lgvBNFZk3dl6kTU9Fipjsq8Cea7w6y4RARLOv5OL4cXDEyMhX3xNYfv8Ohai0jjMYaNT
         dE8nI7j3TE4s5pDT+g9lCAsDm+5Cg75mxudFaLSPDvRHtHRhj43UqfcU1NFfiw078KP1
         S8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I3Okhri3tw25UdOdwoCvxnyGJcdYg9q68dVjdIXnZfU=;
        b=KsGfSRKTqrd+tLaSQkCt7whlgefLaVbre6/LqOPzWS/sBNos781jWnQgSDRTSVCVBw
         ULFaKxSCJ+TOY3oSuD7Spucr3/YKbKoUjWuzwXoydQ8li/HbqPMWmYH9j/ZqEV2Gfywn
         HVNXzyt6FUCSlgU/kQoEMe/dQQ9HyGcwolUXlQWMIHZMO+8J+U8BfKexkFyHPLkOIqaH
         Yik+A1lqekwZ5NfAbitWhZXsYKNOgKXUpcnJkBz2wSL+QejxJD8veh/FD0v2Ykr4JJ3Y
         Wg9OEv35VSt40flpBPjIfmIVNir5wVqQX+RrwpmZRlTDunHssRypzge0lyza0f2ZyuDQ
         JOHA==
X-Gm-Message-State: ALyK8tLqfZeOjicHVI0qQqHW5e3hHfDvr6U9nZJZ18ippCM51SSMVx6TYEr4yOR2bkGHMjn5
X-Received: by 10.66.242.201 with SMTP id ws9mr26261500pac.7.1468532995957;
        Thu, 14 Jul 2016 14:49:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c041:4809:7eab:7652])
        by smtp.gmail.com with ESMTPSA id 75sm6910163pfw.92.2016.07.14.14.49.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 14 Jul 2016 14:49:55 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	git@vger.kernel.org, gitster@pobox.com
Cc:	dwwang@google.com, e@80x24.org, peff@peff.net,
	dennis@kaarsemaker.net, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/4] receive-pack: implement advertising and receiving push options
Date:	Thu, 14 Jul 2016 14:49:46 -0700
Message-Id: <20160714214948.27432-3-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.247.gf748855.dirty
In-Reply-To: <20160714214948.27432-1-sbeller@google.com>
References: <20160714214948.27432-1-sbeller@google.com>
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
 Documentation/config.txt                          |  9 +++++--
 Documentation/technical/pack-protocol.txt         | 10 +++++---
 Documentation/technical/protocol-capabilities.txt |  9 +++++++
 builtin/receive-pack.c                            | 30 +++++++++++++++++++++++
 4 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 16dc22d..0bb6daa 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2417,8 +2417,13 @@ rebase.instructionFormat
 
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
index 6cdd2c6..3c9360a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -44,10 +44,12 @@ static struct strbuf fsck_msg_types = STRBUF_INIT;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int advertise_atomic_push = 1;
+static int advertise_push_options;
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
@@ -1487,6 +1499,21 @@ static struct command *read_head_info(struct sha1_array *shallow)
 	return commands;
 }
 
+static void read_push_options(struct string_list *options)
+{
+	while (1) {
+		char *line;
+		int len;
+
+		line = packet_read_line(0, &len);
+
+		if (!line)
+			break;
+
+		string_list_append(options, line);
+	}
+}
+
 static const char *parse_pack_header(struct pack_header *hdr)
 {
 	switch (read_pack_header(0, hdr)) {
@@ -1774,6 +1801,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		const char *unpack_status = NULL;
 		struct string_list push_options = STRING_LIST_INIT_DUP;
 
+		if (use_push_options)
+			read_push_options(&push_options);
+
 		prepare_shallow_info(&si, &shallow);
 		if (!si.nr_ours && !si.nr_theirs)
 			shallow_update = 0;
-- 
2.9.0.247.gf748855.dirty

