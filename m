From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 5/8] refs: new public ref function: safe_create_reflog
Date: Tue,  7 Jul 2015 20:56:00 -0400
Message-ID: <1436316963-25520-5-git-send-email-dturner@twopensource.com>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Jul 08 02:56:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCdfS-0007J3-7r
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 02:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbbGHA4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 20:56:46 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:35061 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932189AbbGHA4W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 20:56:22 -0400
Received: by qget71 with SMTP id t71so93020272qge.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 17:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H/sPprz+NoBgPJxUTsqs0wVF4tEolAzwOT+xnLioA7M=;
        b=mB8gEo0sNyP2XN/5TznhcwU7aChQ8t213ebehiDMZNODbOlfzS1GUFgWUAaR6k95Sw
         Zr/rzHkHVQra6ij3+JH+C3PJjAqL54oOujJO5FpfKteRtId/ltEoUnQSa7WVsxOimXvW
         dMmabVZUbLT2nu3hFafjV4v4uyIluWr3337dYKudT81yJeiJTZh69W33k3yZhPd/f0UM
         OGG+abhVW9laxUS5fIZeilgTuGG+L59ag5tNT/F+mpd60xSk/hQsmzPq7hRcgUODqDMC
         udI3eKfD9P+tQN6Onij1j8ULcPMAcu5KPa64aP0sP5X+xEdR2Hu0OkiRSYJQTXC4SOT+
         MnoA==
X-Gm-Message-State: ALoCoQlU6FQG/Y4XvUanc+7JdJIqsPb5o2J5iV75pbi5xySwUHXdIaMRqx7ZmPEfhU+Rejc5MDPi
X-Received: by 10.140.85.85 with SMTP id m79mr11764700qgd.37.1436316981906;
        Tue, 07 Jul 2015 17:56:21 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z135sm278447qhd.29.2015.07.07.17.56.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 17:56:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.5.499.g01f6352.dirty-twtrsrc
In-Reply-To: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273626>

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
 builtin/checkout.c | 16 +++++-----------
 refs.c             | 25 +++++++++++++++++++++----
 refs.h             |  2 +-
 3 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 93f63d3..c840f33 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -620,24 +620,18 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 	if (opts->new_branch) {
 		if (opts->new_orphan_branch) {
 			if (opts->new_branch_log && !log_all_ref_updates) {
-				int temp;
-				struct strbuf log_file = STRBUF_INIT;
-				int ret;
-				const char *ref_name;
+				char *refname;
 				struct strbuf err = STRBUF_INIT;
 
-				ref_name = mkpath("refs/heads/%s", opts->new_orphan_branch);
-				temp = log_all_ref_updates;
-				log_all_ref_updates = 1;
-				ret = log_ref_setup(ref_name, &log_file, &err);
-				log_all_ref_updates = temp;
-				strbuf_release(&log_file);
-				if (ret) {
+				refname = mkpathdup("refs/heads/%s", opts->new_orphan_branch);
+				if (safe_create_reflog(refname, &err, 1)) {
+					free(refname);
 					fprintf(stderr, _("Can not do reflog for '%s'. %s\n"),
 						opts->new_orphan_branch, err.buf);
 					strbuf_release(&err);
 					return;
 				}
+				free(refname);
 			}
 		}
 		else
diff --git a/refs.c b/refs.c
index e694359..01b0af5 100644
--- a/refs.c
+++ b/refs.c
@@ -3128,8 +3128,14 @@ static int should_autocreate_reflog(const char *refname)
 		!strcmp(refname, "HEAD");
 }
 
-/* This function will fill in *err and return -1 on failure */
-int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err)
+/*
+ * Create a reflog for a ref.  If force_create = 0, the reflog will
+ * only be created for certain refs (those for which
+ * should_autocreate_reflog returns non-zero.  Otherwise, it will be
+ * created regardless of the ref name.  This function will fill in
+ * *err and return -1 on failure
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
2.0.5.499.g01f6352.dirty-twtrsrc
