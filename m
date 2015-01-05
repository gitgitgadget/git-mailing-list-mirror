From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv10 02/10] receive-pack.c: die instead of error in assure_connectivity_checked
Date: Mon,  5 Jan 2015 10:25:55 -0800
Message-ID: <1420482355-24995-2-git-send-email-sbeller@google.com>
References: <CAGZ79ka8TMvF1s=ZL=4Lj1EaDrLVn8HRA2PR4JLAHWasHmvkFA@mail.gmail.com>
 <1420482355-24995-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, git@vger.kernel.org, sunshine@sunshineco.com,
	mhagger@alum.mit.edu, ronniesahlberg@gmail.com,
	Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon Jan 05 19:36:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8CM2-0005gI-Od
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 19:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbbAES0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2015 13:26:10 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:58022 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080AbbAES0I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2015 13:26:08 -0500
Received: by mail-ie0-f178.google.com with SMTP id vy18so17877934iec.23
        for <git@vger.kernel.org>; Mon, 05 Jan 2015 10:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5GAgVF1OMASx162wJxbO97wFdPlnJS6q3WWo4VKxAhY=;
        b=dqjV3tuNnx/ANa6PXmOdF1PP2rJZP3uHrFkgUX0tBPTN80qUXjqeaaQRm0YfzQTd2T
         3P5SFT/AjPkNgI8LkQFu+vJGeGzjDyfGFDaAwvX7H9OzRS4baGOlcJH7Jp1Ee83UGhxe
         lb0t+IjxaDc+gBt8dcBT2H4p4VVAW+2MvUxXyO0fsOT5n2KJavR3O9lJvvFW9t5FkTel
         I5hwgw29LCZwCwBbYaa3WL6x5gqZo/Jk3idI4PvIFP3Brh6pWO3zqW+L5EBVrwoFvnAf
         i+E9fPLxBTjCjDO7aH49E3eqQ10Pt4POa8CAwxInrMpHL+mZnL++hCr3moXgQENpDZE7
         x/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5GAgVF1OMASx162wJxbO97wFdPlnJS6q3WWo4VKxAhY=;
        b=ZFEuZzIdN7AimI71ET/PPI7ODLgBcLskSRUMYUtxoW5nqhAbIZcmeihSsQzCFZmW4p
         SKG1Uwu3KcD5M71QwpasW9fUgW+4bYwwx8FQnQ/Dys7cmAOUvksDp9thHKcjQTVrFEbJ
         X4bA45pKNEHmTgB4Q9nz3D2VQU1+aEH4GEmDEfk7RPZLY9EhW08NnlYCpihOj9+4tXYe
         7l4ammLCVQZWFUoK8HhzhUKhDg9/Nz7WLqbgXXvRr34BcqQL9A08a9C2/4IDB2ClG2O3
         rI9xkVyBoRX3B8oNugWB8NBTTxne5kEwCpPSPQWhEzc9wWgKsz28bUxICl5qHFA0cNTg
         COAQ==
X-Gm-Message-State: ALoCoQnMUQ5WoUffkEhO2/FYeRtyIqHOrjUwbhqDsBmdmIlixW6rmr7ZSoctb2aDhwxaVdIygES0
X-Received: by 10.107.157.19 with SMTP id g19mr76005904ioe.19.1420482367316;
        Mon, 05 Jan 2015 10:26:07 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:9882:2f2a:8d4c:ba76])
        by mx.google.com with ESMTPSA id m2sm26924380ioi.10.2015.01.05.10.26.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Jan 2015 10:26:06 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1420482355-24995-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262025>

Discussion on the previous patch revealed we rather want to err on the
safe side. To do so we need to stop receive-pack in case of the possible
future bug when connectivity is not checked on a shallow push.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    v10:
    * new in v10.

 builtin/receive-pack.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ed428e4..7ebea7f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1055,15 +1055,15 @@ static void assure_connectivity_checked(struct command *commands,
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (should_process_cmd(cmd) && si->shallow_ref[cmd->index]) {
-			error("BUG: connectivity check has not been run on ref %s",
-			      cmd->ref_name);
+			die("BUG: connectivity check has not been run on ref %s",
+			    cmd->ref_name);
 			checked_connectivity = 0;
 		}
 	}
 	if (!checked_connectivity)
-		error("BUG: run 'git fsck' for safety.\n"
-		      "If there are errors, try to remove "
-		      "the reported refs above");
+		die("BUG: run 'git fsck' for safety.\n"
+		    "If there are errors, try to remove "
+		    "the reported refs above");
 }
 
 static void execute_commands(struct command *commands,
-- 
2.2.1.62.g3f15098
