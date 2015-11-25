From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH] config: add core.trustmtime
Date: Wed, 25 Nov 2015 07:35:23 +0100
Message-ID: <1448433323-21037-1-git-send-email-chriscool@tuxfamily.org>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 07:36:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1TgN-0000H9-No
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 07:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755157AbbKYGf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 01:35:56 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37777 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754425AbbKYGfz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 01:35:55 -0500
Received: by wmww144 with SMTP id w144so55617244wmw.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 22:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=09Kt1Z4waJJG6mLxqtkQg0DZDV1B+ecE5b9a0Z/i0AA=;
        b=tDX2lUubiQV7kzRpM96y9Fo/jfSoam8Jl1Lbvfz5dqIRzSdg+axeTCjokL5ejSUcGV
         EJTzCcv1SGNV/4vRl7rDYHiWGKjO19GNRygonyB/36tXBGilpu2oEw9zXgvRhvZLCiUw
         ysLPMSluqO4EjiVz9i2nCB8nMApjMcGIr+0I7mmBozugVtUqwSrg0AmgNUjzUza8ecsm
         uBoD6qSOsilAC/FbZZqyF4BPI+Ne9P4HEBDPo/NncA7iph4AIwoFLOsnEsoX1p2FvwFx
         RTdm+WPn5Iyj6VR00pxTYP8Quy+GI5xZr7eRpK3d6YBuvBIBDB3FL1NwpSJJMqOegS9u
         IU1w==
X-Received: by 10.28.21.196 with SMTP id 187mr2510236wmv.82.1448433353569;
        Tue, 24 Nov 2015 22:35:53 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id q77sm1854870wmd.22.2015.11.24.22.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Nov 2015 22:35:52 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.380.g494b52d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281678>

When we know that mtime is fully supported by the environment, we
don't want any slow down because we used --untracked-cache rather
than --force-untracked-cache, and we don't want untracked cache to
stop working because we updated a kernel.

Also when we know that mtime is not supported by the environment,
for example because the repo is shared over a network file system,
then we might want 'git update-index --untracked-cache' to fail
immediately instead of it testing if it works (because it might
work on some systems using the repo over the network file system
but not others).

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
At Booking.com we know that mtime works everywhere and we don't
want the untracked cache to stop working when a kernel is upgraded
or when the repo is copied to a machine with a different kernel.
I will add tests later if people are ok with this.

 Documentation/config.txt               | 8 ++++++++
 Documentation/git-update-index.txt     | 6 +++++-
 builtin/update-index.c                 | 6 +++++-
 cache.h                                | 1 +
 config.c                               | 7 +++++++
 contrib/completion/git-completion.bash | 1 +
 dir.c                                  | 2 +-
 environment.c                          | 1 +
 8 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b4b0194..186ad17 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -308,6 +308,14 @@ core.trustctime::
 	crawlers and some backup systems).
 	See linkgit:git-update-index[1]. True by default.
 
+core.trustmtime::
+	If unset or set to 'default' or 'check', Git will test if
+	mtime is working properly before using features that need a
+	working mtime. If false, Git will refuse to use such
+	features. If set to true, Git will blindly use such features
+	without testing if they work.
+	See linkgit:git-update-index[1].
+
 core.checkStat::
 	Determines which stat fields to match between the index
 	and work tree. The user can set this to 'default' or
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 1a296bc..8b4c5af 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -182,7 +182,9 @@ may not support it yet.
 	For safety, `--untracked-cache` performs tests on the working
 	directory to make sure untracked cache can be used. These
 	tests can take a few seconds. `--force-untracked-cache` can be
-	used to skip the tests.
+	used to skip the tests. If you always want to skip those
+	tests, you can set the `core.trustmtime` configuration
+	variable to 'true', (see linkgit:git-config[1]).
 
 \--::
 	Do not interpret any more arguments as options.
@@ -398,6 +400,8 @@ It can be useful when the inode change time is regularly modified by
 something outside Git (file system crawlers and backup systems use
 ctime for marking files processed) (see linkgit:git-config[1]).
 
+Untracked cache needs a fully working mtime, so it will look at
+`core.trustmtime` configuration variable (see linkgit:git-config[1]).
 
 SEE ALSO
 --------
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7431938..c64439f 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1107,9 +1107,13 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	if (untracked_cache > 0) {
 		struct untracked_cache *uc;
 
+		if (trust_mtime == 0) {
+			fprintf_ln(stderr,_("core.trustmtime is set to false"));
+			return 1;
+		}
 		if (untracked_cache < 2) {
 			setup_work_tree();
-			if (!test_if_untracked_cache_is_supported())
+			if (trust_mtime != 1 && !test_if_untracked_cache_is_supported())
 				return 1;
 		}
 		if (!the_index.untracked) {
diff --git a/cache.h b/cache.h
index 736abc0..69a6197 100644
--- a/cache.h
+++ b/cache.h
@@ -601,6 +601,7 @@ extern void set_alternate_index_output(const char *);
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
 extern int trust_ctime;
+extern int trust_mtime;
 extern int check_stat;
 extern int quote_path_fully;
 extern int has_symlinks;
diff --git a/config.c b/config.c
index 248a21a..d720b1f 100644
--- a/config.c
+++ b/config.c
@@ -691,6 +691,13 @@ static int git_default_core_config(const char *var, const char *value)
 		trust_ctime = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "core.trustmtime")) {
+		if (!strcasecmp(value, "default") || !strcasecmp(value, "check"))
+			trust_mtime = -1;
+		else
+			trust_mtime = git_config_maybe_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "core.checkstat")) {
 		if (!strcasecmp(value, "default"))
 			check_stat = 1;
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 482ca84..39d1c9b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2038,6 +2038,7 @@ _git_config ()
 		core.sparseCheckout
 		core.symlinks
 		core.trustctime
+		core.trustmtime
 		core.warnAmbiguousRefs
 		core.whitespace
 		core.worktree
diff --git a/dir.c b/dir.c
index d2a8f06..b06df1b 100644
--- a/dir.c
+++ b/dir.c
@@ -1994,7 +1994,7 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 	if (dir->exclude_list_group[EXC_CMDL].nr)
 		return NULL;
 
-	if (!ident_in_untracked(dir->untracked)) {
+	if (trust_mtime != 1 && !ident_in_untracked(dir->untracked)) {
 		warning(_("Untracked cache is disabled on this system."));
 		return NULL;
 	}
diff --git a/environment.c b/environment.c
index 2da7fe2..c899947 100644
--- a/environment.c
+++ b/environment.c
@@ -14,6 +14,7 @@
 
 int trust_executable_bit = 1;
 int trust_ctime = 1;
+int trust_mtime = -1;
 int check_stat = 1;
 int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = 7;
-- 
2.6.3.380.g494b52d
