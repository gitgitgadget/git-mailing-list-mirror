From: David Turner <dturner@twopensource.com>
Subject: [PATCH 25/43] refs.c: move copy_msg to the common code
Date: Wed,  2 Sep 2015 21:54:55 -0400
Message-ID: <1441245313-11907-26-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:56:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJl7-0006Q5-TW
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbbICB4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:56:08 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34777 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932323AbbICB4B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:56:01 -0400
Received: by qkfq186 with SMTP id q186so15073933qkf.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MkflDBJGUEENjnJ9htfp/eSYIzl9GEasEu8KV9YTkpQ=;
        b=gQ0tajThpAPY7HCtLpe32KBkGPzoekOpjkA4bYxUOLcRWSRj8t0fI2vkX8JR9QS6zx
         MfNhv2JgHQ4e51+sEaxdm7o1ib6/wA4Wf9jsX82wns9ebqpYY8r+1PDVEMUlQZFferVX
         iumrWQkuz322OcF41Pij+lowk1PyJC7GjFaTNCK9hPgDjLgKNcZazu3qDQ2a+iw/Z6hN
         +uoRwph+5e53IHB508vG4oVGSf58fknlBmCuuh/I00gqC51BXo+KvSKBMUp8ClP/kNW/
         mlfgb87DLSd+DltpektR7CiouuDKiz/9T+8sANuSEfvfCrqCF6MrHWynlQP7K4EN7P5l
         bWUA==
X-Gm-Message-State: ALoCoQn4yqhNAai6+FJXcTaZQhhs3fSRcS+TgdaU0FPP7dLkLGaa+claEtun4KvHdfUk6xr3SezU
X-Received: by 10.55.23.219 with SMTP id 88mr34074483qkx.19.1441245360274;
        Wed, 02 Sep 2015 18:56:00 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.55.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:55:59 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277150>

Rename copy_msg to copy_reflog_msg and make it public.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 28 +---------------------------
 refs.c          | 26 ++++++++++++++++++++++++++
 refs.h          |  2 ++
 3 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 9e0e51c..bb208a5 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2669,32 +2669,6 @@ static int commit_ref(struct ref_lock *lock)
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
@@ -2791,7 +2765,7 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 		      sha1_to_hex(new_sha1),
 		      committer);
 	if (msglen)
-		len += copy_msg(logrec + len - 1, msg) - 1;
+		len += copy_reflog_msg(logrec + len - 1, msg) - 1;
 
 	written = len <= maxlen ? write_in_full(fd, logrec, len) : -1;
 	free(logrec);
diff --git a/refs.c b/refs.c
index 5267b2b..fdd1b50 100644
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
index 359e166..049f2c7 100644
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
2.0.4.315.gad8727a-twtrsrc
