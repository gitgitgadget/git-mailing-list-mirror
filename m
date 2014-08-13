From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 19/23] refs.c: add reflog backend methods
Date: Wed, 13 Aug 2014 13:15:03 -0700
Message-ID: <1407960907-18189-20-git-send-email-sahlberg@google.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 22:15:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHexK-0008Ln-O8
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 22:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753807AbaHMUPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 16:15:30 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:41271 "EHLO
	mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665AbaHMUPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 16:15:11 -0400
Received: by mail-oi0-f74.google.com with SMTP id a141so69904oig.3
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 13:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FGq8iBlF2ZC6eC7Usw3NKUnwm1aF4tm8whkb+14NlH8=;
        b=ElHBpfc5YsTgeb1a3sBHHWpBQVxgmNBDJL826XLFHh334zipT9M7QN7MbH0ZtDRVQA
         qVipqMUnMp7pCah5KtPbbhNjKYQakb+gT4oEmZctIp+35JHmTUrwOc1bzAQhzsr0xaj4
         SzzLeIba8XuMJ04x/+Uqdsjn6G8a4LK6CppB6AKYCfs3Gk8J8x576pcRHElp8yoj0lgK
         9YpiYZbi651W0CwjRRexCjTGw/lR2QZzs6r1PNg71ff4oztHFxRykYqTZVND5Q9pnZwb
         0eCqwBE8guvZNzYMSrptyjINnqxO6c4jQoG9H6nrLlHA3KIpK75TpLiQpFhOatC7X9Vp
         IQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FGq8iBlF2ZC6eC7Usw3NKUnwm1aF4tm8whkb+14NlH8=;
        b=cFFthS1HX5LqcLA5/zMin9995l4awmwGRiEm7y/l6Y89Oc1VDVecqYmXeNKhWs8Bq3
         mPMdz2DsIeZZIr0HX7Lvgff6FmEZZrK5N06K5kDnkVixxIvQ46m1rRrmJUx8Gw50CRbW
         AsPINAGQCgQZkMMJpQxhBT1cjxiW3FoqrKPZY4foyRD7+/aDRIrZj0zWesV5zbKY8wZ0
         RtokkcDQgn8u8eatHmnWPxXVqTISnTTbQb8FU/NnW9IGvcoU6Kx/SjpZbam9itDRG+Bz
         FgccrdWIzbWFZ1IzYwoWiWpAe/6Z2+8kcFkVSXgjRtT1pwdHfi/ouwE8Nwz0zVPpArOi
         Xk5Q==
X-Gm-Message-State: ALoCoQlg4RGQtRHnhGSOI6eqNR4XEj9IAFuqugZYxRqxWPuLfHCuDlc8PzlTW8//iyjkF6hKMk0P
X-Received: by 10.182.191.36 with SMTP id gv4mr897604obc.50.1407960911004;
        Wed, 13 Aug 2014 13:15:11 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id h42si209647yhj.3.2014.08.13.13.15.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id BDBCE31C3D0;
	Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 989B5E0AA8; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.gfa712f7
In-Reply-To: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255233>

Add methods for the reflog functions.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 32 ++++++++++++++++++++++++++++++++
 refs.c        | 18 ++++++++++++------
 refs.h        | 17 +++++++++++++++++
 3 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index e7cea02..68152d6 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -853,3 +853,35 @@ void transaction_free(struct ref_transaction *transaction)
 {
 	return refs->transaction_free(transaction);
 }
+
+int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn,
+				void *cb_data)
+{
+	return refs->for_each_reflog_ent_reverse(refname, fn, cb_data);
+}
+
+int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn,
+			void *cb_data)
+{
+	return refs->for_each_reflog_ent(refname, fn, cb_data);
+}
+
+int for_each_reflog(each_ref_fn fn, void *cb_data)
+{
+	return refs->for_each_reflog(fn, cb_data);
+}
+
+int reflog_exists(const char *refname)
+{
+	return refs->reflog_exists(refname);
+}
+
+int create_reflog(const char *refname)
+{
+	return refs->create_reflog(refname);
+}
+
+int delete_reflog(const char *refname)
+{
+	return refs->delete_reflog(refname);
+}
diff --git a/refs.c b/refs.c
index 27eafd0..699b548 100644
--- a/refs.c
+++ b/refs.c
@@ -2251,7 +2251,7 @@ static int copy_msg(char *buf, const char *msg)
 }
 
 /* This function must set a meaningful errno on failure */
-int create_reflog(const char *refname)
+static int files_create_reflog(const char *refname)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
 	char logfile[PATH_MAX];
@@ -2516,7 +2516,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 	return 0;
 }
 
-int reflog_exists(const char *refname)
+static int files_reflog_exists(const char *refname)
 {
 	struct stat st;
 
@@ -2524,7 +2524,7 @@ int reflog_exists(const char *refname)
 		S_ISREG(st.st_mode);
 }
 
-int delete_reflog(const char *refname)
+static int files_delete_reflog(const char *refname)
 {
 	return remove_path(git_path("logs/%s", refname));
 }
@@ -2568,7 +2568,7 @@ static char *find_beginning_of_line(char *bob, char *scan)
 	return scan;
 }
 
-int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data)
+static int files_for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data)
 {
 	struct strbuf sb = STRBUF_INIT;
 	FILE *logfp;
@@ -2645,7 +2645,7 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
 	return ret;
 }
 
-int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data)
+static int files_for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data)
 {
 	FILE *logfp;
 	struct strbuf sb = STRBUF_INIT;
@@ -2706,7 +2706,7 @@ static int do_for_each_reflog(struct strbuf *name, each_ref_fn fn, void *cb_data
 	return retval;
 }
 
-int for_each_reflog(each_ref_fn fn, void *cb_data)
+static int files_for_each_reflog(each_ref_fn fn, void *cb_data)
 {
 	int retval;
 	struct strbuf name;
@@ -3295,6 +3295,12 @@ struct ref_be refs_files = {
 	files_transaction_update_reflog,
 	files_transaction_commit,
 	files_transaction_free,
+	files_for_each_reflog_ent,
+	files_for_each_reflog_ent_reverse,
+	files_for_each_reflog,
+	files_reflog_exists,
+	files_create_reflog,
+	files_delete_reflog,
 };
 
 struct ref_be *refs = &refs_files;
diff --git a/refs.h b/refs.h
index 4b669f5..302eb03 100644
--- a/refs.h
+++ b/refs.h
@@ -373,6 +373,17 @@ typedef int (*transaction_commit_fn)(struct ref_transaction *transaction,
 				       struct strbuf *err);
 typedef void (*transaction_free_fn)(struct ref_transaction *transaction);
 
+typedef int (*for_each_reflog_ent_fn)(const char *refname,
+				      each_reflog_ent_fn fn,
+				      void *cb_data);
+typedef int (*for_each_reflog_ent_reverse_fn)(const char *refname,
+					      each_reflog_ent_fn fn,
+					      void *cb_data);
+typedef int (*for_each_reflog_fn)(each_ref_fn fn, void *cb_data);
+typedef int (*reflog_exists_fn)(const char *refname);
+typedef int (*create_reflog_fn)(const char *refname);
+typedef int (*delete_reflog_fn)(const char *refname);
+
 struct ref_be {
 	transaction_begin_fn transaction_begin;
 	transaction_update_sha1_fn transaction_update_sha1;
@@ -381,6 +392,12 @@ struct ref_be {
 	transaction_update_reflog_fn transaction_update_reflog;
 	transaction_commit_fn transaction_commit;
 	transaction_free_fn transaction_free;
+	for_each_reflog_ent_fn for_each_reflog_ent;
+	for_each_reflog_ent_reverse_fn for_each_reflog_ent_reverse;
+	for_each_reflog_fn for_each_reflog;
+	reflog_exists_fn reflog_exists;
+	create_reflog_fn create_reflog;
+	delete_reflog_fn delete_reflog;
 };
 
 extern struct ref_be *refs;
-- 
2.0.1.556.g3edca4c
