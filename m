From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 13/48] refs.c: make resolve_ref_unsafe set errno to something meaningful on error
Date: Tue, 17 Jun 2014 08:53:27 -0700
Message-ID: <1403020442-31049-14-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:58:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvm5-0000AW-UV
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933622AbaFQP6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:58:01 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:51395 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756243AbaFQPyF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:05 -0400
Received: by mail-pd0-f201.google.com with SMTP id v10so601253pde.0
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r4zm/COXOyU7sCuXVoXp6dC5DZpG+ESk67Ufu2X9uKY=;
        b=JWgeppBc7QRWbgfsxVN+f4d0sHnl94X5T7QPhk2DvX4YWqTNSutGmJoe9K0ZfSScM0
         OBMFepx7yu+i0A4jF9NGZvxhWYiyM9PmQnYQm/1TFYdo5vqj6tIB5362BC0lCl9x4GZa
         s1FDz4yc0TUYeV40s6qs2IU/Kdn6rXSPS4C+2S8a4Q6qwNZOd0TK0yFpppAnlxNsZFrd
         3i5sHk3cATkv4V8N863R0gKCugnhp2HzVBT2QvY+FSZXnCfx9m00SJJEG1nSeQ2GYhDC
         uPfvEhUKsD8+klylf1h+9eVJgy2jVF4jflS+gRkf1uMUPuRwnAorljSuVRX+kmqwI2K8
         kBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r4zm/COXOyU7sCuXVoXp6dC5DZpG+ESk67Ufu2X9uKY=;
        b=EwYCKxdHlL+d8ahgb0wFwbhgt41g8kcSaL4Nu5Dvx7tknEQS8WiI5a+48fyUlhtTml
         wmvuRYecRrNfbNjw62nTFql7u0Uiu2GlXajrREYYd7oDotogkkpEZfWCcJaHZ5comJh7
         qYSDKWPbaDj57BVyLPFmf2bNbkVxUKG+dT207ssr2phzb/wvP3qxbPSvWqHU7RKYpAwb
         9r9VdIGU19jFVxEgTbXE4aDlFwNjVD1pvzLd45j/DHvWaCqubLxdKoXZnQ4JJa9kXLdh
         1/NUByZg/SYEFcMB0yWdzSnQgPFKsmFolAquNopEQVvhy+RWxXrkuVAY3y9Rd6Sx/k/O
         stiw==
X-Gm-Message-State: ALoCoQknLnUyYUtyF2PCqibUNqbjRPGu4KuGna5XuzKq7CMPE19P/4GiR30eyucm6TlAJbfBoBcz
X-Received: by 10.66.218.105 with SMTP id pf9mr247063pac.36.1403020444896;
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id i65si1209462yhg.2.2014.06.17.08.54.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B368831C771;
	Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 60423E036B; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251917>

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
index 7a815be..211429d 100644
--- a/refs.c
+++ b/refs.c
@@ -1334,6 +1334,7 @@ static const char *handle_missing_loose_ref(const char *refname,
 	}
 }
 
+/* This function needs to return a meaningful errno on failure */
 const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int reading, int *flag)
 {
 	int depth = MAXDEPTH;
@@ -1344,8 +1345,10 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 	if (flag)
 		*flag = 0;
 
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		errno = EINVAL;
 		return NULL;
+	}
 
 	for (;;) {
 		char path[PATH_MAX];
@@ -1353,8 +1356,10 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		char *buf;
 		int fd;
 
-		if (--depth < 0)
+		if (--depth < 0) {
+			errno = ELOOP;
 			return NULL;
+		}
 
 		git_snpath(path, sizeof(path), "%s", refname);
 
@@ -1416,9 +1421,13 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 				return NULL;
 		}
 		len = read_in_full(fd, buffer, sizeof(buffer)-1);
-		close(fd);
-		if (len < 0)
+		if (len < 0) {
+			int save_errno = errno;
+			close(fd);
+			errno = save_errno;
 			return NULL;
+		}
+		close(fd);
 		while (len && isspace(buffer[len-1]))
 			len--;
 		buffer[len] = '\0';
@@ -1435,6 +1444,7 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 			    (buffer[40] != '\0' && !isspace(buffer[40]))) {
 				if (flag)
 					*flag |= REF_ISBROKEN;
+				errno = EINVAL;
 				return NULL;
 			}
 			return refname;
@@ -1447,6 +1457,7 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
 			if (flag)
 				*flag |= REF_ISBROKEN;
+			errno = EINVAL;
 			return NULL;
 		}
 		refname = strcpy(refname_buffer, buf);
-- 
2.0.0.438.gec92e5c
