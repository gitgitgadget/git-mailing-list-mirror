From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 13/48] refs.c: make resolve_ref_unsafe set errno to something meaningful on error
Date: Thu, 12 Jun 2014 10:21:04 -0700
Message-ID: <1402593699-13983-14-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:23:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8j9-0000FP-Vr
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933663AbaFLRXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:23:39 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:52826 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756217AbaFLRVo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:44 -0400
Received: by mail-qc0-f202.google.com with SMTP id x13so99182qcv.5
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1z+wHwJ2h1678l+mpT233capYlztEGuV41DjXi5ltIs=;
        b=EYmq3apZxnlQ2o7zqPUgdbpbCNOcoHwQAw428vYgtAB1D2if5fbFoDAZgWFd8QyxS7
         wEUBPrjBdc/RoMPqABD/cAFaG5tD80ToMsT2raoR0+ZFtbWCw0ZAfPxJ5KcrNQq14vmo
         PxWTjMCCPV9kVoNmdIFv8eMr+BTk+Py81VuHAJ1BuCgm6qpjE80R2GR2odpO+dMysExS
         vi1/seWMJ/FKJgAnMCvtMF7d/dK7NqI5zFsFEADCbG0rie60jVksK+DI4+wh/a4zQ4Ef
         lqZhuHKwjx9KkcngciTXbSDN6GQ7Yca6OgY91s3ySAbB7Z21H4hlGv5FiL8JL5lCGPFw
         UMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1z+wHwJ2h1678l+mpT233capYlztEGuV41DjXi5ltIs=;
        b=Fkq5XLkzVKgAOAC1S2nABWipeBG4W9huYtQAOT7inyXnQNDER9haoS708L4Ky8KI+7
         KeKuqXJvhafp9KUUZoQUAG8U355JTn65omyWaYf3CWzYPfWo5vwTP1bYlWdB6I3xgLFs
         C8HOyGwhJqvHmBfQzXV+ZStVDz01/Qui5AdwZvzfA6lep6O800bLl1YQmj7pJssQfTih
         lWO0NYBPHa5a/tu+NNA1gAqeLbS+V6TD4pmFRehEdVZ2Y3v98sFj1xrcUSm9/NbD21Tz
         1jpI9ujgY0ga32Db1pNUHsBz7+888jrwatIj8HAOedQPJR1mAHIgv+u9Nl0CQjolkrC2
         YNPg==
X-Gm-Message-State: ALoCoQmTEbDS8BX8a88fpjz2n3kx0rdKaUjUKVWKSEtgYAJMtLHL5/U62jTAfa3fsrng0LHB6cQ/
X-Received: by 10.58.69.49 with SMTP id b17mr14204976veu.26.1402593703391;
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si111886yhp.6.2014.06.12.10.21.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 3BE835A47F2;
	Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1A0E1E0A7E; Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251453>

Making errno when returning from resolve_ref_unsafe() meaningful,
which should fix

 * a bug in lock_ref_sha1_basic, where it assumes EISDIR
   means it failed due to a directory being in the way

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 cache.h |  2 +-
 refs.c  | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 8b12aa8..e7ec626 100644
--- a/cache.h
+++ b/cache.h
@@ -979,7 +979,7 @@ extern int read_ref(const char *refname, unsigned char *sha1);
  * NULL.  If more than MAXDEPTH recursive symbolic lookups are needed,
  * give up and return NULL.
  *
- * errno is sometimes set on errors, but not always.
+ * errno is set to something meaningful on error.
  */
 extern const char *resolve_ref_unsafe(const char *ref, unsigned char *sha1, int reading, int *flag);
 extern char *resolve_refdup(const char *ref, unsigned char *sha1, int reading, int *flag);
diff --git a/refs.c b/refs.c
index dc9de2c..a4c728c 100644
--- a/refs.c
+++ b/refs.c
@@ -1323,6 +1323,7 @@ static const char *handle_missing_loose_ref(const char *refname,
 	}
 }
 
+/* This function needs to return a meaningful errno on failure */
 const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int reading, int *flag)
 {
 	int depth = MAXDEPTH;
@@ -1333,8 +1334,10 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 	if (flag)
 		*flag = 0;
 
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		errno = EINVAL;
 		return NULL;
+	}
 
 	for (;;) {
 		char path[PATH_MAX];
@@ -1342,8 +1345,10 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		char *buf;
 		int fd;
 
-		if (--depth < 0)
+		if (--depth < 0) {
+			errno = ELOOP;
 			return NULL;
+		}
 
 		git_snpath(path, sizeof(path), "%s", refname);
 
@@ -1405,9 +1410,13 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 				return NULL;
 		}
 		len = read_in_full(fd, buffer, sizeof(buffer)-1);
+		if (len < 0) {
+			int save_errno = errno;
+			close(fd);
+			errno = save_errno;
+ 			return NULL;
+		}
 		close(fd);
-		if (len < 0)
-			return NULL;
 		while (len && isspace(buffer[len-1]))
 			len--;
 		buffer[len] = '\0';
@@ -1424,6 +1433,7 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 			    (buffer[40] != '\0' && !isspace(buffer[40]))) {
 				if (flag)
 					*flag |= REF_ISBROKEN;
+				errno = EINVAL;
 				return NULL;
 			}
 			return refname;
@@ -1436,6 +1446,7 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
 			if (flag)
 				*flag |= REF_ISBROKEN;
+			errno = EINVAL;
 			return NULL;
 		}
 		refname = strcpy(refname_buffer, buf);
-- 
2.0.0.599.g83ced0e
