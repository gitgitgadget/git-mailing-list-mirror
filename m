From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 5/7] refs: new public ref function: safe_create_reflog
Date: Mon, 29 Jun 2015 16:17:54 -0400
Message-ID: <1435609076-8592-6-git-send-email-dturner@twopensource.com>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Jun 29 22:19:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9fWA-0006i7-7h
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 22:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbbF2US5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 16:18:57 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:35627 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913AbbF2USq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 16:18:46 -0400
Received: by qcmc1 with SMTP id c1so46458846qcm.2
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 13:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jlzfn8d5ATFXMocZyXokmhds8qj7dTKfWNImLynRijY=;
        b=CGJBZrjDGuFpi5pAlUnOfiZt8tlAjvVNsJZQ9WUBeBDPQYE5tewE+qIIPV664Ei1Ts
         mNY3F3+sjOZbASAHRtpoBnm0mCxRfib6vOGQXcU8FwlpIuhjRFDe0k8DedYy4uXXdj8k
         6WApvK+lZp48AarekOozI0SPGaQdMiNqsYHpSs9NzW4kgrVCA+weg773jE9Hki8azPzf
         2LtYDLEmR5sZ2qxnUMB/7Z00NtZ6ljJB8qFlgcBs5kz4YQyvY10d1EXan9RyhApWV+Eq
         +BCeuEnokNgWBalO3HRzpMIxCuDxzCG2KPmnVfRba/tovTrTPrjsFdJPg9H4EKNO1MAL
         x97Q==
X-Gm-Message-State: ALoCoQn80r8F/xscyvbYZ3Ej4jCiAN7ZtH23DeRHg4/m+ZFHPixLE9zis5YoLB6rQqHXi6xM8aNv
X-Received: by 10.140.41.9 with SMTP id y9mr21319729qgy.28.1435609125789;
        Mon, 29 Jun 2015 13:18:45 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by mx.google.com with ESMTPSA id 139sm11906090qhx.22.2015.06.29.13.18.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jun 2015 13:18:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273006>

The safe_create_reflog function creates a reflog, if it does not
already exist.

The log_ref_setup function becomes private and gains a force_create
parameter to force the creation of a reflog even if log_all_ref_updates
is false or the refname is not one of the special refnames.

The new parameter also reduces the need to store, modify, and restore
the log_all_ref_updates global before reflog creation.

In a moment, we will use this to add reflog creation commands to
git-reflog.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/checkout.c | 10 +---------
 refs.c             | 25 +++++++++++++++++++++----
 refs.h             |  2 +-
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 93f63d3..9f68399 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -620,19 +620,11 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 	if (opts->new_branch) {
 		if (opts->new_orphan_branch) {
 			if (opts->new_branch_log && !log_all_ref_updates) {
-				int temp;
-				struct strbuf log_file = STRBUF_INIT;
-				int ret;
 				const char *ref_name;
 				struct strbuf err = STRBUF_INIT;
 
 				ref_name = mkpath("refs/heads/%s", opts->new_orphan_branch);
-				temp = log_all_ref_updates;
-				log_all_ref_updates = 1;
-				ret = log_ref_setup(ref_name, &log_file, &err);
-				log_all_ref_updates = temp;
-				strbuf_release(&log_file);
-				if (ret) {
+				if (safe_create_reflog(ref_name, &err, 1)) {
 					fprintf(stderr, _("Can not do reflog for '%s'. %s\n"),
 						opts->new_orphan_branch, err.buf);
 					strbuf_release(&err);
diff --git a/refs.c b/refs.c
index 30e81ba..1e53ef0 100644
--- a/refs.c
+++ b/refs.c
@@ -3128,8 +3128,14 @@ static int should_autocreate_reflog(const char *refname)
 		!strcmp(refname, "HEAD");
 }
 
-/* This function will fill in *err and return -1 on failure */
-int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err)
+/*
+ * This function creates a reflog for a ref.  If force_create = 0, the
+ * reflog will only be created for certain refs (those for which
+ * should_autocreate_reflog returns non-zero.  Otherwise, it will be
+ * created regardless of the ref name.  This function will fill in *err
+ * and return -1 on failure
+ */
+static int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err, int force_create)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
 	char *logfile;
@@ -3138,7 +3144,7 @@ int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf
 	logfile = sb_logfile->buf;
 	/* make sure the rest of the function can't change "logfile" */
 	sb_logfile = NULL;
-	if (should_autocreate_reflog(refname)) {
+	if (force_create || should_autocreate_reflog(refname)) {
 		if (safe_create_leading_directories(logfile) < 0) {
 			strbuf_addf(err, "unable to create directory for %s. "
 				    "%s", logfile, strerror(errno));
@@ -3173,6 +3179,17 @@ int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf
 	return 0;
 }
 
+
+int safe_create_reflog(const char *refname, struct strbuf *err, int force_create)
+{
+	int ret;
+	struct strbuf sb = STRBUF_INIT;
+
+	ret = log_ref_setup(refname, &sb, err, force_create);
+	strbuf_release(&sb);
+	return ret;
+}
+
 static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 			    const unsigned char *new_sha1,
 			    const char *committer, const char *msg)
@@ -3209,7 +3226,7 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates = !is_bare_repository();
 
-	result = log_ref_setup(refname, sb_log_file, err);
+	result = log_ref_setup(refname, sb_log_file, err, 0);
 
 	if (result)
 		return result;
diff --git a/refs.h b/refs.h
index debdefc..3b90e16 100644
--- a/refs.h
+++ b/refs.h
@@ -228,7 +228,7 @@ int pack_refs(unsigned int flags);
 /*
  * Setup reflog before using. Fill in err and return -1 on failure.
  */
-int log_ref_setup(const char *refname, struct strbuf *logfile, struct strbuf *err);
+int safe_create_reflog(const char *refname, struct strbuf *err, int force_create);
 
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *refname, unsigned int flags,
-- 
2.0.4.315.gad8727a-twtrsrc
