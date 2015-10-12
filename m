From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 37/44] refs: break out a ref conflict check
Date: Mon, 12 Oct 2015 17:51:58 -0400
Message-ID: <1444686725-27660-39-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:53:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll2A-0005Ke-Fs
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbbJLVxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:53:24 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34599 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579AbbJLVwy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:54 -0400
Received: by qgez77 with SMTP id z77so130224925qge.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eadZWXvGaCoCMggRdGZv6low+5M3M1hLNxtRhnMuwDg=;
        b=MOGx73Qn3TOtosvdLIpDu2rN07jxOvcx0N0beGMTUTDCtkzdzEulDVOd60H0sGFtsh
         a1XdWu5a/lq0kAzWWWsrld+r+c7OM8OVL3yagGXKLqSFzQI/pynVOZ/kfK3M/h+vugEB
         +V3IScaeRiRyC4RcXdhBnFK4F2jUiMJfF1DeUr0qmT+H+ICcY+eNnKZSvn6d4gXLuC0n
         KwfeSMY2K9ZWIt/eueIbECNWDIL4pyz02/qj49BNmg6Z02Pps/l9qlc3fuZkEyQaYIVI
         tiGNg7h/KMvfr0pH/Vs1Oj0Uv32XvHIWK8lZc2d5pPvOwyv0wyI+vAx/WxVLGj0uLxIb
         TSGA==
X-Gm-Message-State: ALoCoQlEb+SxGAsOqsnF+gRa73BueANJ0eajQE9cxLALo/FqgOFALIhWdWkT3OJ64kvQY4cvCMx8
X-Received: by 10.140.19.227 with SMTP id 90mr34668937qgh.51.1444686773817;
        Mon, 12 Oct 2015 14:52:53 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:53 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279442>

Create new function verify_no_descendants, to hold one of the ref
conflict checks used in verify_refname_available.  Multiple backends
will need this function, so it goes in the common code.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 33 ++++++++-------------------------
 refs.c          | 22 ++++++++++++++++++++++
 refs.h          |  7 +++++++
 3 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 8d1ffce..dd2c42e 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -730,6 +730,7 @@ static int verify_refname_available_dir(const char *refname,
 					struct strbuf *err)
 {
 	const char *slash;
+	const char *extra_refname;
 	int pos;
 	struct strbuf dirname = STRBUF_INIT;
 	int ret = -1;
@@ -835,33 +836,15 @@ static int verify_refname_available_dir(const char *refname,
 		}
 	}
 
-	if (extras) {
-		/*
-		 * Check for entries in extras that start with
-		 * "$refname/". We do that by looking for the place
-		 * where "$refname/" would be inserted in extras. If
-		 * there is an entry at that position that starts with
-		 * "$refname/" and is not in skip, then we have a
-		 * conflict.
-		 */
-		for (pos = string_list_find_insert_index(extras, dirname.buf, 0);
-		     pos < extras->nr; pos++) {
-			const char *extra_refname = extras->items[pos].string;
-
-			if (!starts_with(extra_refname, dirname.buf))
-				break;
-
-			if (!skip || !string_list_has_string(skip, extra_refname)) {
-				strbuf_addf(err, "cannot process '%s' and '%s' at the same time",
-					    refname, extra_refname);
-				goto cleanup;
-			}
-		}
+	extra_refname = find_descendant_ref(dirname.buf, extras, skip);
+	if (extra_refname) {
+		strbuf_addf(err,
+			    "cannot process '%s' and '%s' at the same time",
+			    refname, extra_refname);
+	} else {
+		ret = 0;
 	}
 
-	/* No conflicts were found */
-	ret = 0;
-
 cleanup:
 	strbuf_release(&dirname);
 	return ret;
diff --git a/refs.c b/refs.c
index 5a3125d..3ae0274 100644
--- a/refs.c
+++ b/refs.c
@@ -1101,6 +1101,28 @@ enum peel_status peel_object(const unsigned char *name, unsigned char *sha1)
 	return PEEL_PEELED;
 }
 
+const char *find_descendant_ref(const char *refname,
+				const struct string_list *extras,
+				const struct string_list *skip)
+{
+	int pos;
+	if (!extras)
+		return NULL;
+
+	/* Look for the place where "$refname/" would be inserted in extras. */
+	for (pos = string_list_find_insert_index(extras, refname, 0);
+	     pos < extras->nr; pos++) {
+		const char *extra_refname = extras->items[pos].string;
+
+		if (!starts_with(extra_refname, refname))
+			break;
+
+		if (!skip || !string_list_has_string(skip, extra_refname))
+			return extra_refname;
+	}
+	return NULL;
+}
+
 /* backend functions */
 int refs_initdb(struct strbuf *err, int shared)
 {
diff --git a/refs.h b/refs.h
index 3aad3b8..f8becea 100644
--- a/refs.h
+++ b/refs.h
@@ -637,6 +637,13 @@ int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
 			const unsigned char *new_sha1, const char *msg,
 			int flags, struct strbuf *err);
 
+/*
+ * Check for entries in extras that start with "$refname/", ignoring
+ * those in skip. If there is such an entry, then we have a conflict.
+ */
+const char *find_descendant_ref(const char *refname,
+				const struct string_list *extras,
+				const struct string_list *skip);
 
 enum expire_reflog_flags {
 	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
-- 
2.4.2.644.g97b850b-twtrsrc
