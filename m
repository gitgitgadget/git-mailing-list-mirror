From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 1/9] receive-pack.c: add documentation for atomic push support
Date: Mon, 29 Dec 2014 13:35:07 -0800
Message-ID: <1419888915-31760-2-git-send-email-sbeller@google.com>
References: <1419888915-31760-1-git-send-email-sbeller@google.com>
Cc: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 22:35:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5hyH-0001Ru-Bp
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 22:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbaL2VfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 16:35:22 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:44525 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517AbaL2VfU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 16:35:20 -0500
Received: by mail-ig0-f181.google.com with SMTP id l13so12623721iga.8
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 13:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yQlyptBKxeLonbEjDQG47rpswOAjo/nmlqKd9EOmqr0=;
        b=Pl6AwoSXAz/hZB9SMut/rbfHhkELi1JnJa5V0bBYe1u0MPnyBQmOz50/nG1sBdL4By
         eZjwj+HCYFXOk9fX/8wLfdxVcLka3lK+Z7luvlMnFxDU7hXNkKd17otXLRnJS/wS7vaF
         Bh0xNjrOV3r1hG/55XUrsC0Uk2r9H53ozQ75Dzrc3Vc2aEQkJAs7RR4ljq5Loo9teXXj
         yW27RxacZvGZH9Kp2XQvFuwqXr4XHv7yyuvkvgxY90CyvhzmZPz57uSIUwhFtkHFGiBk
         6MPRVB323g8lUc3GoGc5qdaUfxvqDtjXcS++pm55/yZpdl4A2sfXHd4dclvkUFd9tmXB
         I/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yQlyptBKxeLonbEjDQG47rpswOAjo/nmlqKd9EOmqr0=;
        b=UccW0grwqPZetMcsOhXfq7IFR7dr+Rhmz/j7SLmW1eye1CRXcvg7SLqc2DuLBBW4SE
         7N4nbk5BSv7uYN2QfjjuOeMGqa/bB6Ij8QLG/NHPRWxOhA7JMNzu6Y+0Y2+ERMpMioJz
         mRBgUPYuqq5XVCFl/l10mB0Z14ynfKNHG8qmzMCqZbqFKVMjlLmQQ+CStWwApfo+3LrW
         UcEh8rhwUZpPesX6QgxNXBtA457K55Wxjhwu6XvwO1anNSdIKReeo62IaayrWNclbsB0
         ozQ0VRLR65vUzSAUO0ocKzDcpsFMvaxuICENJa3WHj8NA0DAQv8sfAIAbTRQudGo1pYr
         y2tA==
X-Gm-Message-State: ALoCoQmsm38LK8Oncl2kKPy9MqtyvlFwv4h3lEDmTxC1E+0r9puGReTp3Re4pIdU2KsndMjL/dmY
X-Received: by 10.50.176.129 with SMTP id ci1mr46603542igc.40.1419888919904;
        Mon, 29 Dec 2014 13:35:19 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5860:dcf1:88a4:141b])
        by mx.google.com with ESMTPSA id w202sm18196094iod.8.2014.12.29.13.35.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Dec 2014 13:35:19 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1419888915-31760-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261881>

From: Ronnie Sahlberg <sahlberg@google.com>

This documents the protocol option between send-pack and receive-pack to
* allow receive-pack to inform the client that it has atomic push capability
* allow send-pack to request atomic push back.

There is currently no setting in send-pack to actually request that atomic
pushes are to be used yet. This only adds protocol capability not ability
for the user to activate it. The capability is also not yet advertised
by receive-pack as git doesn't know how to handle it yet.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    Changes v1 -> v2:
    	* Name it atomic instead of atomic-push. The name changes affects
    	  the flags send over the wire as well as the flags in
    	  struct send_pack_args
    	* Add check, which was part of the later patch here:
    	if (args->atomic && !atomic_supported) {
    		fprintf(stderr, "Server does not support atomic push.");
    		return -1;
    	}
    
    v2 -> v3:
    More concise error reporting as suggested by Junio
    -		fprintf(stderr, "Server does not support atomic push.");
    -		return -1;
    +		return error("server does not support atomic push.");
    
    skipped v4 v5
    
    v6:
    	* s/one single atomic transaction./one atomic transaction./
    	* die(_( instead of return error(
    
    v7:
    	* Don't advertise the atomic push capability yet. We cannot handle it at
    	  this point.
    	* reword commit message

 Documentation/technical/protocol-capabilities.txt | 13 +++++++++++--
 builtin/receive-pack.c                            |  3 +++
 send-pack.c                                       | 10 ++++++++++
 send-pack.h                                       |  3 ++-
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 6d5424c..4f8a7bf 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -18,8 +18,9 @@ was sent.  Server MUST NOT ignore capabilities that client requested
 and server advertised.  As a consequence of these rules, server MUST
 NOT advertise capabilities it does not understand.
 
-The 'report-status', 'delete-refs', 'quiet', and 'push-cert' capabilities
-are sent and recognized by the receive-pack (push to server) process.
+The 'atomic', 'report-status', 'delete-refs', 'quiet', and 'push-cert'
+capabilities are sent and recognized by the receive-pack (push to server)
+process.
 
 The 'ofs-delta' and 'side-band-64k' capabilities are sent and recognized
 by both upload-pack and receive-pack protocols.  The 'agent' capability
@@ -244,6 +245,14 @@ respond with the 'quiet' capability to suppress server-side progress
 reporting if the local progress reporting is also being suppressed
 (e.g., via `push -q`, or if stderr does not go to a tty).
 
+atomic
+------
+
+If the server sends the 'atomic' capability it is capable of accepting
+atomic pushes. If the pushing client requests this capability, the server
+will update the refs in one atomic transaction. Either all refs are
+updated or none.
+
 allow-tip-sha1-in-want
 ----------------------
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 32fc540..4e8eaf7 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -40,6 +40,7 @@ static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
 static int report_status;
 static int use_sideband;
+static int use_atomic;
 static int quiet;
 static int prefer_ofs_delta = 1;
 static int auto_update_server_info;
@@ -1179,6 +1180,8 @@ static struct command *read_head_info(struct sha1_array *shallow)
 				use_sideband = LARGE_PACKET_MAX;
 			if (parse_feature_request(feature_list, "quiet"))
 				quiet = 1;
+			if (parse_feature_request(feature_list, "atomic"))
+				use_atomic = 1;
 		}
 
 		if (!strcmp(line, "push-cert")) {
diff --git a/send-pack.c b/send-pack.c
index 949cb61..6d0c159 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -294,6 +294,8 @@ int send_pack(struct send_pack_args *args,
 	int use_sideband = 0;
 	int quiet_supported = 0;
 	int agent_supported = 0;
+	int use_atomic = 0;
+	int atomic_supported = 0;
 	unsigned cmds_sent = 0;
 	int ret;
 	struct async demux;
@@ -314,6 +316,8 @@ int send_pack(struct send_pack_args *args,
 		agent_supported = 1;
 	if (server_supports("no-thin"))
 		args->use_thin_pack = 0;
+	if (server_supports("atomic"))
+		atomic_supported = 1;
 	if (args->push_cert) {
 		int len;
 
@@ -328,6 +332,10 @@ int send_pack(struct send_pack_args *args,
 			"Perhaps you should specify a branch such as 'master'.\n");
 		return 0;
 	}
+	if (args->atomic && !atomic_supported)
+		die(_("server does not support --atomic push"));
+
+	use_atomic = atomic_supported && args->atomic;
 
 	if (status_report)
 		strbuf_addstr(&cap_buf, " report-status");
@@ -335,6 +343,8 @@ int send_pack(struct send_pack_args *args,
 		strbuf_addstr(&cap_buf, " side-band-64k");
 	if (quiet_supported && (args->quiet || !args->progress))
 		strbuf_addstr(&cap_buf, " quiet");
+	if (use_atomic)
+		strbuf_addstr(&cap_buf, " atomic");
 	if (agent_supported)
 		strbuf_addf(&cap_buf, " agent=%s", git_user_agent_sanitized());
 
diff --git a/send-pack.h b/send-pack.h
index 5635457..b664648 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -13,7 +13,8 @@ struct send_pack_args {
 		use_ofs_delta:1,
 		dry_run:1,
 		push_cert:1,
-		stateless_rpc:1;
+		stateless_rpc:1,
+		atomic:1;
 };
 
 int send_pack(struct send_pack_args *args,
-- 
2.2.1.62.g3f15098
