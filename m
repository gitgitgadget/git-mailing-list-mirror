From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 23/27] receive-pack.c: use a reference transaction for updating the refs
Date: Mon, 28 Apr 2014 15:54:38 -0700
Message-ID: <1398725682-30782-24-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:56:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuT0-0006zr-7h
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756191AbaD1WzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:55:17 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:41252 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756080AbaD1Wy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:56 -0400
Received: by mail-pb0-f73.google.com with SMTP id rr13so623239pbb.4
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hhMF7oPX30qMPNBFseLpjg56mm0CNCn+mOQHPwFye18=;
        b=N0MAi0QzNZQH93u3dKi14zjDCgrvkWuJ4FAYM3e3n05FNtiI+XimNIqyxMnDmsT4UR
         zqWxF+xbtMTEw2EHpVaZNaxXT7+y9YygMpzoD44MtJbH7uLSpM1kxBcpFzTvVaeUDwKC
         B9xFFRjkjZHI52FL2zghIlmTe19SFBlLxOV7m5j6BDII2AURypyNd9PFUt1IYHh1W1Sq
         o6cd215fZWxcT90Lvyr/7vSsH2pdHAj7RZfN0vzpMwKNt2xUSdR2WpUdjUcckjvwLbiL
         DUOfsgGoZW5V1JYaKO8Ed0ZJ9vdSE98mq3KDZUKW24sqFVGtjDLxDvazG0F2N3VI3DKO
         Jpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hhMF7oPX30qMPNBFseLpjg56mm0CNCn+mOQHPwFye18=;
        b=f1Ns4PmJ7ltGQLWwsFaojEaE/SXLs7Cg+J7B+lL39E29QYka6xRLRvKzI19hTjK7nK
         wO5yh4IE7nSPjoyfNxOBT+xvMLBcIZf84J5nujaOKIBovS3WJRPOSXuf2Nn7rf6XTQQh
         tapnxTAHvTBq+QZ53KrQasG/R+dZUYbqZ52eTfW95KMSbsl3OQH8M64VwtxgBaiLocGI
         O+1G7UDsLHBjjn+f+gZxkNqz3iguoYqL0Wc3UT2zVHmuXnCk0m5G8Rk/C9l/ionJyOwR
         z/mTimZe9WFXp4Ha7NAM6MLVQRg97o7vJrevsT2Onvp75/8jDUfVRA5Ek4/85aKfoAd/
         oIpg==
X-Gm-Message-State: ALoCoQk3NFYEe9fAr1r32MGxOFZDfqoA6TMhJ0aKtM+SNG0m1+5XuIdcpa4uaCjDLRllnUs0eBRRxvySY+JBJByRZvteds54LTv1Bwz6OGZ759YTtNDM3XW1T/zAAK/2+A5EA+hukh2ZG06s46VCLqMVJQmZzG86KhONZfx4MxsGzdn9cpbg2OZ0hn0nAbFKH3X3w8kkJGJS
X-Received: by 10.68.230.193 with SMTP id ta1mr14389456pbc.6.1398725695764;
        Mon, 28 Apr 2014 15:54:55 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r64si1011533yhh.0.2014.04.28.15.54.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:55 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 92D7C31C20B;
	Mon, 28 Apr 2014 15:54:55 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4953BE0639; Mon, 28 Apr 2014 15:54:55 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247477>

Wrap all the ref updates inside a transaction to make the update atomic.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/receive-pack.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c323081..885aef4 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -46,6 +46,8 @@ static void *head_name_to_free;
 static int sent_capabilities;
 static int shallow_update;
 static const char *alt_shallow_file;
+struct strbuf err = STRBUF_INIT;
+struct ref_transaction *transaction;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -475,7 +477,6 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	const char *namespaced_name;
 	unsigned char *old_sha1 = cmd->old_sha1;
 	unsigned char *new_sha1 = cmd->new_sha1;
-	struct ref_lock *lock;
 
 	/* only refs/... are allowed */
 	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
@@ -580,15 +581,9 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		    update_shallow_ref(cmd, si))
 			return "shallow error";
 
-		lock = lock_any_ref_for_update(namespaced_name, old_sha1,
-					       0, NULL);
-		if (!lock) {
-			rp_error("failed to lock %s", name);
-			return "failed to lock";
-		}
-		if (write_ref_sha1(lock, new_sha1, "push")) {
-			return "failed to write"; /* error() already called */
-		}
+		if (ref_transaction_update(transaction, namespaced_name,
+					   new_sha1, old_sha1, 0, 1))
+			return "failed to update";
 		return NULL; /* good */
 	}
 }
@@ -812,6 +807,7 @@ static void execute_commands(struct command *commands,
 	head_name = head_name_to_free = resolve_refdup("HEAD", sha1, 0, NULL);
 
 	checked_connectivity = 1;
+	transaction = ref_transaction_begin();
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (cmd->error_string)
 			continue;
@@ -827,6 +823,10 @@ static void execute_commands(struct command *commands,
 			checked_connectivity = 0;
 		}
 	}
+	if (ref_transaction_commit(transaction, "push", &err))
+		error("%s", err.buf);
+	ref_transaction_free(transaction);
+	strbuf_reset(&err);
 
 	if (shallow_update && !checked_connectivity)
 		error("BUG: run 'git fsck' for safety.\n"
-- 
1.9.1.528.g98b8868.dirty
