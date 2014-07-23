From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 05/15] refs.c: add a function to append a reflog entry to a fd
Date: Wed, 23 Jul 2014 10:03:45 -0700
Message-ID: <1406135035-26441-6-git-send-email-sahlberg@google.com>
References: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 19:04:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9zyI-0004nO-AH
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 19:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbaGWREk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 13:04:40 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:58012 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932455AbaGWRD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 13:03:59 -0400
Received: by mail-ie0-f202.google.com with SMTP id rl12so415803iec.5
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JpF3XlJrtNpm0zKgfcWVzuqsIfiVlo1GhG1Opwt/WY8=;
        b=mL8nmr2ZssFLrkU9gH/h8vmXAHsM0eE6V1UwvguzvssyZFdL6ObUui0SOZ6+f3SHhz
         f48GA0Sj3W81HKtu/r1d0iDwgXcrN+3ixFrw4EwQAfv3+XeZJeNCd7isC/L5cDAM6zxD
         a4eieb0Nxn5d4R6sz/eFf3JJXpNDFCQ+uK95qRuBCpAwVbLXmurNd1tRukafJWBHeh8H
         AIg/zrOYZaMFMRUxH2fqDr/htcIFirP/lxASfyyocYxKgk+uoqllLAZKWEgH770VZfFt
         aDslarsiXqJ4uu9QmjOlIio2TtDDK7So+K3TjLCqqi60RQ1S7GjAI1hXzN7LeONwtjO4
         xbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JpF3XlJrtNpm0zKgfcWVzuqsIfiVlo1GhG1Opwt/WY8=;
        b=kI7YqFpqOmnnWAiVKDDg2OgBKXWK7ketiUXyviDf2MXPSqvsAWFKU/sOl18HL48eDm
         Uf9btel0MgvAUcR5GhqxWn80jmqyosIIrVCPf9urW7ZJLph/J9XzqsLbN4PUNzFrz0re
         qOosZaFNbJlyWdY8HsC2CYOA2w3v5mirLpUKJn8oVNY+XVr6vM76K+SVo5IHa78VLyHN
         ro0//LuenGG1YAwOmhXkbLU8iTgaLbyaZzg45rxECTfQJMitZ56CjwWo1tM7mauFMIp+
         g5G+JQCWSYd6H46ZQ6RVbxJXC9PCu03anGp8hT3OArGlxJ6FD+2jNW43JLfDx29IOzTz
         r0wg==
X-Gm-Message-State: ALoCoQk6CBIQkdit77F1NVjNxlE1T02A0e5LCUKVQ+MvUe5XYp7zfNPPEZpOZOcmdtVlG3kfU+Bl
X-Received: by 10.42.85.142 with SMTP id q14mr1460868icl.16.1406135038689;
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id v20si487050yhe.2.2014.07.23.10.03.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 85DC75A4308;
	Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 35419E0670; Wed, 23 Jul 2014 10:03:57 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.508.g763ab16
In-Reply-To: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254092>

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
index e88cb97..a479ddd 100644
--- a/refs.c
+++ b/refs.c
@@ -2862,15 +2862,37 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
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
@@ -2882,19 +2904,9 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
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
2.0.1.508.g763ab16
