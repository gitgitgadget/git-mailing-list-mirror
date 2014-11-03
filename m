From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 1/7] receive-pack.c: add protocol support to negotiate atomic-push
Date: Mon,  3 Nov 2014 11:12:26 -0800
Message-ID: <1415041952-19637-2-git-send-email-sahlberg@google.com>
References: <1415041952-19637-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 20:12:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlN3b-0006P7-Hr
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbaKCTMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:12:47 -0500
Received: from mail-ob0-f201.google.com ([209.85.214.201]:42734 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309AbaKCTMf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:12:35 -0500
Received: by mail-ob0-f201.google.com with SMTP id nt9so1728083obb.2
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 11:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i+zVR3FOAne7ht49aORyULFkng4lgmWGe9BgUCge2+s=;
        b=ZYwDIE1gNdNfBpajcrqgYQeeyjqTl4Vu1smamtJC/LL/cO0doWiQS8w9CWg8mjyEKE
         m9g1bbvQmcvVyGt58MnRaHsp67s7zcrAWNsbj27cdx4/jjjJTqYjOTYsSUL6VexENN9O
         DaR6pAvw06mmUhVsMn4NDVQBtFASeFFnlNsX9DpcJT6VL9gYzgiJrqC/IYwDcBNlvJI2
         jdxxobdWUUpWycnaGBQf5pFNVVj2hj1GInWQN9Jwrt89tKBI9ecdTa9J5fjHrSUHlij/
         dYaZ9NKgZuvYtQF1MoadeDWfZL+5oeAkEFoEBf584k/ax7FDZ86vxGKG6FAHQbQzNXsX
         xY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i+zVR3FOAne7ht49aORyULFkng4lgmWGe9BgUCge2+s=;
        b=csG1HmLCRrracnH+EEBz3jh0e547hr1qgmw1Eon6srko7KqvXCUKl2VmVsEbHf4fvS
         LnnZlKyvW6lrUrHQIfbZskGUiWEUiT5kNreTAVKr9M5MsZB30+HuPUih1eBw3LCKtSSj
         Gf9Sc9xcivJ0fIFe3cOdcKY223bzd5xsdUs2iViSayZJW1DAo0GNPla5kJzp012JY7gC
         bOicEfQngv24q8mXyptsG3Nra+inFFnfL/gdTSuRHrGBYGJQTPZMVruf/vdBUA0UllVi
         4Ky3zsqanqq4wBfpCIXVf98md5Wl2YA2qTULpOn/xFbe9TgR6hlWqMrG/KgtusexIqmM
         eXng==
X-Gm-Message-State: ALoCoQmGXrsaXWkBaFSvnNSqCXt9m3DUJdRoqSgAh/+Ae/5x4DbTEQawWeotQv4RrncBM9o8wJa3
X-Received: by 10.50.28.47 with SMTP id y15mr5727860igg.3.1415041955151;
        Mon, 03 Nov 2014 11:12:35 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id t28si976235yhb.4.2014.11.03.11.12.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 11:12:35 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id ykQvkVvS.1; Mon, 03 Nov 2014 11:12:34 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3B9CEE0FD8; Mon,  3 Nov 2014 11:12:33 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415041952-19637-1-git-send-email-sahlberg@google.com>
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
index ccea9dc..65d9a7e 100644
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
2.1.0.rc2.206.gedb03e5
