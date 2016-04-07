From: David Turner <dturner@twopensource.com>
Subject: [PATCH 08/24] resolve_missing_loose_ref(): simplify semantics
Date: Thu,  7 Apr 2016 15:02:55 -0400
Message-ID: <1460055791-23313-9-git-send-email-dturner@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:03:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFDM-00073u-NX
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbcDGTDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:03:34 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:33076 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215AbcDGTDb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:31 -0400
Received: by mail-qg0-f42.google.com with SMTP id j35so71757001qge.0
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=lf+nx+7wRxAZsrs8rBTIm4v0FBhuTztSlEwYP1H3I6A=;
        b=fbEByN28mjP359LjUjchqcDAubMVRPaWSRlCedPOPGU1ubOWiQAKxInwGH0LlprMxp
         MVKcFWhDb3ZH1wblMp5gq1cWYwCIFeZMdkBcnm4JmrjyfPZon7rUPJBiPHFkkRTjfK8y
         zfTqQmAKcX5IH40aRiiIQaELlm66ioaQdFQrdg5SzvFfIsqF88xJN+Nea0I7bOSgvvfr
         DFvv94QW2ChjlaQiRz9ixlveQQ7CrUmCggsZTHJK1rR0GBv0hghk+QNmgFoz4ss3Vm9k
         w74Wt1ExiRlM2A+sLsSOlcU/kHsYdhtuNaTBkhaTG9CC8Yfzzpa6IDftKB1loE/OpSvW
         D8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=lf+nx+7wRxAZsrs8rBTIm4v0FBhuTztSlEwYP1H3I6A=;
        b=SIY1SsWhQD0csT63wSXtY8XdXul9d4bTV9KaHAX5h8sj5/hcEJ6iFu0DDwLHTQCMuW
         9uddzH8QADhsPJTd5GcpRXCY+q/jslnevC6yPQi8Br18kB64S9prMWStDvK8hLSzez1y
         tXRt+INq2IFlpQ6/M2cRbRBRlVl8Kk4c0B23sOIRZRjgkVdIcWhflONMO1ehxkhohsSj
         vmJkJLPXJxB7BMfEcqeVEcYi2kMvARbApFXBJ5PCqGJ1EhXWr6S+/hwu5IwVghA9fBFE
         rT8nCR9ObUY8IrNlXkWFQJUstwVesDZKnttkzFIyLncG7eb7PeyoMuLb3+Had6y0QVkG
         oJrA==
X-Gm-Message-State: AD7BkJLWKXPPZTwdQZ70DQa7E1mbot5QXzSjxz/2dJurEB0T2qt4kFa/qzT2t7fO5db/Tw==
X-Received: by 10.140.176.23 with SMTP id w23mr6407451qhw.76.1460055809735;
        Thu, 07 Apr 2016 12:03:29 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:29 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290954>

From: Michael Haggerty <mhagger@alum.mit.edu>

Make resolve_missing_loose_ref() only responsible for looking up a
packed reference, without worrying about whether we want to read or
write the reference and without setting errno on failure. Move the other
logic to the caller.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9676ec2..c0cf6fd 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1368,11 +1368,9 @@ static struct ref_entry *get_packed_ref(const char *refname)
 }
 
 /*
- * A loose ref file doesn't exist; check for a packed ref.  The
- * options are forwarded from resolve_safe_unsafe().
+ * A loose ref file doesn't exist; check for a packed ref.
  */
 static int resolve_missing_loose_ref(const char *refname,
-				     int resolve_flags,
 				     unsigned char *sha1,
 				     int *flags)
 {
@@ -1389,14 +1387,8 @@ static int resolve_missing_loose_ref(const char *refname,
 			*flags |= REF_ISPACKED;
 		return 0;
 	}
-	/* The reference is not a packed reference, either. */
-	if (resolve_flags & RESOLVE_REF_READING) {
-		errno = ENOENT;
-		return -1;
-	} else {
-		hashclr(sha1);
-		return 0;
-	}
+	/* refname is not a packed reference. */
+	return -1;
 }
 
 /* This function needs to return a meaningful errno on failure */
@@ -1461,9 +1453,13 @@ static const char *resolve_ref_1(const char *refname,
 		if (lstat(path, &st) < 0) {
 			if (errno != ENOENT)
 				return NULL;
-			if (resolve_missing_loose_ref(refname, resolve_flags,
-						      sha1, flags))
-				return NULL;
+			if (resolve_missing_loose_ref(refname, sha1, flags)) {
+				if (resolve_flags & RESOLVE_REF_READING) {
+					errno = ENOENT;
+					return NULL;
+				}
+				hashclr(sha1);
+			}
 			if (bad_name) {
 				hashclr(sha1);
 				if (flags)
-- 
2.4.2.767.g62658d5-twtrsrc
