From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 13/30] commit.c: use ref transactions for updates
Date: Tue, 29 Apr 2014 15:18:58 -0700
Message-ID: <1398809955-32008-14-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:21:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGP8-0003nO-3X
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965339AbaD2WUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:20:33 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:61735 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965275AbaD2WTX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:23 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so139987qcz.4
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PiPdiA7nKYPbdE2C6RNNbkfvSBWhGeuvgp0E/VufvoY=;
        b=kdyZn1cTdv/YWDKesGPNcC/AOgF7rg8YrFWB03KabWf4/utw5m9RzWerZ8IROKrk1d
         LW1FPFWcLLH4zgbVukF8QKMPOdyA4XUA2tc6OxvDTRnyo0JMHzIgMMqfGcAuBnkm9ThX
         wpBhjjail+h1VzN+XoXYoWkuXFncZRXBB0T69hP+P7SSmnZKTkyrHqzKv0Lj3X0YcoUV
         umOeN6qaUAnEX0JT4sbrk6jaxg/B7dxt5BnJ70qLlYu+rw6b16oXgx/4Uy/uylcNqT6y
         rO8RxM368cZXlHSN1i6cytU5ZLnjVbojg2/xS3jRJFgyOcs/v7TBMthtxdbkXntGyRJX
         fLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PiPdiA7nKYPbdE2C6RNNbkfvSBWhGeuvgp0E/VufvoY=;
        b=dncNxNkITmGWTmk/SnzMRuUIkcIE0fWNLvhTyLyGV7D9RtxbMwfav95hkpxYyZTV2v
         o1CnfGtZL9LT7sn0t15CB1gVX/At4w8Rwp8x0Kwjihp8qLmF9woHBRxPtNvq/3ffHb+f
         LKSPcamGjJM9CcNMkg84U3Su+TBlrUmFkO/3fpqUBRV6m6KQhfmaLT6SKMXafEFsSY+2
         WsGXELn1kIyNXLDMaEfK83BREj9jVy7h8/sguRB5leMUHSohTQUHf2nybUETFHt8I2C2
         uMOIeFC+uw4r/Ck02g+ACAhHtkvyVTR9uCShOaE4XGVoPvhGnDUZqvBIyRlCsi4MPyTx
         yvGw==
X-Gm-Message-State: ALoCoQnpwKu0m+JN/96UdS4fEs4S6WUhjJW/20O3dWBaF7E5v9sdONSE+6a1ZkMOrC4WaV9OV9aJ77eZLOkX59dTRF7Mg9isovaiJXzZAN7r55RhKVsBfQNw6181e60K1hRREd8HVhXlAcoMGqTSJy85Gg2fUtJ6e5+nLSVCFD/AQx89U/xgHwNeeLTerXPSSLhnDa/5BNlp
X-Received: by 10.58.210.2 with SMTP id mq2mr299053vec.3.1398809963032;
        Tue, 29 Apr 2014 15:19:23 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id g21si2739686yhe.3.2014.04.29.15.19.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id DCEF85A4121;
	Tue, 29 Apr 2014 15:19:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A1A96E0B2F; Tue, 29 Apr 2014 15:19:22 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247648>

Change commit.c to use ref transactions for all ref updates.
Make sure we pass a NULL pointer to ref_transaction_update if have_old
is false.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/commit.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d9550c5..a56f47a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1541,11 +1541,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
@@ -1667,12 +1668,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_release(&author_ident);
 	free_commit_extra_headers(extra);
 
-	ref_lock = lock_any_ref_for_update("HEAD",
-					   !current_head
-					   ? NULL
-					   : current_head->object.sha1,
-					   0, NULL);
-
 	nl = strchr(sb.buf, '\n');
 	if (nl)
 		strbuf_setlen(&sb, nl + 1 - sb.buf);
@@ -1681,13 +1676,15 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
 	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
 
-	if (!ref_lock) {
-		rollback_index_files();
-		die(_("cannot lock HEAD ref"));
-	}
-	if (write_ref_sha1(ref_lock, sha1, sb.buf) < 0) {
+	transaction = ref_transaction_begin();
+	if (!transaction ||
+	    ref_transaction_update(transaction, "HEAD", sha1,
+				   current_head ?
+				   current_head->object.sha1 : NULL,
+				   0, !!current_head) ||
+	    ref_transaction_commit(transaction, sb.buf, &err)) {
 		rollback_index_files();
-		die(_("cannot update HEAD ref"));
+		die(_("HEAD: cannot update ref: %s"), err.buf);
 	}
 
 	unlink(git_path("CHERRY_PICK_HEAD"));
-- 
1.9.1.532.gf8485a6
