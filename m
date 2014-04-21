From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 08/13] commit.c: use ref transactions for updates
Date: Mon, 21 Apr 2014 15:53:26 -0700
Message-ID: <1398120811-20284-9-git-send-email-sahlberg@google.com>
References: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 00:54:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcN6k-0008Rj-PP
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 00:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755025AbaDUWyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 18:54:31 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:33583 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774AbaDUWxn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 18:53:43 -0400
Received: by mail-qa0-f74.google.com with SMTP id w8so822849qac.5
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 15:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pe/xuTlcMiT72TvaEfPq9nzrLw+iTEuAgjSVY1cCuaI=;
        b=ImiAnkOKMgeGA50+ZX6xrbQD8e+JtYvakyOlKZqFhdMs13oVZCtMiPLOym1kmY+KaY
         4Jhh1x6gq4r57qW6D7tiErdAl0jO/k9o3GBvPBJXI77fuzX0zQS8nhgT34rzdSS/2wA1
         NoGa5Vw2Uvnh59N1DkLzt4HkQF8Sx1I4dYE2J0B0XYMOqm2zXR4eolr8AnWn9uXxVwi/
         Zk5DkiD5qiRyw4FEW+ZMdZzWO50Tb6vlt8hwPOdzwXgizTVQOnZKQZkXzYBOE+WFcaUF
         w5vB+jBUuiav0CwH78gwmJzm6jDQZbKsCTpVqnvd3PwwMU5zAFst58Yu62hY9gk95L+b
         YUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pe/xuTlcMiT72TvaEfPq9nzrLw+iTEuAgjSVY1cCuaI=;
        b=BqxDEZwV9iAVn47w3v33slV3XR/rEJMDGROVe2PSf5HIsxswOURwPpq8WxGFUgtaqB
         AWevo0YAoUqgGz5oqw7HlCZQE1CSNwsaOG+5GtgmyuHZhC6zocg9cJwV0Sw5cUeguRI8
         YLuzoZaNU2S7fVd7lEv9hXRbOxtHn6/lr6JCTTt0Xbrl+2i5KTryfr1/8yDafyPeCzK7
         Ta5ini4Jagu9YFxYebykQ3KL9K+PCiKdLqo1BXsbXuBvQoJz89Pn0pB2QQBmTeLEW4TZ
         lXXnarCHkBg1O5qbVOjYacQRxj/9uEiDtOBo9fhl6z7qARmkjoTnEZ2TI2t4lhXHmMe3
         F2Xg==
X-Gm-Message-State: ALoCoQmSvzZVX3Or/WK/qk7lNWqUX8JJIGe2LZacZ146SMUIxETkOEPQlrGIyNWvw74TiTPvxAcDkWjYl8P9X8y3oR1STLo4phe6nJCEML7MsDbQi418I6mBpvRX0ZXlw5lezoh5R0+47PIUnzVisAcI0/jGtZnPvkLNcYLYzJKKdWo0PYlxJy2fFN/7hqGG0YSgyRK5gdHz
X-Received: by 10.236.29.51 with SMTP id h39mr17795754yha.45.1398120822813;
        Mon, 21 Apr 2014 15:53:42 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si1894201yhk.4.2014.04.21.15.53.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Apr 2014 15:53:42 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A85655A4207;
	Mon, 21 Apr 2014 15:53:42 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6D5FBE06AA; Mon, 21 Apr 2014 15:53:42 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.515.g3b87021
In-Reply-To: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246670>

Change commit.c to use ref transactions for all ref updates.
Make sure we pass a NULL pointer to ref_transaction_update if have_old
is false.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/commit.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d9550c5..1b3c764 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1541,11 +1541,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	const char *index_file, *reflog_msg;
 	char *nl;
 	unsigned char sha1[20];
-	struct ref_lock *ref_lock;
 	struct commit_list *parents = NULL, **pptr = &parents;
 	struct stat statbuf;
 	struct commit *current_head = NULL;
 	struct commit_extra_header *extra = NULL;
+	struct ref_transaction *transaction;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
@@ -1667,12 +1667,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
@@ -1681,14 +1675,23 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
 	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
 
-	if (!ref_lock) {
+	transaction = ref_transaction_begin();
+	if (!transaction) {
 		rollback_index_files();
-		die(_("cannot lock HEAD ref"));
+		die(_("HEAD: cannot start transaction"));
 	}
-	if (write_ref_sha1(ref_lock, sha1, sb.buf) < 0) {
+	if (ref_transaction_update(transaction, "HEAD", sha1,
+				   current_head ? 
+				   current_head->object.sha1 : NULL,
+				   0, !!current_head)) {
 		rollback_index_files();
 		die(_("cannot update HEAD ref"));
 	}
+	if (ref_transaction_commit(transaction, sb.buf,
+				   UPDATE_REFS_QUIET_ON_ERR)) {
+		rollback_index_files();
+		die(_("cannot commit HEAD ref"));
+	}
 
 	unlink(git_path("CHERRY_PICK_HEAD"));
 	unlink(git_path("REVERT_HEAD"));
-- 
1.9.1.515.g3b87021
