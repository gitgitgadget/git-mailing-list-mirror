From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 28/44] refs.c: move should_autocreate_reflog to common code
Date: Mon, 12 Oct 2015 17:51:49 -0400
Message-ID: <1444686725-27660-30-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:53:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll2R-0005aW-HM
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681AbbJLVxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:53:43 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34056 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbbJLVwp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:45 -0400
Received: by qkdo1 with SMTP id o1so53972372qkd.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kj7W9u8nz9xOz7ezmryYs2mbaaQuDlmOFLA2zCCbsEw=;
        b=FD3amRVRjzuSj2X/weKGH455DQyfD6Az0KLoSeG4b+LIJMBRVcOSUinIFYCDRobFRh
         NVVnvwE/jFwnOYD1VvYYx3EaQVA6AgzFV3X7TZ5hf+3DIq1EqwFm52lbq1sgQ4I92R2X
         6RCsRemKeif0SvmS9BKML2SWF3D3NlrnJviB/AePy5S7BbLjgajMs8HCAwazzGAUz8x+
         6VcDVARQN7YL4x4zY4CEDjqyH15qemmvmrREug4TvypbT6pzV6kAdBheKN1Sp81l3gSt
         Q9kkqTr2p0KGAr9JhYDK/kgXjnGP53v8dNq3bf0QeK+B7FKYjS4nDTrRORiteZ6Zym3A
         tbnA==
X-Gm-Message-State: ALoCoQl+XkPA23cksRTS0ltWWoz3wOWoEUDS++YmqumkeUxrQNUQkoo44NNNEwlwyRPcNbn2qE8v
X-Received: by 10.55.214.80 with SMTP id t77mr34830491qki.101.1444686764633;
        Mon, 12 Oct 2015 14:52:44 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:43 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279451>

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 10 ----------
 refs.c          | 10 ++++++++++
 refs.h          |  2 ++
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index bf2fd7a..73111e7 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2584,16 +2584,6 @@ static int commit_ref(struct ref_lock *lock)
 	return 0;
 }
 
-static int should_autocreate_reflog(const char *refname)
-{
-	if (!log_all_ref_updates)
-		return 0;
-	return starts_with(refname, "refs/heads/") ||
-		starts_with(refname, "refs/remotes/") ||
-		starts_with(refname, "refs/notes/") ||
-		!strcmp(refname, "HEAD");
-}
-
 /*
  * Create a reflog for a ref.  If force_create = 0, the reflog will
  * only be created for certain refs (those for which
diff --git a/refs.c b/refs.c
index 99b31f6..1de8529 100644
--- a/refs.c
+++ b/refs.c
@@ -685,6 +685,16 @@ char *resolve_refdup(const char *refname, int resolve_flags,
 						  sha1, flags));
 }
 
+int should_autocreate_reflog(const char *refname)
+{
+	if (!log_all_ref_updates)
+		return 0;
+	return starts_with(refname, "refs/heads/") ||
+		starts_with(refname, "refs/remotes/") ||
+		starts_with(refname, "refs/notes/") ||
+		!strcmp(refname, "HEAD");
+}
+
 /*
  * How to handle various characters in refnames:
  * 0: An acceptable character for refs
diff --git a/refs.h b/refs.h
index 636f959..6d284f5 100644
--- a/refs.h
+++ b/refs.h
@@ -58,6 +58,8 @@ extern const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 extern char *resolve_refdup(const char *refname, int resolve_flags,
 			    unsigned char *sha1, int *flags);
 
+extern int should_autocreate_reflog(const char *refname);
+
 extern int read_ref_full(const char *refname, int resolve_flags,
 			 unsigned char *sha1, int *flags);
 extern int read_ref(const char *refname, unsigned char *sha1);
-- 
2.4.2.644.g97b850b-twtrsrc
