From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 05/15] refs.c: add a function to append a reflog entry to a fd
Date: Mon,  3 Nov 2014 08:55:47 -0800
Message-ID: <1415033757-9539-6-git-send-email-sahlberg@google.com>
References: <1415033757-9539-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 17:59:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlKyL-0003HJ-Oc
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 17:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbaKCQ7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 11:59:14 -0500
Received: from mail-qg0-f73.google.com ([209.85.192.73]:44553 "EHLO
	mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274AbaKCQ4D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 11:56:03 -0500
Received: by mail-qg0-f73.google.com with SMTP id z107so738956qgd.4
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 08:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F428+zIy7ULOCbHa1ozdnUS5OP+UnpQbGv0HkpE9opU=;
        b=iFfDM6aEXepBGhKC31WqD+0TMi7+3MRETYlqfV4Kk+6tT1mpXZNqd5QBrXYi3tDjI2
         7p/B7YsOqjzyjQNC8a92FczXh00YJbPWd96RmOnvqjJAC6gDNM83gd9eCd5rewJie/+i
         eXsxiLpjplIfMc3hD0jM/kQkR7r0cbobD8cS6ywHg6bv02Wa4HcSwukQmald/M/jKNW0
         woD3CruNRQydmCFhmp2RpNVKhu0YLdcmSJG/lqkzbKMt2NxgxnynLdriejsbfAVkndo0
         13quOERIXHs5owmw1SEnufvYDGbrUI9dQWb3i2VKdpwPs+y8VzvKvtUWwN0l1Mxi/8Ob
         PK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F428+zIy7ULOCbHa1ozdnUS5OP+UnpQbGv0HkpE9opU=;
        b=kMOsuU3awSAX/z3NaJ0sXpCeEMip7McW625OJqC5dJWG0j39ZRrMcRb4gwo2NZb/U0
         ztaJg9LK0hHZGtHxQHJ0u7hqtdXt//Cj3Cyr7gAMnUjdSp6BwpaXVMOChRN72jPhRbw7
         QUHxCQYJI21ZQbUOBCqsUtQN2LWeqmpxto0he7t5w/seVnUK4UlFhAW64dmopq4s+7AZ
         sWDltY7uLvRxHP++d4QFNP+fKbIihpaNfgL2xbb8sWi5HYmTEZ3B9W17rWfKlxnxaL41
         XepyNrFtoBE9HL5hdyUIGCYPPbWsKu5hzzRdJEesasjP0dUb8Dw2NU9kk45ETeYEtlzn
         YMTw==
X-Gm-Message-State: ALoCoQk164hD1W/joIyqkTB3zffGBt7ywc1tRBHFlj/X0OgFjMf85iUbkBSIVDgZtRjQMfPVzqoi
X-Received: by 10.236.29.78 with SMTP id h54mr8337111yha.22.1415033762844;
        Mon, 03 Nov 2014 08:56:02 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id 5si150659yhd.6.2014.11.03.08.56.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 08:56:02 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id w74sUdVM.1; Mon, 03 Nov 2014 08:56:02 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 08E43E0F5D; Mon,  3 Nov 2014 08:56:01 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415033757-9539-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Break out the code to create the string and writing it to the file
descriptor from log_ref_write and into a dedicated function log_ref_write_fd.
For now this is only used from log_ref_write but later on we will call
this function from reflog transactions too which means that we will end
up with only a single place where we write a reflog entry to a file instead
of the current two places (log_ref_write and builtin/reflog.c).

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 8803b95..0e11b1c 100644
--- a/refs.c
+++ b/refs.c
@@ -2990,15 +2990,37 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
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
@@ -3010,19 +3032,9 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
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
2.1.0.rc2.206.gedb03e5
