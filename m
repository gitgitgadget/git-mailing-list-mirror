From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 27/48] commit.c: use ref transactions for updates
Date: Thu, 12 Jun 2014 10:21:18 -0700
Message-ID: <1402593699-13983-28-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:23:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8iy-0008VI-Rp
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933636AbaFLRXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:23:36 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:59581 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756246AbaFLRVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:45 -0400
Received: by mail-pd0-f202.google.com with SMTP id fp1so185220pdb.3
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zvvCuWkvFZEnYE096tK1ntm/GUqwVE5hG3fHmDdskTM=;
        b=WBgvaCBp8qc9i8LvwfijcFHAehrfsUGfM4cUDSeWZOZdw+UUGMFRj+Tl+K70bgVlv4
         DCK/I8JH34GluHZ4a2G9KcDSAhDgckR0PP4L+gv5lCq+4HXmopTIlZls24VMNo2Wcg57
         G0Z4T3sd4Whtv5quItE2YtzkJVf/Rs7z5d1cQ43eZhfTh1qxIizhD8d2akt8J1Av/A8Q
         GcO7SY1oxXZO0IX7m8A7ctMj/Xo/OlZypNblZKoNPTePZuMctYNXnCsWA5FbRx58tdxp
         BfnH6mj8VDzVMkL62bI+r6H3LhO0BJs7bzWnSbrmq59SfjRrrhgeXQcs6RzPpAKXXW1K
         G7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zvvCuWkvFZEnYE096tK1ntm/GUqwVE5hG3fHmDdskTM=;
        b=kRaxtkgKgzKXHpaKm92TaVRG+ut5CiiOxys1iHGLe806tmeUEZo4wBHd89r02pHriO
         iht7oWZ5iSkwHlhFY6r5uYKFO0rqy8ZAU9HvXU+Y2QWa/gIZyHNxmE1HuMn4rzsoznN+
         pJpyg3RlA3P5MUNtFF+LdB5Rixmziw3k0hQgZLkKkjbSHxVqVBLbJaHoF8vhI2884IEF
         Weejq58my1ukT1LTMBliz8Dbb9zmIC829DJRXdZ2vvB3Dk9WNHhAH/SAXjm4c2BacFoU
         78KV86ML63iaEcOE1mmkfDN49RZEaut2rQMdrg3lMgaNVojMlxoviKjWp5zDEyIZ59m2
         jcDg==
X-Gm-Message-State: ALoCoQkopqm5NKv/eKywd5LF+ZCmHyMzZE2/HqfX0zxLrwkwF2wnImZUaefTkF+zxlC/253Snqe3
X-Received: by 10.66.175.173 with SMTP id cb13mr5163952pac.10.1402593703905;
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si112565yhk.4.2014.06.12.10.21.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B6C4F31C66C;
	Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 93423E0A7E; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251450>

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
2.0.0.599.g83ced0e
