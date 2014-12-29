From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 6/9] receive-pack.c: add execute_commands_atomic function
Date: Mon, 29 Dec 2014 13:35:12 -0800
Message-ID: <1419888915-31760-7-git-send-email-sbeller@google.com>
References: <1419888915-31760-1-git-send-email-sbeller@google.com>
Cc: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 22:35:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5hyV-0001f8-OQ
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 22:35:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbaL2Vfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 16:35:32 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33389 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517AbaL2Vf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 16:35:29 -0500
Received: by mail-ie0-f170.google.com with SMTP id rd18so12858386iec.15
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 13:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1YO6F8bwa8hdfFF/3+v/3GTxHGHQqyBEuOdT3amFKhc=;
        b=BnlKpf61NKDl19r1awG1d2AZ/HuQlVgBDqdps9YiwwFQCqaGXSrv05xI4s9hGyNNak
         Ity9CDB1amb8mqpZB9DRSlOPhaFJV2Z42tZMqaYUXhK7ydAXbvOYdz9YH3KE24wxgU3m
         9tBlxklJKHavIwY3YHSq7BFOD4K2nx+MUAl05SndYOYsfGug94D1q/1BFRMg3tVOpqKA
         a9+ia32WT0NhIXu/9bT9bpj8q8ohdnVL0BDVGUCGgDaLuBr12Nok4tOsOot1kBIMrmMp
         2/CtcqaA7sLFduk/U6sEDOEDIbx8FGYaKk7TYoSksBIjOwaU9uY3iBXA5ZJR558hK8Rc
         RfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1YO6F8bwa8hdfFF/3+v/3GTxHGHQqyBEuOdT3amFKhc=;
        b=VD72fJntOa3mxTwvRe82AeaV9NgB7Z/aLaTXQ7fQlLUZJawGCyEK2HohM9KrG25hLy
         KBi6K2HG8PmSb8CBAAiz2Lkaq2Gd5Qgvf4BQrPgh6qmdETvlCht6j6QXaeRPpcMQkFxK
         juBOUC4/D2tGN1VeOV5TNXFLVFyjo7DdMyBbMzTCLAE1iVtGfjK4K2TcODR3BQdPeOFp
         HuFkTVuGS6XhlNf8pY0+mJho6bN8Zs0Vva5m5j/XGYDb9DZe8SBdPh8Uj49IZmDr0eqy
         Bz34CkSmmmknNOnuFXcYEEPOTrJi5Wp9iUSYtjf9OzaxmKQEJuxE0QYfu4AfTU3dBiXA
         +/kQ==
X-Gm-Message-State: ALoCoQlMS5H+NEgo2k8B1VBTnPbhK2Y+mIclfgZ5cAvnSd3dt/pZifobV6ZRaIscn0zj7oamMP8d
X-Received: by 10.107.137.92 with SMTP id l89mr51056712iod.22.1419888929178;
        Mon, 29 Dec 2014 13:35:29 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5860:dcf1:88a4:141b])
        by mx.google.com with ESMTPSA id f9sm18192671iod.24.2014.12.29.13.35.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Dec 2014 13:35:28 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1419888915-31760-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261884>

Update receive-pack to use an atomic transaction iff the client negotiated
that it wanted atomic push. This leaves the default behavior to be the old
non-atomic one ref at a time update. This is to cause as little disruption
as possible to existing clients. It is unknown if there are client scripts
that depend on the old non-atomic behavior so we make it opt-in for now.

If it turns out over time that there are no client scripts that depend on the
old behavior we can change git to default to use atomic pushes and instead
offer an opt-out argument for people that do not want atomic pushes.

Inspired-by: Ronnie Sahlberg <sahlberg@google.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    Changes in v7:
    	Eric suggested to replace "[PATCH 4/7] receive-pack.c:
    	receive-pack.c: use a single ref_transaction for atomic pushes"
    	by smaller patches
    	This is the last patch replacing said large commit.
    
    Changes in v6:
    	This is a complete rewrite of the patch essentially.
    	Eric suggested to split up the flow into functions, so
    	it is easier to read. It's more lines of code, but indeed
    	it's easier to follow. Thanks Eric!
    
    	Note there is another patch following this one
    	moving the helper functions above execute_commands.
    	I just choose the order of the functions in this patch
    	to have a better diff (just inserting the call to the function
    	execute_commands_non_atomic and that function directly follows.)
    	The next patch of the series will move that up.
    
    	Because of the rewrite and the fixes of the previous five
    	versions there is not much left of Ronnies original patch,
    	so I'll claim authorship of this one.
    
    Changes v1 -> v2:
    	* update(...) assumes to be always in a transaction
    	* Caring about when to begin/commit transactions is put
    	  into execute_commands
    v2->v3:
    	* meditated about the error flow. Now we always construct a local
    	  strbuf err if required. Then the flow is easier to follow and
    	  destruction of it is performed nearby.
    	* early return in execute_commands if transaction_begin fails.
    
    v3->v4:
    	* revamp logic again. This should keep the non atomic behavior
    	  as is (in case of error say so, in non error case just free the
    	  transaction). In the atomic case we either do nothing (when no error),
    	  or abort with the goto.
    
    		if (!cmd->error_string) {
    			if (!use_atomic
    			    && ref_transaction_commit(transaction, &err)) {
    				ref_transaction_free(transaction);
    				rp_error("%s", err.buf);
    				strbuf_release(&err);
    				cmd->error_string = "failed to update ref";
    			}
    		} else if (use_atomic) {
    			goto atomic_failure;
    		} else {
    			ref_transaction_free(transaction);
    		}
    
    	 * Having the goto directly there when checking for cmd->error_string,
    	   we don't need to do it again, so the paragraph explaining the error
    	   checking is gone as well. (Previous patch had the following, this is
    	   put at the end of the function, where the goto jumps to and the comment
    	   has been dropped.
    +		/*
    +		 * update(...) may abort early (i.e. because the hook refused to
    +		 * update that ref) which then doesn't even record a transaction
    +		 * regarding that ref. Make sure all commands are without error
    +		 * and then commit atomically.
    +		 */
    +		for (cmd = commands; cmd; cmd = cmd->next)
    +			if (cmd->error_string)
    +				break;
    
    v4->v5:
    Eric wrote:
    > Repeating from my earlier review[1]: If the 'pre-receive' hook
    > "declines", then this transaction is left dangling (and its resources
    > leaked).
    
    You're right. The initialization of the transaction is now
    near the actual loop after the pre receive hook.
    
    > The !use_atomic case (below), calls this error "failed to start
    > transaction", not merely "transaction error".
    
    ok, now both are "transaction failed to start".
    In all cases where these generic errors are reported,
    we do have a rp_error(...) with details.
    
    > Furthermore, in the use_atomic case (also below), when a commit fails,
    > you assign err.buf to cmd->error_string rather than a generic
    > "transaction error" message. What differs between these cases which
    > makes the generic message preferable here over the more specific
    > err.buf message?
    
    They are the same now.
    
    > Repeating from my earlier review[1]: This is leaking 'transaction' for
    > each successful commit (and only freeing it upon commit error).
    
    Right. I thought I had it covered with the else clause. Of course not.
    
    > At the end of this function, strbuf_release(&err) is invoked, which
    > leaves all these cmd->error_strings dangling.
    
    I removed all assignments of err.buf now.
    
    > goto's can help simplify error-handling when multiple conditional
    > branches need to perform common cleanup, however, this label
    > corresponds to only a single goto statement.
    
    moved up again.

 builtin/receive-pack.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 915ad3c..7e3bbe6 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1110,13 +1110,16 @@ static void execute_commands(struct command *commands,
 	free(head_name_to_free);
 	head_name = head_name_to_free = resolve_refdup("HEAD", 0, sha1, NULL);
 
-	execute_commands_loop(commands, si);
+	if (use_atomic)
+		execute_commands_atomic(commands, si);
+	else
+		execute_commands_non_atomic(commands, si);
 
 	check_shallow_bugs(commands, si);
 }
 
-static void execute_commands_loop(struct command *commands,
-				  struct shallow_info *si)
+static void execute_commands_non_atomic(struct command *commands,
+					struct shallow_info *si)
 {
 	struct command *cmd;
 	struct strbuf err = STRBUF_INIT;
@@ -1148,6 +1151,50 @@ static void execute_commands_loop(struct command *commands,
 	strbuf_release(&err);
 }
 
+static void execute_commands_atomic(struct command *commands,
+					struct shallow_info *si)
+{
+	struct command *cmd;
+	struct strbuf err = STRBUF_INIT;
+	const char *reported_error = "atomic push failure";
+
+	transaction = ref_transaction_begin(&err);
+	if (!transaction) {
+		rp_error("%s", err.buf);
+		strbuf_reset(&err);
+		reported_error = "transaction failed to start";
+		goto failure;
+	}
+
+	for (cmd = commands; cmd; cmd = cmd->next) {
+		if (!should_process_cmd(cmd))
+			continue;
+
+		cmd->error_string = update(cmd, si);
+
+		if (cmd->error_string)
+			goto failure;
+	}
+
+	if (ref_transaction_commit(transaction, &err)) {
+		rp_error("%s", err.buf);
+		reported_error = "atomic transaction failed";
+		goto failure;
+	}
+
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
+	return;
+
+failure:
+	for (cmd = commands; cmd; cmd = cmd->next)
+		if (!cmd->error_string)
+			cmd->error_string = reported_error;
+
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
+}
+
 static struct command **queue_command(struct command **tail,
 				      const char *line,
 				      int linelen)
-- 
2.2.1.62.g3f15098
