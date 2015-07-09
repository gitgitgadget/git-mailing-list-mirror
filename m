From: David Turner <dturner@twopensource.com>
Subject: [PATCH v8 3/7] refs: new public ref function: safe_create_reflog
Date: Thu,  9 Jul 2015 18:50:56 -0400
Message-ID: <1436482260-28088-4-git-send-email-dturner@twopensource.com>
References: <1436482260-28088-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, j6t@kdbg.org
X-From: git-owner@vger.kernel.org Fri Jul 10 00:51:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDKfF-00072W-R2
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 00:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbbGIWva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 18:51:30 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35253 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbbGIWv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 18:51:27 -0400
Received: by pdrg1 with SMTP id g1so40773927pdr.2
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 15:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i2si8oGdfoLiDKwXJTymf5K5b34LD3v/saWNjsZBsMw=;
        b=iZdgeyvc7sEdzjArrIABjLekOtfKVR2nJq8a1fbTzK47n3T7TS6vOSW9Y5KtOaQiHo
         rqzhgahxmretiZwgGN9HS3aXxNuA+O1ClRnR5lgBSIqqnGpJkc+qNxYirqQOI9cPJxst
         u5CQsqxlMqyhKOTSbv9GBzbdIRYkaz+sWVXW999f8wO/FvhYT9UJN9FNZn7C8/3sz0kh
         b9U5TOvHyebThedohpRmHSLhOMmePhxApa1QdI+w/kRgnosU5fBHf6Sd3cqCngcgp9G6
         oyJIoGF5o0AFtTLu3MuRpMhAZ9XBK3idEulyU5hIw9EiZ72ZRQtPA72fR+y/Dzd35ok6
         oPjA==
X-Gm-Message-State: ALoCoQkkoNuL27bc5FETU637M3bWlnsCYRAkIEclXJQB8hE7XtL3q4Hboli4OKdSdqwzet4J6a5b
X-Received: by 10.66.62.163 with SMTP id z3mr35250545par.12.1436482286526;
        Thu, 09 Jul 2015 15:51:26 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id fr2sm7129684pdb.22.2015.07.09.15.51.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Jul 2015 15:51:25 -0700 (PDT)
X-Mailer: git-send-email 2.0.5.499.g01f6352.dirty-twtrsrc
In-Reply-To: <1436482260-28088-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273789>

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
 builtin/checkout.c | 16 ++++++----------
 refs.c             | 24 ++++++++++++++++++++----
 refs.h             |  2 +-
 3 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 93f63d3..9923fd5 100644
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
+				ret = safe_create_reflog(refname, &err, 1);
+				free(refname);
 				if (ret) {
-					fprintf(stderr, _("Can not do reflog for '%s'. %s\n"),
+					fprintf(stderr, _("can not do reflog for '%s'. %s\n"),
 						opts->new_orphan_branch, err.buf);
 					strbuf_release(&err);
 					return;
 				}
+				strbuf_release(&err);
 			}
 		}
 		else
diff --git a/refs.c b/refs.c
index 903b401..4857f0b 100644
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
 			strbuf_addf(err, "unable to create directory for %s. "
 				    "%s", logfile, strerror(errno));
@@ -3173,6 +3178,17 @@ int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf
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
@@ -3209,7 +3225,7 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
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
2.0.5.499.g01f6352.dirty-twtrsrc
