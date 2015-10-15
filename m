From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 19/26] refs.c: move refname_is_safe to the common code
Date: Thu, 15 Oct 2015 15:46:43 -0400
Message-ID: <1444938410-2345-20-git-send-email-dturner@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 15 21:47:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmoUx-0006tn-9G
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020AbbJOTrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:47:31 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36172 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978AbbJOTr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:47:28 -0400
Received: by qgx61 with SMTP id 61so80925965qgx.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O8phQVOsXsX/g4OHoT6S2pGigVWW4PN52UbC6kq2pq0=;
        b=bFiS4Ro0XGw6xVJs4DT7aH/2LZ7wM1U7ih7rTKnUhBjNq5749p4yk5TDdaWPYRTFOK
         dZw6A/CM77o9BpP23n0FPzmvBVl5SFl/uKJbPbscnWCA2X2e7oYD370lQeqAFXPy+Alr
         KzvyuZtTM5UnufVbvLJQTEXegzWB1smQO6vdC777duarEJYa1GI3uJtMob+/zGw5yhWh
         +6KVUAV6KQnv1/yOMxC/QGmZxcC1tG0scIEOqb84cJz1xqFIetDXcm13p+ksD7mn10y8
         90ZgpBygllQ/z//3absHT5l3uiWKrm9wHHnSc5R17dqldHnXNwmHAseeNZoEXutTg8eK
         FeCw==
X-Gm-Message-State: ALoCoQlFMAMBA94Ljyub+cqw7urSEjDdK7tITPd9+HoGxUPkddpMZdIr+3kvLebsnwllN9gHajn2
X-Received: by 10.140.29.164 with SMTP id b33mr14399035qgb.37.1444938447969;
        Thu, 15 Oct 2015 12:47:27 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p193sm6054142qha.29.2015.10.15.12.47.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2015 12:47:26 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279688>

This function does not contain any backend specific code so we move it
to the common code. This function might be used by other refs backends.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs-be-files.c | 33 ---------------------------------
 refs.c          | 24 ++++++++++++++++++++++++
 refs.h          | 11 +++++++++++
 3 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 73eb1e2..8d966f1 100644
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
index be08787..3eb3a28 100644
--- a/refs.c
+++ b/refs.c
@@ -950,3 +950,27 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 				      NULL, old_sha1,
 				      flags, NULL, err);
 }
+
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
diff --git a/refs.h b/refs.h
index 3d24c79..be94e18 100644
--- a/refs.h
+++ b/refs.h
@@ -396,6 +396,17 @@ extern int for_each_reflog(each_ref_fn, void *);
  */
 extern int check_refname_format(const char *refname, int flags);
 
+/*
+ * Check if a refname is safe.
+ * For refs that start with "refs/" we consider it safe as long they do
+ * not try to resolve to outside of refs/.
+ *
+ * For all other refs we only consider them safe iff they only contain
+ * upper case characters and '_' (like "HEAD" AND "MERGE_HEAD", and not like
+ * "config").
+ */
+extern int refname_is_safe(const char *refname);
+
 extern const char *prettify_refname(const char *refname);
 
 extern char *shorten_unambiguous_ref(const char *refname, int strict);
-- 
2.4.2.644.g97b850b-twtrsrc
