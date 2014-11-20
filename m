From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v3] refs.c: add a function to append a reflog entry to a fd
Date: Thu, 20 Nov 2014 10:37:37 -0800
Message-ID: <1416508657-9057-1-git-send-email-sbeller@google.com>
References: <20141120023655.GG6527@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 20 19:37:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrWbx-0004Yf-6q
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 19:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757710AbaKTShl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 13:37:41 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:48625 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757077AbaKTShl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 13:37:41 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so5248569igd.14
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 10:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aq96OnVUDzOEXXKt9M6+1FwqedJjy18VR9v0jTxi8z4=;
        b=lGavWe4KjkdfaRj9GWU1t7GFV2T8YNvVij+A5WX25EIRSWSa61ykN6tg1+q3+LQ0/5
         tITVt3fUpFcG6sl7a0PkuYmQ0gi/6ZfNiU/Wh5g/r2oXzbc8HK9UG7wIrd1r5f4mSmXw
         JyhJK/afsAAzUZ77YA4AizUZJ5mqBGToE+6Nk14f3zivafMiHNRY3F6BwA0kcgiUNxKK
         td7Q2yE1KTDhSc/O6tBwMTRW6DnNEICQtxSaO4f+gg536LD4GOf3NbSpBM6Sl9tP1KwH
         +g5UCG1I5aCzpc75y45+YAntcPob+80yn+2IWawn0gqSkr1cHz16SBcQ32Cpeykttkp7
         N5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aq96OnVUDzOEXXKt9M6+1FwqedJjy18VR9v0jTxi8z4=;
        b=hi58z9R8Q+ApoZr/hrbdoP+HzKf26bLoRZPx3QfnojNELRb0445m9NBelJfBB3NTIQ
         oUEd664VKyWJjib8s0btX5MkABExp0kOxAjZUYoF/6GQjKMqG4UWNe0lx7GLdZs4MG/1
         x7eZB9J2D4aC9xkS3FQpnxVyonmDOWlZs707EK8+IuLz+3rjr+Pz6wIvT1M0Fco0p09a
         KxLlp1aoJrmemkHUSUvwcpJiFm+2cQSjV2c/vgedWgX/MWyqTF26Ys/AvROmEKrxf8rV
         VF5/kTxL3zW1Wj6hh2Kkrk8wSqjrSJ1P4gYL2GaaX5wH9dHnu/Ai0XfIDoAiwNXBgNQ+
         Erjw==
X-Gm-Message-State: ALoCoQnIoOQLRA/mnW6dT87F0Pi3iZrFs+9IBmBrj8ORwgnenfrf9pXSbAbTWTwZJYm2c5HQhbiW
X-Received: by 10.50.128.163 with SMTP id np3mr17829061igb.28.1416508660174;
        Thu, 20 Nov 2014 10:37:40 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:2878:9312:86d2:4f27])
        by mx.google.com with ESMTPSA id d7sm1576147iod.34.2014.11.20.10.37.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Nov 2014 10:37:39 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.23.gca0107e
In-Reply-To: <20141120023655.GG6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Move code to create the string for a ref and write it to a file descriptor
from log_ref_write and add it into a new dedicated function
log_ref_write_fd.

For now the new function is only used from log_ref_write, but later
on we will call this function from reflog transactions too. That means
that we will end up with only a single place, where we write a
reflog entry to a file instead of the current two places
(log_ref_write and builtin/reflog.c).

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Changes in version 3:
* reword the commit message to make it more understandable.
* no changes in code
* wait for the follow up to address any changes in the code.

 refs.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 5ff457e..9948841 100644
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
+	len = sprintf(logrec, maxlen, "%s %s %s\n",
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
2.2.0.rc2.23.gca0107e
