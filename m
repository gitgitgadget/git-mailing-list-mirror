From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 13/48] refs.c: make resolve_ref_unsafe set errno to something meaningful on error
Date: Mon, 16 Jun 2014 11:03:44 -0700
Message-ID: <1402941859-29354-14-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:07:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbJd-0006ak-KH
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932798AbaFPSHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:07:25 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:36008 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932447AbaFPSEY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:24 -0400
Received: by mail-oa0-f74.google.com with SMTP id i7so1126944oag.5
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5wxrLGnMtF2/Eai/VhhBadPUgzBh2YQyPt7Mz6PNno8=;
        b=ZFTvU8/6Gl3PqRNvKGVB+THlUv3pBjryDire3Q6b/FFo5sjtS25j0OqGaJpyU7ydqN
         8/6BQgChx6BDOUr2SBzUQRxdOJ3L4S2eqLLVFDjSq6IBn0jUIlIRDKFrI0GpW/E8B6pT
         hF1q18UOHfnuRiy2iTcsTnxn5XAToiHErXZkg+OM5sRURvpUKFdfDiJaEb1s08k28+X2
         2EPdddJsu0aBuDBvIOPCp9cBCmoq/etspwhA+cRGj94E+fsAy2qox/8OjSTE8BkaK9On
         G7HgB+GsPHDtY3+JG1ESGK1O0i0RrpgYdhVR0afzO1L5BzGnsZ7hfr3ZnSZgrcS/+zNo
         wM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5wxrLGnMtF2/Eai/VhhBadPUgzBh2YQyPt7Mz6PNno8=;
        b=OSSCHf858DV9Er+/Q6t1GdkaovUfMH8A821Du5pNtoblmuIFcIiR6j7fn4Ku1wXV+G
         CuNlrOj6CPEnENRiQ1AoOxLNyi/FJXvaodlMxJVb1ff0vvZmo5WrZDpiIHXWScbOtXfr
         p45zagsozRC4ntkbnqbaFpk2o1E6ul1dQwnbbG0ksXNs9wV9/Zq0CdxyjgDXp5kJkXlz
         YJldV75tbZs+qCbWRZidruVcQdp3M9Rw4VKsNtmHoaLumLk2FMScsCP3ckXVbz0aNdkH
         NJYw/Kce1EEPYGurkr6TlBf3kv9Lj4Hh8dmGyN+EfEKqpFjzcMMYE5R5pesrBP1s02tf
         HsHw==
X-Gm-Message-State: ALoCoQkzWXigd8Bm7z5CX14+tb2VRD7fz3sx8irM9NXgOyxDXDlKIi8Cg70Pc8NYT+zSU/E05Nu+
X-Received: by 10.182.226.166 with SMTP id rt6mr2679568obc.47.1402941862824;
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si998063yhg.2.2014.06.16.11.04.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id AA23C5A4911;
	Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 85439E05EA; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251768>

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
index 19b0963..0c2a9aa 100644
--- a/cache.h
+++ b/cache.h
@@ -980,7 +980,7 @@ extern int read_ref(const char *refname, unsigned char *sha1);
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
2.0.0.282.g3799eda.dirty
