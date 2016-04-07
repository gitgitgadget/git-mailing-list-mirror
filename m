From: David Turner <dturner@twopensource.com>
Subject: [PATCH 10/24] resolve_ref_unsafe(): ensure flags is always set
Date: Thu,  7 Apr 2016 15:02:57 -0400
Message-ID: <1460055791-23313-11-git-send-email-dturner@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:04:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFEc-0007wR-D5
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757370AbcDGTEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:04:37 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36019 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756785AbcDGTDc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:32 -0400
Received: by mail-qg0-f48.google.com with SMTP id f52so71730389qga.3
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ULvlxMfGS84nxOt822d5I4rhB1/Z6ciIbxxkLlBm93I=;
        b=fB5F/bQ/BYyHGKuroX7Tt6QDOpJSgNX9SZsPXcqytWhuZuA2dhk0S7GkIuMm94JoL1
         r69n+hJu/QuRFfzu7g5yWe9ejiQg0yQMV2cVH7SgiWCY/HOKlMfvWL8xX2a2ERE+8pkQ
         RYUorAFYA2zrmXBaB/LKM/BuqkOFSLtvor9FYeiIp29RhWdi6KTtJNEc31Q9ssI+xPd+
         ToO2H4oC9xzixbyovIx9FMp97Lq/axx3EyHYd4tsQUWoK+iXwebFdRFoONn3fuMeZcLf
         8+c2ny2VIzojb2uQj/zuvpnA4AsObdfC/sW8V5lBJlMJj0MnLkFY0ed2BHyMILc0yvp6
         WbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ULvlxMfGS84nxOt822d5I4rhB1/Z6ciIbxxkLlBm93I=;
        b=CN3CSovD3NwtW8KWiR3WuVVFb7BDM/fBx4KJuxa2V3pqSU18Z+SgUwkZ0XjvE5/tFl
         mrjd2nPFg5HFAElDisw0wHsg+M4K7J8qV3C8uILmRwT0xc2sXgQd4X08PtjpiAks4dOK
         MmkECDw3fruCif9TJw0Yo6O8QgcaPOaVbpyWPleWTGj/S8KwXxtXH08djuH8GDFjoFyh
         shYdV9XWKFWfC2pILsLVZBANiqIEmgdarnHF4hZj4+ofeLPY3sfHVI9Vr13y3cyvX6/G
         cEZLDOOHtXGOYofWeYv1a9UrDtuKZytgZu5pxYw03/zxYq6Lq9zye5u7CuI+FTIb7fRX
         Pjbg==
X-Gm-Message-State: AD7BkJIGp9djX5uxtx2jSwc21N4CnwR9HvlsRJ7RiS6+fbXgCRtn7wUsx8hKJn/ZmafiqA==
X-Received: by 10.140.232.211 with SMTP id d202mr6389116qhc.27.1460055811669;
        Thu, 07 Apr 2016 12:03:31 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:30 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290976>

From: Michael Haggerty <mhagger@alum.mit.edu>

If the caller passes flags==NULL, then set it to point at a local
scratch variable. This removes the need for a lot of "if (flags)" guards
in resolve_ref_1() and resolve_missing_loose_ref().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 101abba..067ce1c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1383,8 +1383,7 @@ static int resolve_missing_loose_ref(const char *refname,
 	entry = get_packed_ref(refname);
 	if (entry) {
 		hashcpy(sha1, entry->u.value.oid.hash);
-		if (flags)
-			*flags |= REF_ISPACKED;
+		*flags |= REF_ISPACKED;
 		return 0;
 	}
 	/* refname is not a packed reference. */
@@ -1403,12 +1402,10 @@ static const char *resolve_ref_1(const char *refname,
 	int bad_name = 0;
 	int symref_count;
 
-	if (flags)
-		*flags = 0;
+	*flags = 0;
 
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		if (flags)
-			*flags |= REF_BAD_NAME;
+		*flags |= REF_BAD_NAME;
 
 		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 		    !refname_is_safe(refname)) {
@@ -1458,8 +1455,7 @@ static const char *resolve_ref_1(const char *refname,
 			}
 			if (bad_name) {
 				hashclr(sha1);
-				if (flags)
-					*flags |= REF_ISBROKEN;
+				*flags |= REF_ISBROKEN;
 			}
 			return refname;
 		}
@@ -1478,8 +1474,7 @@ static const char *resolve_ref_1(const char *refname,
 			    !check_refname_format(sb_contents->buf, 0)) {
 				strbuf_swap(sb_refname, sb_contents);
 				refname = sb_refname->buf;
-				if (flags)
-					*flags |= REF_ISSYMREF;
+				*flags |= REF_ISSYMREF;
 				if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
 					hashclr(sha1);
 					return refname;
@@ -1526,20 +1521,17 @@ static const char *resolve_ref_1(const char *refname,
 			 */
 			if (get_sha1_hex(sb_contents->buf, sha1) ||
 			    (sb_contents->buf[40] != '\0' && !isspace(sb_contents->buf[40]))) {
-				if (flags)
-					*flags |= REF_ISBROKEN;
+				*flags |= REF_ISBROKEN;
 				errno = EINVAL;
 				return NULL;
 			}
 			if (bad_name) {
 				hashclr(sha1);
-				if (flags)
-					*flags |= REF_ISBROKEN;
+				*flags |= REF_ISBROKEN;
 			}
 			return refname;
 		}
-		if (flags)
-			*flags |= REF_ISSYMREF;
+		*flags |= REF_ISSYMREF;
 		buf = sb_contents->buf + 4;
 		while (isspace(*buf))
 			buf++;
@@ -1551,8 +1543,7 @@ static const char *resolve_ref_1(const char *refname,
 			return refname;
 		}
 		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
-			if (flags)
-				*flags |= REF_ISBROKEN;
+			*flags |= REF_ISBROKEN;
 
 			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 			    !refname_is_safe(buf)) {
@@ -1573,8 +1564,12 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 	static struct strbuf sb_refname = STRBUF_INIT;
 	struct strbuf sb_contents = STRBUF_INIT;
 	struct strbuf sb_path = STRBUF_INIT;
+	int unused_flags;
 	const char *ret;
 
+	if (!flags)
+		flags = &unused_flags;
+
 	ret = resolve_ref_1(refname, resolve_flags, sha1, flags,
 			    &sb_refname, &sb_path, &sb_contents);
 	strbuf_release(&sb_path);
-- 
2.4.2.767.g62658d5-twtrsrc
