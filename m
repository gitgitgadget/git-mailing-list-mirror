From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 04/14] refs.c: add a function to append a reflog entry to a fd
Date: Mon, 17 Nov 2014 17:35:40 -0800
Message-ID: <1416274550-2827-5-git-send-email-sbeller@google.com>
References: <1416274550-2827-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:36:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXiC-0000BI-Rz
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328AbaKRBgC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:36:02 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:57072 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbaKRBf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:35:59 -0500
Received: by mail-ig0-f169.google.com with SMTP id hl2so3042588igb.4
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Acz/PUVyR8uzxKQqJ8yJdbCpWkzBcgoaE+aKMwp9FI0=;
        b=f1w/dio1uHqd5r64J460mjsUAAE+P6/VFX+XzyGMS9U1dYT3O/9RbUVtRVs9rsF0Tt
         hY5fJ3chNfTib5T1F07SR34pPS26+Bms/xSQVclXn2wX3XB4FwNMkO1uG9C8IhjfMMhX
         Gjn8aN6oxRoeM/jwAWmzmVRSFi4mvyisJmOq58l0kKrreSXGIvFEwIPksKueRnSSqlrP
         RjIh5K8xwzjmr6oxCzCcAQHS+dLSy8ewF6Ku1YgGcSrenOEpcGHczhe0FtAJ13THvuTV
         qPmi6mET6lm64hMlGaeF/Urr0oGPn8NGz7w4ZXp+fKV/z0E/wZvSw2tUDfbX38ucs0Jr
         VFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Acz/PUVyR8uzxKQqJ8yJdbCpWkzBcgoaE+aKMwp9FI0=;
        b=hZQDXz7/48/HdhypZDMNGhUth1lrfrqnl/3ZePbmAsXhyl6BC6VAjmsqeGNTlVhDt8
         Csh2dGj81nkaXFW8k8gj1hL7sa22EP+LB++T1+B+m8+u9rd7gItaKZpSN5xixwpT1h7w
         n4PIq446mkvzt88CwcFD+eeYrZGAGUpkNguaYJy3ecvVjNcxBOetI/DuyEEIbodilcib
         GP0qUwIsRGjK17Pzkmxh6DG3yhzTlriOyzhZZ7U7URvdmdIPAaSZ3fPTED5bnpXrMDw5
         nQ5j67g6hbRn0Leao2wQ2XCPNYM9Pz7aY0QWp+mJ6f/7DaGYhbgdEKyceAQFKNYVCsG8
         eWCg==
X-Gm-Message-State: ALoCoQlgIBQwYpxBK1km4em0dmgEyFdieTcChQxDMjluENLVczeSZNCub2KD+wZ4IRGyJpLwvvrk
X-Received: by 10.42.96.198 with SMTP id k6mr30853177icn.7.1416274558654;
        Mon, 17 Nov 2014 17:35:58 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id d2sm19782296ioj.30.2014.11.17.17.35.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:35:58 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416274550-2827-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Break out the code to create the string and writing it to the file
descriptor from log_ref_write and add it into a dedicated function
log_ref_write_fd. For now this is only used from log_ref_write,
but later on we will call this function from reflog transactions too,
which means that we will end up with only a single place,
where we write a reflog entry to a file instead of the current two
places (log_ref_write and builtin/reflog.c).

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 2044d8f..f0f0d23 100644
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
2.2.0.rc2.5.gf7b9fb2
