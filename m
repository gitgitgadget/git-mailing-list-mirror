From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 05/11] refs.c: add a function to append a reflog entry to a fd
Date: Wed,  4 Jun 2014 11:57:46 -0700
Message-ID: <1401908272-7600-6-git-send-email-sahlberg@google.com>
References: <1401908272-7600-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 20:58:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsGO9-0007zq-UZ
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 20:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbaFDS6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 14:58:13 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:61868 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbaFDS6H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 14:58:07 -0400
Received: by mail-oa0-f73.google.com with SMTP id g18so1816097oah.0
        for <git@vger.kernel.org>; Wed, 04 Jun 2014 11:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zA9y4BKEJ4kSYLjSzGBWwC3IhgA1GFFnygmbDXiW4JE=;
        b=Mg9SWNJv/tzB5FQoun5sbWdhyDQCGmS0qYf3XZe00/biEQsKPj8+A6prQ4XcZjo/XI
         JAU2gkgQVBz/9OIrIWkEOCgyfMWhgGsQ6sTLb3iIosBWZ//2pIFW0/9nysGI4TSh6fY6
         S1SYCHG8NBbtUeLxJ/TJoDI9SOGY1YKZzTp0cA6ONTol5eI3o5JNGFJNB+SuET3sace3
         K1Rsw1ew8O1wEscgQDmLHXT2ya6wZu8ECa+ev+rcdWPOlibNvpFOSBhh5r8bYl1n9ANB
         PQnVl5fQRETl8ezpKfDWRj2v6xbW4OiUoMMSLs77yeKej7YIX3gCunf/K3thMdaPsnzR
         CNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zA9y4BKEJ4kSYLjSzGBWwC3IhgA1GFFnygmbDXiW4JE=;
        b=fbxPiGxEXqoOtfyV/V8J5tDp/mJx8aUNNxJSfN/yTxfuVcljt5m2IWyluOZ3MymOBq
         x44RHBAhZKuLcOfHrH60JecVbdYnt0eBc9Bz4BolmOmAH01nrokqdtNyZKNlV740KZQt
         ZMiK1jBarhTj7Pp5ByOP0VD40xXlX0lM7wl1rPwyFj7jPR/sxdLlXRW/J9K/zB5Fn6kj
         jbpsPEFCmZwYeHI6JBZnsvmuBXWk3mc5kPNSicvYTBtXB5/bzNbhJthzdujCHUr10ByB
         ekyACHc1k/1SiBjbfzZyYdMHVfoD4yNQWfK6ii/vW2ksHS9Jw3IotEmb3iLmiOMVQQ+v
         ro8A==
X-Gm-Message-State: ALoCoQmbr/flOiyhFI0cWbAm5zzhaP887HAPIfxRLzpD6MoU6pWWiofHtv5R8ec/34NOe5ra29Co
X-Received: by 10.50.73.74 with SMTP id j10mr3028711igv.1.1401908286904;
        Wed, 04 Jun 2014 11:58:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si331411yhj.5.2014.06.04.11.58.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jun 2014 11:58:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B8D7E31D63D;
	Wed,  4 Jun 2014 11:58:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6A6CEE0B12; Wed,  4 Jun 2014 11:58:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.578.gb9e379f
In-Reply-To: <1401908272-7600-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250761>

Break out the code to create the string and writing it to the file descriptor
from log_ref_write and into a dedicated function log_ref_write_fd. For now
this is only used from log_ref_write but later on we will call this function
from reflog transactions too which means that we will end up with only a single
place where we write a reflog entry to a file instead of the current two places
(log_ref_write and builtin/reflog.c).

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 0c3e83b..e89a81c 100644
--- a/refs.c
+++ b/refs.c
@@ -2835,15 +2835,37 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
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
@@ -2855,19 +2877,9 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
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
2.0.0.578.gb9e379f
