From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 5/7] refs: add safe_create_reflog function
Date: Thu, 25 Jun 2015 20:29:06 -0400
Message-ID: <1435278548-3790-5-git-send-email-dturner@twopensource.com>
References: <1435278548-3790-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Jun 26 02:29:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8HWe-0005AC-Mo
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 02:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbbFZA3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 20:29:43 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36452 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbbFZA3h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 20:29:37 -0400
Received: by igbiq7 with SMTP id iq7so3448543igb.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 17:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j5Em9TNP/OglyJByJDVZODoYAEiXuCr3/s+ks4DEPeI=;
        b=eGHLPnuPwclui64jgyuLYaQ79K2kSPUgTQf2h/Jtw7UN8fODAzk5qIrKnI11vuqgl5
         GeT0cFIRujy2w6F6GJUKCKpdur2Qy6JGREZjmKXXtISWFgj9R+tGsHGaU8jCoOtKcSZb
         jRbeY5HYpj7B8dpShUUtre84SwcbawfBEZyOsXWQqXJ+eIHXXQpAMwxBmpq9fM36tJRa
         bR3fY5KDaG973nyq923CQsZYh8Y5eQ6e/4tDybsNhuWCfRCUFrVsKeRlYTQ4r8lZ8HK/
         HK9xJeCzA6oiTGWwkv2KDsMkJqRmDoIa9NT+vVUCL2ud7rsyZOB/g/tbEVXeCuCsxwZi
         v8VA==
X-Gm-Message-State: ALoCoQmm2cs82hrPCHR1K7dSFG0ztNh/vmws5kR+QgZuVMn0/DOY7TAbaGb9jl5s+tTOJky6xEXZ
X-Received: by 10.50.117.66 with SMTP id kc2mr388667igb.31.1435278576590;
        Thu, 25 Jun 2015 17:29:36 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id i85sm20714344iod.41.2015.06.25.17.29.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 17:29:35 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.314.gdbf7a51-twtrsrc
In-Reply-To: <1435278548-3790-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272752>

Make log_ref_setup private, and add public safe_create_reflog which
calls log_ref_setup.

In a moment, we will use safe_create_reflog to add reflog creation
commands to git-reflog.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/checkout.c |  4 +---
 refs.c             | 19 ++++++++++++++++---
 refs.h             |  2 +-
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 93f63d3..55e4fbc 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -621,7 +621,6 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 		if (opts->new_orphan_branch) {
 			if (opts->new_branch_log && !log_all_ref_updates) {
 				int temp;
-				struct strbuf log_file = STRBUF_INIT;
 				int ret;
 				const char *ref_name;
 				struct strbuf err = STRBUF_INIT;
@@ -629,9 +628,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 				ref_name = mkpath("refs/heads/%s", opts->new_orphan_branch);
 				temp = log_all_ref_updates;
 				log_all_ref_updates = 1;
-				ret = log_ref_setup(ref_name, &log_file, &err);
+				ret = safe_create_reflog(ref_name, &err, 0);
 				log_all_ref_updates = temp;
-				strbuf_release(&log_file);
 				if (ret) {
 					fprintf(stderr, _("Can not do reflog for '%s'. %s\n"),
 						opts->new_orphan_branch, err.buf);
diff --git a/refs.c b/refs.c
index dff91cf..7519dac 100644
--- a/refs.c
+++ b/refs.c
@@ -3123,11 +3123,12 @@ static int should_autocreate_reflog(const char *refname)
 	return starts_with(refname, "refs/heads/") ||
 		starts_with(refname, "refs/remotes/") ||
 		starts_with(refname, "refs/notes/") ||
+		!strcmp(refname, "refs/stash") ||
 		!strcmp(refname, "HEAD");
 }
 
 /* This function will fill in *err and return -1 on failure */
-int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err)
+static int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err, int force_create)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
 	char *logfile;
@@ -3136,7 +3137,8 @@ int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf
 	logfile = sb_logfile->buf;
 	/* make sure the rest of the function can't change "logfile" */
 	sb_logfile = NULL;
-	if (log_all_ref_updates && should_autocreate_reflog(refname)) {
+	if (log_all_ref_updates &&
+	    (force_create || should_autocreate_reflog(refname))) {
 		if (safe_create_leading_directories(logfile) < 0) {
 			strbuf_addf(err, "unable to create directory for %s. "
 				    "%s", logfile, strerror(errno));
@@ -3171,6 +3173,17 @@ int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf
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
@@ -3207,7 +3220,7 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
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
2.0.4.314.gdbf7a51-twtrsrc
