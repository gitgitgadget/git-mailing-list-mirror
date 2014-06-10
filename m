From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 13/48] refs.c: make resolve_ref_unsafe set errno to something meaningful on error
Date: Tue, 10 Jun 2014 15:29:01 -0700
Message-ID: <1402439376-25839-14-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:37:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUa7-0006OG-Go
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823AbaFJWbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:31:44 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:36503 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbaFJW3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:41 -0400
Received: by mail-pb0-f73.google.com with SMTP id md12so205691pbc.2
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VIjfeIx6ChH/Bmv5HeD+/bnDogM5AdQ2DRDQs+tKrdA=;
        b=FS/LbCmTJHFgbL3H4ibj3fIOu+GjY/cp5BWJ6tRgLFkbWj6h/DaWmX62GzFpStzoyl
         j3lkn5nqlkisPzpPw3BbddyG7pZvmcaZSfYv8ThC0Xb0KwP5l6cWG6gR4FHXdroFHP4i
         MhsdQXtJ7flXURqs9PpFVxW8rI6ZiRar+8PPgVMp3gusRHjBzWHyrOABc45vHyxpd86V
         JjmnSj4muEsLHvgZ9gtR7xoGfyr48QwdNpbyMgYD2Y/z7xFmIFJWaZ6MFjRuHZe3SZ07
         7OID5hGmR0Nao3xJnLwOt0Z40f90M0cf9FUwc6x7jvZBr0P4D/wqdbrDjn+0fAE/Gsv/
         9Ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VIjfeIx6ChH/Bmv5HeD+/bnDogM5AdQ2DRDQs+tKrdA=;
        b=Y9g3/uliFBtSf0+uo/yXNZRl7WafYmZ3059OrpO75RaiYaNyLp4NO9eFcutoc1LRlp
         ZhOpHr/CcsEOs2SD4UkA1Y3luZwPZmkYVAvrzPjwByel3UwLSAGZYVvcXEMa6alg8Mad
         vFRdtFp7Ux5NDAiaQ093tVjbYuaHxnlrHPNdksEcgSsNgV2R453Bi6KicNUywDXDO+Gf
         hhc8HQsGFJo8hFpMTtoOd7kiz/Gmm9VTWJ6Tu7Ex9A99W2BBKTxN0KXw6KGoNA5NlR2F
         PfxRzbjFqPqpyQxXQ2gdW47NWU/83NGEm41tV+PDDrlbxgm+nR9uahQIRM0KOF7DbZ9n
         i7wA==
X-Gm-Message-State: ALoCoQn2Cb0KmNxBOhQdjuhOrMjWAgyuDIrXAdfidcrok1g57m9tMGFerErnjY5Xd44RRw1694Zg
X-Received: by 10.66.65.109 with SMTP id w13mr3933789pas.21.1402439380672;
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si1394551yhl.7.2014.06.10.15.29.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 7CB3D5A4838;
	Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 346D2E0616; Tue, 10 Jun 2014 15:29:39 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251281>

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
2.0.0.574.g30c2c5e
