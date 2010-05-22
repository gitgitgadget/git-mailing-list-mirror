From: Erick Mattos <erick.mattos@gmail.com>
Subject: [PATCH 2/5] refs: split log_ref_write logic into log_ref_setup
Date: Fri, 21 May 2010 21:28:36 -0300
Message-ID: <1274488119-6989-3-git-send-email-erick.mattos@gmail.com>
References: <1274488119-6989-1-git-send-email-erick.mattos@gmail.com>
Cc: git@vger.kernel.org, Erick Mattos <erick.mattos@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 22 02:29:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFcb7-00029t-6z
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 02:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932750Ab0EVA3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 20:29:44 -0400
Received: from mail-yw0-f180.google.com ([209.85.211.180]:54023 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932341Ab0EVA3n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 20:29:43 -0400
Received: by mail-yw0-f180.google.com with SMTP id 10so919647ywh.1
        for <git@vger.kernel.org>; Fri, 21 May 2010 17:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=KwA3eqwN7Ybl0pnEPLIGAevd3S2UnaZDb++dI9dgh6o=;
        b=B/ETYG3/D9cPito1JFWLT80pCPdtZZdEdOjrBVpDrvDxGwXpLL2EFJ7EsYvW2uCKdN
         SxQLcqhk/GgtPfPY1Nbun89dAteSSUqVY4c6TWcZ3JUqWTOnN9OLMg2WyAhjkH/BoEZs
         rQ36YsJJ5XHNklgqnpW/unHOFd2AZUxlY0UaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qCFRdbPDK8SCh/7sBaj405E7RBKJvqXhmpG3Tx+0pVqsbLE0kKRDLMTkjHv3fB2jFX
         RFvjfuQiHXE+610qp92B7kmeiCeeh0zmjaepMuXLLgBm/RGGjFfWN70kFNVavMVsQ8I4
         xLm7JNbcDpIl+vNIrF+NqKPhOkhxL98XslOEg=
Received: by 10.150.166.5 with SMTP id o5mr3421371ybe.404.1274488183269;
        Fri, 21 May 2010 17:29:43 -0700 (PDT)
Received: from localhost.localdomain ([187.15.117.192])
        by mx.google.com with ESMTPS id z42sm23557998ybc.6.2010.05.21.17.29.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 May 2010 17:29:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.231.g0687c.dirty
In-Reply-To: <1274488119-6989-1-git-send-email-erick.mattos@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147499>

Separation of the logic for testing and preparing the reflogs from
function log_ref_write to a new non static new function: log_ref_setup.

This allows to be performed from outside the first all reasonable checks
and procedures for writing reflogs.
---
 refs.c |   57 ++++++++++++++++++++++++++++++++++++---------------------
 refs.h |    3 +++
 2 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index d3db15a..1161c2d 100644
--- a/refs.c
+++ b/refs.c
@@ -1258,52 +1258,67 @@ static int copy_msg(char *buf, const char *msg)
 	return cp - buf;
 }
 
-static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
-			 const unsigned char *new_sha1, const char *msg)
+int log_ref_setup(const char *ref_name, char **log_file)
 {
-	int logfd, written, oflags = O_APPEND | O_WRONLY;
-	unsigned maxlen, len;
-	int msglen;
-	char log_file[PATH_MAX];
-	char *logrec;
-	const char *committer;
-
-	if (log_all_ref_updates < 0)
-		log_all_ref_updates = !is_bare_repository();
-
-	git_snpath(log_file, sizeof(log_file), "logs/%s", ref_name);
+	int logfd, oflags = O_APPEND | O_WRONLY;
+	char logfile[PATH_MAX];
 
+	git_snpath(logfile, sizeof(logfile), "logs/%s", ref_name);
+	*log_file = logfile;
 	if (log_all_ref_updates &&
 	    (!prefixcmp(ref_name, "refs/heads/") ||
 	     !prefixcmp(ref_name, "refs/remotes/") ||
 	     !prefixcmp(ref_name, "refs/notes/") ||
 	     !strcmp(ref_name, "HEAD"))) {
-		if (safe_create_leading_directories(log_file) < 0)
+		if (safe_create_leading_directories(*log_file) < 0)
 			return error("unable to create directory for %s",
-				     log_file);
+				     *log_file);
 		oflags |= O_CREAT;
 	}
 
-	logfd = open(log_file, oflags, 0666);
+	logfd = open(*log_file, oflags, 0666);
 	if (logfd < 0) {
 		if (!(oflags & O_CREAT) && errno == ENOENT)
 			return 0;
 
 		if ((oflags & O_CREAT) && errno == EISDIR) {
-			if (remove_empty_directories(log_file)) {
+			if (remove_empty_directories(*log_file)) {
 				return error("There are still logs under '%s'",
-					     log_file);
+					     *log_file);
 			}
-			logfd = open(log_file, oflags, 0666);
+			logfd = open(*log_file, oflags, 0666);
 		}
 
 		if (logfd < 0)
 			return error("Unable to append to %s: %s",
-				     log_file, strerror(errno));
+				     *log_file, strerror(errno));
 	}
 
-	adjust_shared_perm(log_file);
+	adjust_shared_perm(*log_file);
+	close(logfd);
+	return 0;
+}
 
+static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
+			 const unsigned char *new_sha1, const char *msg)
+{
+	int logfd, result, written, oflags = O_APPEND | O_WRONLY;
+	unsigned maxlen, len;
+	int msglen;
+	char *log_file;
+	char *logrec;
+	const char *committer;
+
+	if (log_all_ref_updates < 0)
+		log_all_ref_updates = !is_bare_repository();
+
+	result = log_ref_setup(ref_name, &log_file);
+	if (result)
+		return result;
+
+	logfd = open(log_file, oflags);
+	if (logfd < 0)
+		return 0;
 	msglen = msg ? strlen(msg) : 0;
 	committer = git_committer_info(0);
 	maxlen = strlen(committer) + msglen + 100;
diff --git a/refs.h b/refs.h
index 4a18b08..594c9d9 100644
--- a/refs.h
+++ b/refs.h
@@ -68,6 +68,9 @@ extern void unlock_ref(struct ref_lock *lock);
 /** Writes sha1 into the ref specified by the lock. **/
 extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
 
+/** Setup reflog before using. **/
+int log_ref_setup(const char *ref_name, char **log_file);
+
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *sha1, char **msg, unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
 
-- 
1.7.1.231.g0687c.dirty
