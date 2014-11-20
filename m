From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] refs.c: add a function to append a reflog entry to a fd
Date: Wed, 19 Nov 2014 16:42:22 -0800
Message-ID: <1416444142-28042-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: sahlberg@google.com, jrnieder@gmail.com, gitster@pobox.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 20 01:42:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrFpS-0003AW-LA
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 01:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756228AbaKTAma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 19:42:30 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:56861 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754986AbaKTAm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 19:42:29 -0500
Received: by mail-ie0-f170.google.com with SMTP id rd18so1772894iec.29
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 16:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=yveqnGjI8sSfHgDl7EFjkqhWYJ9omKz0rEbETaP4BaA=;
        b=S+R02CoKWkq2qdkt7GXl+weVJak1Ge36UWL2b9e23gIC9rwAtmsIw1MumkQIb+L9DF
         kaJuYGD36X9/Tvye5Zh/YK2s2Glxlh6g9QOdgKIUPSqIKFFgjRD0274HiryKKMyoBdb4
         j31PHX/g3lrlkt80SYPGg2uF/V9Kh2QzxCYhpEy586P2eju3+mfQR1QHD/UvHUY/6iXT
         PKuOhqxcRwgpmUekiTUiIQqbxuiOs0A+CFk5ZjEDpL9zI//6GNjlNFkH6asJEzUK6z12
         u9uzHp2fooDfBUy018gFFQuogyX4UR5AYq48ZrSYJTH66wGoJVAWFVwU4/QCGSR9LFnr
         ashA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yveqnGjI8sSfHgDl7EFjkqhWYJ9omKz0rEbETaP4BaA=;
        b=FWFFn9sG0mtz+aeZMnDfsqREX03D89retLTeP6xN+IO+LQGgKOWLKab8edjqWu3+CL
         0Qu+7G+nBFYykNXD17GB5yaSG2wVIVvuiOBFvDN2n/QF5mFSTkUVElcYjSrI8+pdvE4S
         mgg9GxBS1/PR5Yhbxzqwn6ShjhZrNYHRV02uwYn22T5GIh/kCuGBFGeC67MZnJGWKtKi
         nE3MK9PDie0cEJHFgds5dXqStzYoQfOaM2ZfM1n5YIY0Dtp9CpKmKu+Liq9fSyag6skf
         adpevWAqOpDrxn6g5FP47s5mQAuZ6Rzjh+bDjpDkbfVS6ocKypgwc2RKNGsGSRTN3xNk
         E+GQ==
X-Gm-Message-State: ALoCoQlU/j6mPdBCpE9DszX1foTfr+njl11OcnNBHcEBgTOg73b36i+5IZtEaA7STF9bRu0vTr1r
X-Received: by 10.50.114.97 with SMTP id jf1mr6370394igb.29.1416444149284;
        Wed, 19 Nov 2014 16:42:29 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:7876:7c52:1268:8374])
        by mx.google.com with ESMTPSA id p198sm436697iop.36.2014.11.19.16.42.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Nov 2014 16:42:28 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.13.g0786cdb
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

[sb: replaced sprintf by snprintf for security reasons, 
     which was there in the beginning (6de08ae688b9f2, 2006-06-17, 
     Log ref updates to logs/refs/<ref>), but got lost in (8ac65937d032ad, 
     2007-01-26, Make sure we do not write bogus reflog entries.)
]

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

This is also part of the ref-transaction-reflog series, but is 
sufficiently independant, that I'd argue it's a general code hygiene thing,
we can use in any case.

Applies on master.

Compared to the last send of this patch[1], there was one change in the print
function. Replaced sprintf by snprintf for security reasons. 

[1] part of the ref-transaction-reflog series 
    http://permalink.gmane.org/gmane.comp.version-control.git/259714
 

diff --git a/refs.c b/refs.c
index 5ff457e..f9b42e5 100644
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
+	len = snprintf(logrec, maxlen, "%s %s %s\n",
+		       sha1_to_hex(old_sha1),
+		       sha1_to_hex(new_sha1),
+		       committer);
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
2.2.0.rc2.13.g0786cdb
