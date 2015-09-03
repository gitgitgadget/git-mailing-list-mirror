From: David Turner <dturner@twopensource.com>
Subject: [PATCH 11/43] refs.c: move read_ref, read_ref_full and ref_exists to the common code
Date: Wed,  2 Sep 2015 21:54:41 -0400
Message-ID: <1441245313-11907-12-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twitter.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:58:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJmu-0007YP-3s
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbbICB56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:57:58 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33226 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756284AbbICBzh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:55:37 -0400
Received: by qkdv1 with SMTP id v1so15671022qkd.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=81vxG3rizptA84G7kpJzzp5/MUTDBLEBSKwHgA6FtE0=;
        b=V4g9D7T+DLpNo3nwqP1DXnp6q0xwch75V5xPBrgzBJByRkBLnxLlMdL+XHO9IeN1iA
         2y5sMux3CHQJ/pOZ9G80s3ERCnPVvgB08PHwd8l7k29+60kEdBgWISlOF29RXprgFlmP
         UbX8WVzlJyGo16+1p3Mq9AGmDz3d4s7J+MNbHwN3oo+iZMCFX+cPtX86FvWtUpj+oiA9
         aBXAJYlFvR7IrkZcXFPLzwvjcBa4Zdsi0IMD8/Y5aJF8kPGCr/pSNw2KXnbFPD5V3/Ht
         YkwRx/Zi/N4245aKNsThr1fUf7otwx+A4d3KGkZkEgIFfKiya04RGyjt/BYef1sBLeiu
         iBLg==
X-Gm-Message-State: ALoCoQkoNzTC9MQX9UXsJJqWY8aUIeXeWDzn8UPiN2DnvO0MnpqlkuqGgtEvgE5k7yb/ryuelMkg
X-Received: by 10.55.25.220 with SMTP id 89mr33505457qkz.40.1441245337072;
        Wed, 02 Sep 2015 18:55:37 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.55.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:55:36 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277178>

From: Ronnie Sahlberg <sahlberg@google.com>

These functions do not depend on the backend implementation so we
move them to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twitter.com>
---
 refs-be-files.c | 18 ------------------
 refs.c          | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 9c0dd5c..f67ff41 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1800,24 +1800,6 @@ struct ref_filter {
 	void *cb_data;
 };
 
-int read_ref_full(const char *refname, int resolve_flags, unsigned char *sha1, int *flags)
-{
-	if (resolve_ref_unsafe(refname, resolve_flags, sha1, flags))
-		return 0;
-	return -1;
-}
-
-int read_ref(const char *refname, unsigned char *sha1)
-{
-	return read_ref_full(refname, RESOLVE_REF_READING, sha1, NULL);
-}
-
-int ref_exists(const char *refname)
-{
-	unsigned char sha1[20];
-	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, sha1, NULL);
-}
-
 static int filter_refs(const char *refname, const struct object_id *oid,
 			   int flags, void *data)
 {
diff --git a/refs.c b/refs.c
index 24d5e28..242f66d 100644
--- a/refs.c
+++ b/refs.c
@@ -633,3 +633,21 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_li
 	data.msg_fmt = msg_fmt;
 	for_each_rawref(warn_if_dangling_symref, &data);
 }
+
+int read_ref_full(const char *refname, int resolve_flags, unsigned char *sha1, int *flags)
+{
+	if (resolve_ref_unsafe(refname, resolve_flags, sha1, flags))
+		return 0;
+	return -1;
+}
+
+int read_ref(const char *refname, unsigned char *sha1)
+{
+	return read_ref_full(refname, RESOLVE_REF_READING, sha1, NULL);
+}
+
+int ref_exists(const char *refname)
+{
+	unsigned char sha1[20];
+	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, sha1, NULL);
+}
-- 
2.0.4.315.gad8727a-twtrsrc
