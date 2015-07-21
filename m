From: David Turner <dturner@twopensource.com>
Subject: [PATCH v10 3/7] refs: new public ref function: safe_create_reflog
Date: Tue, 21 Jul 2015 17:04:52 -0400
Message-ID: <1437512696-14672-3-git-send-email-dturner@twopensource.com>
References: <1437512696-14672-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhaggerty@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jul 21 23:05:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHej5-0001X4-59
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 23:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933518AbbGUVFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 17:05:13 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34467 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933098AbbGUVFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 17:05:09 -0400
Received: by qgeu79 with SMTP id u79so38509472qge.1
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 14:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qCP7WtRDE9WHhoDjLjw8b5Ex2ZEEj8E9O6yauEd7upM=;
        b=WbpdhaVF7jU+Bvo2UQfmvlbNj61XCvsk3X71krEs3Ut2eALxI9S9w/EujiXiTHeuKj
         eoW/LFrwWt2jTj6+lyiQ5D2Rij2VaCG6iM1c9AIQt3uvCfFmVNYJRMpJVj4Y6ExbCh7J
         S7hwlTRPtsuyUKm9SdLEHGZKIsKdgQaWcuBb0CKlTS6meeUeM3Zbv8oOj149DJwlYXtI
         JnAjhPZxr6qp4hCqjmjshdVqw6X2McO3ov++Jb/jaMEo9xFd3+k+qiIlCS/44aGDEpM3
         JFe4YeBgRrRURJhHjRQZNkimELR7JLWetfZrXL5UXRUI7pR7fCKLhHPArHSM1yqYLc6V
         Yv0g==
X-Gm-Message-State: ALoCoQl/xuLKJjWfaw5O39WLnEAZk/KsRaOoNtwbnSlCvzRd5j5n0KwYkbzRKfWd5D5aCPQATsaf
X-Received: by 10.55.24.226 with SMTP id 95mr27691087qky.74.1437512708675;
        Tue, 21 Jul 2015 14:05:08 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id x137sm13430413qkx.28.2015.07.21.14.05.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Jul 2015 14:05:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1437512696-14672-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274420>

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
 builtin/checkout.c | 14 +++++---------
 refs.c             | 24 ++++++++++++++++++++----
 refs.h             |  2 +-
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index beea1eb..b3057ec 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -620,24 +620,20 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 	if (opts->new_branch) {
 		if (opts->new_orphan_branch) {
 			if (opts->new_branch_log && !log_all_ref_updates) {
-				int temp;
-				struct strbuf log_file = STRBUF_INIT;
 				int ret;
-				const char *ref_name;
+				char *refname;
 				struct strbuf err = STRBUF_INIT;
 
-				ref_name = mkpath("refs/heads/%s", opts->new_orphan_branch);
-				temp = log_all_ref_updates;
-				log_all_ref_updates = 1;
-				ret = log_ref_setup(ref_name, &log_file, &err);
-				log_all_ref_updates = temp;
-				strbuf_release(&log_file);
+				refname = mkpathdup("refs/heads/%s", opts->new_orphan_branch);
+				ret = safe_create_reflog(refname, 1, &err);
+				free(refname);
 				if (ret) {
 					fprintf(stderr, _("Can not do reflog for '%s': %s\n"),
 						opts->new_orphan_branch, err.buf);
 					strbuf_release(&err);
 					return;
 				}
+				strbuf_release(&err);
 			}
 		}
 		else
diff --git a/refs.c b/refs.c
index cf1abeb..1abfe64 100644
--- a/refs.c
+++ b/refs.c
@@ -3128,8 +3128,13 @@ static int should_autocreate_reflog(const char *refname)
 		!strcmp(refname, "HEAD");
 }
 
-/* This function will fill in *err and return -1 on failure */
-int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err)
+/*
+ * Create a reflog for a ref.  If force_create = 0, the reflog will
+ * only be created for certain refs (those for which
+ * should_autocreate_reflog returns non-zero.  Otherwise, create it
+ * regardless of the ref name.  Fill in *err and return -1 on failure.
+ */
+static int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err, int force_create)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
 	char *logfile;
@@ -3138,7 +3143,7 @@ int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf
 	logfile = sb_logfile->buf;
 	/* make sure the rest of the function can't change "logfile" */
 	sb_logfile = NULL;
-	if (should_autocreate_reflog(refname)) {
+	if (force_create || should_autocreate_reflog(refname)) {
 		if (safe_create_leading_directories(logfile) < 0) {
 			strbuf_addf(err, "unable to create directory for %s: "
 				    "%s", logfile, strerror(errno));
@@ -3173,6 +3178,17 @@ int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf
 	return 0;
 }
 
+
+int safe_create_reflog(const char *refname, int force_create, struct strbuf *err)
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
@@ -3209,7 +3225,7 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates = !is_bare_repository();
 
-	result = log_ref_setup(refname, sb_log_file, err);
+	result = log_ref_setup(refname, sb_log_file, err, 0);
 
 	if (result)
 		return result;
diff --git a/refs.h b/refs.h
index debdefc..f82fc51 100644
--- a/refs.h
+++ b/refs.h
@@ -228,7 +228,7 @@ int pack_refs(unsigned int flags);
 /*
  * Setup reflog before using. Fill in err and return -1 on failure.
  */
-int log_ref_setup(const char *refname, struct strbuf *logfile, struct strbuf *err);
+int safe_create_reflog(const char *refname, int force_create, struct strbuf *err);
 
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *refname, unsigned int flags,
-- 
2.0.4.315.gad8727a-twtrsrc
