From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v9 4/8] change `git_config()` return value to void
Date: Thu,  7 Aug 2014 04:59:15 -0700
Message-ID: <1407412759-13833-5-git-send-email-tanayabh@gmail.com>
References: <1407412759-13833-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 14:00:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFMMu-0004x2-Tc
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 14:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbaHGMAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 08:00:22 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:54239 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932290AbaHGMAT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 08:00:19 -0400
Received: by mail-pa0-f45.google.com with SMTP id eu11so5311045pac.32
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 05:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KHgDjku2cGk64yAccRP8ANSZBW7qYrS2E6Cqzl/7P/4=;
        b=ZPEUGchVYc8GPniAZyqe4cN9DzmGr/7mo2Z7plsSsGggpSBvIqyF5vKKVChK1qg67u
         EFcY2Yu+O9zJ1k2WNg60oNCSGrD6ci4cwPm08vf4HjS7ROCMJs/qFx7vwp64IwYjJHMc
         Y7IsLA1fm2INnbl9z1v0QGAIBWmcQ5nznMvLPFd4hKkkyAZsgl7USs6wlzstL+b5T/fv
         zTtBEonhbVg8HxXC8sCzeQ1P0Dsi4Wod1I7NRg0N1o5ILP7qeYtal3cWyp/mExnCtSba
         RKrOwfpGUOg4QCJB6iH+xDIdCoDvUgSW3yj1luajIiro0e/K65AhEGa1eDHrXQB17qoH
         QpAQ==
X-Received: by 10.70.127.230 with SMTP id nj6mr1192194pdb.164.1407412818555;
        Thu, 07 Aug 2014 05:00:18 -0700 (PDT)
Received: from localhost.localdomain ([223.176.226.83])
        by mx.google.com with ESMTPSA id cb8sm13997212pad.8.2014.08.07.05.00.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 05:00:18 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407412759-13833-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254954>

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
index 0b1bdfd..f11ce41 100644
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
index e4d745e..4cefa25 100644
--- a/config.c
+++ b/config.c
@@ -1230,9 +1230,21 @@ int git_config_with_options(config_fn_t fn, void *data,
 	return ret;
 }
 
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
