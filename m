From: David Turner <dturner@twopensource.com>
Subject: [PATCH 39/43] refs: break out a ref conflict check
Date: Wed,  2 Sep 2015 21:55:09 -0400
Message-ID: <1441245313-11907-40-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:56:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJlT-0006eR-Ba
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbbICB42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:56:28 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:36343 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932400AbbICB4X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:56:23 -0400
Received: by qgx61 with SMTP id 61so18644337qgx.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OnCEwwugx0ajAad1V7IJEHDfKUEyxOApNWjDQBDgQLM=;
        b=PvD2oEsjw6ukFdIIfZHmdtDyq+xCo5lR3PYofKJfJ+NMOmElgO4t7bTQWqDy0ZxdWt
         XrvU+uhMw/CnG8v+ryo+DC2zKRYwv8K28ZsuMZ1C8ZuFrelisP5SisGvyBpLKa8RmHlL
         gsL1mVInAZqmnPNTLsSG5f/rUSLEzLEHOeGTs9NbHbFj0xfQj8zlhVSz+73f/xgDU4Jx
         4/LwePwsvAZmCiuo0wBB5zSOmDkPZSTG9mnaWM5HLBtkvCod4RrOXEKkri5wmxwacjCB
         kJd9/PyFu87j0sl8hpreWvfTBa+OgAlnxmMuAa8Qk8BhUTAhSdHr/tGpXExhJ7Cy0ark
         c4Fw==
X-Gm-Message-State: ALoCoQn/OKYOxzGReBuTEg7ssewdDukVD9RxzTMfIMbBBpbTExGEYccmUpXTLhZ//3Ycqqb9B3GE
X-Received: by 10.140.237.140 with SMTP id i134mr65325003qhc.81.1441245382443;
        Wed, 02 Sep 2015 18:56:22 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.56.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:56:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277156>

Create new function verify_no_descendants, to hold one of the ref
conflict checks used in verify_refname_available.  Multiple backends
will need this function, so it goes in the common code.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 33 ++++++++-------------------------
 refs.c          | 29 +++++++++++++++++++++++++++++
 refs.h          |  4 ++++
 3 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 7c9473f..72952f5 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -753,6 +753,7 @@ static int verify_refname_available_dir(const char *refname,
 					struct strbuf *err)
 {
 	const char *slash;
+	const char *extra_refname;
 	int pos;
 	struct strbuf dirname = STRBUF_INIT;
 	int ret = -1;
@@ -858,33 +859,15 @@ static int verify_refname_available_dir(const char *refname,
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
index ae394fa..3f8fa8e 100644
--- a/refs.c
+++ b/refs.c
@@ -994,6 +994,35 @@ enum peel_status peel_object(const unsigned char *name, unsigned char *sha1)
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
+	/*
+	 * Check for entries in extras that start with "$refname/". We
+	 * do that by looking for the place where "$refname/" would be
+	 * inserted in extras. If there is an entry at that position
+	 * that starts with "$refname/" and is not in skip, then we
+	 * have a conflict.
+	 */
+	for (pos = string_list_find_insert_index(extras, refname, 0);
+	     pos < extras->nr; pos++) {
+		const char *extra_refname = extras->items[pos].string;
+
+		if (!starts_with(extra_refname, refname))
+			break;
+
+		if (!skip || !string_list_has_string(skip, extra_refname)) {
+			return extra_refname;
+		}
+	}
+	return NULL;
+}
+
 /* backend functions */
 int refs_initdb(struct strbuf *err, int shared)
 {
diff --git a/refs.h b/refs.h
index 91d30b5..fe7c249 100644
--- a/refs.h
+++ b/refs.h
@@ -570,6 +570,10 @@ enum ref_type ref_type(const char *refname);
 
 int copy_reflog_msg(char *buf, const char *msg);
 
+const char *find_descendant_ref(const char *refname,
+				const struct string_list *extras,
+				const struct string_list *skip);
+
 int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
 			const unsigned char *new_sha1, const char *msg,
 			int flags, struct strbuf *err);
-- 
2.0.4.315.gad8727a-twtrsrc
