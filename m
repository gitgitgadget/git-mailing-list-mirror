From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 03/13] refs.c: add a function to append a reflog entry to a fd
Date: Thu,  4 Dec 2014 00:29:13 -0800
Message-ID: <1417681763-32334-4-git-send-email-sbeller@google.com>
References: <1417681763-32334-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 04 09:30:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwRoH-0006Eo-US
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 09:30:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbaLDIap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 03:30:45 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:44494 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbaLDI3g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 03:29:36 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so14690029iec.8
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 00:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QbKH4g6pnYD+Qa7rFgIB6XFqa0ISf96TOfGeIWCnoDI=;
        b=i2QUDsfPygMjYbA7ioXMf69jaNLgZ/O2nG952OeLrdcmmlALWGL5OQc0cw06wptb7H
         3IS4T0PWkJ03BVExdpBZy6EIbQLGKI+aGwP2tzfDMM61s1O4TjY3a3lbLsFjWC7wfXe3
         Hppn4sBIIAzXyDjAkfGnIWX67df1q1LwpmsL2GnVWKR7rVZeAudIqv3Mm4BUU+6yBFkp
         CmeRktRrWVweY6cEisur/JJ7dXZvnHMAHWv7Ryp+lhgaAG6X4Dr7fWZ8yOUgtbmbETip
         eO0w/L9ghP5yp91UVVhosSxtx9CF16RyRakxjgeVPwdEeu1Xutdx6m7gaqAFuZCGB7ds
         hvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QbKH4g6pnYD+Qa7rFgIB6XFqa0ISf96TOfGeIWCnoDI=;
        b=jnVczb7QWcpV2QQLNENE8IMNYOrZD37KdJnsgmKUDyPFofl+p0noQtNf97dq0SlfQd
         11g3wGRhgP+gSouXyMzEno2vm4RVcOiaMqzzCxCkxOYdNYK8+q2Jjk/yeXbCAp/d7xtL
         qR4yCO7Wd41rh/QYdjHofl7TPXNFewCxjAVfVd5calqLv1M613ucR9nSEnoGH6h5Mt1l
         6odIZG/CBpOjHL4N0TGDdV8Z4M6HP72G/3ybat1NInZIg9qk+PoDkZztOMiwdVXyIrPK
         BTQOME7SSQauxzNWLKhJd1VYlBWl7v8XQgmH/F4JBWGJItIn4J3bsMVcpHrN41Ah4jdi
         Bx4w==
X-Gm-Message-State: ALoCoQki4eJF1tCfGO9FLcIdqECXUMlhMzBtr07+F3ZOzXdqhimlLj51BGhCcgzsDeg5emjZ8GcH
X-Received: by 10.107.168.216 with SMTP id e85mr8263696ioj.89.1417681776183;
        Thu, 04 Dec 2014 00:29:36 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5d2c:9a2d:3064:bc4])
        by mx.google.com with ESMTPSA id c139sm6170311ioc.28.2014.12.04.00.29.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 00:29:35 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417681763-32334-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260745>

From: Ronnie Sahlberg <sahlberg@google.com>

Break out the code to create the string and writing it to the file
descriptor from log_ref_write and add it into a dedicated function
log_ref_write_fd. For now this is only used from log_ref_write,
but later on we will call this function from reflog transactions too,
which means that we will end up with only a single place,
where we write a reflog entry to a file instead of the current two
places (log_ref_write and builtin/reflog.c).

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---

Notes:
    being part of origin/sb/log-ref-write-fd
    
    no changes since sending last time.

 refs.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 05cb299..150c980 100644
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
2.2.0
