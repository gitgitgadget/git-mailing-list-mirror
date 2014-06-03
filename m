From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 19/41] commit.c: use ref transactions for updates
Date: Tue,  3 Jun 2014 14:37:37 -0700
Message-ID: <1401831479-3388-20-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:38:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwPe-0005YP-Uo
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934347AbaFCViX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:38:23 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:55661 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934227AbaFCViI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:08 -0400
Received: by mail-pd0-f202.google.com with SMTP id fp1so706854pdb.3
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3nz07Jq1ZnyAtnY2P3iTE2nE7Bs+nUoDB4bsOog+Mq0=;
        b=VUdYxR9z8ec4RVsUfuHVLEC1b0EHLcYkpdArSnzyDE+vMqflsXmU31WU7KGBX+nBE4
         iBnwSsI1ya8Etqo0Na2B/wtIO/QmtfUXU0+0MPpW4eYHKxmqImS6WVT3skKq2Y+K05Sm
         68cUVDSoodDLXYSdtpzjtnm5HcCAMt3xijQxMUqagycnMqkWO+iAkRfp0JMJoHw84THE
         B193zCOtvJkjtzmUkBMeC9OrluvYCQF9DWG2ynpmJQ/yKi9BxWLkk17wTp/xRAgGKyJv
         M6y4SsUAyImJy1S3C0xR7ZzkYmJN4reAaDR+3rqRSvdXSK7F0rtc0gq7jibLxxb6yH1n
         YwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3nz07Jq1ZnyAtnY2P3iTE2nE7Bs+nUoDB4bsOog+Mq0=;
        b=Iy5qhIU8o3/pI0lN0ewiqm3k7c/8TaPj3HEhwbwNnu8eHLjeJZk4wfqT5DwPeGTe6y
         J1BAmAZCK3UCOdoJGWW0dy63GaHer63m4bJs6vSbKSoNAn1NIw1JNjZcLfzK+GqQmdVq
         fOOoT852x3XTWzbFPY09fDVdB69kD04dRf63+r4TDB/pUwfG4ZDjU9VKQZ0+hkJWckLP
         7rBzBlIAWAyhs9e91Cc5qgaGDxMs/I+8b+k84rIoHR29XZrqA+NhlvqIo42QQ3Fo6Evd
         yLb54avC8PMYi7VBs467fDGtp/Vanc9o87t2NewukU1uTF4/VDs+aOLf2Zx6nHCNgwSX
         TDeA==
X-Gm-Message-State: ALoCoQma/mcEHNHR0gsx//peXCzwh1uQy2ZV9MqXBuk54l0nUkQN//LrKC3OkyPBKoa+ICL9vWtH
X-Received: by 10.68.137.99 with SMTP id qh3mr17424044pbb.2.1401831487844;
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t4si8970yhm.0.2014.06.03.14.38.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id A2FED31C4B7;
	Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 37BB8E11CC; Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250654>

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
2.0.0.567.g64a7adf
