From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 08/13] refs.c: rename log_ref_setup to create_reflog
Date: Thu,  4 Dec 2014 00:29:18 -0800
Message-ID: <1417681763-32334-9-git-send-email-sbeller@google.com>
References: <1417681763-32334-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 04 09:29:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwRnN-0005j2-Mh
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 09:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbaLDI3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 03:29:46 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:53624 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbaLDI3o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 03:29:44 -0500
Received: by mail-ig0-f173.google.com with SMTP id r2so18335311igi.0
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 00:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aUn9mwjAoo6ilSpaND/jSHHVIAebKWyUzuLo1Y5FLuM=;
        b=k81abT3azOvfx7dvQUqAXE0eaSwr6XRhiel9uNqarWoMSCSuTDuu2zQmm2p5TJ/8HW
         SQ0ckSHSU6JCsi477xtwULrB7mitGZ8Vcgsu1Rd9x+1XWBM6H85C+SGL10dEFfQcOeq8
         kbRRm1vjNkBUV5EKRJ5lhA5mj0wCBXAs86BhkzRhHgqMvjAB7VrETk93eI9CAcsQ1zaE
         F6NYY47QQo22XF9kdRR/MWJOm5Nhosj/CGV+qZobBEKV0+H018aL3WlE30Inx9y4aWdt
         UoiHAsgz0viRpeTbK08E+Nbk1tZAifEciEyy+hkJA+zFbF7fHyraEwNukQeNCA/com09
         eTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aUn9mwjAoo6ilSpaND/jSHHVIAebKWyUzuLo1Y5FLuM=;
        b=jDbmPuiMKR33B0++NKWf2dfNSlItU4sHZ3Ld9EdCEjYghkLDE5Z4lq/Wj7MH3a7XmK
         yrO6dtrX0sa0B2EeMa9K1v/s4FNe5MTwe8V+qc50O8gYbdlEarxVwSerFuCbuWAKX/dj
         5S25O8OK/s3sr3QhOs5jg/eBKOsSfooqgBaq0Hu1S67eMyU87B9QyzUK3h0qSrlN78TD
         QSghmZ2VWOgMKgEA4pwmLEC8hCeiT0PdPQU9t0UsUWU3g1Fkon43lRyipb/74CdyVLtV
         cTwvu/c1Gpm5mRUZQarNsxJu3LXFEms4M44WMf1CGP7v/WDZSvrVrbH4m/oq+UJGmHrr
         TZLw==
X-Gm-Message-State: ALoCoQnVi03P3PlJ/kwxiPIZEjOcJsxJvXgcK0fl2iXQ1h/5gqcWse/cMyS+9gI780qtICJcYtYD
X-Received: by 10.42.86.136 with SMTP id u8mr10172326icl.91.1417681783454;
        Thu, 04 Dec 2014 00:29:43 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5d2c:9a2d:3064:bc4])
        by mx.google.com with ESMTPSA id ck1sm5900307igb.0.2014.12.04.00.29.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 00:29:42 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417681763-32334-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260737>

From: Ronnie Sahlberg <sahlberg@google.com>

log_ref_setup is used to do several semi-related things:
* Sometimes it will create a new reflog including missing parent
  directories and cleaning up any conflicting stale directories
  in the path.
* Fill in a filename buffer for the full path to the reflog.
* Unconditionally re-adjust the permissions for the file.

This function is only called from two places: In checkout.c, where
it is always used to create a reflog and in refs.c log_ref_write,
where it is used to create a reflog sometimes, and sometimes just
to fill in the filename.

Rename log_ref_setup to create_reflog and change it to only take the
refname as an argument to make its signature similar to delete_reflog
and reflog_exists. Change create_reflog to ignore log_all_ref_updates
and "unconditionally" create the reflog when called. Since checkout.c
always wants to create a reflog we can call create_reflog directly and
avoid the temp-and-log_all_ref_update dance.

In log_ref_write, only call create_reflog, iff we want to create a reflog
and if the reflog does not yet exist. This means that for the common case
where the log already exists we now only need to perform a single lstat()
instead of a open(O_CREAT)+lstat()+close().

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/checkout.c |  8 +-------
 refs.c             | 22 +++++++++++++---------
 refs.h             |  8 +++-----
 3 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5410dac..8550b6d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -587,19 +587,13 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 	if (opts->new_branch) {
 		if (opts->new_orphan_branch) {
 			if (opts->new_branch_log && !log_all_ref_updates) {
-				int temp;
-				char log_file[PATH_MAX];
 				char *ref_name = mkpath("refs/heads/%s", opts->new_orphan_branch);
 
-				temp = log_all_ref_updates;
-				log_all_ref_updates = 1;
-				if (log_ref_setup(ref_name, log_file, sizeof(log_file))) {
+				if (create_reflog(ref_name)) {
 					fprintf(stderr, _("Can not do reflog for '%s'\n"),
 					    opts->new_orphan_branch);
-					log_all_ref_updates = temp;
 					return;
 				}
-				log_all_ref_updates = temp;
 			}
 		}
 		else
diff --git a/refs.c b/refs.c
index c411af9..bdd3f75 100644
--- a/refs.c
+++ b/refs.c
@@ -2941,16 +2941,16 @@ static int copy_msg(char *buf, const char *msg)
 }
 
 /* This function must set a meaningful errno on failure */
-int log_ref_setup(const char *refname, char *logfile, int bufsize)
+int create_reflog(const char *refname)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
+	char logfile[PATH_MAX];
 
-	git_snpath(logfile, bufsize, "logs/%s", refname);
-	if (log_all_ref_updates &&
-	    (starts_with(refname, "refs/heads/") ||
-	     starts_with(refname, "refs/remotes/") ||
-	     starts_with(refname, "refs/notes/") ||
-	     !strcmp(refname, "HEAD"))) {
+	git_snpath(logfile, sizeof(logfile), "logs/%s", refname);
+	if (starts_with(refname, "refs/heads/") ||
+	    starts_with(refname, "refs/remotes/") ||
+	    starts_with(refname, "refs/notes/") ||
+	    !strcmp(refname, "HEAD")) {
 		if (safe_create_leading_directories(logfile) < 0) {
 			int save_errno = errno;
 			error("unable to create directory for %s", logfile);
@@ -3019,16 +3019,20 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 			 const unsigned char *new_sha1, const char *msg)
 {
-	int logfd, result, oflags = O_APPEND | O_WRONLY;
+	int logfd, result = 0, oflags = O_APPEND | O_WRONLY;
 	char log_file[PATH_MAX];
 
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates = !is_bare_repository();
 
-	result = log_ref_setup(refname, log_file, sizeof(log_file));
+	if (log_all_ref_updates && !reflog_exists(refname))
+		result = create_reflog(refname);
+
 	if (result)
 		return result;
 
+	git_snpath(log_file, sizeof(log_file), "logs/%s", refname);
+
 	logfd = open(log_file, oflags);
 	if (logfd < 0)
 		return 0;
diff --git a/refs.h b/refs.h
index 1afc72c..0c75217 100644
--- a/refs.h
+++ b/refs.h
@@ -207,11 +207,6 @@ extern int commit_ref(struct ref_lock *lock);
 /** Release any lock taken but not written. **/
 extern void unlock_ref(struct ref_lock *lock);
 
-/*
- * Setup reflog before using. Set errno to something meaningful on failure.
- */
-int log_ref_setup(const char *refname, char *logfile, int bufsize);
-
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *refname, unsigned int flags,
 		       unsigned long at_time, int cnt,
@@ -221,6 +216,9 @@ extern int read_ref_at(const char *refname, unsigned int flags,
 /** Check if a particular reflog exists */
 extern int reflog_exists(const char *refname);
 
+/** Create reflog. Set errno to something meaningful on failure. */
+extern int create_reflog(const char *refname);
+
 /** Delete a reflog */
 extern int delete_reflog(const char *refname);
 
-- 
2.2.0
