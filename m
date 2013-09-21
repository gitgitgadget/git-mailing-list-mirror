From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2] Add core.mode configuration
Date: Sat, 21 Sep 2013 08:12:13 -0500
Message-ID: <1379769133-31732-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 21 15:17:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNN4N-0003vT-D0
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 15:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923Ab3IUNRj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 09:17:39 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:40725 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab3IUNRi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 09:17:38 -0400
Received: by mail-ob0-f173.google.com with SMTP id vb8so1854798obc.4
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 06:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rZSxfN3Nx5/6qV9ouG0pimB3Fai1cZyFcTm/P1yKd3U=;
        b=XmJsC8q/p5XwtcshBMI66c2N7ssbuwr0ZA8QgvQaOZw8bHldiCSBelU6Li3Nozix3+
         kB9h6RA0iIimCBNJ1FE8u9NLXRV3hZVnzBzW2mL/ohaYg4aKgX/yq8F9xwKUTbpJ71hL
         w/REilH9FCeMcfiuhHKr7T4CQiX+PuWb9ETDg/XzdtBK9m3H5q12UBmuQq7lYd9TiOd2
         NWrtmVzI95mwyQc6YoBm4TCYprJI/FEOpzDEva54XZ/q9dgU39SkY2r39gVwWawESa4r
         Htmq4rRwK1Vl1HK2zankTJlVDPpVY4ZDt9iJcXoXq2NUatngvGuThx+hb18JUrLm+/bt
         IIPg==
X-Received: by 10.60.44.240 with SMTP id h16mr10599884oem.2.1379769457891;
        Sat, 21 Sep 2013 06:17:37 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id j9sm7447676oef.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 06:17:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.3.g9a9e30e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235100>

So that we can specify general modes of operation, specifically, add the
'next' mode, which makes Git pre v2.0 behave as Git v2.0.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/add.c | 13 +++++++++----
 cache.h       |  6 ++++++
 config.c      | 13 +++++++++++++
 environment.c |  1 +
 4 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 8266a9c..95a396d 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -483,14 +483,16 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	 */
 	memset(&update_data, 0, sizeof(update_data));
 	if (!take_worktree_changes && addremove_explicit < 0)
-		update_data.warn_add_would_remove = 1;
+		if (git_mode == MODE_CURRENT)
+			update_data.warn_add_would_remove = 1;
 
 	if (!take_worktree_changes && addremove_explicit < 0 && argc)
 		/*
 		 * Turn "git add pathspec..." to "git add -A pathspec..."
 		 * in Git 2.0 but not yet
 		 */
-		; /* addremove = 1; */
+		if (git_mode != MODE_CURRENT)
+			addremove = 1;
 
 	if (!show_only && ignore_missing)
 		die(_("Option --ignore-missing can only be used together with --dry-run"));
@@ -503,10 +505,13 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		short_option_with_implicit_dot = "-u";
 	}
 	if (option_with_implicit_dot && !argc) {
-		static const char *here[2] = { ".", NULL };
+		static const char *here[2] = { ":/", NULL };
 		argc = 1;
 		argv = here;
-		implicit_dot = 1;
+		if (git_mode == MODE_CURRENT) {
+			here[0] = ".";
+			implicit_dot = 1;
+		}
 	}
 
 	add_new_files = !take_worktree_changes && !refresh_only;
diff --git a/cache.h b/cache.h
index 85b544f..f28240f 100644
--- a/cache.h
+++ b/cache.h
@@ -627,9 +627,15 @@ enum push_default_type {
 	PUSH_DEFAULT_UNSPECIFIED
 };
 
+enum git_mode {
+	MODE_CURRENT = 0,
+	MODE_NEXT
+};
+
 extern enum branch_track git_branch_track;
 extern enum rebase_setup_type autorebase;
 extern enum push_default_type push_default;
+extern enum git_mode git_mode;
 
 enum object_creation_mode {
 	OBJECT_CREATION_USES_HARDLINKS = 0,
diff --git a/config.c b/config.c
index e13a7b6..f0e0370 100644
--- a/config.c
+++ b/config.c
@@ -831,6 +831,19 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.mode")) {
+		if (!value)
+			return config_error_nonbool(var);
+		else if (!strcmp(value, "current"))
+			git_mode = MODE_CURRENT;
+		else if (!strcmp(value, "next")) {
+			git_mode = MODE_NEXT;
+			push_default = PUSH_DEFAULT_SIMPLE;
+		} else
+			die("wrong mode '%s'", value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 5398c36..751e14d 100644
--- a/environment.c
+++ b/environment.c
@@ -62,6 +62,7 @@ int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 struct startup_info *startup_info;
 unsigned long pack_size_limit_cfg;
+enum git_mode git_mode = MODE_CURRENT;
 
 /*
  * The character that begins a commented line in user-editable file
-- 
1.8.4.3.g9a9e30e.dirty
