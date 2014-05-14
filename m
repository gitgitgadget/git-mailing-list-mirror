From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 05/31] refs.c: add a function to append a reflog entry to a fd
Date: Wed, 14 May 2014 15:13:04 -0700
Message-ID: <1400105610-21194-6-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:13:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhQm-00064m-49
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbaENWNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:13:35 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:39759 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbaENWNe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:34 -0400
Received: by mail-ig0-f202.google.com with SMTP id r10so22288igi.1
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sg06SOwG36SQXHvm66Tw2suzB/mPplY67zKqdGb3ji0=;
        b=a6eIsVvYqNjqG0i2xMp41rEe9mdEpffTMYY193e+gYY4TD4gdvTp6alvyCQ4zZRTn5
         9pyBIU/yfj68txMrGtI0kKZH64RvZBgxUoZQXFLyhgfztjJCiFqMzjrwPYoXEe0ZxtLP
         G+Lii5mOhw+bgl2W55LkuedO9WapOSRM3B0upBDgWFhuB3nJAwPzGOwb6bOC++D/+yEo
         MJGxPllqvDBUvjh1ZLDEwGzF4TWcUH2MGpZyQPc0aCHHpE8J9GRgA2tBBw7Rx7rAnK06
         f2aRsNG/elfVwCUttQqJVKhKwJGqPNDoPPFECF2eAme028HQn6AgGEumna7DyXYcxcVB
         z4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sg06SOwG36SQXHvm66Tw2suzB/mPplY67zKqdGb3ji0=;
        b=dehBl5xXL4eCfQ2aXvF5NB5sAYl/c6lZACtiZ7w2jpPbp6BODYO7IpEHfhtrMtchu9
         PL+TjScDSUruPJARRdPar4kQRm8Bj+t6SJpTUxjSIlT+xQ5VFFd+FloqArWc8U1ptIbB
         9Mr5ukJ5gDOUU0h5PMWlSE837vJi5DTizLKPmpRkyXz5WudpWIq2hc2paI+cONX+UPdl
         7UUUsqHuTiG2My7klL1o80pnRDE4nT/mbUAq5QiOucl3y2cZA7YcsJY0jFyEufKoxR46
         H+etkgRkaz7JQf9B3ffTiFUVd8vxgjVdBDfsOVQScbl4UDWMo658zTkZfmJrM09DkmDB
         DwqQ==
X-Gm-Message-State: ALoCoQkxDEWPpisfZi5jafJwJCRJ0GAVERD3Zv0pCE4LHBDv2cBtQKunmhvcy+K2pitsCIhX7oVL
X-Received: by 10.50.115.104 with SMTP id jn8mr10653738igb.1.1400105614069;
        Wed, 14 May 2014 15:13:34 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si151862yhk.4.2014.05.14.15.13.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id DBAC05A41E5;
	Wed, 14 May 2014 15:13:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 9F9FFE038E; Wed, 14 May 2014 15:13:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249010>

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
index 018062d..98c6c00 100644
--- a/refs.c
+++ b/refs.c
@@ -2745,15 +2745,37 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
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
+	written = len <= maxlen ? write_in_full(fd, logrec, len) : -1;
+
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
@@ -2765,19 +2787,9 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
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
-	if (close(logfd) != 0 || written != len)
+	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
+				  git_committer_info(0), msg);
+	if (close(logfd) != 0 || result)
 		return error("Unable to append to %s", log_file);
 	return 0;
 }
-- 
2.0.0.rc3.506.g3739a35
