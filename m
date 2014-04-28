From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 13/27] commit.c: use ref transactions for updates
Date: Mon, 28 Apr 2014 15:54:28 -0700
Message-ID: <1398725682-30782-14-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:56:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuTA-0007EB-OI
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057AbaD1W4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:56:05 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:36479 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755325AbaD1Wyv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:51 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so570086vcb.4
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aYFW2aeWvEOZTtSxS4EEWGjwZHDklb7inam8cc9SM+I=;
        b=S+InJ6itrve4NFEwPMgPmYoQJT5NeeTkcS/depc7B1PNrKiRNq13KUIHnfP9vM7RSh
         zfKFKdNcaE1ED4XwYnsJLyypEBUTrf3JP8CA+mEUc7VGgnEDno7beLzDKFNlJWrOftV5
         bQ/85HEZeqLkmnqspDvs2NAB8eCGZl5UcUwrPAFm088PZRrlW+Et+yJZ6yyxSZRqwX4B
         19IZbhScbknZt3Y4g5oAz53RboTu2Z0FGb3DFKETTcJNLelbCENmhVhFQOKwiJz680mx
         iil4Z8gfld6SRG+32vi/rNwKeVzfQi1pll8rTlxMX1yEarXEK6fAQCYT60QIa02o9udu
         tc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aYFW2aeWvEOZTtSxS4EEWGjwZHDklb7inam8cc9SM+I=;
        b=E1G7T1vQRp6FZUEMEXg9BmiRLrqXnG9ZF8y7QYT/eBzw4b2gPujSL690SkCVegkDrl
         pjzbJ5pruvooqF9MjTwiMD5n5G/nF6ZrIw6cIprdt5PYq5hdxMnGTHsLhCShdGic9l2X
         tCK0Rasyd+f/ZL4tOQ+0ROomZYbuFbC+y9hcrbcfre3HucxIB4KAnfzJllNs8bjYBqdj
         j4GHYA7M03EVGyuM018F4ltnCH+qJZkweur7LDGkDQcXR3z7V0wKkuxqXaSMAf53IBrc
         vAWrMao35GxK7DmkFHbHebuNtOvaBTrLZ+R63VnVwxaPopLR9wxQNoEgnRNqWjJee4mM
         vpeg==
X-Gm-Message-State: ALoCoQm4FNd5li0LHyb8dr5zT+Gp3NjUgmajkP24Q3vezxmFJSjd6XF1BpPyl7cyhqFXyNJpYV396bxmcL3d8Ye2cUq9J9rkW/A2tWw1WtjpOImXyWEXDcTsWiEMX8yn+CTDpCOD641xCTjmLKP44MdLQx/jQqcF0PAlPnGuQ9x26Ud1ylGhaaL7lCjWe0vA2a5nrJ15JA3q
X-Received: by 10.236.36.33 with SMTP id v21mr1782337yha.53.1398725691311;
        Mon, 28 Apr 2014 15:54:51 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si1424558yhl.7.2014.04.28.15.54.51
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:51 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 26F3531C20B;
	Mon, 28 Apr 2014 15:54:51 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B0203E080D; Mon, 28 Apr 2014 15:54:50 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247480>

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
1.9.1.528.g98b8868.dirty
