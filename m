From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 13/48] refs.c: make resolve_ref_unsafe set errno to something meaningful on error
Date: Fri, 20 Jun 2014 07:42:54 -0700
Message-ID: <1403275409-28173-14-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:46:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy05U-000410-Ek
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295AbaFTOq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:46:27 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:57612 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166AbaFTOnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:33 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so506791qcz.0
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5sjNv+gFMPB/6axy7Dl8R/E4HHmM3nFsPqqH0jyCR9E=;
        b=g/YDiIdD25s/BWcQLv1R+sZIEwWNhQMcEqcMguO6cWAqrLrJ8ZGwE99AAU0G+5Xz7r
         FP+mNghQVrSdBTOzKwkSxRN1Fc/YbyocQkPaxHphejpn21e1M5a+mQ3vjPKNwWcZjoKp
         AZakpwarfDVuQ4OounP6MYk5+1zTxNJA/IVEBYaKw/INHauq5Ud6Bk7o+5cAEkr+eiue
         BcSC3zprg11RIx++3uTX6nHDEf64Xq6UyCKRKZGGNzA0aDfQjT2b5bEmbQ/g3ZuZGPe+
         5tIrhr5zTcD6AisgMCeJF/5HZFg6ma5dYEZU4PzRpH3UHvuFBsCIykKa/JTv1MPNVZ32
         jSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5sjNv+gFMPB/6axy7Dl8R/E4HHmM3nFsPqqH0jyCR9E=;
        b=NvYBArWpWIPBYAnGqOd8QQdzRhfJpWwrJKk0esWW9z4wuge51SwTh2eNIm/jRr8c4s
         6Laq9QG6kIE9zxQx8e5JP7R/L07iF3p0MtOWOJRoph7O7Ou1NzLNSEtIOCbZVPxhVGtE
         w93saesZBYwT6tH88dE98f1q0HzynkeLaTzjMtzrktOfobFT5HM+Y+ahqZZVJjZcnqu2
         R0AkOx9kjVBsMNXOPD/U8uQToNkyf9+rT/sN92Fm/imIZ37NVDn1WbmvzmjU5n7QLik+
         4AefkBlQjElcF54gN4hw40nfAfbYscIPsONZC4hDhzKW6V20LWxAkaS0+18LVF5siqk2
         rjkg==
X-Gm-Message-State: ALoCoQmmFmQ0L2iIwrYg3ByQT9U3tzVNmc1kC7JmnvIj5aC6/UyA2I30MuO9cWhDRN7fF+q8IJ17
X-Received: by 10.236.216.5 with SMTP id f5mr1297058yhp.10.1403275412615;
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j43si432418yhh.5.2014.06.20.07.43.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 7978931C6B5;
	Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 57BA2E1207; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252266>

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
2.0.0.420.g181e020.dirty
