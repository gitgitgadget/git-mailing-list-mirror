From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v21 13/19] refs.c: make resolve_ref_unsafe set errno to something meaningful on error
Date: Mon, 14 Jul 2014 13:58:55 -0700
Message-ID: <1405371541-32121-14-git-send-email-sahlberg@google.com>
References: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 23:00:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6nLu-0003E7-UM
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 23:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757249AbaGNU7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 16:59:54 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:58130 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756999AbaGNU7I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 16:59:08 -0400
Received: by mail-qa0-f73.google.com with SMTP id s7so450426qap.2
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nsm3tl/HL5YDfLo/f0hcvSva0+LUybqvlpjfaVw1Q1I=;
        b=fULZy+a4pptU0u/t5lNZkc4Gdf7YaEM7te951wHM00u/iVWChxCPZ1jY3sPa/LyrX7
         HrD3Dp0neB+w1AzBDQOhyiH57mldovOP3+Pzhce6KJUDuCFNjm7AcAMH1zApFspwNSVy
         s591cHjON2cmknMqBB/KxSjvpLTCFd4hB3J09/3iby07EElHCsVo39Q+mkchSYM+k/G3
         DptM7WHwDqox2b5n8B71Q4ic3qat3qb3uf0KwX6vnpFh7c57AqxjFQz+8FZDboUGnw9T
         9VMqMu4BLj9kPBm6zRRHBlN96hnAKufBao850e9SeCeMlREc6WkyAUB1T6TH+LVXcPal
         693g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nsm3tl/HL5YDfLo/f0hcvSva0+LUybqvlpjfaVw1Q1I=;
        b=gF6vVhP9pXjWhonSHqUFtoRaTcoceP336tHzFDnrEmQRLRwQXj6C/lSUhBxGn6okvc
         ACTUqwDGsW+G4Ax1F873bP3LjxHpE9kTrGm0rG2vlzA7sPtfqfzm7FB4nIcczvuQVGWT
         jAW6m97aHLsuSlcYNkv4oDombEr0F1Wd28ufhbgxbSNNpazRcAllljAK1VUheYA3Yk92
         buPO314uICSLRwEARCRau1ob2ZAYwKS8pZCgUQUwYMFAipLTB5XO1HRBkRYzik9g2HEx
         8vtjBp0YRx9X6Z3Ic73o2LWzTeYl1ENIXzWmP3SVGIQRaP+mYEmvQCN1jUXyVrHG/gdG
         TeeQ==
X-Gm-Message-State: ALoCoQn6NNtSBFDrL/o3+bfZSkOmY+OyAG67kIG2+UCf6//CIRVZUirqjkFwZFiov30iQSNEo3PF
X-Received: by 10.236.223.9 with SMTP id u9mr7905149yhp.2.1405371546344;
        Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si821467yhk.4.2014.07.14.13.59.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 34C025A4456;
	Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BCB99E0ED7; Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.546.gf603308
In-Reply-To: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253532>

Making errno when returning from resolve_ref_unsafe() meaningful,
which should fix

 * a bug in lock_ref_sha1_basic, where it assumes EISDIR
   means it failed due to a directory being in the way

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h |  2 +-
 refs.c  | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 8a46294..4ca4583 100644
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
2.0.1.546.gf603308
