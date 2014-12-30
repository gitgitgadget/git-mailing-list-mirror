From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv9 4/9] receive-pack.c: add execute_commands_atomic function
Date: Tue, 30 Dec 2014 15:41:33 -0800
Message-ID: <1419982898-23108-5-git-send-email-sbeller@google.com>
References: <1419982898-23108-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com, mhagger@alum.mit.edu,
	jrnieder@gmail.com, ronniesahlberg@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 31 00:42:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y66QO-0007uT-IV
	for gcvg-git-2@plane.gmane.org; Wed, 31 Dec 2014 00:42:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbaL3Xl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 18:41:57 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:65183 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbaL3Xlu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 18:41:50 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so13203735igi.12
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 15:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BSHDKY6UPItvB71rTTsnLXKSKv1kauVKY8fI6EyMA1Y=;
        b=lFzWMF26gXlS5Igo0GBVE/zMZzaSHwDPVSfEzJh6jlcX4YcLAOmq5YTUmXNLdED/tf
         R7G2Yijno++EuGHIdbxrHtfW3Dvd/ewFwWBOI8GQITLwDduyprsHynV3P6plYQC2Sqlj
         xmbwdxvUx0TdhYIZJcVq01yTWGI5fakR7PIqHMUH40bx6PLSQbVCwILiNzPfxPP9czso
         bVg3xg1GyyYbi07TzCTZ9WF/MvWw7B8P2dwDqcyj8D9/CzwC141uenlr4bHlK50YtssH
         AAzOlY8OlBCwySC9kl+i7/pr6VRyaCPeBRyuNqarcpsKcaDnxxHtm82y1wVsAlgzgq0L
         GIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BSHDKY6UPItvB71rTTsnLXKSKv1kauVKY8fI6EyMA1Y=;
        b=kqhDO4we/Siv+oO5J28H4aYRhctENfS0h1EoHH3H+TZ+M2brvedTv+XwvrLcWT4kuQ
         0/MpPfUGl9oM9KClXSSzp/5wT7wKIEK8tcf8ACl2f2pUNHr7zS62NjFPOHtsM8/qPdCP
         UXOUzNSWhzCOxr5vfDr+hEdzOaRELRrjDQvcClvKMe+gfvRS7J+GuT3TyQOr15fj3sZP
         C+QNkUeSZF6niampujyTx21vmqeELC46lGQ64jge6ziqgGa2kL5H51z/zOGa0fNoqtDl
         pd/PKAFIrSgfCcGXvf5+rZeetUl2evFRpQ/p5fSuscx6eH6gAWXWn/TfLO0U/7wLQg7Q
         eW8g==
X-Gm-Message-State: ALoCoQmGjL1ygtnmkKLCESx65eUl+F8BgciH34XvZ5DCfFUvBtRmjJzZbNZc8AXgpgqpczhFbj0O
X-Received: by 10.43.106.147 with SMTP id du19mr37136304icc.22.1419982910013;
        Tue, 30 Dec 2014 15:41:50 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e545:220a:6cf6:2fed])
        by mx.google.com with ESMTPSA id bd5sm16266310igb.14.2014.12.30.15.41.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Dec 2014 15:41:49 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1419982898-23108-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261959>

This introduces the new function execute_commands_atomic which will use
one atomic transaction for all updates. The default behavior is still
the old non atomic way, one ref at a time. This is to cause as little
disruption as possible to existing clients. It is unknown if there are
client scripts that depend on the old non-atomic behavior so we make it
opt-in for now.

A later patch will add the possibility to actually use the functionality
added by this patch. For now use_atomic is always 0.

Inspired-by: Ronnie Sahlberg <sahlberg@google.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    v9:
    	Because the patches have been reordered, we introduce use_atomic
    	in this patch, but don't touch it.
    
    > Minor comment: This cleanup code is repeated in both the success and
    > fail branches. It _might_ (or not) be a bit cleaner and more
    > maintainable to replace the above three lines with:
    
    	Personally I have no strong opinion about that one.
    	I implemented it as you suggested, having a cleanup and a failure
    	label. It seems to look ok and has less lines of code.
    
    	However writing this code made me feel a bit like producing
    	spagetti code here. ("Goto is evil!", I accepted goto as a
    	convenient way to have one common cleanup or failure before
    	exiting the function before, but now we have two jump targets.)
    
    Changes in v8:
    	removed superflous "}" to make it compile again
    
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

 builtin/receive-pack.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 36e8795..d431e97 100644
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
@@ -1096,7 +1097,48 @@ static void execute_commands_non_atomic(struct command *commands,
 		}
 		ref_transaction_free(transaction);
 	}
+	strbuf_release(&err);
+}
+
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
 
+	if (ref_transaction_commit(transaction, &err)) {
+		rp_error("%s", err.buf);
+		reported_error = "atomic transaction failed";
+		goto failure;
+	}
+	goto cleanup;
+
+failure:
+	for (cmd = commands; cmd; cmd = cmd->next)
+		if (!cmd->error_string)
+			cmd->error_string = reported_error;
+
+cleanup:
+	ref_transaction_free(transaction);
 	strbuf_release(&err);
 }
 
@@ -1134,7 +1176,10 @@ static void execute_commands(struct command *commands,
 	free(head_name_to_free);
 	head_name = head_name_to_free = resolve_refdup("HEAD", 0, sha1, NULL);
 
-	execute_commands_non_atomic(commands, si);
+	if (use_atomic)
+		execute_commands_atomic(commands, si);
+	else
+		execute_commands_non_atomic(commands, si);
 
 	if (shallow_update)
 		check_shallow_bugs(commands, si);
-- 
2.2.1.62.g3f15098
