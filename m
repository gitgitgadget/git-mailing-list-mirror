From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 26/44] refs.c: move copy_msg to the common code
Date: Mon, 12 Oct 2015 17:51:47 -0400
Message-ID: <1444686725-27660-28-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:53:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll2Q-0005aW-UB
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbbJLVwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:52:45 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:33038 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbbJLVwn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:43 -0400
Received: by qgeb31 with SMTP id b31so28261311qge.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qwPaqbwz+5AkGjyfSXpHiq663C9FeILdLHDqHBcz5hE=;
        b=ihRf3mJz9JFCbt71dLCEHj99CmfaCN3vFLVCU73RgRwA67o3q/h3PklMu6jdM4fM9+
         i4CTyJD8WkCTboTkFpGXa3rwmB0AjVSoQukNbNIe7TBGvmxFaQAPTGpjfUL9P1FDkV90
         My7IpsyeJUO2LXconI5mezrVVfiWA6Iyc7OLrpz3SMem7Bd6JpE8A3e03q3MjVSoH0fZ
         ZvTiVwWjO2xuDOC99iRVuUiaLnN3WI+v/k7qvTY4X1xMYHBTBtViwfNFhvKRoWf2zYkM
         00f7UemvM6zTBcTyOxPzscfAotet2xjQ6xI/LiJitUEP9sR5vO36PBsAwOtceYzUm8Ar
         kp7w==
X-Gm-Message-State: ALoCoQmdlrzgtDMJDcYfUXuTy+I3WgIj1QSUckOPoWxh8JxV8Ee1fE7dcu/KReX4CjgzQ5dQu9QE
X-Received: by 10.140.217.70 with SMTP id n67mr37114793qhb.96.1444686762422;
        Mon, 12 Oct 2015 14:52:42 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:41 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279448>

Rename copy_msg to copy_reflog_msg and make it public.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 28 +---------------------------
 refs.c          | 26 ++++++++++++++++++++++++++
 refs.h          |  2 ++
 3 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 346429e..830b5a1 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2637,32 +2637,6 @@ static int commit_ref(struct ref_lock *lock)
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
@@ -2765,7 +2739,7 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 			sha1_to_hex(new_sha1),
 			committer);
 	if (msglen)
-		len += copy_msg(logrec + len - 1, msg) - 1;
+		len += copy_reflog_msg(logrec + len - 1, msg) - 1;
 
 	written = len <= maxlen ? write_in_full(fd, logrec, len) : -1;
 	free(logrec);
diff --git a/refs.c b/refs.c
index 2515f6e..bd8c71b 100644
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
index 7a936e2..3da5d09 100644
--- a/refs.h
+++ b/refs.h
@@ -597,6 +597,8 @@ enum ref_type {
 
 enum ref_type ref_type(const char *refname);
 
+int copy_reflog_msg(char *buf, const char *msg);
+
 enum expire_reflog_flags {
 	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
 	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
-- 
2.4.2.644.g97b850b-twtrsrc
