From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 11/26] refs.c: move read_ref, read_ref_full and ref_exists to the common code
Date: Thu, 15 Oct 2015 15:46:35 -0400
Message-ID: <1444938410-2345-12-git-send-email-dturner@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 15 21:48:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmoVX-0007WP-40
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbbJOTsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:48:05 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36011 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbbJOTrT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:47:19 -0400
Received: by qgx61 with SMTP id 61so80922015qgx.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e8XuoRkb41v4t1wjioKgz3R1qyirq6DnlymNDb6z1dY=;
        b=chwgFjphATB5Znh3e2/RySbj5FalK9TdzGkx+rsaFnmy93svcrOg22NqzsavVvQT4Y
         AVgGcA4L3x7JgUjJ5vjd+rd+GPyn1PIrYPgoeA8Y5w87C+olraqKj8/E566HD6bvfLgM
         RcHCeeMlOMS8/WqldkR3BEUMjDOhNy/KMz0uPj7x8q2qr73ZiarRYueURQdI/X1pc5xz
         RUf9Nhz7idPwO/jNok9gG/XzXrm4xtzPzqUppFYwhlyGuggQSu0gTEPrjuvvEzfjvq8p
         e2Az6zKRH/eqkg6P+zEQjle6zNdTAI9Ul7FKtWwkHfo/KhbkO/+4JegO01tngVFIK8cM
         U95w==
X-Gm-Message-State: ALoCoQl3mTZMGE1BfwdWe/Zs2YnBtrYk+0SjrQVXS9Lo+nmTZ2Wb4fCTrYamHlTy8QeQ47LBjBw6
X-Received: by 10.140.128.81 with SMTP id 78mr15481668qha.62.1444938438392;
        Thu, 15 Oct 2015 12:47:18 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p193sm6054142qha.29.2015.10.15.12.47.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2015 12:47:17 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279702>

From: Ronnie Sahlberg <sahlberg@google.com>

These functions do not depend on the backend implementation so we
move them to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs-be-files.c | 18 ------------------
 refs.c          | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 9c53f54..728751a 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1791,24 +1791,6 @@ struct ref_filter {
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
index fab7603..8a619a6 100644
--- a/refs.c
+++ b/refs.c
@@ -598,3 +598,21 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_li
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
