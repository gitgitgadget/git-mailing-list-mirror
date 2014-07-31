From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v5 3/7] change `git_config()` return value to void
Date: Thu, 31 Jul 2014 02:44:13 -0700
Message-ID: <1406799857-28048-4-git-send-email-tanayabh@gmail.com>
References: <1406799857-28048-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 11:45:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCmvl-0004kP-UP
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 11:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbaGaJpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 05:45:47 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:42107 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265AbaGaJpr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 05:45:47 -0400
Received: by mail-pa0-f45.google.com with SMTP id eu11so3318699pac.32
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 02:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JFW2aTvxN3mqyJ2MCeNRmX1b2uezg4lZgej8HiXhT+I=;
        b=v0AuwJ+q0QNI5Q48FTAAbnQimmCfC95lubTlBvYvrS737ZDFsCbmzfQ/z5Vw5iPyK8
         Pt6HL2EN7oNsNtXcHeeZ0hGQ1e0O7HaMBaXLRO11QqK9EoeWT1y9B12lEDOQZSi8fEm+
         Qoqv0APs1qpjxQBwYE237eIrCC91xCeVc3T/CQDQxKnxiXR7wuQVcF8T8sVRTHk9Ung+
         yKtXkAwKuhegYKpvZTO5CkaYwAXtqMD2gqFVVotsvjKwoC0BxaM6PwipinBcByedeaJw
         wp1vzD3cWx5BN5meg+Cu8pG7L81WmTD59/MtOzzUxkHqrUd60NQvTELDBfQVsvPmwI3o
         p9Xg==
X-Received: by 10.70.90.237 with SMTP id bz13mr10889406pdb.110.1406799945374;
        Thu, 31 Jul 2014 02:45:45 -0700 (PDT)
Received: from localhost.localdomain ([106.201.156.106])
        by mx.google.com with ESMTPSA id zq5sm4933551pbb.37.2014.07.31.02.45.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 02:45:45 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406799857-28048-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254544>

Currently `git_config()` returns an integer signifying an error code.
During a previous rewrite of the function most of the code was shifted
to `git_config_with_options()`. `git_config_with_options()` normally
returns positive values if its `config_source` parameter is set as NULL,
as most errors are fatal, and non-fatal potential errors are guarded
by "if" statements that are entered only when no error is possible.

Still a negative value can be returned in case of race condition between
`access_or_die()` & `git_config_from_file()`. Also, all callers of
`git_config()` ignore the return value except for one case in branch.c.

Change `git_config()` return value to void and make it die if it receives
a negative return value from `git_config_with_options()`.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 branch.c |  5 +----
 cache.h  |  2 +-
 config.c | 16 ++++++++++++++--
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/branch.c b/branch.c
index 46e8aa8..735767d 100644
--- a/branch.c
+++ b/branch.c
@@ -161,10 +161,7 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
 	strbuf_addf(&name, "branch.%s.description", branch_name);
 	cb.config_name = name.buf;
 	cb.value = NULL;
-	if (git_config(read_branch_desc_cb, &cb) < 0) {
-		strbuf_release(&name);
-		return -1;
-	}
+	git_config(read_branch_desc_cb, &cb);
 	if (cb.value)
 		strbuf_addstr(buf, cb.value);
 	strbuf_release(&name);
diff --git a/cache.h b/cache.h
index 7292aef..c61919d 100644
--- a/cache.h
+++ b/cache.h
@@ -1294,7 +1294,7 @@ extern int git_config_from_buf(config_fn_t fn, const char *name,
 			       const char *buf, size_t len, void *data);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
-extern int git_config(config_fn_t fn, void *);
+extern void git_config(config_fn_t fn, void *);
 extern int git_config_with_options(config_fn_t fn, void *,
 				   struct git_config_source *config_source,
 				   int respect_includes);
diff --git a/config.c b/config.c
index 4a15383..c0faaca 100644
--- a/config.c
+++ b/config.c
@@ -1235,9 +1235,21 @@ struct key_value_info {
 	int linenr;
 };
 
-int git_config(config_fn_t fn, void *data)
+void git_config(config_fn_t fn, void *data)
 {
-	return git_config_with_options(fn, data, NULL, 1);
+	if (git_config_with_options(fn, data, NULL, 1) < 0)
+		/*
+		 * git_config_with_options() normally returns only
+		 * positive values, as most errors are fatal, and
+		 * non-fatal potential errors are guarded by "if"
+		 * statements that are entered only when no error is
+		 * possible.
+		 *
+		 * If we ever encounter a non-fatal error, it means
+		 * something went really wrong and we should stop
+		 * immediately.
+		 */
+		die("Unknown error occured while reading the configuration files");
 }
 
 static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
-- 
1.9.0.GIT
