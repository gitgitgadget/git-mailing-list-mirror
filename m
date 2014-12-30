From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv9 1/9] receive-pack.c: shorten the execute_commands loop over all commands
Date: Tue, 30 Dec 2014 15:41:30 -0800
Message-ID: <1419982898-23108-2-git-send-email-sbeller@google.com>
References: <1419982898-23108-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com, mhagger@alum.mit.edu,
	jrnieder@gmail.com, ronniesahlberg@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 31 00:41:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y66QC-0007kt-EH
	for gcvg-git-2@plane.gmane.org; Wed, 31 Dec 2014 00:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbaL3Xls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 18:41:48 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:61553 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbaL3Xlq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 18:41:46 -0500
Received: by mail-ie0-f172.google.com with SMTP id tr6so14299432ieb.17
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 15:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LmpApA6YcA9xtemaGQzksYVdcubN3YtKstbAcLo/TjM=;
        b=FSvr0Bq7eXhIvcDzO6fN8ur3d5EI/oGBJJx99STimeJBHGZW6Ng63H16OV9QTVimVR
         ZQ6MfeJ9eTiyNgOOtdl/EfTV02UFpCVM8bTOyWzd4BV3pmHhl8x0j8GhNQufVS14rpUI
         UdVr/sBuY0kDWloOaKwRXQgnFqZLjc83AM2ssfuxyoItZlNZ8jk0f3kr/aG2SMRMQnFo
         sGqT3GrpsM1EhkFVNHi1w3rhC9r9ObqaPmA9aaot0+hf2QS91z6QVAM4AuskRFsTbAAU
         mWgD9sQUuhujUICnHv786XyuAbijoXBR9x6f0phVep+VL2X8HitCNkCDFHMsad3YU6x1
         GCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LmpApA6YcA9xtemaGQzksYVdcubN3YtKstbAcLo/TjM=;
        b=k+eVVxolLRtSJO6e33mTAcTKDbh6msm30C84iqRbAEK0YO5i2JnJJKXMDvkDnYz0FM
         LNNjADGZY04qQeZUQMaGPuMweVRO4A/UEllecGJ2z+NyclstBHfRCQoA28JXcVWQg2qF
         z5OrHKE+heCa4WjkVMFma8CIQWMXssXQtE+k7+uoua+EaHj5LSrcCDGWxhnLFA4z6QsP
         ANa3b+YoWsREW84s9vC0nug0mV4BA8YaOrddBy/DHR2oQ2mIHduUYo/3RjuLbC2P0c9v
         i9Xo6naJXIV696CAfwj+9ZBM4SRkMiGC6MRn/o/Iin547Ufr29+jXjs0KXTt0/iYJsFn
         /UAw==
X-Gm-Message-State: ALoCoQkigHNjt6VHPovrbJw5aPwak1X1iLNqidsTTR19jWOm+GbvknyHoZxNT3tb0m78ZkoGjBM0
X-Received: by 10.50.143.65 with SMTP id sc1mr27822985igb.12.1419982905688;
        Tue, 30 Dec 2014 15:41:45 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e545:220a:6cf6:2fed])
        by mx.google.com with ESMTPSA id j82sm19667329iod.12.2014.12.30.15.41.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Dec 2014 15:41:45 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1419982898-23108-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261955>

This commit shortens execute_commands loop over all commands by moving
some parts of the code to extra functions. This will help us in a later
patch to avoid duplicate code when the loop over all commands should be
made atomic or not.

No functional changes intended.

Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    v9:
    * simplified should_process_cmd to be a one liner
    * check_shallow_bugs doesn't check of shallow_update being set, rather
      the function is just called if that option is set.
    
    v8: no change
    
    v7:
     new in v7 as in v7 I'd split up the previous
     [PATCH 4/7] receive-pack.c: receive-pack.c: use a single ref_transaction for atomic pushes
     as suggested by Eric.
    
     This is pretty much
    > patch 1: Factor out code into helper functions which will be needed by
    > the upcoming atomic and non-atomic worker functions. Example helpers:
    > 'cmd->error_string' and cmd->skip_update' check; and the
    > 'si->shallow_ref[cmd->index]' check and handling.

 builtin/receive-pack.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 32fc540..68b9cfb 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1042,11 +1042,33 @@ static void reject_updates_to_hidden(struct command *commands)
 	}
 }
 
+static int should_process_cmd(struct command *cmd)
+{
+	return !cmd->error_string && !cmd->skip_update;
+}
+
+static void check_shallow_bugs(struct command *commands,
+			       struct shallow_info *si)
+{
+	struct command *cmd;
+	int checked_connectivity = 1;
+	for (cmd = commands; cmd; cmd = cmd->next) {
+		if (should_process_cmd(cmd) && si->shallow_ref[cmd->index]) {
+			error("BUG: connectivity check has not been run on ref %s",
+			      cmd->ref_name);
+			checked_connectivity = 0;
+		}
+	}
+	if (!checked_connectivity)
+		error("BUG: run 'git fsck' for safety.\n"
+		      "If there are errors, try to remove "
+		      "the reported refs above");
+}
+
 static void execute_commands(struct command *commands,
 			     const char *unpacker_error,
 			     struct shallow_info *si)
 {
-	int checked_connectivity;
 	struct command *cmd;
 	unsigned char sha1[20];
 	struct iterate_data data;
@@ -1077,27 +1099,15 @@ static void execute_commands(struct command *commands,
 	free(head_name_to_free);
 	head_name = head_name_to_free = resolve_refdup("HEAD", 0, sha1, NULL);
 
-	checked_connectivity = 1;
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (cmd->error_string)
-			continue;
-
-		if (cmd->skip_update)
+		if (!should_process_cmd(cmd))
 			continue;
 
 		cmd->error_string = update(cmd, si);
-		if (shallow_update && !cmd->error_string &&
-		    si->shallow_ref[cmd->index]) {
-			error("BUG: connectivity check has not been run on ref %s",
-			      cmd->ref_name);
-			checked_connectivity = 0;
-		}
 	}
 
-	if (shallow_update && !checked_connectivity)
-		error("BUG: run 'git fsck' for safety.\n"
-		      "If there are errors, try to remove "
-		      "the reported refs above");
+	if (shallow_update)
+		check_shallow_bugs(commands, si);
 }
 
 static struct command **queue_command(struct command **tail,
-- 
2.2.1.62.g3f15098
