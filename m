From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 1/5] receive-pack.c: add protocol support to negotiate atomic-push
Date: Thu, 31 Jul 2014 14:39:07 -0700
Message-ID: <1406842751-6657-2-git-send-email-sahlberg@google.com>
References: <1406842751-6657-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 23:39:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCy4G-00055i-Lx
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 23:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbaGaVjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 17:39:17 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:51788 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbaGaVjP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 17:39:15 -0400
Received: by mail-pd0-f201.google.com with SMTP id g10so612274pdj.0
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 14:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=buqdstRAB6NVpxwUyxTv8iRMrShqnC2P2pKhqN1S7G0=;
        b=iFwjHyZCtUdDXUN3cFwWS37pEVutc1bGPV84Qm5CXiyy30TSa5Qo23HxGXHe8TsdKV
         IwMIIJsUjqsE+rgzxNXpL3vZ89UwZhzhw6FITUDtexK1ISYZjBVLB2gTWjMNGh/HZBNy
         PG3NS/L6aRQn3omnWkbKmiEC5SzC2a8Lix8yHtDnJ2jP7OZtEzIJit2tVnAW2Ti3bkOT
         I1aL21jF9jKIOxGrP/DhmC6Q8cnrvMv3mh63dRntdAXMQI1/Cw3iUehOMgr6YU7QSZ76
         2e6XQveRTaFKRKFVp8YGdVszb+ioGhxBVZ2yMkmVdlGPfOiCLoyNcI3sIvrC1KSnMmyH
         MEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=buqdstRAB6NVpxwUyxTv8iRMrShqnC2P2pKhqN1S7G0=;
        b=cQuBq6Q8DUOtZemRsblCRNQZgFWDpMWjl11jH269Jp6Skym4okLoTZdZyfT3gRl1K0
         oMA6nlvQRFIkCnkvljDSODXVnr807awso7P04y4+QKR8/UR9XFelYD6EfV6Djh7T9bop
         33TMrZiHeR95CiLt8UblRcTZbFDzp3O9SoCZ27s7/GQ17IaTr2aOZU7g6ZUxCNzVkMHu
         HuDTJwIN0wMhwG4CsXDtGZCjllK1YSgj7mNc5hflDH2kOGY9WnTeYkBsjidyCwIHFwuU
         4pJqvA1AoMQSeq4OzHPRg/kNbeW8LNcdBo4e7h1aQ0sbQtfmj9+iWOpJLV6avDnADCtE
         p58w==
X-Gm-Message-State: ALoCoQko9uatCFxSBlxdCJOZHLMTFoPlNbS1zzs3HDYZVj4P5Tic9SUCZ+tiJ1XgZtcO/WdIp2dJ
X-Received: by 10.66.141.48 with SMTP id rl16mr444707pab.1.1406842754500;
        Thu, 31 Jul 2014 14:39:14 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id l23si424324yhg.1.2014.07.31.14.39.14
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jul 2014 14:39:14 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 4EB2F5A42D3;
	Thu, 31 Jul 2014 14:39:14 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E5015E0669; Thu, 31 Jul 2014 14:39:13 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.528.gd0e7a84
In-Reply-To: <1406842751-6657-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254608>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/receive-pack.c |  6 +++++-
 send-pack.c            | 12 +++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 0565b94..f6b20cb 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -36,6 +36,7 @@ static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
 static int report_status;
 static int use_sideband;
+static int use_atomic_push;
 static int quiet;
 static int prefer_ofs_delta = 1;
 static int auto_update_server_info;
@@ -142,7 +143,8 @@ static void show_ref(const char *path, const unsigned char *sha1)
 	else
 		packet_write(1, "%s %s%c%s%s agent=%s\n",
 			     sha1_to_hex(sha1), path, 0,
-			     " report-status delete-refs side-band-64k quiet",
+			     " report-status delete-refs side-band-64k quiet"
+			     " atomic-push",
 			     prefer_ofs_delta ? " ofs-delta" : "",
 			     git_user_agent_sanitized());
 	sent_capabilities = 1;
@@ -892,6 +894,8 @@ static struct command *read_head_info(struct sha1_array *shallow)
 				use_sideband = LARGE_PACKET_MAX;
 			if (parse_feature_request(feature_list, "quiet"))
 				quiet = 1;
+			if (parse_feature_request(feature_list, "atomic-push"))
+				use_atomic_push = 1;
 		}
 		cmd = xcalloc(1, sizeof(struct command) + len - 80);
 		hashcpy(cmd->old_sha1, old_sha1);
diff --git a/send-pack.c b/send-pack.c
index 6129b0f..f91b8d9 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -205,6 +205,7 @@ int send_pack(struct send_pack_args *args,
 	int use_sideband = 0;
 	int quiet_supported = 0;
 	int agent_supported = 0;
+	int atomic_push_supported = 0;
 	unsigned cmds_sent = 0;
 	int ret;
 	struct async demux;
@@ -224,6 +225,8 @@ int send_pack(struct send_pack_args *args,
 		agent_supported = 1;
 	if (server_supports("no-thin"))
 		args->use_thin_pack = 0;
+	if (server_supports("atomic-push"))
+		atomic_push_supported = 1;
 
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
@@ -269,17 +272,20 @@ int send_pack(struct send_pack_args *args,
 			char *old_hex = sha1_to_hex(ref->old_sha1);
 			char *new_hex = sha1_to_hex(ref->new_sha1);
 			int quiet = quiet_supported && (args->quiet || !args->progress);
+			int atomic_push = atomic_push_supported;
 
 			if (!cmds_sent && (status_report || use_sideband ||
-					   quiet || agent_supported)) {
+					   quiet || agent_supported ||
+					   atomic_push)) {
 				packet_buf_write(&req_buf,
-						 "%s %s %s%c%s%s%s%s%s",
+						 "%s %s %s%c%s%s%s%s%s%s",
 						 old_hex, new_hex, ref->name, 0,
 						 status_report ? " report-status" : "",
 						 use_sideband ? " side-band-64k" : "",
 						 quiet ? " quiet" : "",
 						 agent_supported ? " agent=" : "",
-						 agent_supported ? git_user_agent_sanitized() : ""
+						 agent_supported ? git_user_agent_sanitized() : "",
+						 atomic_push ? " atomic-push" : ""
 						);
 			}
 			else
-- 
2.0.1.528.gd0e7a84
