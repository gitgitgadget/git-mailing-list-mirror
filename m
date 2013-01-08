From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] commit: make default of "cleanup" option configurable
Date: Tue,  8 Jan 2013 21:16:16 +0100
Message-ID: <1357676176-30019-1-git-send-email-ralf.thielow@gmail.com>
Cc: gitster@pobox.com, Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 21:16:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsfbH-0001je-RI
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 21:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031Ab3AHUQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 15:16:24 -0500
Received: from mail-bk0-f53.google.com ([209.85.214.53]:62809 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab3AHUQX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 15:16:23 -0500
Received: by mail-bk0-f53.google.com with SMTP id j5so505980bkw.40
        for <git@vger.kernel.org>; Tue, 08 Jan 2013 12:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=9IMR9MKYPkDakKExYl0NvHJ2omOgCbRZ6AeJnuHY2Pk=;
        b=H2aExIaNP0U+i76GLUVgjnK356db2/+mv9mlG+TaYRFU6EaEqSDM5CWh8Tktp3c/Qe
         brNEHFg5W7ysh1m8e4tq25/1gDmAyFgwAo2Ug1qqUcmLLuyxgIuXCJqRMbza4GyPP7g2
         PieRC8LSD2BFMNUUu5RJ7f8XJlpsm9M3tfinU60ZrPJBPXrlLu6y0vkioBQMywN2Lg9s
         ef2W7JiJo3cCw8H5/G5EYr8HxPlrd/VVKkEdahzZ5aAlQcS1SrBN6RUv16XazhwHva9O
         hauQhgZGswhbr1Av9phwg2NDeEQUG2Jj5Z9ImaV92OplHoo/AeNPaGFz3Zst3mh7gqJG
         kV8A==
X-Received: by 10.204.157.152 with SMTP id b24mr32246525bkx.92.1357676182678;
        Tue, 08 Jan 2013 12:16:22 -0800 (PST)
Received: from localhost.localdomain (dslb-094-222-138-000.pools.arcor-ip.net. [94.222.138.0])
        by mx.google.com with ESMTPS id d16sm46773342bkw.2.2013.01.08.12.16.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Jan 2013 12:16:22 -0800 (PST)
X-Mailer: git-send-email 1.8.1.165.gd94bd4e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213002>

The default of the "cleanup" option in "git commit"
is not configurable. Users who don't want to use the
default have to pass this option on every commit since
there's no way to configure it. This commit introduces
a new config option "commit.cleanup" which can be used
to change the default of the "cleanup" option in
"git commit".

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 Documentation/config.txt |  4 ++++
 builtin/commit.c         | 29 ++++++++++++++++++-----------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 53c4ca1..3f76cd1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -917,6 +917,10 @@ column.tag::
 	Specify whether to output tag listing in `git tag` in columns.
 	See `column.ui` for details.
 
+commit.cleanup::
+	This setting overrides the default of the `--cleanup` option in
+	`git commit`. See linkgit:git-commit[1] for details.
+
 commit.status::
 	A boolean to enable/disable inclusion of status information in the
 	commit message template when using an editor to prepare the commit
diff --git a/builtin/commit.c b/builtin/commit.c
index d6dd3df..42acde7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -103,7 +103,7 @@ static enum {
 	CLEANUP_NONE,
 	CLEANUP_ALL
 } cleanup_mode;
-static char *cleanup_arg;
+const static char *cleanup_arg;
 
 static enum commit_whence whence;
 static int use_editor = 1, include_status = 1;
@@ -966,6 +966,20 @@ static const char *read_commit_message(const char *name)
 	return out;
 }
 
+static void parse_cleanup_arg()
+{
+	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
+		cleanup_mode = use_editor ? CLEANUP_ALL : CLEANUP_SPACE;
+	else if (!strcmp(cleanup_arg, "verbatim"))
+		cleanup_mode = CLEANUP_NONE;
+	else if (!strcmp(cleanup_arg, "whitespace"))
+		cleanup_mode = CLEANUP_SPACE;
+	else if (!strcmp(cleanup_arg, "strip"))
+		cleanup_mode = CLEANUP_ALL;
+	else
+		die(_("Invalid cleanup mode %s"), cleanup_arg);
+}
+
 static int parse_and_validate_options(int argc, const char *argv[],
 				      const struct option *options,
 				      const char * const usage[],
@@ -1044,18 +1058,9 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		only_include_assumed = _("Clever... amending the last one with dirty index.");
 	if (argc > 0 && !also && !only)
 		only_include_assumed = _("Explicit paths specified without -i nor -o; assuming --only paths...");
-	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
-		cleanup_mode = use_editor ? CLEANUP_ALL : CLEANUP_SPACE;
-	else if (!strcmp(cleanup_arg, "verbatim"))
-		cleanup_mode = CLEANUP_NONE;
-	else if (!strcmp(cleanup_arg, "whitespace"))
-		cleanup_mode = CLEANUP_SPACE;
-	else if (!strcmp(cleanup_arg, "strip"))
-		cleanup_mode = CLEANUP_ALL;
-	else
-		die(_("Invalid cleanup mode %s"), cleanup_arg);
 
 	handle_untracked_files_arg(s);
+	parse_cleanup_arg();
 
 	if (all && argc > 0)
 		die(_("Paths with -a does not make sense."));
@@ -1320,6 +1325,8 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 		include_status = git_config_bool(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "commit.cleanup"))
+		return git_config_string(&cleanup_arg, k, v);
 
 	status = git_gpg_config(k, v, NULL);
 	if (status)
-- 
1.8.1.165.gd94bd4e.dirty
