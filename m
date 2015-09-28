From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 11/43] refs.c: move read_ref, read_ref_full and ref_exists to the common code
Date: Mon, 28 Sep 2015 18:01:46 -0400
Message-ID: <1443477738-32023-12-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:04:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggXX-0002gh-0D
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbbI1WDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:03:11 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:35837 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032AbbI1WDI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:08 -0400
Received: by qgt47 with SMTP id 47so133554779qgt.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FFF1h6sFuYgiEDhw7qUbcR4C9dsueojDFTApDxJJti4=;
        b=azOk6McGrHw+M6hl9E/dz0edmkiRQW9mycADHIET0B0rET9zf5rwj4c0Obizws2XXj
         JmwWBRcoS8LQ3T0h0kx88B2JC3ZU/ijr0Z/CzBOT/lMXikU9kdf9dgU+nTDuTTbUEZ8E
         LXXu4wVMUFy4JEhu0WN+GwhW3+xZ9gDcGOElGgZZ9y12XS3PJ7XQtVfpxqJoNNU+CaHK
         7whQhjkkzYh1lC+UMbc8ICVFcV7o4cfzFfKywpCiA7X9ErmdsZ4M2Ox32AYr5L/1jnLh
         eWtnZlpFz4B/nw321k92940E205SVcZCumjj69G2bUwt6ls0OjKcI6O+uzXzll2O3yzc
         3r9w==
X-Gm-Message-State: ALoCoQmO858tM7nBC//kElJe/GJI7XnUUZzvs9i664QiRmfd8mpBDtiOpgQfzXDvhb5KfueONBoS
X-Received: by 10.140.29.164 with SMTP id b33mr25675397qgb.37.1443477787651;
        Mon, 28 Sep 2015 15:03:07 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:06 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278790>

From: Ronnie Sahlberg <sahlberg@google.com>

These functions do not depend on the backend implementation so we
move them to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 18 ------------------
 refs.c          | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 2495d42..d46474a 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1803,24 +1803,6 @@ struct ref_filter {
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
2.4.2.644.g97b850b-twtrsrc
