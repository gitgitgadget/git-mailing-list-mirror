From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 13/48] refs.c: make resolve_ref_unsafe set errno to something meaningful on error
Date: Thu, 19 Jun 2014 08:52:55 -0700
Message-ID: <1403193210-6028-14-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:56:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxehR-0000yz-Bw
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758054AbaFSP4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:56:15 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:52231 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757784AbaFSPxe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:34 -0400
Received: by mail-ie0-f202.google.com with SMTP id tr6so692549ieb.5
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kkes+RgdPZP5E36xV0W2nrZlqXGmBF45lMqLGcy9cOg=;
        b=hnqfNSXUrEXAQHamfHaYlUfzBgg8xW88mqUWShOH/+kN1Tm71mHJ0x45oh7DRakO4I
         GT1krWEgLyjx45f6GIc212mko2iBKp+sEngNfzb+z+6un+Y3r8cKjU2fgbOgOWuK9c67
         QHRnT1Em31o2W5Ls8+YThfpYp9SF3CgYU1T6GudF2RpFBWU/RkT90KiPkcLJUblJS9xs
         fMqkVdtH2R8Myq1iAEno0TBCu54dEnCN/asmtfsDXy5eVl3HJm4O8OwCAsO3s1YzUyx8
         7NQ/EAKGr60RoQzKMlxfxWORHe3lne9ZMgQHuf+01WXcz5VMrwEBXxcaGC0VhhGWhwFZ
         /Q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kkes+RgdPZP5E36xV0W2nrZlqXGmBF45lMqLGcy9cOg=;
        b=HsaWsPn1R/YcKFJ3oYKPdK0PVtzG8HTmtuz7rZ4mTvnLZHh0sGx2K16/3u533H/UD6
         9hyAviPoJoIqs1VPC10GqDc6Umk2b4Ep/pz/50YyH3NTu4LG/tbl/VczOhxHz+UQzaN7
         PtLrbtb2GKl8cyH+xRj/wTHnjwXa7hjqoM8Mu0lUkXilBoTPeOl8OfAbYVKQ/flwhP3/
         7449FWSm8Fz7N7PYS9H/Hn7XPRhlgMf39/QBMkECFS2DbIsg8MeAhDimzisZrAEXC3ha
         crsr+Pf9qSLXIh2bYXWXvKe/eC5r7QrS9EyIMqVk4KpMMUBl6wN2fqtTEKsK5PcQ3RFH
         LA/A==
X-Gm-Message-State: ALoCoQlXQ2RZvJ62z5SA4dS4v13AJhji0wH96i2m+nKnVPGkmmw+J1aqz0ALCkuqh36Xgy+oLsC1
X-Received: by 10.182.87.3 with SMTP id t3mr2750823obz.20.1403193213332;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j43si187562yhh.5.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 3163831C3F5;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DF786E24DB; Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252158>

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
2.0.0.438.g337c581
