From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 24/44] refs.c: move refname_is_safe to the common code
Date: Mon, 12 Oct 2015 17:51:45 -0400
Message-ID: <1444686725-27660-26-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:52:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll1T-0004bL-4Q
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbbJLVwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:52:42 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33014 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275AbbJLVwk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:40 -0400
Received: by qgeb31 with SMTP id b31so28260675qge.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xqle2mQ4r+v1rNi4JVlImUsBF9LJ5/jglCJPqTKtWOc=;
        b=VT1Q+VF2TjBS2p2RXDTMzFHWcFgLJKBu6NFwnMR3/UTdFHwsdejMXi7OvK+rHzaTKi
         A58rDx4dp478sktLLIm5UiicSpygHBwhAfFuumrl4+3Eo6CmnKj0arPnI4bfzMefKc3R
         03V7cDRYw84qkN3qPB2YXCa0946mbAtn5mQUId+dqTRKpgw7kNHNeJjipl6mNn3NuRT5
         eSaOYEJsihvS47V3WH5jf0pG6zWZt5MSHnvleu61/xX04UhDENZzVS0iLmuriDP0vRP4
         49I4wkz/TaCXrU49wbiIxQSVVP/gQtQojvJlTNDgG6MlLLqF92Kd/L3qOpv4ELPxvEP4
         DOQA==
X-Gm-Message-State: ALoCoQlBmYeZY0OI8jbJQjK7fgNAshGwsx3Pd06EBoVWcMKHOQy3wcjeIMfNOt4Vr/I9D+6edS16
X-Received: by 10.140.202.195 with SMTP id x186mr36782589qha.71.1444686759977;
        Mon, 12 Oct 2015 14:52:39 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:39 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279431>

This function does not contain any backend specific code so we
move it to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 33 ---------------------------------
 refs.c          | 24 ++++++++++++++++++++++++
 refs.h          |  2 ++
 3 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 9548fb3..346429e 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -196,39 +196,6 @@ static struct ref_dir *get_ref_dir(struct ref_entry *entry)
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
index e627d74..2515f6e 100644
--- a/refs.c
+++ b/refs.c
@@ -1009,6 +1009,30 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 				      flags, NULL, err);
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
+
 /* backend functions */
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
diff --git a/refs.h b/refs.h
index e2ba725..fc8a748 100644
--- a/refs.h
+++ b/refs.h
@@ -415,6 +415,8 @@ extern int for_each_reflog(each_ref_fn, void *);
  */
 extern int check_refname_format(const char *refname, int flags);
 
+extern int refname_is_safe(const char *refname);
+
 extern const char *prettify_refname(const char *refname);
 
 extern char *shorten_unambiguous_ref(const char *refname, int strict);
-- 
2.4.2.644.g97b850b-twtrsrc
