From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v7 4/8] change `git_config()` return value to void
Date: Fri,  1 Aug 2014 10:05:52 -0700
Message-ID: <1406912756-15517-5-git-send-email-tanayabh@gmail.com>
References: <1406912756-15517-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 01 19:07:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDGIF-0001qE-7B
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 19:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395AbaHARG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 13:06:56 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34477 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151AbaHARGz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 13:06:55 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so5822164pdj.8
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 10:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A5jIxJU+RvcNx9AWDpVenQG/TaAyj9AUNbf1m92i74w=;
        b=YGHiN7Kqiy+gJzO58VDDGDFTRnUb9tDYGn9SsMPod6SGbVKr+8yXZ0MU73UL9DqAW5
         CNRCRA5aC1uRVvYGj3Agc2D6tNKdFNHE/2aLHSxttyrZo1OeKpSsMYXSNfbhOXiDEHpL
         3DfuzoukTOc85F/ETvzIg7Fsq8ArMLQhr66PwJceARtVnZGX0SQYekmF/pki/toYuIpS
         V5BI2RJFnGhPiZbLWbk6vSjAVlN5PCDzWdZu6mCywAsFlVClkW+3cs3aXrbxAW18fmBO
         7g4gerZzQgjvEEy6vhVTQ/mi1ToMixgsbUtLyYWmpCMHfNCK7aWXH5DDgkvY+ra/DEPt
         Ti5Q==
X-Received: by 10.70.127.207 with SMTP id ni15mr7775496pdb.129.1406912815100;
        Fri, 01 Aug 2014 10:06:55 -0700 (PDT)
Received: from localhost.localdomain ([110.225.111.156])
        by mx.google.com with ESMTPSA id pz10sm9241121pbb.33.2014.08.01.10.06.51
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 01 Aug 2014 10:06:54 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406912756-15517-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254637>

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
index e685b66..f923b1c 100644
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
