From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 05/14] refs.c: add a function to append a reflog entry to a fd
Date: Wed, 18 Jun 2014 10:08:57 -0700
Message-ID: <1403111346-18466-6-git-send-email-sahlberg@google.com>
References: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 19:09:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxJMT-0006uT-66
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 19:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361AbaFRRJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 13:09:14 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:54594 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbaFRRJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 13:09:10 -0400
Received: by mail-ie0-f202.google.com with SMTP id tr6so300250ieb.5
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CqKBzOVHkUj7n9msfExAKLSGzSjATZmk1wHAYU7Exlk=;
        b=FgAVvfKAJTxoIMSC6xSZ/zT99hJC0vhAqNvOHFvPkaZMuy4BQ6f6Dto30A8psDsxHK
         QXorgq+kVNxss8SZpd2cN5UnpufGEoS2yHdgo1VFptUQMmQuWoGYesUdkR9m+yGmAbMR
         Zbv04H6KqaDujNATEcVSSbGobk+TGSG83dZ7ti4MiyulKXthdnbtKMNAFoRa4z85xC93
         M1X9cm3TcNeIX2ZISVNO0C3KC6IKqA7eI4QSQ9iznqGfHDXfVoCtJexFbmTBmexO801P
         DPIrxI+oV4tMUsyLrPTwiZUUABt/qXGZngLx9vZwzPrEbRR6FwH3lyzCFnk8aN4QikoC
         mw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CqKBzOVHkUj7n9msfExAKLSGzSjATZmk1wHAYU7Exlk=;
        b=cVH2cQh779cJoU65G06g+baT4X8EzpUZyGYIRWw6OKCpBd89W1r4/0HW9uqLjoZ2Kl
         IP0E8/PMBoWZPiA5/piSo83wGN/bJYtwrfRDj9jbBh7/yseObfwFKgizeqsWMKYnWwSA
         2ylaKWJysoeRgYYcmtk7X6rpS3yi/p6JaqwuJEiL1/nZpZXHKoqw5bOCEM5hprh1tCMl
         Fd66AFV9lIPCrod+FpEPQxhGNEmr77M8WJzwBv1mHytWzsIanv7KO5T5zCeTwzwy+5ud
         miP5uzdlw/MavEEVFo5eDPwKrYYY3v/yl1dqbrJiAI1hLW+xoEfTSCL3mS+sLuHUH7Eb
         v9IA==
X-Gm-Message-State: ALoCoQl+kfwQL7+DcP0HWBVIQ5fEe/ug44DZvMdS4lVwKXhxHcZ50flhtTLkmjAy5g6zgA5KJoU1
X-Received: by 10.182.28.136 with SMTP id b8mr1349011obh.19.1403111349966;
        Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si173341yhk.4.2014.06.18.10.09.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id CBA325A4790;
	Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 69105E05BF; Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.467.g08c0633
In-Reply-To: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251994>

Break out the code to create the string and writing it to the file
descriptor from log_ref_write and into a dedicated function log_ref_write_fd.
For now this is only used from log_ref_write but later on we will call
this function from reflog transactions too which means that we will end
up with only a single place where we write a reflog entry to a file instead
of the current two places (log_ref_write and builtin/reflog.c).

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 4129de6..f203285 100644
--- a/refs.c
+++ b/refs.c
@@ -2865,15 +2865,37 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
 	return 0;
 }
 
+static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
+			    const unsigned char *new_sha1,
+			    const char *committer, const char *msg)
+{
+	int msglen, written;
+	unsigned maxlen, len;
+	char *logrec;
+
+	msglen = msg ? strlen(msg) : 0;
+	maxlen = strlen(committer) + msglen + 100;
+	logrec = xmalloc(maxlen);
+	len = sprintf(logrec, "%s %s %s\n",
+		      sha1_to_hex(old_sha1),
+		      sha1_to_hex(new_sha1),
+		      committer);
+	if (msglen)
+		len += copy_msg(logrec + len - 1, msg) - 1;
+
+	written = len <= maxlen ? write_in_full(fd, logrec, len) : -1;
+	free(logrec);
+	if (written != len)
+		return -1;
+
+	return 0;
+}
+
 static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 			 const unsigned char *new_sha1, const char *msg)
 {
-	int logfd, result, written, oflags = O_APPEND | O_WRONLY;
-	unsigned maxlen, len;
-	int msglen;
+	int logfd, result, oflags = O_APPEND | O_WRONLY;
 	char log_file[PATH_MAX];
-	char *logrec;
-	const char *committer;
 
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates = !is_bare_repository();
@@ -2885,19 +2907,9 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 	logfd = open(log_file, oflags);
 	if (logfd < 0)
 		return 0;
-	msglen = msg ? strlen(msg) : 0;
-	committer = git_committer_info(0);
-	maxlen = strlen(committer) + msglen + 100;
-	logrec = xmalloc(maxlen);
-	len = sprintf(logrec, "%s %s %s\n",
-		      sha1_to_hex(old_sha1),
-		      sha1_to_hex(new_sha1),
-		      committer);
-	if (msglen)
-		len += copy_msg(logrec + len - 1, msg) - 1;
-	written = len <= maxlen ? write_in_full(logfd, logrec, len) : -1;
-	free(logrec);
-	if (written != len) {
+	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
+				  git_committer_info(0), msg);
+	if (result) {
 		int save_errno = errno;
 		close(logfd);
 		error("Unable to append to %s", log_file);
-- 
2.0.0.467.g08c0633
