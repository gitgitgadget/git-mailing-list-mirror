From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 19/40] commit.c: use ref transactions for updates
Date: Fri,  6 Jun 2014 15:28:57 -0700
Message-ID: <1402093758-3162-20-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:31:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2fw-0003X3-GH
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369AbaFFWbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:31:32 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:56024 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbaFFW3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:23 -0400
Received: by mail-qa0-f74.google.com with SMTP id j5so680734qaq.5
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iSweqmWwhszdycvSz5oxT75205e2QW6WTt1G2NKFc50=;
        b=LDutios5X72G5ssvfqq1Z+YNaz7ZJFuEkoI9nvCMMbe6SchKVpVvSpG510SVSFqkps
         ekoWTMVeHz9xpifB7Y5iAZ+7DmX1wREEbRx/AIoYpwkOGXnEMmErJfOjjsjxrXCyLY5j
         aJBZURDhi8Mc3XzBAHRmkMDcxw9gR4OAoIfl51TyL9SVNgPptIQUhXVXHV3/OOAavs64
         U3TwrQ+HNs09QrdcRqexgSiN8d77uw9VZmvztBRSPLrxYZIuRKWQgJ0Gc92gyZRE837e
         r6eUCR7RH/BSA7MEfvqTuhUWA7mcofTjOfhMqTvcZV+R7WjWWxgeyN+UOw0h5I4OLJED
         BpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iSweqmWwhszdycvSz5oxT75205e2QW6WTt1G2NKFc50=;
        b=BuiqJMo90vkmRj32i5eXKGnGQ/rJzX6fmAlLmfs5GUGDr8siVAWAn7mv5Rqf8/8wyT
         cNc/2Rf2Kgu8CHOXhQrkPcWgzSNZ0fv0gzce6cDbAVtNi6cNJj+o6twyriqwcuiwpxoT
         v9fEDX45nzfhHArsXarbiPig0v+I6gB0oFHkOljWTAerfsuwmAw5PPfZI30zGReCSbGg
         HEuQVuBYjXLAASWrI59mOij6i3ZVmef6gZEM412JsFniBH6RtJgBMsX3j8xMYi67zEdm
         smP55cp/Dk7te4mMxGghlipHU6gdediLSysBHxZUID+5i0mGfYYtV9fA4mY715hXPofo
         pPRA==
X-Gm-Message-State: ALoCoQlCX80ufXHh4t8BYpFJtNrDsehYcwPBsaw4oW8ytPBgzEZIfy7q/Q3ZOo+Ks+/u0XS1DsDz
X-Received: by 10.52.27.174 with SMTP id u14mr1542200vdg.9.1402093762495;
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id xn6si751078vdc.2.2014.06.06.15.29.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 446B231C61F;
	Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 20EE6E1084; Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251010>

Change commit.c to use ref transactions for all ref updates.
Make sure we pass a NULL pointer to ref_transaction_update if have_old
is false.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/commit.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 99c2044..14cd9f4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1613,11 +1613,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
@@ -1739,16 +1740,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
@@ -1757,10 +1748,17 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
2.0.0.582.ge25c160
