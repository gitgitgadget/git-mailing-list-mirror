From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv11 01/11] receive-pack.c: shorten the execute_commands loop over all commands
Date: Tue,  6 Jan 2015 11:34:37 -0800
Message-ID: <1420572877-9753-1-git-send-email-sbeller@google.com>
References: <20150105211803.GM29365@google.com>
Cc: gitster@pobox.com, git@vger.kernel.org, sunshine@sunshineco.com,
	mhagger@alum.mit.edu, ronniesahlberg@gmail.com,
	Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Jan 06 20:35:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8Zu9-0005uG-Eu
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 20:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756755AbbAFTez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 14:34:55 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:46456 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbbAFTev (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 14:34:51 -0500
Received: by mail-ig0-f171.google.com with SMTP id z20so4696637igj.4
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 11:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bprw0EW13Si8MwdRvATNK/OcHlzhFhzRfVtS0Y5cd0U=;
        b=Dk7L3Gb61pemijj1iR70KnEB/7icxlTr8D7+GDG28LYmvxzcdad0CZUrS16pw7lISa
         TpyLBZxGtiWc8VSu5LVsZE8iyWmtU4OnN8Y4INquV6rNrdX9uL+jEL3dQmRs3A//N3re
         wWD3uq3DNVD0KudzlfB58R/GCEsWWUbZSJLIdbL5taAi57Dnhz7cMF9fthQHNDELBGQq
         NfKARAAHZBMDiMWZjbSwA2dE93eynLntPZgd9eAAFOdAx9FjWClL+aUqTUdKr5LiUISv
         O7cu5sO6SggqWa0AhTGjEWbfZ3hcS/KwrZQv3dByYI+GR1u8swi3rdaVkAkmO4PIbCl1
         +ILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bprw0EW13Si8MwdRvATNK/OcHlzhFhzRfVtS0Y5cd0U=;
        b=atb58ozEBid5LFhDS8AcJhwzHzhSiLxqvgZhk24eEApOrasf/nKXNRpsSxmrYcmhCc
         uIJufVlw40gXAyc1nAhH4vd/odNqlQ/0SxwLR3TAhZPN1+RYpZm2YiiDOcVMAnu8KHXe
         AE6R6CNjAnoZboskUp9ZVkDPNaPHOol3DnEcvOgi+I0I05aBa8G9Uxjzu1A5tD62Btha
         DMEN775lVDI3BUdJL0NTQdAovBrZEV7ryDArUsTI7aYrw3wJ+syQ9Btp3z2TajkFCZzY
         yYVzsaAWKPl5W2RHUIqKrftmG7cPM4FJiue8LuSMt95vI6vqhDpC+hbGJr9V+x16VHUZ
         Uu9w==
X-Gm-Message-State: ALoCoQlUoTVF1Qh5siqIWhEk2YG4TeWAeqp77AzbpyTWfkdIhP42uDqnVz/NLfqpLAT6gWMVTvo4
X-Received: by 10.50.43.133 with SMTP id w5mr17887498igl.44.1420572890532;
        Tue, 06 Jan 2015 11:34:50 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:59c9:bff1:416:944d])
        by mx.google.com with ESMTPSA id k6sm5397310igm.4.2015.01.06.11.34.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 06 Jan 2015 11:34:49 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <20150105211803.GM29365@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262093>

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
