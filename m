From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 4/6] refs: Break out check for reflog autocreation
Date: Sat, 27 Jun 2015 00:23:54 -0400
Message-ID: <1435379036-30894-5-git-send-email-dturner@twopensource.com>
References: <1435379036-30894-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Sat Jun 27 06:24:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8hfc-0005t5-4s
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 06:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbbF0EYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2015 00:24:35 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36283 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbbF0EY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2015 00:24:28 -0400
Received: by iecvh10 with SMTP id vh10so87259137iec.3
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 21:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IKMD9bo1q7gP3Dx/OAe1x0asYgt2OZIzuVyy6m5Nfz8=;
        b=TIKyoR7ZawDTHkRUgd9QLNMfT/89ERFGx47pjzwv4U75iG2O5cLfQIDULDl7Gq0IBp
         H6vqfekUvV2gC+Rl7+M3mtmdUE7iKXUjpAI88rwf+RhBLEFCOW562iTTcnnU/rtbxRnQ
         MqMfgT7UsfHCOrBSw5NGt2bdJaSTuTNu34SZCNTrYekPX1035176RayINzIIBt2hYdL7
         D3Q3w4duqAxmgzMYbYqCKaF9YIiKH4nIPjQg9JnlF9Sj9e8GOTpQHS5PqQTfFpAWnttB
         hVVnAyMHhdmYsKslGqzi2wz5KAb/32q+SsH/Vz4Y8W06xlsYSCLw9eRnEGyhkP3gdPtI
         Swag==
X-Gm-Message-State: ALoCoQkt/UxpuR3Nxy25TF0/c2O6iamvgEZoqw5tIM6IdYFsSRhv7hQd6T8ijG30NOkNZMzu5FfP
X-Received: by 10.107.17.137 with SMTP id 9mr6242589ior.28.1435379068212;
        Fri, 26 Jun 2015 21:24:28 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id k74sm22930720iok.30.2015.06.26.21.24.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jun 2015 21:24:27 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1435379036-30894-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272843>

This is just for clarity.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/checkout.c | 10 +---------
 refs.c             | 31 ++++++++++++++++++++++++-------
 refs.h             |  2 +-
 3 files changed, 26 insertions(+), 17 deletions(-)

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
index b34a54a..2f4c304 100644
--- a/refs.c
+++ b/refs.c
@@ -3118,8 +3118,18 @@ static int copy_msg(char *buf, const char *msg)
 	return cp - buf;
 }
 
+static int should_autocreate_reflog(const char *refname)
+{
+	if (!log_all_ref_updates)
+		return 0;
+	return starts_with(refname, "refs/heads/") ||
+		starts_with(refname, "refs/remotes/") ||
+		starts_with(refname, "refs/notes/") ||
+		!strcmp(refname, "HEAD");
+}
+
 /* This function will fill in *err and return -1 on failure */
-int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err)
+static int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err, int force_create)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
 	char *logfile;
@@ -3128,11 +3138,7 @@ int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf
 	logfile = sb_logfile->buf;
 	/* make sure the rest of the function can't change "logfile" */
 	sb_logfile = NULL;
-	if (log_all_ref_updates &&
-	    (starts_with(refname, "refs/heads/") ||
-	     starts_with(refname, "refs/remotes/") ||
-	     starts_with(refname, "refs/notes/") ||
-	     !strcmp(refname, "HEAD"))) {
+	if (force_create || should_autocreate_reflog(refname)) {
 		if (safe_create_leading_directories(logfile) < 0) {
 			strbuf_addf(err, "unable to create directory for %s. "
 				    "%s", logfile, strerror(errno));
@@ -3167,6 +3173,17 @@ int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf
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
@@ -3203,7 +3220,7 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
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
