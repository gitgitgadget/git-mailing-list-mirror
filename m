From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv12 01/10] receive-pack.c: shorten the execute_commands loop over all commands
Date: Wed,  7 Jan 2015 19:23:15 -0800
Message-ID: <1420687404-13997-2-git-send-email-sbeller@google.com>
References: <1420687404-13997-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
	mhagger@alum.mit.edu, ronniesahlberg@gmail.com, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 08 04:24:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y93hv-0000cP-NK
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 04:24:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275AbbAHDXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 22:23:47 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:51012 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640AbbAHDXp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 22:23:45 -0500
Received: by mail-ie0-f178.google.com with SMTP id vy18so7442631iec.9
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 19:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ddy4KqRdQtP7UoBWSzeXhtV8oZ60ll6I3dI4m1Xe4tQ=;
        b=ETXVw8YbCt2UCOBodHdeVEBbsLhmtRAplwD3QVrEupsxOiovPYKuSm8QK6AMFP6G7u
         klxgTPy14eXuGg0CBQfTOOEQ+zj9cR5O1UFqeioX7Cz20OuKIbwAKDxqb7GmIjGWwGiV
         BAugc0/kMst16bvzYovznsMYoyLmCGouXHVgSGcmG8ISRXfq+uRsQ5TTgsTEJFrHlgnZ
         ubMrkDWJjjpZs8toTGBggo9+1Ox/l0zAzxIsrz8EOHH0uJS6QJkUcuouwaJSZkl59plw
         VPDyByQypLKNH3OmnXSPAHhMVlBZrr4j8ZPfgxJUirC0bJ/0pnvdGt5LonZqd6BPAOOQ
         9ZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ddy4KqRdQtP7UoBWSzeXhtV8oZ60ll6I3dI4m1Xe4tQ=;
        b=W7SYwyCouOfnzozHQEmNAEkoAxOQPE7+jqZr8RoNXZnXdL7eA4fAFJ73Kfbwc50NmB
         cRwXzFZgBMCLiJnN5D4bOKXMYRUwHAUJYW9pTaDKRslAigbMnt6Ysbj7YsIExpiwvSWV
         Ru14KXO130Fm9TuCfAwGvbXsLY7k9sw1255TRTB2FL//td9bbgcPmAEaZsl8gccc7rqh
         DTsBigeSYs3D4Ur0Q9rABpOizdt3u8xfjWa2vROrmG/VeFMl7icimEAveAVo/a5R2o+k
         zvvzrswv/PiGKRe2mIDRDlrtVNDkTLo9yAtH17Qmj8kOaW4jVv5CjChCzWsYBaOEwWNG
         eUIQ==
X-Gm-Message-State: ALoCoQkE5lvgWZjMcNu2Pr7+qfnPCNeS0UmWJdtig/pT06r58kJOsoO/bxI1wBttWgQUmiHlbjP3
X-Received: by 10.42.130.198 with SMTP id w6mr6121623ics.97.1420687424396;
        Wed, 07 Jan 2015 19:23:44 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:948f:12c6:eb26:9b9c])
        by mx.google.com with ESMTPSA id e3sm7452348igg.16.2015.01.07.19.23.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Jan 2015 19:23:43 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1420687404-13997-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262178>

Make the main "execute_commands" loop in receive-pack easier to read
by splitting out some steps into helper functions. The new helper
'should_process_cmd' checks if a ref update is unnecessary, whether
due to an error having occurred or for another reason. The helper
'warn_if_skipped_connectivity_check' warns if we have forgotten to
run a connectivity check on a ref which is shallow for the client
which would be a bug.

This will help us to duplicate less code in a later patch when we make
a second copy of the "execute_commands" loop.

No functional change intended.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    v12:
    * no changes
    v11:
    * rename assure_connectivity_checked to warn_if_skipped_connectivity_check
    
    >> This is why I choose the word assure.
    >If this patch depends on the next one, would it make sense to put them
    >in the opposite order?
    
    With the next patch applied which dies if the assumption doesn't hold,
    assure/assume sounds to me as if it describes the siuation well.
    
    > My personal preference would be to refactor the preceding code to make
    > the check unnecessary.
    
    The way I understand it, the shallow case is spread out all over the place
    not by choise but because it doesn't work better. So the original author
    (Duy) was wise enough to put checks in place because knowing it is fragile
    and may break in the future?
    This series doesn't intend to refactor the shallow case.
    
    So I picked up warn_if_skipped_connectivity_check as I'm ok with that.
    
    v10:
    * rename check_shallow_bugs to assure_connectivity_checked.
    * reword commit message.
    
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

 builtin/receive-pack.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 32fc540..2ebaf66 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1042,11 +1042,34 @@ static void reject_updates_to_hidden(struct command *commands)
 	}
 }
 
+static int should_process_cmd(struct command *cmd)
+{
+	return !cmd->error_string && !cmd->skip_update;
+}
+
+static void warn_if_skipped_connectivity_check(struct command *commands,
+					       struct shallow_info *si)
+{
+	struct command *cmd;
+	int checked_connectivity = 1;
+
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
@@ -1077,27 +1100,15 @@ static void execute_commands(struct command *commands,
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
+		warn_if_skipped_connectivity_check(commands, si);
 }
 
 static struct command **queue_command(struct command **tail,
-- 
2.2.1.62.g3f15098
