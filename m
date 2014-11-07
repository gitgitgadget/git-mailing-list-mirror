From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 1/7] receive-pack.c: add protocol support to negotiate atomic-push
Date: Fri,  7 Nov 2014 11:41:55 -0800
Message-ID: <1415389321-10386-2-git-send-email-sahlberg@google.com>
References: <1415389321-10386-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 20:49:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmpX0-0005Wg-RH
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbaKGTtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:49:10 -0500
Received: from mail-oi0-f73.google.com ([209.85.218.73]:52714 "EHLO
	mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141AbaKGTtH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:49:07 -0500
Received: by mail-oi0-f73.google.com with SMTP id e131so546788oig.2
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 11:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i+zVR3FOAne7ht49aORyULFkng4lgmWGe9BgUCge2+s=;
        b=OryVSq0rtrBWGxGHKIg0T3nhh8+LUumUIwSQ3QTERzc8zk4ZY18F7Ec3nnWs5ZBWCd
         kYRi+EdqCzabsAST+4OGHKSsCEpkNg2m663+G7wpzqE9YDjkzwscA83wGYRUaaJOO+lg
         4OPvSfPR+HvsK7R332FHQSWBum5Wrj1WUBnyGP39YhL+8onzSmwDFFMmAgPu+dos2wQ9
         MlbTAKzM0wM5waddKSmTdfIf65r1K+5WUA8lhiuO56GVK5aT8AxRxvbXZhQ+FisAAPyB
         aHzbPHS9ZSfgxff2+UfZ1AbxwpsRrLD65weKGdjL2cV0rkjBQCuT5pWmS4E5JKsIQHH1
         HnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i+zVR3FOAne7ht49aORyULFkng4lgmWGe9BgUCge2+s=;
        b=AMZSt4OYGFdvLbK9s2oz566pLK4aysb73v9XIaYExEI0qYtvJ37lkeuebHgZxfMEf3
         1Nd65oBIInz3tx27eE29EBtXwiBACM5zxHfdNPjNCJ8dTCSUYmFEQ6Ak72UCoHDaEiuZ
         hA1n7n2Y/6r6U1A4yX7ZSc95XFK/lSGQYgPByrAEyMUYOeE4iHcFL0FsSxdFwcN8CxHF
         BXVpbGSWPF6ylmxWzjWe1d0GsM/9snn9qPHew55c1pia8pPpeWI9DG1VOtVlLsq+Psgg
         St1zc0bR4b3sJejZcY+iqX7aHtdZgHp7+opOqSXpTWubIl3shiWOiCahHlIfGFxgwUsw
         ZtWQ==
X-Gm-Message-State: ALoCoQlhOc5i2tlWN+aqMwUO0eWqUf+albi2bGI5K3pCidizGXJRPZdpgADfcTJK3X93Xh25ggBJ
X-Received: by 10.42.62.81 with SMTP id x17mr16792491ich.10.1415389746873;
        Fri, 07 Nov 2014 11:49:06 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id s23si406410yhf.0.2014.11.07.11.49.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2014 11:49:06 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id aGXUYBzw.1; Fri, 07 Nov 2014 11:49:06 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D21EEE0AD7; Fri,  7 Nov 2014 11:42:03 -0800 (PST)
X-Mailer: git-send-email 2.1.2.810.gfbd2bf7.dirty
In-Reply-To: <1415389321-10386-1-git-send-email-sahlberg@google.com>
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
