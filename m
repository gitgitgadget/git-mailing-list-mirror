From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 7/8] config: add core.untrackedCache
Date: Tue,  8 Dec 2015 18:15:15 +0100
Message-ID: <1449594916-21167-8-git-send-email-chriscool@tuxfamily.org>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 18:16:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6Lrs-0006Ri-LT
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 18:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbbLHRPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 12:15:55 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37246 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbbLHRPx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 12:15:53 -0500
Received: by wmww144 with SMTP id w144so38466948wmw.0
        for <git@vger.kernel.org>; Tue, 08 Dec 2015 09:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=esTVeNO2VzlQcvMzb2JYvEH7zSPLQBJcQl+BE+p28kY=;
        b=Zu8r/gvnjgQhYWj73EmDp2MsWS75iFzbRzZdjtGZkfRKdtpBb1Z6UGlGt7AdOoV8dx
         0tnBvg6ZC/VT7qku9U3LS/Ik0KTpBUZeWrkyG0yAUwytf/mVUMZ3fAmrCR00hmukgQqF
         Kg0G8j2B2fCmTENh8tB9KXuWrjBt48i0vV9jYa7nBFbSLJDRqjDz8AtQH43+1xVJVkEo
         v3qTiLADxAiPDTJIOKng+uZIZD78H/xaZqYMNDIxYCOcMNuAnuX72eJz5dj0SmY8epoN
         t4rDEnxdEr4hnlC9ssfGr/EtUJmmb3Vvw20JUvadtRKxQgioXGqjfOkzQ0qzOjLqRfGH
         aFpA==
X-Received: by 10.28.212.84 with SMTP id l81mr6070130wmg.50.1449594952400;
        Tue, 08 Dec 2015 09:15:52 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 200sm4332517wmn.11.2015.12.08.09.15.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Dec 2015 09:15:51 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.478.g9f95483.dirty
In-Reply-To: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282164>

When we know that mtime is fully supported by the environment, we
might want the untracked cache to be always used by default without
any mtime test or kernel version check being performed.

Also when we know that mtime is not supported by the environment,
for example because the repo is shared over a network file system,
then we might want 'git update-index --untracked-cache' to fail
immediately instead of preforming tests (because it might work on
some systems using the repo over the network file system but not
others).

The normal way to achieve the above in Git is to use a config
variable. That's why this patch introduces "core.untrackedCache".

To keep things simple, this variable is a bool which default to
false.

When "git status" is run, it now adds or removes the untracked
cache in the index to respect the value of this variable.

This means that `git update-index --[no-|force-]untracked-cache`,
to be compatible with the new config variable, have to set or
unset it. This new behavior is backward incompatible change, but
that is deliberate.

Also `--untracked-cache` used to check that the underlying
operating system and file system change `st_mtime` field of a
directory if files are added or deleted in that directory. But
those tests take a long time and there is now
`--test-untracked-cache` to perform them.

So to be more consistent with other git commands, this patch
prevents `--untracked-cache` to perform tests. This means that
after this patch there is no difference any more between
`--untracked-cache` and `--force-untracked-cache`.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt               |  7 +++++++
 Documentation/git-update-index.txt     | 28 ++++++++++++++++++----------
 builtin/update-index.c                 | 23 +++++++++++++----------
 cache.h                                |  1 +
 config.c                               |  4 ++++
 contrib/completion/git-completion.bash |  1 +
 dir.c                                  |  2 +-
 environment.c                          |  1 +
 t/t7063-status-untracked-cache.sh      |  4 +---
 wt-status.c                            |  9 +++++++++
 10 files changed, 56 insertions(+), 24 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2d06b11..94820eb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -308,6 +308,13 @@ core.trustctime::
 	crawlers and some backup systems).
 	See linkgit:git-update-index[1]. True by default.
 
+core.untrackedCache::
+	Determines if untracked cache will be enabled. Using
+	'git update-index --[no-|force-]untracked-cache' will set
+	this variable. Before setting it to true, you should check
+	that mtime is working properly on your system.
+	See linkgit:git-update-index[1]. False by default.
+
 core.checkStat::
 	Determines which stat fields to match between the index
 	and work tree. The user can set this to 'default' or
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 0ff7396..0fb39db 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -175,22 +175,28 @@ may not support it yet.
 --no-untracked-cache::
 	Enable or disable untracked cache extension. This could speed
 	up for commands that involve determining untracked files such
-	as `git status`. The underlying operating system and file
-	system must change `st_mtime` field of a directory if files
-	are added or deleted in that directory.
+	as `git status`.
++
+The underlying operating system and file system must change `st_mtime`
+field of a directory if files are added or deleted in that
+directory. You can test that using
+`--test-untracked-cache`. `--untracked-cache` used to test that too
+but it doesn't anymore.
++
+This sets the `core.untrackedCache` configuration variable to 'true'
+or 'false' in the repo config file, (see linkgit:git-config[1]), so
+that the untracked cache stays enabled or disabled.
 
 --test-untracked-cache::
 	Only perform tests on the working directory to make sure
 	untracked cache can be used. You have to manually enable
-	untracked cache using `--force-untracked-cache` (or
-	`--untracked-cache` but this will run the tests again)
-	afterwards if you really want to use it.
+	untracked cache using `--untracked-cache` or
+	`--force-untracked-cache` or the `core.untrackedCache`
+	configuration variable afterwards if you really want to use
+	it.
 
 --force-untracked-cache::
-	For safety, `--untracked-cache` performs tests on the working
-	directory to make sure untracked cache can be used. These
-	tests can take a few seconds. `--force-untracked-cache` can be
-	used to skip the tests.
+	Same as `--untracked-cache`.
 
 \--::
 	Do not interpret any more arguments as options.
@@ -406,6 +412,8 @@ It can be useful when the inode change time is regularly modified by
 something outside Git (file system crawlers and backup systems use
 ctime for marking files processed) (see linkgit:git-config[1]).
 
+Untracked cache look at `core.untrackedCache` configuration variable
+(see linkgit:git-config[1]).
 
 SEE ALSO
 --------
diff --git a/builtin/update-index.c b/builtin/update-index.c
index e427657..7fe3a86 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1115,19 +1115,22 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		the_index.split_index = NULL;
 		the_index.cache_changed |= SOMETHING_CHANGED;
 	}
+	if (untracked_cache == TEST_UC) {
+		setup_work_tree();
+		return !test_if_untracked_cache_is_supported();
+	}
 	if (untracked_cache > NO_UC) {
-		if (untracked_cache < FORCE_UC) {
-			setup_work_tree();
-			if (!test_if_untracked_cache_is_supported())
-				return 1;
-			if (untracked_cache == TEST_UC)
-				return 0;
-		}
+		if (!use_untracked_cache && git_config_set("core.untrackedCache", "true"))
+			die("could not set core.untrackedCache to true");
 		add_untracked_cache();
 		fprintf(stderr, _("Untracked cache enabled for '%s'\n"), get_git_work_tree());
-	} else if (untracked_cache == NO_UC && the_index.untracked) {
-		remove_untracked_cache();
-		fprintf(stderr, _("Untracked cache disabled\n"));
+	} else if (untracked_cache == NO_UC) {
+		if (use_untracked_cache > 0 && git_config_set("core.untrackedCache", "false"))
+			die("could not set core.untrackedCache to false");
+		if (the_index.untracked) {
+			remove_untracked_cache();
+			fprintf(stderr, _("Untracked cache disabled\n"));
+		}
 	}
 
 	if (active_cache_changed) {
diff --git a/cache.h b/cache.h
index 2a9e902..0cc2c2f 100644
--- a/cache.h
+++ b/cache.h
@@ -619,6 +619,7 @@ extern void set_alternate_index_output(const char *);
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
 extern int trust_ctime;
+extern int use_untracked_cache;
 extern int check_stat;
 extern int quote_path_fully;
 extern int has_symlinks;
diff --git a/config.c b/config.c
index 248a21a..f023ee7 100644
--- a/config.c
+++ b/config.c
@@ -691,6 +691,10 @@ static int git_default_core_config(const char *var, const char *value)
 		trust_ctime = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "core.untrackedcache")) {
+		use_untracked_cache = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "core.checkstat")) {
 		if (!strcasecmp(value, "default"))
 			check_stat = 1;
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 111b053..b7e5736 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2054,6 +2054,7 @@ _git_config ()
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
index 2da7fe2..9ca71b1 100644
--- a/environment.c
+++ b/environment.c
@@ -14,6 +14,7 @@
 
 int trust_executable_bit = 1;
 int trust_ctime = 1;
+int use_untracked_cache;
 int check_stat = 1;
 int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = 7;
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 0e8d0d4..253160a 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -8,10 +8,8 @@ avoid_racy() {
 	sleep 1
 }
 
-# It's fine if git update-index returns an error code other than one,
-# it'll be caught in the first test.
 test_lazy_prereq UNTRACKED_CACHE '
-	{ git update-index --untracked-cache; ret=$?; } &&
+	{ git update-index --test-untracked-cache; ret=$?; } &&
 	test $ret -ne 1
 '
 
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
2.6.3.478.g9f95483.dirty
