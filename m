From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv10 01/10] receive-pack.c: shorten the execute_commands loop over all commands
Date: Mon,  5 Jan 2015 10:25:54 -0800
Message-ID: <1420482355-24995-1-git-send-email-sbeller@google.com>
References: <CAGZ79ka8TMvF1s=ZL=4Lj1EaDrLVn8HRA2PR4JLAHWasHmvkFA@mail.gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org, sunshine@sunshineco.com,
	mhagger@alum.mit.edu, ronniesahlberg@gmail.com,
	Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon Jan 05 19:33:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8CM3-0005gI-EV
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 19:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102AbbAES0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2015 13:26:09 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:58345 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055AbbAES0H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2015 13:26:07 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so20059329ier.32
        for <git@vger.kernel.org>; Mon, 05 Jan 2015 10:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PYOdtkvrBRcS6Ru/TV3FgqccCwv6xrHAqh+qB3bCwkQ=;
        b=Z2yNJujzDQ3GjarMgSwx+CGTn9ruVgR0o6VZXPX55wZHk9txsp/zgbtaooNYQYlqlQ
         auf4PFljv5hGRjJLzhezq37zaMAbYt0ioq4ez8HhTLXs6IIE+sLHi0tDfAanvtM4/hwQ
         Ra2xP6Ue8bfx9ZDekoIk5j09GMxF+ePGzBNd307jNIKpij0+XywUiqkNBVVe/ux5/SMi
         ZjpcCxxGnUhfZvohSc74GQZWyNJa4F7+ZFBEwUkqkeLctiSkTBJxzG33iynhMEtmwunW
         3ljW4+2eHWQXjD0PgGWMdiOS4jyWS63pHV9MQ7LuOkQPkdTuluu2acwGwRjJZLsNHhgq
         kY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PYOdtkvrBRcS6Ru/TV3FgqccCwv6xrHAqh+qB3bCwkQ=;
        b=BxIKAFdjEh8yOORNT27bUlSoYR/TqZ1IWR9dRM33DLs00McGSyBP/48oiD/3q4GY3K
         xF6NEFTRfbg6H5qvHvkX5o90XrtnbQ/wHo9SxDP1XgFgTiglSuYMqViYgddSzRP8p790
         lSFWld4prZnUdEBU6J7X5tcHis/fshC+viZ41zgXR6zmnzp6kWi0zQ/XlyKExrA+0Ie7
         vXQXHJLlL2AUgA+I97+GCilzDLjSpnNUoxo0C8hYglMDnzm4vWifCxN8aXLZ2oE8ephB
         Ozj/+owVXqmRhex4HN2iY0ftyt0ttLCtHWQmgpgK/aSh/TdcF7JjGxYgtj6UDMNPNRPG
         Jwkw==
X-Gm-Message-State: ALoCoQmBv96eF/3HykSe8z/hgF/TIvira7K20cV8/NHBvD2/JFPnm/f4SuKKVUajjerSYWY3a2g3
X-Received: by 10.107.132.210 with SMTP id o79mr81746681ioi.50.1420482365989;
        Mon, 05 Jan 2015 10:26:05 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:9882:2f2a:8d4c:ba76])
        by mx.google.com with ESMTPSA id i3sm26921678iod.19.2015.01.05.10.26.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Jan 2015 10:26:05 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <CAGZ79ka8TMvF1s=ZL=4Lj1EaDrLVn8HRA2PR4JLAHWasHmvkFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262024>

Make the main "execute_commands" loop in receive-pack easier to read
by splitting out some steps into helper functions. The new helper
'should_process_cmd' checks if a ref update is unnecessary, whether
due to an error having occurred or for another reason. The helper
'assure_connectivity_checked' warns if we have forgotten to run a
connectivity check on a ref which is shallow for the client which
would be a bug.

This will help us to duplicate less code in a later patch when we make
a second copy of the "execute_commands" loop.

No functional change intended.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
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
index 32fc540..ed428e4 100644
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
+static void assure_connectivity_checked(struct command *commands,
+					struct shallow_info *si)
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
+		assure_connectivity_checked(commands, si);
 }
 
 static struct command **queue_command(struct command **tail,
-- 
2.2.1.62.g3f15098
