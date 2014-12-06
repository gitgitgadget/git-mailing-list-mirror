From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 7/8] refs.c: rename log_ref_setup to create_reflog
Date: Fri,  5 Dec 2014 18:46:34 -0800
Message-ID: <1417833995-25687-8-git-send-email-sbeller@google.com>
References: <1417833995-25687-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, jrnieder@gmail.com,
	ronniesahlberg@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 06 03:47:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx5Od-0004pu-Dv
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 03:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbaLFCqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 21:46:50 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:52948 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbaLFCqr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 21:46:47 -0500
Received: by mail-ie0-f181.google.com with SMTP id tp5so1857284ieb.12
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 18:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VtVICD+nkukA8yKb6LvCCurMwIRYwq7d6q/1O3tMpdo=;
        b=HsIkDGdHyzECZybUs/iSA1gWtOL9+rwJYQ14Dov7mjVfoT73jJslQVvpnvdSA0YggJ
         1jvd1mnPCj6Hlcb4tB2LbHuBLsy4agwThIelta5Ro5Kdeo7af8YPd3uO1r42YIA1iyqA
         lw8St0co0AFGy07xAdj9SBuIoyQaAyEiiWXYEehitKyYqst1dQd0WYDU1SYTnLDSpr/O
         WZBjJlDRYepueKuB2jnNjOZf0eNt8xoAMHIzvzV43EjFYViZTfsk5C3pzPpeSd7QWlnA
         uBPBCciuMOJMDJhlcRa8NUV3E+fC/2GOKtxGuxscvi/XyQ5wpwiTw9pYK3OVMWRiMhZI
         Gg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VtVICD+nkukA8yKb6LvCCurMwIRYwq7d6q/1O3tMpdo=;
        b=I3DE6M68dShPLhWpC1LOgvrnAjHv3Y8YYHqZQi5EZScX9rvB1c98SpDpg5W7ByFtTF
         AQgqtiopibMHH2qanm9jpLUz5pccoFiVhbeCaJljCSa7dgDzVIIGoU/l8objtVujSvDf
         nhbI/olyzTtT++QRC/lOV0j45xS1SbjqCRoBANKvpbcLypD8K3oi75+o0l0qR5mZ83Ow
         ykTdJPznxxBuNeUB+bnySs64RKFjqB2ZUIo5RB6kDHlNo6QNkwRXRsF1LkR+WOqOMGJY
         DF+B5KFbb+W+Dj3F4IlHr8i0Ov/MdjQPgYe4n6ES7Z8b27tTiuHXEjzhEu+qsordUma2
         Qc5w==
X-Gm-Message-State: ALoCoQmee30QeAwUOi7p6QSlTNlaZkxcU6WAf5ON0ivuWHbpjyfo0La59kyl7dVobyQUZPg+p4Yk
X-Received: by 10.107.154.10 with SMTP id c10mr1633405ioe.78.1417834007166;
        Fri, 05 Dec 2014 18:46:47 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:4022:de56:febc:d879])
        by mx.google.com with ESMTPSA id 12sm14213484ios.32.2014.12.05.18.46.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Dec 2014 18:46:46 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417833995-25687-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260930>

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

Notes:
    This is also just carried along from sending it last time.

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
index 295ea09..2effd66 100644
--- a/refs.c
+++ b/refs.c
@@ -2943,16 +2943,16 @@ static int copy_msg(char *buf, const char *msg)
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
@@ -3021,16 +3021,20 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
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
index 40607d6..7599f81 100644
--- a/refs.h
+++ b/refs.h
@@ -183,11 +183,6 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
 #define REF_NODEREF	0x01
 #define REF_DELETING	0x02
 
-/*
- * Setup reflog before using. Set errno to something meaningful on failure.
- */
-int log_ref_setup(const char *refname, char *logfile, int bufsize);
-
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *refname, unsigned int flags,
 		       unsigned long at_time, int cnt,
@@ -197,6 +192,9 @@ extern int read_ref_at(const char *refname, unsigned int flags,
 /** Check if a particular reflog exists */
 extern int reflog_exists(const char *refname);
 
+/** Create reflog. Set errno to something meaningful on failure. */
+extern int create_reflog(const char *refname);
+
 /** Delete a reflog */
 extern int delete_reflog(const char *refname);
 
-- 
2.2.0
