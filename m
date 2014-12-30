From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv9 2/9] receive-pack.c: move iterating over all commands outside execute_commands
Date: Tue, 30 Dec 2014 15:41:31 -0800
Message-ID: <1419982898-23108-3-git-send-email-sbeller@google.com>
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
	id 1Y66QD-0007kt-7Q
	for gcvg-git-2@plane.gmane.org; Wed, 31 Dec 2014 00:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbaL3Xlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 18:41:49 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:55167 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbaL3Xlr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 18:41:47 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so13134232igd.8
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 15:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5LYCvYm4jSOUftbuN0ph5Mq6XmkVD+zjzKvgbp94aGA=;
        b=Lyoexo3g8R5plMISh15Nhps5bgyDZ3cHCdxP7yrPH1K8XLGCeMXWDRu8x0t7XBK5nc
         52Wov4M+F5QDIkPhZMfxIb6hpEwiTCq651SNQD6ZuS6PhVYp+wWVIOrnpaApzYw7905O
         WE8ALdjLzrM5FAaj8se6EAnub6M06aYX5IB8BDc0W4Tem1sEG6zBt9dyzz5GkBzh+2JZ
         2/r/8bcNl8w+WQmakY1VyixLKiu7pMzL4kHuBnptFzZ4KSoze5EH57nUB3vjCuA55bga
         GVqxKCkzXz2Jmi952iLeFHRmZs6V9Zgb25K167Xq22iWYttauEaoNvhT3oy/kQhQJCdK
         o4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5LYCvYm4jSOUftbuN0ph5Mq6XmkVD+zjzKvgbp94aGA=;
        b=POz4iO4gy5WWP9uZhIiS3U2s58aZymVIYGLyR7WdmSUbUGDfp0HgV9BmjKf1dOogxE
         2MWtTXCbmxgnMzxVHsm+49jFnCS8JhWGYb8hhFTujLNbs/wf5zdREBFgpyDG/I6QTXfw
         oKoOoHXoRtpkBcJqzAxMvILL2lvoUJipGD/xsnBerefltl9jIX47culhfk1BQMqYWOUf
         +Tu4/LKtAkn5H32LtAyitVDvDFZZm1KZxZIozIdMRLaerh97LC9xGtzrV+E9lgH4tfkk
         7qHePSFXn9ix1YpWuHGxPvprA/xfVVJ1pL9USXZEHNmiexFS3v+pr1/n+VPudDqa/4GM
         zbpA==
X-Gm-Message-State: ALoCoQlJ+yo775qZMGjID90D42tDUO0jusQQUBINNKY9xPWiYlIncASR7qScZ88eN0D+gP/NyzRT
X-Received: by 10.42.4.201 with SMTP id 9mr48541013ict.23.1419982907018;
        Tue, 30 Dec 2014 15:41:47 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e545:220a:6cf6:2fed])
        by mx.google.com with ESMTPSA id n17sm17202258igi.2.2014.12.30.15.41.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Dec 2014 15:41:46 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1419982898-23108-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261954>

This commit allows us in a later patch to easily distinguish between
the non atomic way to update the received refs and the atomic way which
is introduced in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    v9:
     new and shiny. But makes the next patch easier to review.

 builtin/receive-pack.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 68b9cfb..941aae5 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1065,6 +1065,18 @@ static void check_shallow_bugs(struct command *commands,
 		      "the reported refs above");
 }
 
+static void execute_commands_non_atomic(struct command *commands,
+					struct shallow_info *si)
+{
+	struct command *cmd;
+	for (cmd = commands; cmd; cmd = cmd->next) {
+		if (!should_process_cmd(cmd))
+			continue;
+
+		cmd->error_string = update(cmd, si);
+	}
+}
+
 static void execute_commands(struct command *commands,
 			     const char *unpacker_error,
 			     struct shallow_info *si)
@@ -1099,12 +1111,7 @@ static void execute_commands(struct command *commands,
 	free(head_name_to_free);
 	head_name = head_name_to_free = resolve_refdup("HEAD", 0, sha1, NULL);
 
-	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd))
-			continue;
-
-		cmd->error_string = update(cmd, si);
-	}
+	execute_commands_non_atomic(commands, si);
 
 	if (shallow_update)
 		check_shallow_bugs(commands, si);
-- 
2.2.1.62.g3f15098
