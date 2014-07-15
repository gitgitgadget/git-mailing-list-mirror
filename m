From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 07/20] commit.c: use ref transactions for updates
Date: Tue, 15 Jul 2014 16:34:05 -0700
Message-ID: <1405467258-24102-8-git-send-email-sahlberg@google.com>
References: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 01:35:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CFv-0003dK-If
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbaGOXf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:35:28 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:34864 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934275AbaGOXeY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:34:24 -0400
Received: by mail-ob0-f201.google.com with SMTP id nu7so34760obb.2
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZBDmgLCGgNDFRUQLCfVOAQZfX+16wEt2V0gpq6gyVcM=;
        b=juLK+QvjaLSVStFgXSh0uhJ8bRFlfumqstKdf8pC0NXRqMQRjH7p7kHTh0Eb2+WtFK
         /b1dwDY5dtx+fg+aU7YU/+u2kGcH5FT22WC/MTzDXiMFN5JOQzGXvcBb5ewiUfGZgPRJ
         d9+5wa3/TxrnxLpkZYfXoWk+DLvUIh0PGazsmOAsbr9xZ7+CkuJI/p4DuJo2hND7EmQQ
         xRO6z16h2hkbPrHIV3b2LPAivTLS+EV7DUH4gBOV2liQbGLnoZzNNw9/nvgssaFqK9O0
         E7gcJ65Qp05RXNTfxYEY4T9L4wTMa8iiyyiJXNxmCxCSsS939edtHiQ9pZm08I7U8gpF
         CCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZBDmgLCGgNDFRUQLCfVOAQZfX+16wEt2V0gpq6gyVcM=;
        b=giSKCN3K62+FmouCCqWwOjBU55AyEAa06uiwm9M9kwDP6VWpPEt6opB4tMYQMvNMaC
         tmc88PL34LqBjhQpOBXjvDQStaTFnEguJcbgnQkrUfCNAxrsc8UbN9mre3OVLL42iONO
         sVP5KgmMsLmkDkumxAgiAqR3r2JQNoiE3YcQegmJ8DWh5MSEt17xUAsuZuZ7V6BInJuT
         f7HjPYD/Qd0R5vKz+R/Gw9V23dKdZGCcbhyVf9s7EIA/8IK7Ybq06v84vE6mqUtpFvsf
         bmOfHD4k+UZY2slYhcW8rpEXMgFZJ9u/UwxTQvOeYiuznZU/yEOO5cC0EhA08K/4FNHw
         q2jA==
X-Gm-Message-State: ALoCoQnBh881bDEglh/j33RAW/trKHI6ymdJU9+nyucXFwtODNZAyydLuDxd6TQPyqdr8pVM/nuC
X-Received: by 10.182.28.5 with SMTP id x5mr13422507obg.44.1405467263853;
        Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j43si1059800yhh.5.2014.07.15.16.34.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B0F9531C2D7;
	Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6D147E0B27; Tue, 15 Jul 2014 16:34:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.481.gb244468
In-Reply-To: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253642>

Change commit.c to use ref transactions for all ref updates.
Make sure we pass a NULL pointer to ref_transaction_update if have_old
is false.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/commit.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 5e2221c..668fa6a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1627,11 +1627,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	const char *index_file, *reflog_msg;
 	char *nl;
 	unsigned char sha1[20];
-	struct ref_lock *ref_lock;
 	struct commit_list *parents = NULL, **pptr = &parents;
 	struct stat statbuf;
 	struct commit *current_head = NULL;
 	struct commit_extra_header *extra = NULL;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
@@ -1753,16 +1754,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_release(&author_ident);
 	free_commit_extra_headers(extra);
 
-	ref_lock = lock_any_ref_for_update("HEAD",
-					   !current_head
-					   ? NULL
-					   : current_head->object.sha1,
-					   0, NULL);
-	if (!ref_lock) {
-		rollback_index_files();
-		die(_("cannot lock HEAD ref"));
-	}
-
 	nl = strchr(sb.buf, '\n');
 	if (nl)
 		strbuf_setlen(&sb, nl + 1 - sb.buf);
@@ -1771,10 +1762,17 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
 	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
 
-	if (write_ref_sha1(ref_lock, sha1, sb.buf) < 0) {
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, "HEAD", sha1,
+				   current_head ?
+				   current_head->object.sha1 : NULL,
+				   0, !!current_head, &err) ||
+	    ref_transaction_commit(transaction, sb.buf, &err)) {
 		rollback_index_files();
-		die(_("cannot update HEAD ref"));
+		die("%s", err.buf);
 	}
+	ref_transaction_free(transaction);
 
 	unlink(git_path("CHERRY_PICK_HEAD"));
 	unlink(git_path("REVERT_HEAD"));
-- 
2.0.1.442.g7fe6834.dirty
