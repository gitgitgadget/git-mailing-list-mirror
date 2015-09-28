From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 23/43] refs.c: move refname_is_safe to the common code
Date: Mon, 28 Sep 2015 18:01:58 -0400
Message-ID: <1443477738-32023-24-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:04:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggXE-0002Ea-Mu
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754904AbbI1WEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:04:33 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:36018 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341AbbI1WDV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:21 -0400
Received: by qgx61 with SMTP id 61so133698210qgx.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GJhH71ixrYT0OYNDxqj2nP13SzM2SDlcnP5a3OfXVVo=;
        b=kbsFNPLoK1axFfyQAKEGBGz4E/AoXmNMC4qi53GBJLbzb5JYHo3qDLhiHtsgr1fDvx
         VLmir4nb+e+JtUPXu2sZm3Vimi+UzqnNh7DMeww8YQHlrltT5+DClkt6RfiNrRgrG+EC
         jHrDAASMup7U7WHayT1DT/Y4HIMTPnmy9PrdOt+yGGXm3YnGOkdt56Yb0X/fO/83POJX
         opWCIbvyxwn3+iku3/fka54DIW6qxH8lJFSTg6osOpiWybaOT+Iz3zccwee1EJraYQFJ
         z/GNl8Ed8yz9jf6DzIxrITgdQiMtOWQFZ39vMrVciSiZtsbgT+r3uiM4Fq3BneLkGJ9U
         AgPg==
X-Gm-Message-State: ALoCoQkZ+BIMKi7O5oVq7tsgCM0YDdqMRCOe3Y4pSzQqUnFKXl9s0V1VE3L+bKXBlGpzb688xwKX
X-Received: by 10.140.236.203 with SMTP id h194mr25361036qhc.73.1443477800537;
        Mon, 28 Sep 2015 15:03:20 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:19 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278784>

This function does not contain any backend specific code so we
move it to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 33 ---------------------------------
 refs.c          | 23 +++++++++++++++++++++++
 refs.h          |  2 ++
 3 files changed, 25 insertions(+), 33 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index dc89289..bb5a3ad 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -231,39 +231,6 @@ static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 	return dir;
 }
 
-/*
- * Check if a refname is safe.
- * For refs that start with "refs/" we consider it safe as long they do
- * not try to resolve to outside of refs/.
- *
- * For all other refs we only consider them safe iff they only contain
- * upper case characters and '_' (like "HEAD" AND "MERGE_HEAD", and not like
- * "config").
- */
-static int refname_is_safe(const char *refname)
-{
-	if (starts_with(refname, "refs/")) {
-		char *buf;
-		int result;
-
-		buf = xmalloc(strlen(refname) + 1);
-		/*
-		 * Does the refname try to escape refs/?
-		 * For example: refs/foo/../bar is safe but refs/foo/../../bar
-		 * is not.
-		 */
-		result = !normalize_path_copy(buf, refname + strlen("refs/"));
-		free(buf);
-		return result;
-	}
-	while (*refname) {
-		if (!isupper(*refname) && *refname != '_')
-			return 0;
-		refname++;
-	}
-	return 1;
-}
-
 static struct ref_entry *create_ref_entry(const char *refname,
 					  const unsigned char *sha1, int flag,
 					  int check_name)
diff --git a/refs.c b/refs.c
index c6112ac..aa49db5 100644
--- a/refs.c
+++ b/refs.c
@@ -901,6 +901,29 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 	return ret;
 }
 
+int refname_is_safe(const char *refname)
+{
+	if (starts_with(refname, "refs/")) {
+		char *buf;
+		int result;
+
+		buf = xmalloc(strlen(refname) + 1);
+		/*
+		 * Does the refname try to escape refs/?
+		 * For example: refs/foo/../bar is safe but refs/foo/../../bar
+		 * is not.
+		 */
+		result = !normalize_path_copy(buf, refname + strlen("refs/"));
+		free(buf);
+		return result;
+	}
+	while (*refname) {
+		if (!isupper(*refname) && *refname != '_')
+			return 0;
+		refname++;
+	}
+	return 1;
+}
 
 /* backend functions */
 struct ref_transaction *ref_transaction_begin(struct strbuf *err)
diff --git a/refs.h b/refs.h
index 09d140d..2bafa55 100644
--- a/refs.h
+++ b/refs.h
@@ -326,6 +326,8 @@ extern int for_each_reflog(each_ref_fn, void *);
  */
 extern int check_refname_format(const char *refname, int flags);
 
+extern int refname_is_safe(const char *refname);
+
 extern const char *prettify_refname(const char *refname);
 
 extern char *shorten_unambiguous_ref(const char *refname, int strict);
-- 
2.4.2.644.g97b850b-twtrsrc
