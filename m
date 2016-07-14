Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E2C520196
	for <e@80x24.org>; Thu, 14 Jul 2016 21:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbcGNVZD (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 17:25:03 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33972 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbcGNVZA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 17:25:00 -0400
Received: by mail-pa0-f48.google.com with SMTP id fi15so32055052pac.1
        for <git@vger.kernel.org>; Thu, 14 Jul 2016 14:25:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=RMFaakAVvW9YPtWU/N1Ls+ySlBBGoljRBigVuHgo6VQ=;
        b=Bug4P5QaAYpfEmdyDbWAVEC3nDx6XuevI91YBeeWPPH5mx63Fa9GFLsyl3ALQbd5XF
         3Tb0CQdlCwJYa9Cz7N4abd7IMxd2FjhhGIejBQsBkAb1U7BKeCJT7GvnarF5mszEtdY+
         f4kLF2qicktFqr9PlcKNBPHKzqq+W9OG8P3lQna1rDlvvu5SA8M4wJNzBH0nj+W4le/1
         UePzmkVucZQ2BpkjbphhKdlUrAIhwMFGyzuptg6nK5U0Si1av612t+wlEUSFioGT3tOQ
         cgMFkEr/lj8sJOuD/3IHGGMpL4LCQ3BAB4CnTm9WnZZZ4iVx32PPUBnP0qFBbD6QvaRO
         Vbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RMFaakAVvW9YPtWU/N1Ls+ySlBBGoljRBigVuHgo6VQ=;
        b=B+w+AvPYrKUOdq7SvVmErKwFtUf3TBSAHkR8EoyPQQNdbhiLUW49v10kk1nph3B8u2
         a4JpHbYonH+99tP7WWlqhkrjLtlUiiV8pE+GD5Lkb4nDp/qJSe4IeBLO31WVTcoWtcQM
         IyLlJrHJXpu9UFhUtiDODemXDLoCBHqtrejceKsnCdtgKptCPH6PCF2NvFWzRYZfchCg
         Mt/TNdzOGgssnI0+PAN5HsbYjNjJ6JDWIWK3lJgxE4tCdyV+mGhOnvyJxBHfTDlHAsTl
         sFgratp9Ep3ZArtuIc4FvKQ38LJWdxN1yt75kmKib712JWDjE5c8lHf2XBRt4S/NV5bW
         6m6Q==
X-Gm-Message-State: ALyK8tKTHqYEJWoknmowvP9V3EhpVFr7vBxDrjS+/UJJRtlAi765VyXyE13XLI/ID2AN0lBf
X-Received: by 10.67.13.196 with SMTP id fa4mr26670088pad.115.1468531499833;
        Thu, 14 Jul 2016 14:24:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c041:4809:7eab:7652])
        by smtp.gmail.com with ESMTPSA id cp3sm6920143pad.12.2016.07.14.14.24.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 14 Jul 2016 14:24:58 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, dwwang@google.com, peff@peff.net,
	jrnieder@gmail.com, e@80x24.org, dennis@kaarsemaker.net,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv6 2/4] receive-pack: implement advertising and receiving push options
Date:	Thu, 14 Jul 2016 14:24:54 -0700
Message-Id: <20160714212454.16643-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.247.gf748855.dirty
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

 Junio,
 please replace v5 2/4 with this patch (I only resend this single patch
 as the other 3 remain as is).

 This only changes read_push_options to not care at all about any
 limitations.
 
 Thanks,
 Stefan

# interdiff to v5:
# diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
# index 917ac18..9bb9afc 100644
# --- a/builtin/receive-pack.c
# +++ b/builtin/receive-pack.c
# @@ -1505,7 +1505,7 @@ static struct string_list *read_push_options(void)
#  	string_list_init(ret, 1);
#  
#  	while (1) {
# -		char *line, *lf;
# +		char *line;
#  		int len;
#  
#  		line = packet_read_line(0, &len);
# @@ -1513,30 +1513,6 @@ static struct string_list *read_push_options(void)
#  		if (!line)
#  			break;
#  
# -		/*
# -		* NEEDSWORK: expose the limitations to be configurable;
# -		* Once the limit can be lifted, include a way for payloads
# -		* larger than one pkt, e.g use last byte to indicate if
# -		* the push option continues in the next packet or implement
# -		* larger packets.
# -		*/
# -		if (len > LARGE_PACKET_MAX - 1) {
# -			/*
# -			 * NEEDSWORK: The error message in die(..) is not
# -			 * transmitted in call cases, so ideally all die(..)
# -			 * calls are prefixed with rp_error and then we can
# -			 * combine rp_error && die into one helper function.
# -			 */
# -			rp_error("protocol error: server configuration allows push "
# -				 "options of size up to %d bytes",
# -				 LARGE_PACKET_MAX - 1);
# -			die("protocol error: push options too large");
# -		}
# -
# -		lf = strchr(line, '\n');
# -		if (lf)
# -			*lf = '\0';
# -
#  		string_list_append(ret, line);
#  	}


 Documentation/config.txt                          |  9 ++++--
 Documentation/technical/pack-protocol.txt         | 10 ++++---
 Documentation/technical/protocol-capabilities.txt |  9 ++++++
 builtin/receive-pack.c                            | 35 +++++++++++++++++++++++
 4 files changed, 57 insertions(+), 6 deletions(-)

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
index 236417e..9bb9afc 100644
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
@@ -1487,6 +1499,26 @@ static struct command *read_head_info(struct sha1_array *shallow)
 	return commands;
 }
 
+static struct string_list *read_push_options(void)
+{
+	struct string_list *ret = xmalloc(sizeof(*ret));
+	string_list_init(ret, 1);
+
+	while (1) {
+		char *line;
+		int len;
+
+		line = packet_read_line(0, &len);
+
+		if (!line)
+			break;
+
+		string_list_append(ret, line);
+	}
+
+	return ret;
+}
+
 static const char *parse_pack_header(struct pack_header *hdr)
 {
 	switch (read_pack_header(0, hdr)) {
@@ -1774,6 +1806,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		const char *unpack_status = NULL;
 		struct string_list *push_options = NULL;
 
+		if (use_push_options)
+			push_options = read_push_options();
+
 		prepare_shallow_info(&si, &shallow);
 		if (!si.nr_ours && !si.nr_theirs)
 			shallow_update = 0;
-- 
2.9.0.247.gf748855.dirty

