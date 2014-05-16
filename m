From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 15/44] commit.c: use ref transactions for updates
Date: Fri, 16 May 2014 10:37:03 -0700
Message-ID: <1400261852-31303-16-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:40:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM75-0003XW-Cq
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758142AbaEPRjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:39:43 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:37510 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757397AbaEPRhi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:38 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so886202yhl.1
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yJqv4wo8BpxXgCIKGQVV6YW7NqN8O87LioBujuUIPFM=;
        b=IEJCIWf0FL0NfVyipV/jm6r1XNqAM6dNVLzi0YMztvfYtdFfClAj6tPTjtRLyTqFqT
         5Np8WzHND4eD9DVAb84PkE16BGKB3HXF3Li1SGftlgTefMmyyzfDnOk8aGijZfBQ1LPu
         qVRTW7qFcofnj9Xt6eI7Jqy/So8XJfrJnH5Wac5UniAzopJr/2libFN25hZWIgNxzmb+
         FbeoVx9XUSuD9eeYjkOrsCigPxGscDvzVjctBF4N+KXtkDxVLSReDgZkRQ3E8D8+p7nf
         nIgYwp8LBATdGwe807PApg78niu519Bbi7VvS6K0b4TmAwbXFxftBSRGYCepNEKhH7ao
         AVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yJqv4wo8BpxXgCIKGQVV6YW7NqN8O87LioBujuUIPFM=;
        b=KsPhwR+JIh3U+UctzjDaU8x8vMaYwcfiOsIjL9q6hfEw3LCzkMpW2iriqWeJaUx2Dq
         YUg3Igdid+eO7LlgACR+/2dcD4rrTHAi4d4wroziEEtjjyf3pD7HRjV0Hm+3gDbIDR0D
         TLJEynoo/sVExjwQQnP4087Nyvu3k3oP9t0HIChfCDI6rfmivaa/NJW8GL9H0Wy9u9ox
         9k+6KlGZR1KYSnjjzY2Ws4ASLF9HuSSHWAT5mCARYi+1r5dkFtFfvKnFKUHNswG3DVCf
         ZETSNzG16+PhlpWAXIgEUs8qDQlMcJASvfxa7uX/258+SDMhPlfyhgaaIox63qET/LLS
         jWLQ==
X-Gm-Message-State: ALoCoQnRC/dT7j6YQXIaPjg1cqhdqX5CZjqeJthTu6UUJNkd5btpp6FiEG/YKUWRAPV1g/bu+fZU
X-Received: by 10.58.106.229 with SMTP id gx5mr1141854veb.22.1400261857288;
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id k43si442527yhq.3.2014.05.16.10.37.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1E8E031C211;
	Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id F0BBBE0C3A; Fri, 16 May 2014 10:37:36 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249396>

Change commit.c to use ref transactions for all ref updates.
Make sure we pass a NULL pointer to ref_transaction_update if have_old
is false.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/commit.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d28505a..c429216 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1581,11 +1581,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
@@ -1707,16 +1708,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
@@ -1725,9 +1716,15 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
 	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
 
-	if (write_ref_sha1(ref_lock, sha1, sb.buf) < 0) {
+	transaction = ref_transaction_begin();
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
 
 	unlink(git_path("CHERRY_PICK_HEAD"));
-- 
2.0.0.rc3.510.g20c254b
