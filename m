From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 19/41] commit.c: use ref transactions for updates
Date: Tue, 27 May 2014 13:25:38 -0700
Message-ID: <1401222360-21175-20-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:28:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNyg-0004zy-Bf
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576AbaE0U1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:27:35 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:52763 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbaE0U0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:05 -0400
Received: by mail-oa0-f73.google.com with SMTP id i4so1918952oah.4
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z3IkT1ysRnWNPlw7OrgxayHvtqi7awRsZ0EH0AHmP+8=;
        b=H1Y2rmug9MFP0GHxaEMTi88r/qPIo6H7YnMKTBnrJ3TYoS5b+MyHguZZkVvH5F25nU
         HtC/UYWolElo21EEuf3lGEUrhvThWDDB3dyB1IHf1+vI2efAZuLDmzj1joSR6oYYUOM7
         mDoGCkNQe9Uh6TBKGgi3cydRN+qxBVJG6OQ9YQAtR72IBlIqqwumxYozmI3g56EfGdVr
         /3cCL3ja13FZ/r7iUBhLZoCB03r5EwiCf4B49LMURkBsX4pawZ3WdX2PORDV0gkyODN9
         0N2McoziXXApPHcFYNZZR6pguJDSLtC5yVY51DjLdspl3p7GKjoF3CYJSggpEfntZ4Ba
         V3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z3IkT1ysRnWNPlw7OrgxayHvtqi7awRsZ0EH0AHmP+8=;
        b=iiVSVrzuX5nc+nkIezQ/pUivKYlieBxOtxVLTB/ubql7KbhBj2EjoeIu/xXNEdw57m
         anMLnGMoXJ8C5JDym5Zt2w4tnHmOhcDfE8Mqr5vjdJyvb9n2hbwVbW+t9xyI4qNDBrXG
         vckzIzWelhPHGwkX2Ef7C7e3PDbGcOvRB7EzpaNohr661wHgOHvLD3K/4TflUkr/zUON
         7TrpQnqwOgqHmkV90r44yXK9SqSTH152Aklu65XZ3KqUnjno8SbM4cKSj7rS6TCi2ZXV
         YV/ubhN6XjJkF73xBo5SGnhkOL2KuxJ9p/fXOsBCLwBTe/DJPz6Zplp+TeMk3yDDdrrD
         2JHA==
X-Gm-Message-State: ALoCoQldLqdcJFPiVV1KKQATTFLV4Ffww5ESvs2jAHA3Ba/gbBpjtggYTSrR7bFrG2dtmgaBsV65
X-Received: by 10.182.104.161 with SMTP id gf1mr14922475obb.45.1401222364545;
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id k43si1575169yhq.3.2014.05.27.13.26.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 65E832F4AE1;
	Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4247EE1958; Tue, 27 May 2014 13:26:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250231>

Change commit.c to use ref transactions for all ref updates.
Make sure we pass a NULL pointer to ref_transaction_update if have_old
is false.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/commit.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d28505a..7db194f 100644
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
@@ -1725,10 +1716,17 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
2.0.0.rc3.474.g0203784
