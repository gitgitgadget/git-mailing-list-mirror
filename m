From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 26/48] commit.c: use ref transactions for updates
Date: Fri, 20 Jun 2014 07:43:07 -0700
Message-ID: <1403275409-28173-27-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:46:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy04t-0003ML-SX
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101AbaFTOpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:45:46 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:34721 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270AbaFTOne (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:34 -0400
Received: by mail-ve0-f202.google.com with SMTP id oy12so505199veb.1
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P3rHUL0PbWjsi1y3CmL9cZ3vh2gzH1fjYfoNhVZyyLI=;
        b=Yd2DrWsZflim7/MmUiVCxzIjTrJEUbHHzTkj5WXdJtr2BMdsyKbw1WWBoVEEZmqr9N
         tfR2/HLYAyeXLpxG2PYtE3cJjdrrpJPfnkY6/MrZvQzbGSLkAH4YTY/RLjRE6fhUi4SV
         eaUvuiqQ/j0nQSbqwYUq+2XBAFr8x0EqokmKWv3DqLDK2ocLCKkxaAD5UiO2feyUohXt
         iSgeaJVkIJUhtITRO2G0hESFAgEBcb7CKiNsIPB1H7+KUHTfW4QQpGbaYks33FYeZv48
         uCAOuxZCtdpZc9n+wAeAjUpUKqf3/EL/Trb/X6cIpdfx8EpTZRpJ46fAfrFsLNtULM0M
         /Y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P3rHUL0PbWjsi1y3CmL9cZ3vh2gzH1fjYfoNhVZyyLI=;
        b=GIjywb5+BlCNmm7mbsVfGMTKfNqXaje3+j0yYDjL3ZwYb26QtzHIVS69Nn2lH35VKJ
         /5NWHnnwIFgAQ0opQivGHytnEDlLTfUqSBk/QL35+YD84LCkHjWIuuwvMT2OKb0V+kPq
         MYfBwUdRv98wQlUsyqKSkxc9oNGpTvYj42ObpOfMjI7jM/Jjc6w/mYCCHL1CI450m8OA
         OIejuo4QidgWKjAoSwduJO1/qZYA6KADRGCrZqttKcczNhOXMTl7TGPhrpRs61IYpASP
         +fZhzq67usEblDdWVlfxavG6i9wxjnrsxguY+aHyeL8udLduGvo+oI7Bt1JBz8FUqklz
         HXAQ==
X-Gm-Message-State: ALoCoQmte0CCWmBdwdKjecjLudWo3JLYvXsyy0ew4Y9qhoyzFezgWK7aOk/ArhKN/qbgFdBpqBc3
X-Received: by 10.52.114.42 with SMTP id jd10mr1314579vdb.0.1403275413226;
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si663240yhl.7.2014.06.20.07.43.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 18CD131C6B4;
	Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E9423E0651; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252252>

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
2.0.0.420.g181e020.dirty
