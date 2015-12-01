From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 6/8] config: add core.untrackedCache
Date: Tue,  1 Dec 2015 21:31:37 +0100
Message-ID: <1449001899-18956-7-git-send-email-chriscool@tuxfamily.org>
References: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 21:33:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3rby-0000ZW-J7
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 21:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756437AbbLAUdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 15:33:11 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36215 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756182AbbLAUcn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 15:32:43 -0500
Received: by wmec201 with SMTP id c201so5028835wme.3
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 12:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CTBMNLN8XW+yv/MLj42uFWRFBJGPuodvEzX3/L/128M=;
        b=RzED2Qh3+8UkCHuV7natzVwoTwUOGdDsBbvuMf9vqY5PDmDWfOf3G3Jyr+NvOVxkoM
         hlkaVTMZoed0TaM6HdW4HrweX6Rdnrc6isuVzKgGmaRy1HCR5ktYWzdXpr7T1xmW0oPQ
         XWVzj9fvzcuDgeAzjo8rok/9QXuZrTMi0rTonKSfkhj9kTEWKgDvsgElDQvs8gEByXk7
         Z44qjZ2Tqpzs8ly2uEQPK9aibdg5LDqzzbRfZb+CKPziJMkG9/xY4WemntjAK3Mz/Yp2
         x/JvJxGM5pYDnG7uGN9BfFG9OKpMwQ4MrMFc+G4YJkWm/n1MpfOM4F450b0S8avI+1xN
         SC5A==
X-Received: by 10.194.75.202 with SMTP id e10mr93869112wjw.160.1449001962163;
        Tue, 01 Dec 2015 12:32:42 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id uw6sm1978310wjc.42.2015.12.01.12.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Dec 2015 12:32:41 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.391.g95a3a5c
In-Reply-To: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281852>

When we know that mtime is fully supported by the environment, we
might want the untracked cache to be always used by default without
any mtime test or kernel version check being performed.

Also when we know that mtime is not supported by the environment,
for example because the repo is shared over a network file system,
then we might want 'git update-index --untracked-cache' to fail
immediately instead of it testing if it works (because it might
work on some systems using the repo over the network file system
but not others).

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt               | 10 ++++++++++
 Documentation/git-update-index.txt     | 11 +++++++++--
 builtin/update-index.c                 | 28 ++++++++++++++++++----------
 cache.h                                |  1 +
 config.c                               | 10 ++++++++++
 contrib/completion/git-completion.bash |  1 +
 dir.c                                  |  2 +-
 environment.c                          |  1 +
 wt-status.c                            |  9 +++++++++
 9 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b4b0194..bf176ff 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -308,6 +308,16 @@ core.trustctime::
 	crawlers and some backup systems).
 	See linkgit:git-update-index[1]. True by default.
 
+core.untrackedCache::
+	If unset or set to 'default' or 'check', untracked cache will
+	not be enabled by default and when
+	'update-index --untracked-cache' is called, Git will test if
+	mtime is working properly before enabling it. If set to false,
+	Git will refuse to enable untracked cache even if
+	'--force-untracked-cache' is used. If set to true, Git will
+	blindly enabled untracked cache by default without testing if
+	it works. See linkgit:git-update-index[1].
+
 core.checkStat::
 	Determines which stat fields to match between the index
 	and work tree. The user can set this to 'default' or
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 0ff7396..4e6078b 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -177,7 +177,10 @@ may not support it yet.
 	up for commands that involve determining untracked files such
 	as `git status`. The underlying operating system and file
 	system must change `st_mtime` field of a directory if files
-	are added or deleted in that directory.
+	are added or deleted in that directory. If you want to always
+	enable, or always disable, untracked cache, you can set the
+	`core.untrackedCache` configuration variable to 'true' or
+	'false' respectively, (see linkgit:git-config[1]).
 
 --test-untracked-cache::
 	Only perform tests on the working directory to make sure
@@ -190,7 +193,9 @@ may not support it yet.
 	For safety, `--untracked-cache` performs tests on the working
 	directory to make sure untracked cache can be used. These
 	tests can take a few seconds. `--force-untracked-cache` can be
-	used to skip the tests.
+	used to skip the tests. It cannot enable untracked cache if
+	`core.untrackedCache` configuration variable is set to false
+	(see linkgit:git-config[1]).
 
 \--::
 	Do not interpret any more arguments as options.
@@ -406,6 +411,8 @@ It can be useful when the inode change time is regularly modified by
 something outside Git (file system crawlers and backup systems use
 ctime for marking files processed) (see linkgit:git-config[1]).
 
+Untracked cache look at `core.untrackedCache` configuration variable
+(see linkgit:git-config[1]).
 
 SEE ALSO
 --------
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 2cbaee0..bf697a5 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1106,19 +1106,27 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		the_index.split_index = NULL;
 		the_index.cache_changed |= SOMETHING_CHANGED;
 	}
+	if (untracked_cache == 2 || (untracked_cache == 1 && use_untracked_cache == -1)) {
+		setup_work_tree();
+		if (!test_if_untracked_cache_is_supported())
+			return 1;
+		if (untracked_cache == 2)
+			return 0;
+	}
 	if (untracked_cache > 0) {
-		if (untracked_cache < 3) {
-			setup_work_tree();
-			if (!test_if_untracked_cache_is_supported())
-				return 1;
-			if (untracked_cache == 2)
-				return 0;
-		}
+		if (!use_untracked_cache)
+			die("core.untrackedCache is set to false; "
+			    "the untracked cache will not be enabled");
 		add_untracked_cache();
 		fprintf(stderr, _("Untracked cache enabled for '%s'\n"), get_git_work_tree());
-	} else if (!untracked_cache && the_index.untracked) {
-		remove_untracked_cache();
-		fprintf(stderr, _("Untracked disabled\n"));
+	} else if (!untracked_cache) {
+		if (use_untracked_cache > 0)
+			die("core.untrackedCache is set to true; "
+			    "the untracked cache will not be disabled");
+		if (the_index.untracked) {
+			remove_untracked_cache();
+			fprintf(stderr, _("Untracked disabled\n"));
+		}
 	}
 
 	if (active_cache_changed) {
diff --git a/cache.h b/cache.h
index 736abc0..b27692d 100644
--- a/cache.h
+++ b/cache.h
@@ -601,6 +601,7 @@ extern void set_alternate_index_output(const char *);
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
 extern int trust_ctime;
+extern int use_untracked_cache;
 extern int check_stat;
 extern int quote_path_fully;
 extern int has_symlinks;
diff --git a/config.c b/config.c
index 248a21a..7d50f43 100644
--- a/config.c
+++ b/config.c
@@ -691,6 +691,16 @@ static int git_default_core_config(const char *var, const char *value)
 		trust_ctime = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "core.untrackedcache")) {
+		if (!strcasecmp(value, "default") || !strcasecmp(value, "check"))
+			use_untracked_cache = -1;
+		else {
+			use_untracked_cache = git_config_maybe_bool(var, value);
+			if (use_untracked_cache == -1)
+				error("unknown core.untrackedCache value '%s'; using default", value);
+		}
+		return 0;
+	}
 	if (!strcmp(var, "core.checkstat")) {
 		if (!strcasecmp(value, "default"))
 			check_stat = 1;
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 482ca84..f23a800 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2038,6 +2038,7 @@ _git_config ()
 		core.sparseCheckout
 		core.symlinks
 		core.trustctime
+		core.untrackedCache
 		core.warnAmbiguousRefs
 		core.whitespace
 		core.worktree
diff --git a/dir.c b/dir.c
index ffc0286..aa07aca 100644
--- a/dir.c
+++ b/dir.c
@@ -2014,7 +2014,7 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 	if (dir->exclude_list_group[EXC_CMDL].nr)
 		return NULL;
 
-	if (!ident_in_untracked(dir->untracked)) {
+	if (use_untracked_cache != 1 && !ident_in_untracked(dir->untracked)) {
 		warning(_("Untracked cache is disabled on this system."));
 		return NULL;
 	}
diff --git a/environment.c b/environment.c
index 2da7fe2..8f631a1 100644
--- a/environment.c
+++ b/environment.c
@@ -14,6 +14,7 @@
 
 int trust_executable_bit = 1;
 int trust_ctime = 1;
+int use_untracked_cache = -1;
 int check_stat = 1;
 int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = 7;
diff --git a/wt-status.c b/wt-status.c
index 435fc28..3e0fe02 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -586,6 +586,15 @@ static void wt_status_collect_untracked(struct wt_status *s)
 		dir.flags |= DIR_SHOW_IGNORED_TOO;
 	else
 		dir.untracked = the_index.untracked;
+
+	if (!dir.untracked && use_untracked_cache == 1) {
+		add_untracked_cache();
+		dir.untracked = the_index.untracked;
+	} else if (dir.untracked && use_untracked_cache == 0) {
+		remove_untracked_cache();
+		dir.untracked = NULL;
+	}
+
 	setup_standard_excludes(&dir);
 
 	fill_directory(&dir, &s->pathspec);
-- 
2.6.3.391.g95a3a5c
