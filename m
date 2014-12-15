From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/5] receive-pack.c: add protocol support to negotiate atomic-push
Date: Mon, 15 Dec 2014 11:56:04 -0800
Message-ID: <1418673368-20785-2-git-send-email-sbeller@google.com>
References: <1418673368-20785-1-git-send-email-sbeller@google.com>
Cc: mhagger@alum.mit.edu, jrnieder@gmail.com, gitster@pobox.com,
	ronniesahlberg@gmail.com, Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 20:56:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0bku-00021J-A0
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 20:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbaLOT4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 14:56:22 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:36096 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbaLOT4U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 14:56:20 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so11475892ier.32
        for <git@vger.kernel.org>; Mon, 15 Dec 2014 11:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bs7NEcA8IymMciX39WnH9TX92g3kNP9I+SA9RMqzb0E=;
        b=ZZNxsTo7xsUDOL+vV67uKUXumo81Vm31KH6i/XXvw4te7EvfDOOqcLaOEWx5Ef8ACw
         UD/8AMHN9vLTFLzSKnwsqj2kiGyyUhYYlvLVI20r9A3JxDzJ3KEzSiQntaN8PFIGABNQ
         ksoszRrK9HDqFc2ZFiAHy5d8buFxLMMkrrzf5ETJg2bccXFbfDSQfmT6Phl/zG1AnmpR
         Qm/bObmkrLGQ21dK0WzEDQ1+B/yCThhYlCTaBjJPVeW5IT9mD78U4zdKhvy1W3+SRrgQ
         5XOd7cwMypXwsGkSr4VxcF/3+BL18IUKWuuqjHSf3eI7nPj4v0FvGWz+YiLpQ5H9iPIE
         kZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bs7NEcA8IymMciX39WnH9TX92g3kNP9I+SA9RMqzb0E=;
        b=OeUSaI9+ZqK8dz4GdA2cDPjHupzxoKxThAO1FtDHSl5110ZMArqoZ9TMjVMOmc83q1
         JepCz14DLVhct710zLKd/g+NHsATf0K87GGgm8V1PSXKCpfWB0aSCDBs1yEW9f3sIrwJ
         S5QvbaThtcCM9BFdLbsfoZNhOqlF14erKAq9z/po5Sgm+b+RHsGBxOrdEHiyaT8gwAom
         1ixk9nI4fr90UuMSNFaAsMrWkJvre/AoJzJFaXpUrvqKqkAF9jL6lmT5tY0gDJyXmYP6
         43yjGnf0rj/RBtUtBoBITExI+i6EUJCANy4T2X1o0DFYTpBtznV2Tow1e4GFQcPOF43Z
         4w0A==
X-Gm-Message-State: ALoCoQmciB/slRLEbWpSIAi/GHb1DO5yc4l55AUYxXqPzC31lZXULAbT38GpkSEO+06lR+dEYCmp
X-Received: by 10.107.5.7 with SMTP id 7mr11219553iof.1.1418673379552;
        Mon, 15 Dec 2014 11:56:19 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:ccd:69a0:9bbf:bab9])
        by mx.google.com with ESMTPSA id 6sm5328120igk.11.2014.12.15.11.56.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Dec 2014 11:56:18 -0800 (PST)
X-Mailer: git-send-email 2.2.0.33.gc2219e3.dirty
In-Reply-To: <1418673368-20785-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261416>

From: Ronnie Sahlberg <sahlberg@google.com>

This adds support to the protocol between send-pack and receive-pack to
* allow receive-pack to inform the client that it has atomic push capability
* allow send-pack to request atomic push back.

There is currently no setting in send-pack to actually request that atomic
pushes are to be used yet. This only adds protocol capability not ability
for the user to activate it.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/protocol-capabilities.txt | 12 ++++++++++--
 builtin/receive-pack.c                            |  6 +++++-
 send-pack.c                                       |  6 ++++++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 6d5424c..763120c 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -18,8 +18,9 @@ was sent.  Server MUST NOT ignore capabilities that client requested
 and server advertised.  As a consequence of these rules, server MUST
 NOT advertise capabilities it does not understand.
 
-The 'report-status', 'delete-refs', 'quiet', and 'push-cert' capabilities
-are sent and recognized by the receive-pack (push to server) process.
+The 'atomic-push', 'report-status', 'delete-refs', 'quiet', and 'push-cert'
+capabilities are sent and recognized by the receive-pack (push to server)
+process.
 
 The 'ofs-delta' and 'side-band-64k' capabilities are sent and recognized
 by both upload-pack and receive-pack protocols.  The 'agent' capability
@@ -244,6 +245,13 @@ respond with the 'quiet' capability to suppress server-side progress
 reporting if the local progress reporting is also being suppressed
 (e.g., via `push -q`, or if stderr does not go to a tty).
 
+atomic-push
+-----------
+
+If the server sends the 'atomic-push' capability, it means it is
+capable of accepting atomic pushes. If the pushing client requests this
+capability, the server will update the refs in one single atomic transaction.
+
 allow-tip-sha1-in-want
 ----------------------
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 32fc540..0c642ab 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -40,6 +40,7 @@ static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
 static int report_status;
 static int use_sideband;
+static int use_atomic_push;
 static int quiet;
 static int prefer_ofs_delta = 1;
 static int auto_update_server_info;
@@ -171,7 +172,8 @@ static void show_ref(const char *path, const unsigned char *sha1)
 		struct strbuf cap = STRBUF_INIT;
 
 		strbuf_addstr(&cap,
-			      "report-status delete-refs side-band-64k quiet");
+			      "report-status delete-refs side-band-64k quiet "
+			      "atomic-push");
 		if (prefer_ofs_delta)
 			strbuf_addstr(&cap, " ofs-delta");
 		if (push_cert_nonce)
@@ -1179,6 +1181,8 @@ static struct command *read_head_info(struct sha1_array *shallow)
 				use_sideband = LARGE_PACKET_MAX;
 			if (parse_feature_request(feature_list, "quiet"))
 				quiet = 1;
+			if (parse_feature_request(feature_list, "atomic-push"))
+				use_atomic_push = 1;
 		}
 
 		if (!strcmp(line, "push-cert")) {
diff --git a/send-pack.c b/send-pack.c
index 949cb61..1ccc84c 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -294,6 +294,8 @@ int send_pack(struct send_pack_args *args,
 	int use_sideband = 0;
 	int quiet_supported = 0;
 	int agent_supported = 0;
+	int atomic_push_supported = 0;
+	int atomic_push = 0;
 	unsigned cmds_sent = 0;
 	int ret;
 	struct async demux;
@@ -314,6 +316,8 @@ int send_pack(struct send_pack_args *args,
 		agent_supported = 1;
 	if (server_supports("no-thin"))
 		args->use_thin_pack = 0;
+	if (server_supports("atomic-push"))
+		atomic_push_supported = 1;
 	if (args->push_cert) {
 		int len;
 
@@ -335,6 +339,8 @@ int send_pack(struct send_pack_args *args,
 		strbuf_addstr(&cap_buf, " side-band-64k");
 	if (quiet_supported && (args->quiet || !args->progress))
 		strbuf_addstr(&cap_buf, " quiet");
+	if (atomic_push)
+		strbuf_addstr(&cap_buf, " atomic-push");
 	if (agent_supported)
 		strbuf_addf(&cap_buf, " agent=%s", git_user_agent_sanitized());
 
-- 
2.2.0.33.gc2219e3.dirty
