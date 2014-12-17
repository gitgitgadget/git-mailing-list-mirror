From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 1/6] receive-pack.c: add protocol support to negotiate atomic
Date: Wed, 17 Dec 2014 10:32:52 -0800
Message-ID: <1418841177-12152-2-git-send-email-sbeller@google.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
 <1418841177-12152-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Wed Dec 17 19:33:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1JPL-0000P3-0G
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 19:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbaLQSdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 13:33:06 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:41502 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbaLQSdE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 13:33:04 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so9454281igi.6
        for <git@vger.kernel.org>; Wed, 17 Dec 2014 10:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1I1L4XREGkEvOuVcRNlhdpokK2fatzhiSKkIrGmtwtA=;
        b=FDY9xhxqxkgpf5sHOFIXhuRq2pkAfbKnzEAD7+anWbXCesWWLMHiIQl3dN50ZiwQyM
         KA5lCMz93YucU3oWv4GlZu0LCL2TMVgFgqSvmPJnZBsXVX8aVeXrxDMXalfEW6ecMQf7
         dQ8fawf79Lfe5VSNZ01lomKFybyrPXHRYZbmjnwef6P5vuszgFpOJosSA5qyDKgu6LhD
         CDj75U6bQLnBPm2GSdp9G07JadYnTt76VSdcJJTKeOZA3JWV7oxS623sLTJRIqt9PjAc
         JKwMUDjjlSjXj/boJ84uhGY2idR3o6C2h0TQSgytrlzlD3prCh+n0/tIGTwe0ymd1JeL
         UFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1I1L4XREGkEvOuVcRNlhdpokK2fatzhiSKkIrGmtwtA=;
        b=UPojeUDR+LK+nBT6+q9UxNZ7x8Tl/C6UVTz68LxEZ+vy1EXP0gk2Vr/mWCNjzyrOVe
         tOS/8u74Gc/FGosT/+yQUxv3pRf95XA6wlKcc2TX7rGOP/3IpvOR+LxMbc4hP2B8cvKI
         H3So9TAma5mck/wH1dhV4SO6gGZiHU1rIsKDLBXFycD/kEZ0gTEIewXXvJNrJ9N2co0d
         KApjOs3ajkq32/r02VqTZcS7RkEuKvD7dynjtaB60J60S6Ic48/pzsofmzBOwT0OTtOz
         zRr3p2PxMrxyQ6T5be2e5lTB6zik0LReVH2kRCLyIbvuIX/lsxsAq52J0MT7JfL7tOlR
         misA==
X-Gm-Message-State: ALoCoQnJQj5qAy3YTjBGhf9J2oGYKDLPs0Ry6VTTIpMlJDZJ1d12N/e88TREIXudodpTAmEanYLf
X-Received: by 10.43.95.2 with SMTP id ca2mr25838007icc.89.1418841183946;
        Wed, 17 Dec 2014 10:33:03 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:9f5:d31a:4ba2:b65d])
        by mx.google.com with ESMTPSA id b7sm2623799igx.15.2014.12.17.10.33.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Dec 2014 10:33:03 -0800 (PST)
X-Mailer: git-send-email 2.2.0.31.gad78000.dirty
In-Reply-To: <1418841177-12152-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261488>

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

 Documentation/technical/protocol-capabilities.txt | 13 +++++++++++--
 builtin/receive-pack.c                            |  6 +++++-
 send-pack.c                                       | 10 ++++++++++
 send-pack.h                                       |  3 ++-
 4 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 6d5424c..68ec23d 100644
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
+will update the refs in one single atomic transaction. Either all refs are
+updated or none.
+
 allow-tip-sha1-in-want
 ----------------------
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 32fc540..e76e5d5 100644
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
@@ -171,7 +172,8 @@ static void show_ref(const char *path, const unsigned char *sha1)
 		struct strbuf cap = STRBUF_INIT;
 
 		strbuf_addstr(&cap,
-			      "report-status delete-refs side-band-64k quiet");
+			      "report-status delete-refs side-band-64k quiet "
+			      "atomic");
 		if (prefer_ofs_delta)
 			strbuf_addstr(&cap, " ofs-delta");
 		if (push_cert_nonce)
@@ -1179,6 +1181,8 @@ static struct command *read_head_info(struct sha1_array *shallow)
 				use_sideband = LARGE_PACKET_MAX;
 			if (parse_feature_request(feature_list, "quiet"))
 				quiet = 1;
+			if (parse_feature_request(feature_list, "atomic"))
+				use_atomic = 1;
 		}
 
 		if (!strcmp(line, "push-cert")) {
diff --git a/send-pack.c b/send-pack.c
index 949cb61..e2bdd89 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -294,6 +294,8 @@ int send_pack(struct send_pack_args *args,
 	int use_sideband = 0;
 	int quiet_supported = 0;
 	int agent_supported = 0;
+	int use_atomic;
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
+	if (args->atomic && !atomic_supported) {
+		return error("server does not support atomic push.");
+	}
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
2.2.0.31.gad78000.dirty
