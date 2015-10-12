From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 29/44] refs.c: add ref backend init function
Date: Mon, 12 Oct 2015 17:51:50 -0400
Message-ID: <1444686725-27660-31-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <rsahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:52:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll1X-0004fc-8c
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbbJLVws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:52:48 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:35580 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507AbbJLVwq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:46 -0400
Received: by qgt47 with SMTP id 47so129535072qgt.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ijWg8SgheKZC2eOSTKTDmQoEZNgfAVbyXFAJMEdlqag=;
        b=klrbH55j07nUaRC5BrCf+/kafZ9F8130XkNtfrz85ILpVF7o0F1MgYiRfyN8OTvz5E
         iqsVdf1F5bPo3Up4z/ImbMpcPulpQSkPz7ON+/cyGz6WSq4/ZR8sxf0UtR6ZWVhNnwsB
         h3iaESuqWNWu4m93ho7XMQRH1/KKoGicuYdXiDv/Q4IO8QJHmzZaU2/mRy7GpOroTulW
         0T2ZyrcT99yTr+WH8t4jDiCJwLoXu6xTBADWdCtDwCa6mI9ERWXnAB8iXySDFkmWVJs3
         jtstGgMDvWSLkXtEqT7+AXyIoiRvyvjhjswI/O7w/+5ojJU7XVbHnHvnecflki1sp13v
         AGVA==
X-Gm-Message-State: ALoCoQkMVXL8YOZ+1UyJVABqFK1npoDMD/fDM/fyfHgG3VmeNenUvuUr5m+0TQc250HHEwCHZCMB
X-Received: by 10.140.29.164 with SMTP id b33mr35459215qgb.37.1444686765618;
        Mon, 12 Oct 2015 14:52:45 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:44 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279432>

The file backend doesn't need this function, but other backends might.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Ronnie Sahlberg <rsahlberg@google.com>
---
 refs-be-files.c | 6 ++++++
 refs.c          | 3 ++-
 refs.h          | 4 +++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 73111e7..f123459 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -3307,6 +3307,11 @@ static int ref_present(const char *refname,
 
 	return string_list_has_string(affected_refnames, refname);
 }
+ 
+void files_init_backend(void *data)
+{
+	/* do nothing */
+}
 
 int initial_ref_transaction_commit(struct ref_transaction *transaction,
 				   struct strbuf *err)
@@ -3532,6 +3537,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 struct ref_be refs_be_files = {
 	NULL,
 	"files",
+	files_init_backend,
 	files_transaction_commit,
 	files_resolve_ref_unsafe,
 	files_verify_refname_available,
diff --git a/refs.c b/refs.c
index 1de8529..6370ace 100644
--- a/refs.c
+++ b/refs.c
@@ -19,13 +19,14 @@ struct ref_be *refs_backends = &refs_be_files;
 /*
  * This function is used to switch to an alternate backend.
  */
-int set_refs_backend(const char *name)
+int set_refs_backend(const char *name, void *init_data)
 {
 	struct ref_be *be;
 
 	for (be = refs_backends; be; be = be->next)
 		if (!strcmp(be->name, name)) {
 			the_refs_backend = be;
+			be->init_backend(init_data);
 			return 0;
 		}
 	return 1;
diff --git a/refs.h b/refs.h
index 6d284f5..e76553a 100644
--- a/refs.h
+++ b/refs.h
@@ -675,6 +675,7 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
 			 void *policy_cb_data);
 
 /* refs backends */
+typedef void ref_backend_init_fn(void *data);
 typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
 				      struct strbuf *err);
 typedef void ref_transaction_free_fn(struct ref_transaction *transaction);
@@ -714,6 +715,7 @@ typedef int for_each_reftype_fullpath_fn(each_ref_fn fn, char *type,
 struct ref_be {
 	struct ref_be *next;
 	const char *name;
+	ref_backend_init_fn *init_backend;
 	ref_transaction_commit_fn *transaction_commit;
 	resolve_ref_unsafe_fn *resolve_ref_unsafe;
 	verify_refname_available_fn *verify_refname_available;
@@ -736,6 +738,6 @@ struct ref_be {
 
 
 extern struct ref_be refs_be_files;
-int set_refs_backend(const char *name);
+int set_refs_backend(const char *name, void *init_data);
 
 #endif /* REFS_H */
-- 
2.4.2.644.g97b850b-twtrsrc
