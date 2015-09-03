From: David Turner <dturner@twopensource.com>
Subject: [PATCH 23/43] refs.c: move refname_is_safe to the common code
Date: Wed,  2 Sep 2015 21:54:53 -0400
Message-ID: <1441245313-11907-24-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:56:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJl0-0006LL-CE
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbbICB4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:56:00 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:33628 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932354AbbICBz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:55:59 -0400
Received: by qgev79 with SMTP id v79so18597813qge.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h7NmQboc1t5cIaZ0AK5cj/K4KmCXVVmElVcQBYq4wo4=;
        b=LzApCrhq5wCTROTnYQKAEbht9AAhXQjx4r8/pw5muoRAWVHw+L1p5u4G/rgwygjHkB
         0khpcKD6fIV05/uyEtxgeNiXQ+hqUUHEzD7Wv5TdH2hmPk45pMhLvbJlVs+NY0FVKAc6
         wmYbjQGc/HxqyfPGgeIYIYIrFQmDNVjc4kjvby8dbbdRMB6ib3ah0IxA5dRvXlvrpH78
         BigI+4K638Mc8uKoeBU3oUT5KEAT+D8CIeHfrbQcwsscuHqIcwBGkZHUSl4w6AEB1Irf
         LNkW20wN3wXo3mZS0xA+ckDejapkl3NqpJ1gH9wA/3w+8B+Ir5uTrOlQmFFGsUcbcbz8
         K8VQ==
X-Gm-Message-State: ALoCoQkb78HUAi5CFq7P0M2idqPpRrufNJYlhdV9JEiMIT083iDqZ/l4OeSj6CMNRU5zOZhOhdXq
X-Received: by 10.140.16.43 with SMTP id 40mr2310077qga.64.1441245358522;
        Wed, 02 Sep 2015 18:55:58 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.55.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:55:57 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277147>

This function does not contain any backend specific code so we
move it to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twitter.cOM
---
 refs-be-files.c | 33 ---------------------------------
 refs.c          | 23 +++++++++++++++++++++++
 refs.h          |  2 ++
 3 files changed, 25 insertions(+), 33 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index ff9dd6f..9e0e51c 100644
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
index 082c540..5267b2b 100644
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
index 0c5c8e0..5542587 100644
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
2.0.4.315.gad8727a-twtrsrc
