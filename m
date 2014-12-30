From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv8 1/9] receive-pack.c: add documentation for atomic push support
Date: Mon, 29 Dec 2014 18:36:39 -0800
Message-ID: <1419907007-19387-2-git-send-email-sbeller@google.com>
References: <1419907007-19387-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Tue Dec 30 03:37:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5mgL-0001pL-Mq
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 03:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbaL3ChF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 21:37:05 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:59980 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbaL3ChE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 21:37:04 -0500
Received: by mail-ig0-f171.google.com with SMTP id z20so12028132igj.16
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 18:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6OlOa1vLeFppsmVuIWwr2ThqH/IwEJlhLfSAJOVvdzU=;
        b=omzPiLGgE0Z5hZu8in/LRKWy8W9IkvnMb0lhnefXECrzH6ZZbuqLGutiuf0krmkEIE
         s5TP0NBJ6rAGtmkQF34eGMaXDKz9u3iFIiM+rj+MDNXJZUumNsYmDOQ3QslNl+nocQrM
         eSvV2Gv89NUTdARkDJxjBKcBrWt8q0S6lwjiNhNrGGFuBwn3RhF3n9Q/jR3ZyfjUNum/
         pHeLEOoZ0knyztmHiSrsnd2MUd7liTb9IcnDHAGDRwpAKxJFgjZsfmnvZg5itHP+O8cJ
         6SDMOpKfU1uZp8lIWo9btbKwopJVTZxRUvXVMXcw/ydtPv9ya5sX1LFZ6YZJM8TtWcsJ
         euaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6OlOa1vLeFppsmVuIWwr2ThqH/IwEJlhLfSAJOVvdzU=;
        b=Y9GNC9cdThdUS89niaTjx3jQiZO106lQdaa4sU/CHxiIt992InODxpe0xrRh6wWyVv
         1evZPvY+lOzPFfjRQoiJLLpSiCiuq+BZJkBlvBNJe5GIj2bxFBH2TsM2yYVWFXwHsxse
         pUpAOJSilMdJehE3XdcjQLsD7b3OERLg/0ISBX8Rx3m9QM83d6z1/0vMWCpAfl2o54jN
         QqnBiEqs5CFVFw7JKC5B0ZDS9loitrnjD7/vWpYlHV8CybneFsXElC+ueXlBX/l6WYd7
         wrNIVawIdWlXo4YreBgG0EW12hCkgGBirKiE8fGiIUwlL6cMCVlveojoWjMrswerUkzI
         8KDg==
X-Gm-Message-State: ALoCoQkiEf6nA/mmb3EgxXbc6WmrT/y/x8ISAkMX4DKxn3LQQBkjok3vfFq0aq90ADgBb7jCm9I0
X-Received: by 10.107.138.5 with SMTP id m5mr53054417iod.85.1419907023322;
        Mon, 29 Dec 2014 18:37:03 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5860:dcf1:88a4:141b])
        by mx.google.com with ESMTPSA id h3sm14793837igh.21.2014.12.29.18.37.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Dec 2014 18:37:02 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1419907007-19387-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261901>

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
    
    v8:
    	no changes

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
