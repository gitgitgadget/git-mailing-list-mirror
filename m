From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 25/43] refs.c: move copy_msg to the common code
Date: Mon, 28 Sep 2015 18:02:00 -0400
Message-ID: <1443477738-32023-26-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:03:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggWD-0000zo-5K
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448AbbI1WDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:03:24 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34073 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233AbbI1WDW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:22 -0400
Received: by qgez77 with SMTP id z77so134282869qge.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6fhiUAfEOxSKMlLgn3/bcB6TBxf49ti7TujOukA9c8Y=;
        b=H8rRzQD+pfw86Egk0BAs73tT/8KhIT+PNNJLLC2s+IXU3AyiIJVF+ajoscV2kZsHj7
         3Kfz7QLQ4ACvjjErKb222Zz8qgjrlfvcmglIJX+GiODzEZXjKu7lRz7xJ7xsvVMbYCs2
         coyP+3as4ocjVMUiI5+Ky7kROF8PBYxX4Hbg7r2w00l6XI83vS8uHp4+dnA2CdYRm8SN
         z+kVdmB6V5ynXe+KkJFLnuO8qZI7ReBNOUaqZWa/9IfX3l1CworljUAP1KgYs9Ihqwmy
         0YcLeTBEfAPOIG3yaNEIagVQCbNEtiPWSXtqcPY/PFi9koUEpqXAqk5wH0zRWLmQUppg
         OnRg==
X-Gm-Message-State: ALoCoQlj9i0mFz8b/ZpFokRbwIMQZcpmhQLY18f1kGYdWU8cR/vwaHSkpVoyiZ5lnCIltz4GBTxx
X-Received: by 10.140.237.212 with SMTP id i203mr26655873qhc.97.1443477802149;
        Mon, 28 Sep 2015 15:03:22 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:21 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278764>

Rename copy_msg to copy_reflog_msg and make it public.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 28 +---------------------------
 refs.c          | 26 ++++++++++++++++++++++++++
 refs.h          |  2 ++
 3 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index bb5a3ad..8898e86 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2684,32 +2684,6 @@ static int commit_ref(struct ref_lock *lock)
 	return 0;
 }
 
-/*
- * copy the reflog message msg to buf, which has been allocated sufficiently
- * large, while cleaning up the whitespaces.  Especially, convert LF to space,
- * because reflog file is one line per entry.
- */
-static int copy_msg(char *buf, const char *msg)
-{
-	char *cp = buf;
-	char c;
-	int wasspace = 1;
-
-	*cp++ = '\t';
-	while ((c = *msg++)) {
-		if (wasspace && isspace(c))
-			continue;
-		wasspace = isspace(c);
-		if (wasspace)
-			c = ' ';
-		*cp++ = c;
-	}
-	while (buf < cp && isspace(cp[-1]))
-		cp--;
-	*cp++ = '\n';
-	return cp - buf;
-}
-
 static int should_autocreate_reflog(const char *refname)
 {
 	if (!log_all_ref_updates)
@@ -2806,7 +2780,7 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 			sha1_to_hex(new_sha1),
 			committer);
 	if (msglen)
-		len += copy_msg(logrec + len - 1, msg) - 1;
+		len += copy_reflog_msg(logrec + len - 1, msg) - 1;
 
 	written = len <= maxlen ? write_in_full(fd, logrec, len) : -1;
 	free(logrec);
diff --git a/refs.c b/refs.c
index aa49db5..db650b6 100644
--- a/refs.c
+++ b/refs.c
@@ -886,6 +886,32 @@ int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *c
 	return for_each_ref_in_submodule(submodule, "refs/remotes/", fn, cb_data);
 }
 
+/*
+ * copy the reflog message msg to buf, which has been allocated sufficiently
+ * large, while cleaning up the whitespaces.  Especially, convert LF to space,
+ * because reflog file is one line per entry.
+ */
+int copy_reflog_msg(char *buf, const char *msg)
+{
+	char *cp = buf;
+	char c;
+	int wasspace = 1;
+
+	*cp++ = '\t';
+	while ((c = *msg++)) {
+		if (wasspace && isspace(c))
+			continue;
+		wasspace = isspace(c);
+		if (wasspace)
+			c = ' ';
+		*cp++ = c;
+	}
+	while (buf < cp && isspace(cp[-1]))
+		cp--;
+	*cp++ = '\n';
+	return cp - buf;
+}
+
 int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/refs.h b/refs.h
index db60bfe..c224f0e 100644
--- a/refs.h
+++ b/refs.h
@@ -508,6 +508,8 @@ enum ref_type {
 
 enum ref_type ref_type(const char *refname);
 
+int copy_reflog_msg(char *buf, const char *msg);
+
 enum expire_reflog_flags {
 	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
 	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
-- 
2.4.2.644.g97b850b-twtrsrc
