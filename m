From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v6 3/7] change `git_config()` return value to void
Date: Thu, 31 Jul 2014 08:47:38 -0700
Message-ID: <1406821662-1570-4-git-send-email-tanayabh@gmail.com>
References: <1406821662-1570-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 17:49:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCsbB-0008KP-O3
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 17:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbaGaPsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 11:48:45 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:32877 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbaGaPsn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 11:48:43 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so3861129pab.16
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 08:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3vDw/BHUw8kFT4Sa24WDesF8nO4mf0Q58C1m+wlurks=;
        b=hdAZctSkJ+X8J4E5puMFLKBGmsVDGQf4ZpZFxANI3C48u3jusDctNSu30kiK51M7V+
         1gTyhMvFCFYbiZhSrKb70oPOaPkmY7qMzlQLsopuJdQ8CB1KKPY3MG7OOGq1+uDVoUxm
         2RA3/FmzRXKvpJVhU3yZ/HLiVvyWcFBKZbiJHMVP+DD4066UEU8WRUcfM8RekmkvLijq
         0DcEoZ4NdEal0QESKd5qFARIj9U/BL6j9/6T/RsKLR5u9+CeIfSDCq6dm85luwAPYLqU
         NLuLi4rnjAgS1K1ZVv9xN9DUaj4MvLAwqanbR9+crz/cUHgB0dZBm5SfdSFJSsbEvZHe
         wptw==
X-Received: by 10.66.183.81 with SMTP id ek17mr5421383pac.39.1406821723257;
        Thu, 31 Jul 2014 08:48:43 -0700 (PDT)
Received: from localhost.localdomain ([223.229.21.143])
        by mx.google.com with ESMTPSA id n16sm8837555pdj.41.2014.07.31.08.48.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 08:48:42 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406821662-1570-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254584>

Currently `git_config()` returns an integer signifying an error code.
During rewrites of the function most of the code was shifted to
`git_config_with_options()`. `git_config_with_options()` normally
returns positive values if its `config_source` parameter is set as NULL,
as most errors are fatal, and non-fatal potential errors are guarded
by "if" statements that are entered only when no error is possible.

Still a negative value can be returned in case of race condition between
`access_or_die()` & `git_config_from_file()`. Also, all callers of
`git_config()` ignore the return value except for one case in branch.c.

Change `git_config()` return value to void and make it die if it receives
a negative value from `git_config_with_options()`.

Original-patch-by: Matthieu Moy <Matthieu.Moy@imag.fr>
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
index 4a15383..ecbe14f 100644
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
+		die(_("unknown error occured while reading the configuration files"));
 }
 
 static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
-- 
1.9.0.GIT
