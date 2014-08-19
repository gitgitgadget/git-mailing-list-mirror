From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 1/5] receive-pack.c: add protocol support to negotiate atomic-push
Date: Tue, 19 Aug 2014 09:24:47 -0700
Message-ID: <1408465491-25488-2-git-send-email-sahlberg@google.com>
References: <1408465491-25488-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:25:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmEA-0007ki-7C
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129AbaHSQZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:25:15 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:34523 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbaHSQYz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:24:55 -0400
Received: by mail-pa0-f73.google.com with SMTP id kx10so1807528pab.2
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V9Jxcs+4+UtUtZ3QOlIdz5/HCLN5JK/3T39zIjBkSBM=;
        b=WlPzOPt4e29z/uHQtdM2x28nPnfWd2Z7gUX9qXg4uMYdO2NdsJmz4sV9qhpUsVtpVe
         aGIGYT2Cf85pYc4OAdTNUtcBvUEQU1efIYYNb+Gy8ir+pxI8wAxV59MAXCMKHt82j7vx
         prjUE+4wWUXZiKEnIRyBrM43JewJQqHR3p3BEmCXQ0ATeCMoYTQqGLotTiHgH4YCGshR
         umgol0SjklQFqNJNzhvbtNWmF/YfwULx51qLv4QlFrkHdoi63im4gLHrMweIXDt0hRwG
         5HKEvWbMiKrZ7+Avnc3qzOu3wuvYv+167M3S0AdlK+RG1M/HdZAWt38Vf+g4wk8MfFbI
         NavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V9Jxcs+4+UtUtZ3QOlIdz5/HCLN5JK/3T39zIjBkSBM=;
        b=lJi3QI7a+OrxV/GyNUoyqyLyBcUYQccRQnO84SIcw0r5/+2CNYNBnPzE2w44s9W/gZ
         EIxqPfZgSvD7F6VxnHlxAC4V2yWYhflVD7XimBNR9rrY8banwSL5U4qC35Zm3k6kr2U+
         Vl2L7Zm8e0VLl9licJj6biQsz2xs0XUzxz6xf2WhKNskLcFrHWujrKzlNcQVgzBPqG6L
         9GocJtrOBvTds08zhgENrlk1iM9XUuY7CVwKiPEGoEyX7BGrJGvyCeGUId+26Twy3fSB
         L0Xo+k2Q4J/KPXu3MgVcAPmj0eCTo9NkvEgokUQPhlnC6T3YSmiHU0FDDP4OOP1ziLig
         BV5g==
X-Gm-Message-State: ALoCoQnzbM2LTwk1oJPiClbhT7npu9Bmri+viFLZUNBt63CIay4FtYJ4AqbFyaNrdWGfe3MpiIgC
X-Received: by 10.66.97.65 with SMTP id dy1mr738013pab.45.1408465495461;
        Tue, 19 Aug 2014 09:24:55 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id x19si331537yhg.0.2014.08.19.09.24.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:24:55 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 2AF0D31C531;
	Tue, 19 Aug 2014 09:24:55 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AA057E106D; Tue, 19 Aug 2014 09:24:54 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.ge8f7cba.dirty
In-Reply-To: <1408465491-25488-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255475>

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
2.0.1.556.ge8f7cba.dirty
