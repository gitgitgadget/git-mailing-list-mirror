From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 05/15] refs.c: add a function to append a reflog entry to a fd
Date: Tue, 21 Oct 2014 12:24:12 -0700
Message-ID: <1413919462-3458-6-git-send-email-sahlberg@google.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 21:25:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgf3T-0000d0-Rw
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 21:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932799AbaJUTY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 15:24:59 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:40719 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932369AbaJUTYf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 15:24:35 -0400
Received: by mail-ig0-f202.google.com with SMTP id r2so3895igi.1
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 12:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T6YDMaAJ44sOJjm93ClfQf+ad4GFfyx03pKEafIMGHU=;
        b=b20Mlaa2VBzvM09BG+uCqaJ0mWbtfgjDYzzvt6NFNlucQelEyDpPoYp78JUCEvoCaa
         R+bozSh1tw023GYye+ST3I/pUlEkgBBtD3jyAfpVpa5O6BQ3wHBRWzW9cT/n2sUH/6xY
         +d9jrfQZA/VctFIbGNqob8olZ5hHOAOlHwIYAJNfrG5iuujiM6CiDe6j8guQJ/J/ZxAQ
         +ZFq59Hb789tw/eN2DWD9u+82T7VR12ubMchJ7t9bCdLsr51UYKJUrG8nfz8YUnGdPpD
         RIPWZiZVqT7m3LRJUzJWFIHtvaRXWI6W6ev54F4znBfPINOThX7wvVrLwAt9qpFyKsT7
         4kGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T6YDMaAJ44sOJjm93ClfQf+ad4GFfyx03pKEafIMGHU=;
        b=UdvK0ornXKVQqpbz2hAbQxM3K+PC5t3iLcwWzOq5MG3puV6dwIpmgRMJ/UNLlmcvrf
         +I4mLgP8HTx4i3v8WSplJgqA2FrrlvwXBBW39K1jUNOVcgG7cse9+0594EgLaZ5q5IVe
         xbXRtf2DtPQWWVz7z4oadWPlKteKrEVO6fWb6fp72nSnfz1PAOu8By0Be0phCFgZDdMM
         Spee0hZjgPfaH56RHLD/GljWNXJIWnP2im6xmh9FE1xSRxXgAdyDPOAAElEvEO3UY9UX
         9S/9Ydkf/suIfEG3n5on+Lc9xhpZ7Ukd2Iesa1ir9E6PYqROQOG+lAXeJtKKI8txftRA
         ry7A==
X-Gm-Message-State: ALoCoQnwH8/fLVwHyzHFF+twqpqzD8c8WPyaFcB3H3y13x2+XnyrfXN5D+i/QDGitN95p+R79Kx7
X-Received: by 10.50.23.50 with SMTP id j18mr17650301igf.4.1413919474979;
        Tue, 21 Oct 2014 12:24:34 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id n22si585436yhd.1.2014.10.21.12.24.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 12:24:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id J3yyJYWh.1; Tue, 21 Oct 2014 12:24:34 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 379BFE0A43; Tue, 21 Oct 2014 12:24:34 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.728.g406752a
In-Reply-To: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit 07baa71eda8d1047f003acc7ea32ad6b6600b179 upstream.

Break out the code to create the string and writing it to the file
descriptor from log_ref_write and into a dedicated function log_ref_write_fd.
For now this is only used from log_ref_write but later on we will call
this function from reflog transactions too which means that we will end
up with only a single place where we write a reflog entry to a file instead
of the current two places (log_ref_write and builtin/reflog.c).

Change-Id: I178e84a52af18c800844596af33dbc21bc076c1f
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
