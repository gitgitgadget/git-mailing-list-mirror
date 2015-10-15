From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 20/26] refs.c: move copy_msg to the common code
Date: Thu, 15 Oct 2015 15:46:44 -0400
Message-ID: <1444938410-2345-21-git-send-email-dturner@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 15 21:48:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmoVK-0007IP-TK
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbbJOTrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:47:51 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:33679 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967AbbJOTra (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:47:30 -0400
Received: by qgeo38 with SMTP id o38so36981780qge.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XLISSIIZTKQpuGoL0CMHgW8XVXCQy0KhOyCtymXA9bI=;
        b=T0Le1CICMvhRlJSSYyZE9vBVCy+r/166bgiFyL0VSoJtkeEqOBmV9x9bb8KbWcZCzk
         kL1Pj2Or6nFz+0dNOdZOZaqbbpYu1+drh24PstqWQlcwi9wjdbIkuMPbtj22+A5ezoia
         3GSCwuejR+bMB4NMdZAShVXnjZYMA/V6EtIIhlW8De0xDdf2+OmBCPTj/wOzB2Twz3ua
         T+/C5tqfdOIe258dqTgabBn7K6AtXlmFX9M83EmvLK655W0kN8VbG7/G3KZZd9hUhMnT
         ceemzwFMXAdLHAjit12weV+dB4VfGlNvPRs5ouT/GwxdkUqWRV3WKuclEWP734aeoakY
         RFyA==
X-Gm-Message-State: ALoCoQmmTlB94UWPGuaV+aK36enMewNzI0bYs1nHxWRh2odBXBF7cDqTBjJxLIxEGkRUipZQwymA
X-Received: by 10.140.144.8 with SMTP id 8mr14614208qhq.54.1444938449265;
        Thu, 15 Oct 2015 12:47:29 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p193sm6054142qha.29.2015.10.15.12.47.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2015 12:47:28 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279695>

Rename copy_msg to copy_reflog_msg and make it public.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs-be-files.c | 28 +---------------------------
 refs.c          | 21 +++++++++++++++++++++
 refs.h          |  7 +++++++
 3 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 8d966f1..4b6bf29 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2654,32 +2654,6 @@ static int commit_ref(struct ref_lock *lock)
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
@@ -2774,7 +2748,7 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 			sha1_to_hex(new_sha1),
 			committer);
 	if (msglen)
-		len += copy_msg(logrec + len - 1, msg) - 1;
+		len += copy_reflog_msg(logrec + len - 1, msg) - 1;
 
 	written = len <= maxlen ? write_in_full(fd, logrec, len) : -1;
 	free(logrec);
diff --git a/refs.c b/refs.c
index 3eb3a28..16280d5 100644
--- a/refs.c
+++ b/refs.c
@@ -828,6 +828,27 @@ int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *c
 	return for_each_ref_in_submodule(submodule, "refs/remotes/", fn, cb_data);
 }
 
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
index be94e18..fc0611d 100644
--- a/refs.h
+++ b/refs.h
@@ -576,6 +576,13 @@ enum ref_type {
 
 enum ref_type ref_type(const char *refname);
 
+/*
+ * Copy the reflog message msg to buf, which has been allocated sufficiently
+ * large, while cleaning up the whitespaces.  Especially, convert LF to space,
+ * because reflog file is one line per entry.
+ */
+int copy_reflog_msg(char *buf, const char *msg);
+
 enum expire_reflog_flags {
 	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
 	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
-- 
2.4.2.644.g97b850b-twtrsrc
