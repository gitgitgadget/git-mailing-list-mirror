From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 1/7] receive-pack.c: add protocol support to negotiate atomic-push
Date: Mon, 17 Nov 2014 18:00:34 -0800
Message-ID: <1416276040-5303-2-git-send-email-sbeller@google.com>
References: <1416276040-5303-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 03:00:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqY65-0000pa-WF
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 03:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbaKRCAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 21:00:46 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35765 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbaKRCAp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 21:00:45 -0500
Received: by mail-ig0-f182.google.com with SMTP id hn15so3194060igb.9
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 18:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BrSWn8bk1SmgjJkspDZOJfNnlueizJS3GIc9/KkPjWQ=;
        b=csMarV2w/vgr33oAHryHc36RLNiiEjJG4wpsZDIwfmK0gdUg5GHDg26sR9qJTGXSWJ
         5Pofj33VUjovDnCSm0K42InY0HP3lSrkXHkZWXQqTwPvGZrTgReOOfIatCryMBiJVg83
         P7+E++P8694p9n13zA1JfXl9KqeQr//E/jOlW346NtQfPIyLmp5FhbJIcrY3+t7HnNbY
         D3EnFDAxh2T9lig0vHL+3CctZXVKsnRda0Xjk5gP0HORk6GD/YNBLveJF9o+/LSH343K
         6FH2UqGiCI0xUiVcGZoXPCBDhtNqX4f5+XV6K0e6A3OoGw4SohcXY5QsbpEpiwMF8QwV
         I1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BrSWn8bk1SmgjJkspDZOJfNnlueizJS3GIc9/KkPjWQ=;
        b=WNTigC9TJibKPVXpen0HFtPG+8KVYHDVg5llpwsIM4DZtsu2BuCjcwD+a0fSDjBNek
         dmyfvSE/AR0AqIYHhNaLTSJo3bK1ZFKpeu+rYMF7MY5m7mf9GP1iDgRNOctrbh+HidDw
         wys0dMY8tIx/H4MgxMlmqPdCPaC+EGjaNcltOkZactBCHZhox8/lQUU3+nLuHenhnlyQ
         RhVNi5Cj7XgRrp3cr0LurnpEAPCRSRIrMQRlT4vjQDiDeRogL0DsI2zkLzgjyKI8MkHu
         +7CDm17JkgLPkhAlGoQui21K/QzemKCriRW9r2enOwYSTjzliYlNfi7B9VFA/BLA74oU
         gIUA==
X-Gm-Message-State: ALoCoQkWqskCi8OpfR0owzC5OnOSFK/Gdb1WxZk/Cj7AQZzry9bRRXvnukEeo4R+YeuRhp2QuO6i
X-Received: by 10.42.53.80 with SMTP id m16mr24283574icg.43.1416276044850;
        Mon, 17 Nov 2014 18:00:44 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id fk8sm6894541igb.9.2014.11.17.18.00.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 18:00:44 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416276040-5303-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index 397abc9..63acebf 100644
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
@@ -1178,6 +1180,8 @@ static struct command *read_head_info(struct sha1_array *shallow)
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
2.2.0.rc2.5.gf7b9fb2
