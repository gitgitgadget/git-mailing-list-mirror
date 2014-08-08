From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 18/22] refs.c: add reflog backend methods
Date: Fri,  8 Aug 2014 09:45:05 -0700
Message-ID: <1407516309-27989-19-git-send-email-sahlberg@google.com>
References: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 18:46:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnJh-0000s3-R5
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756915AbaHHQpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:45:30 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:63312 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756633AbaHHQpR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:45:17 -0400
Received: by mail-qa0-f74.google.com with SMTP id j15so763892qaq.1
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XW9A4UFMT+J8NOpaHVcupBcwxj89GrsEs9c1jmD7+zI=;
        b=NbuslKH4VD7IKzzEB6X5M37EXfDojh9OKzF1Uymy87OEOO9vn+rlPdIl1vZNvW1uOh
         DkK4j1lNbqLnJsoPC7UaNJdVpi7AFrTUitdJSURr5QX8Hh4+JfGiNdt47pKWWHxk+BPD
         saw47CZo35JpI5Syz0GWAt4+Mr1djnxiwd6JPH4x+jPsy9eA3PHLFoEIoMouzLH/LMT3
         GZ36DhOIm+R8WqFwegG0FnpDjaL3JbjAkBg0Vt5IX9rZYFRyyW4aSYMMvGVSwQvUq9Rz
         SGlsLXbDXIrI/M4TpwB8r6+YqeKVrzmeysPmnYef1YxYvk4GeiftXnkn3ErXE26rSJ6/
         iSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XW9A4UFMT+J8NOpaHVcupBcwxj89GrsEs9c1jmD7+zI=;
        b=CImM0NrKP7RL/bIqTCk45+JoSXjcIa+VnZRa5phfcEgsQ5AJu/OfXLgsqq2US3LES4
         XRXRMcYLndNPRLSgMhl2TmdwXV87u78SkqkbjMC+wPekM9xWph42agaW4yqn9Q1HGEDF
         1XA+Y+NTItlR3l7tvyDfYoORQ5Vzy5lwovVJYJiJIXLJleAi3G2EcEXa1yR1PZm9aTMg
         snODzaBfFET+U4NLvejbMG0ib6DNP4MLs0UOhUzF8nLtUGWDLZb790tLhd3+shXVa4FD
         jD2w1ojpKHTrZpcEeHV/IBiC044HmJ/xKXQA4zOurT5yf7+DZI9juLR1VMgd2rapmQXj
         f78g==
X-Gm-Message-State: ALoCoQn7xMokSTAcaXbSkKhW/gTIE2Dpa3iR8oYMPDeQS5ZdlDJFWnqqByTXPfwaAsZTVikRlUDg
X-Received: by 10.236.15.167 with SMTP id f27mr5301839yhf.37.1407516316252;
        Fri, 08 Aug 2014 09:45:16 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id v20si505276yhe.2.2014.08.08.09.45.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 09:45:16 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 06C765A461A;
	Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A49BDE1025; Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.553.geee1b3e
In-Reply-To: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255041>

Add methods for the reflog functions.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 32 ++++++++++++++++++++++++++++++++
 refs.c        | 19 +++++++++++++------
 refs.h        | 18 ++++++++++++++++++
 3 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index d4782ad..083964f 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -838,3 +838,35 @@ void transaction_free(struct ref_transaction *transaction)
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
index bfb42d8..49fd360 100644
--- a/refs.c
+++ b/refs.c
@@ -2266,7 +2266,7 @@ static int copy_msg(char *buf, const char *msg)
 }
 
 /* This function must set a meaningful errno on failure */
-int create_reflog(const char *refname)
+static int files_create_reflog(const char *refname)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
 	char logfile[PATH_MAX];
@@ -2531,7 +2531,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 	return 0;
 }
 
-int reflog_exists(const char *refname)
+static int files_reflog_exists(const char *refname)
 {
 	struct stat st;
 
@@ -2539,7 +2539,7 @@ int reflog_exists(const char *refname)
 		S_ISREG(st.st_mode);
 }
 
-int delete_reflog(const char *refname)
+static int files_delete_reflog(const char *refname)
 {
 	return remove_path(git_path("logs/%s", refname));
 }
@@ -2583,7 +2583,7 @@ static char *find_beginning_of_line(char *bob, char *scan)
 	return scan;
 }
 
-int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data)
+static int files_for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data)
 {
 	struct strbuf sb = STRBUF_INIT;
 	FILE *logfp;
@@ -2660,7 +2660,7 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
 	return ret;
 }
 
-int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data)
+static int files_for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data)
 {
 	FILE *logfp;
 	struct strbuf sb = STRBUF_INIT;
@@ -2721,7 +2721,7 @@ static int do_for_each_reflog(struct strbuf *name, each_ref_fn fn, void *cb_data
 	return retval;
 }
 
-int for_each_reflog(each_ref_fn fn, void *cb_data)
+static int files_for_each_reflog(each_ref_fn fn, void *cb_data)
 {
 	int retval;
 	struct strbuf name;
@@ -3310,6 +3310,13 @@ struct ref_be refs_files = {
 	.transaction_update_reflog	= files_transaction_update_reflog,
 	.transaction_commit		= files_transaction_commit,
 	.transaction_free		= files_transaction_free,
+
+	.for_each_reflog_ent		= files_for_each_reflog_ent,
+	.for_each_reflog_ent_reverse	= files_for_each_reflog_ent_reverse,
+	.for_each_reflog		= files_for_each_reflog,
+	.reflog_exists			= files_reflog_exists,
+	.create_reflog			= files_create_reflog,
+	.delete_reflog			= files_delete_reflog,
 };
 
 struct ref_be *refs = &refs_files;
diff --git a/refs.h b/refs.h
index 7b92241..f630e20 100644
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
@@ -381,6 +392,13 @@ struct ref_be {
 	transaction_update_reflog_fn transaction_update_reflog;
 	transaction_commit_fn transaction_commit;
 	transaction_free_fn transaction_free;
+
+	for_each_reflog_ent_fn for_each_reflog_ent;
+	for_each_reflog_ent_reverse_fn for_each_reflog_ent_reverse;
+	for_each_reflog_fn for_each_reflog;
+	reflog_exists_fn reflog_exists;
+	create_reflog_fn create_reflog;
+	delete_reflog_fn delete_reflog;
 };
 
 extern struct ref_be *refs;
-- 
2.0.1.553.geee1b3e
