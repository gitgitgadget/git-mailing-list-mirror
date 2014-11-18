From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 11/14] refs.c: rename log_ref_setup to create_reflog
Date: Mon, 17 Nov 2014 17:35:47 -0800
Message-ID: <1416274550-2827-12-git-send-email-sbeller@google.com>
References: <1416274550-2827-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:36:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXim-0000S9-4i
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557AbaKRBgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:36:35 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:55638 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250AbaKRBgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:36:09 -0500
Received: by mail-ig0-f169.google.com with SMTP id hl2so3041033igb.2
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tmnV7iOVDcm2xRRrgUpiYNEBtOuIPLIlO7nLIKLZY3o=;
        b=GlgWRCErKkIIaqZcaeZPCqG1l0iIojwp6jRHTbDX0qLspIec8OuA5SpN89WQ9pJ5SD
         8ngTuR4qUFxEwIbdzy/LvkRrkhofjASRDQ5CF7iDoaHN4auk+t6qmC7ie+sClYFaWpo2
         Zbjx9xfbHh4OV/6ny/8I76dm2fDUyYQ6ruho7Yo9Ak6NLfQJR8+bz0gwmOCK45/+ffg7
         aCbK+J3JaDR/B5m0OSjS/Vk8GgHtXHvzEvndBAB6Drw2/1AWk5aWq69nIV/je9Mqov6N
         5izP8gjXB890PkMaRQ4sHUTn7HFjlGLxJ0oskU+kIr0HIqd+jsWzOcafPmxsP56I6oQD
         gkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tmnV7iOVDcm2xRRrgUpiYNEBtOuIPLIlO7nLIKLZY3o=;
        b=HblRTC4MD3H9eslnqEAcOCprE21PQzFtayMsCt1yo9zsCIMxhFgjOtzBsAmreMCXME
         Wqr9PPphL8gmbGOdMOzdjg8ycrhtak5xMbCRykBsokR+9/GwRVOOPH+hz5hCiPKxMbWe
         5UMCmJpwYANMA6ndv7eE6lzwxgj7dt6oL1nOwBqysqM3d+8Da39s6z1isN8SFwW3VKks
         tK3WsdXBK7cVU1vl0KwumFpcUKeE7fA4okPPq8yz0OiALC2ladqdaqvJeH0JB15szQq9
         o4sKVNYPhh17GkuXLzQZtwbdYhTElRSkObhfxb8QpCh2XNN8LZAGFjxKdP8f71Kz+0zd
         dZjg==
X-Gm-Message-State: ALoCoQmfoUSKCOCFpmJugp48gj8XfVOxc7sL2RdsNKn/eoGW25TcE+IfcylvuA3tK2+2KAIDjuHT
X-Received: by 10.42.51.133 with SMTP id e5mr31407519icg.44.1416274568679;
        Mon, 17 Nov 2014 17:36:08 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id y139sm660473iod.5.2014.11.17.17.36.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:36:08 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416274550-2827-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
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
index 1571fa5..11cf26b 100644
--- a/refs.c
+++ b/refs.c
@@ -2947,16 +2947,16 @@ static int copy_msg(char *buf, const char *msg)
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
@@ -3025,16 +3025,20 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
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
index 9f70b89..17e3a3c 100644
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
2.2.0.rc2.5.gf7b9fb2
