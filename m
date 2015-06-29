From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 5/7] refs: new public ref function: safe_create_reflog
Date: Mon, 29 Jun 2015 13:54:26 -0400
Message-ID: <1435600468-21710-6-git-send-email-dturner@twopensource.com>
References: <1435600468-21710-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Jun 29 19:55:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9dGn-0005vv-2y
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 19:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037AbbF2Ryy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 13:54:54 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:34466 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445AbbF2Ryo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 13:54:44 -0400
Received: by qcji3 with SMTP id i3so45218910qcj.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 10:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6t8Eam1ywPJNquk4CoZDmUukNPV5QbqYPMiampoSnRo=;
        b=J4CnCilpQDVU74mPcgmfP2P6i1zRUKJNFbZnIgw5qyjgovP6F3EVmvO/QEbzhZopFc
         gBmqfO5WNehbWD/P41LanUqdBGTjW7EMz6Y6BhIusjGSSM0YQDzGnXjoolVd4bvzIX1g
         eNDTyEzlpK1KeRV9UZN5XwsezbipGO8i68yEzZ6Itti0GwWEcX+LWKWgKwnvdNAC3v7D
         DJKEVnm00CwoikmpYW1l4DGnmxn6cvf7VyHpc9CViklDeY8MvV5riCVBo5No7unNfU4M
         UK/JfgnBGZKfZSUKx5Q5QlqPe9MySaaFOK9Gvpsw31KAnWWDR1hJogWn9AOnaY1ckITy
         Teug==
X-Gm-Message-State: ALoCoQnITK2xXQmKMkrjAAjFF9/yThX2nvPOX8ZlYeiNqgIzUHOBu/j7guavIfi9s3tn2u9vyiZF
X-Received: by 10.140.234.1 with SMTP id f1mr21062863qhc.48.1435600483582;
        Mon, 29 Jun 2015 10:54:43 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by mx.google.com with ESMTPSA id w67sm11860026qgw.41.2015.06.29.10.54.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jun 2015 10:54:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1435600468-21710-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272985>

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
index dd76721..0ece8f2 100644
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
