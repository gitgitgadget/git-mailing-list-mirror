From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 1/8] receive-pack.c: add protocol support to negotiate atomic-push
Date: Tue, 21 Oct 2014 13:46:33 -0700
Message-ID: <1413924400-15418-2-git-send-email-sahlberg@google.com>
References: <1413924400-15418-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 22:46:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XggKS-0004zm-K3
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 22:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933502AbaJUUqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 16:46:47 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:37190 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933466AbaJUUqo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 16:46:44 -0400
Received: by mail-pa0-f74.google.com with SMTP id kq14so368881pab.5
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 13:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YZCVVoyRG9IuCAOaKLfWIUj/0wgUooTcUpjXXg1H2N0=;
        b=Nbk1/xFovPQ7P6JuVMiksxowizadThZ19cqbfZcM/hJLKY2O86UWqBf97HFlO8D7cE
         Rlbod/xKuEq1N1jkiw0vor6BsMSP18NZtgpyDD1I7xwtTDksDhYSNUxlwNKs8Hpffi+K
         UjkZfgUtgpXx/jTQtcOZzIZ1fca1INpQzWb0PBDZm6QkDGaja+khUQugHzAxmLBiFovA
         chVud6mTj55jHUtybsCl2QMTdcy01cjRBNHG1D0MLz0e2lwpPwGEQIrj2HDI3Dnf8WiS
         k0JEPB3lr7X/EL47EKh/0Bt6sxKCkLAikPlWTWOHTXz1JnKoqTabNutO3UGPMqAXdwqD
         oahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YZCVVoyRG9IuCAOaKLfWIUj/0wgUooTcUpjXXg1H2N0=;
        b=YpkApCqWqKRDTffYdi2USrhjIWKH+WkkbF9QHuFYjwKaORvyTCQFcdF4Qu6HLQFvff
         MAMVYGcpKe/I2o05McJ160sXp5l9rsoUuBVsQyFCIVTO+b+p+IGk7h939um2fGqu8162
         YLxneGRvpCy0/vo0/k/0s0HJLNtVNCZ/TIOtP2FqRSJ+xXzutYg7nI/9YsBfdj9IssjY
         5ipat1fIi7AFUkeH+Q+DFf+FDNe+AcfLa6nx24kvjENd8q34QbgF1cV3FD/cDoPEbPwd
         gGBMEJfMBayR8I3NUWuMo/mBg+YaDGQZRK1ba3c8mOtGvcqvCv9emSvTEQgiXRBPX/iz
         vumQ==
X-Gm-Message-State: ALoCoQkgXi2QcIDjSf6inbgD+8GFAg9H1mtmgtQN+TFP6GBRP9Aq/42gyryZEK6yKp8kqrTgh5M8
X-Received: by 10.70.43.5 with SMTP id s5mr23826114pdl.7.1413924404014;
        Tue, 21 Oct 2014 13:46:44 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id e24si596836yhe.3.2014.10.21.13.46.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 13:46:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id K2TXo1bs.1; Tue, 21 Oct 2014 13:46:43 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5375CE0952; Tue, 21 Oct 2014 13:46:43 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.738.gd04b95a
In-Reply-To: <1413924400-15418-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds support to the protocol between send-pack and receive-pack to
* allow receive-pack to inform the client that it has atomic push capability
* allow send-pack to request atomic push back.

There is currently no setting in send-pack to actually request that atomic
pushes are to be used yet. This only adds protocol capability not ability
for the user to activate it.

Change-Id: I9a12940fb5c7443a1ddf9e45f6ea33b547c7ecfd
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 Documentation/technical/protocol-capabilities.txt | 12 ++++++++++--
 builtin/receive-pack.c                            |  6 +++++-
 send-pack.c                                       |  6 ++++++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 0c92dee..26bc5b1 100644
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
index 7ddd756..b8ffd9e 100644
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
@@ -1173,6 +1175,8 @@ static struct command *read_head_info(struct sha1_array *shallow)
 				use_sideband = LARGE_PACKET_MAX;
 			if (parse_feature_request(feature_list, "quiet"))
 				quiet = 1;
+			if (parse_feature_request(feature_list, "atomic-push"))
+				use_atomic_push = 1;
 		}
 
 		if (!strcmp(line, "push-cert")) {
diff --git a/send-pack.c b/send-pack.c
index 949cb61..3520fe5 100644
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
 
@@ -337,6 +341,8 @@ int send_pack(struct send_pack_args *args,
 		strbuf_addstr(&cap_buf, " quiet");
 	if (agent_supported)
 		strbuf_addf(&cap_buf, " agent=%s", git_user_agent_sanitized());
+	if (atomic_push)
+		strbuf_addstr(&cap_buf, " atomic-push");
 
 	/*
 	 * NEEDSWORK: why does delete-refs have to be so specific to
-- 
2.1.0.rc2.206.gedb03e5
