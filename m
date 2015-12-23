From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 10/11] config: add core.untrackedCache
Date: Wed, 23 Dec 2015 22:03:58 +0100
Message-ID: <1450904639-25592-11-git-send-email-chriscool@tuxfamily.org>
References: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 22:05:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBqao-0000a2-JE
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 22:05:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965488AbbLWVFB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Dec 2015 16:05:01 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34043 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965479AbbLWVEt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 16:04:49 -0500
Received: by mail-wm0-f47.google.com with SMTP id l126so160140976wml.1
        for <git@vger.kernel.org>; Wed, 23 Dec 2015 13:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=q/DFt4meeCegYm8QM01Jxcc3lroomMNFRiD6Ms59rSI=;
        b=u1zL+NIxRMlqRvgT+r7mvN+FsuLasSWvNwP1Qynb6yO3J6MvQKAJiAgzXO3NYEkg2r
         DZZ9HSOPvcVKf8RFvok5oXQPea04t6hdWxiEnVwuKmPq3g98Q+cViRMlsdk2G6e10rvd
         Uk7WueegL3a5u/KFbXOeaPr50qvmnsi17Z9qW4Wmvty/WQSEFgC+KUOojujJD/UVSVig
         taMjcUYcNZizV0fcZ000+1tyN5bgB0H3M2AE0krmbrSMbIQ1zKvSebwSg9YWK/pWwqsG
         FDPfmvia9cP+RZCQMd4uHgQxuU90XyNl8AOJZpkCayoyK4w1ZJc0RxdNPYKVoBfkZf19
         P8Kw==
X-Received: by 10.194.184.210 with SMTP id ew18mr19921377wjc.79.1450904687819;
        Wed, 23 Dec 2015 13:04:47 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id w80sm9434692wme.17.2015.12.23.13.04.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Dec 2015 13:04:46 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.rc2.11.g68ccdd4
In-Reply-To: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282965>

When we know that mtime is fully supported by the environment, we
might want the untracked cache to be always used by default without
any mtime test or kernel version check being performed.

Also when we know that mtime is not supported by the environment,
for example because the repo is shared over a network file system,
then we might want 'git update-index --untracked-cache' to fail
immediately instead of performing tests (because it might work on
some systems using the repo over the network file system but not
others).

The normal way to achieve the above in Git is to use a config
variable. That's why this patch introduces "core.untrackedCache".

To keep things simple, this variable is a bool which default to
false.

When "git status" is run, it now adds or removes the untracked
cache in the index to respect the value of this variable.

The job of `git update-index --[no-|force-]untracked-cache` was
to add or remove the untracked cache from the index. This was a
kind of configuration because this was persistant across git
commands. To make this kind of configuration compatible with the
new config variable, the simple thing to do, and what this patch
does, is to make `git update-index --[no-|force-]untracked-cache`
set or unset this config option.

This new behavior is a backward incompatible change, but that is
deliberate. The untracked cache feature has been experimental
and is very unlikely used by beginners.

When people will upgrade, this will remove any untracked cache
they used unless they set "core.untrackedCache" before upgrading.
This should be stated in the release notes.

Also `--untracked-cache` used to check that the underlying
operating system and file system change `st_mtime` field of a
directory if files are added or deleted in that directory. But
those tests take a long time and there is now
`--test-untracked-cache` to perform them.

That's why, to be more consistent with other git commands, this
patch prevents `--untracked-cache` to perform tests, so that
after this patch there is no difference any more between
`--untracked-cache` and `--force-untracked-cache`.

All the changes to `--[no-|force-]untracked-cache` make it
possible to deprecate those options in the future.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/config.txt               |  7 ++++
 Documentation/git-update-index.txt     | 58 ++++++++++++++++++++++++++=
+-------
 builtin/update-index.c                 | 15 +++++----
 cache.h                                |  1 +
 config.c                               |  4 +++
 contrib/completion/git-completion.bash |  1 +
 environment.c                          |  1 +
 t/t7063-status-untracked-cache.sh      |  4 +--
 wt-status.c                            |  5 +++
 9 files changed, 74 insertions(+), 22 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f617886..08f0510 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -308,6 +308,13 @@ core.trustctime::
 	crawlers and some backup systems).
 	See linkgit:git-update-index[1]. True by default.
=20
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
diff --git a/Documentation/git-update-index.txt b/Documentation/git-upd=
ate-index.txt
index a0ee0c9..bab6394 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -174,24 +174,29 @@ may not support it yet.
=20
 --untracked-cache::
 --no-untracked-cache::
-	Enable or disable untracked cache extension. This could speed
-	up for commands that involve determining untracked files such
-	as `git status`. The underlying operating system and file
-	system must change `st_mtime` field of a directory if files
-	are added or deleted in that directory.
+	Enable or disable untracked cache extension. Please use
+	`--test-untracked-cache` before enabling it.
++
+These options are mostly aliases for setting the `core.untrackedCache`
+configuration variable to 'true' or 'false' in the local config file
+(see linkgit:git-config[1]). You can equivalently just set those
+configuration values directly. These options are just provided for
+backwards compatibility with the older versions of Git where this was
+the only way to enable or disable the untracked cache extension.
=20
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
=20
 --force-untracked-cache::
-	For safety, `--untracked-cache` performs tests on the working
-	directory to make sure untracked cache can be used. These
-	tests can take a few seconds. `--force-untracked-cache` can be
-	used to skip the tests.
+	Same as `--untracked-cache`. Provided for backwards
+	compatibility with older versions of Git where
+	`--untracked-cache` used to imply `--test-untracked-cache` but
+	this option would enable the extension unconditionally.
=20
 \--::
 	Do not interpret any more arguments as options.
@@ -382,6 +387,33 @@ Although this bit looks similar to assume-unchange=
d bit, its goal is
 different from assume-unchanged bit's. Skip-worktree also takes
 precedence over assume-unchanged bit when both are set.
=20
+Untracked cache
+---------------
+
+This cache could speed up commands that involve determining untracked
+files such as `git status`.
+
+This feature works by recording the mtime of the working tree
+directories and then omitting reading directories and stat calls
+against files in those directories whose mtime hasn't changed. For
+this to work the underlying operating system and file system must
+change the `st_mtime` field of directories if files in the directory
+are added, modified or deleted.
+
+You can test whether the filesystem supports that with the
+`--test-untracked-cache` option. The `--untracked-cache` option used
+to implicitly perform that test in older versions of Git, but that's
+no longer the case.
+
+It is recommended to use the `core.untrackedCache` configuration
+variable (see linkgit:git-config[1]) to enable or disable this feature
+instead of using the `--[no-|force-]untracked-cache` which are going
+to set or unset this configuration variable anyway.
+
+When the `core.untrackedCache` configuration variable is changed, the
+untracked cache is added or removed from the index the next time "git
+status" is run, while when `--[no-|force-]untracked-cache` are used,
+the untracked cache is immediately added to the index.
=20
 Configuration
 -------------
@@ -407,6 +439,8 @@ It can be useful when the inode change time is regu=
larly modified by
 something outside Git (file system crawlers and backup systems use
 ctime for marking files processed) (see linkgit:git-config[1]).
=20
+The untracked cache extension is enabled by the `core.untrackedCache`
+configuration variable (see linkgit:git-config[1]).
=20
 SEE ALSO
 --------
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 3e5b4a6..9bb70dc 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1115,18 +1115,19 @@ int cmd_update_index(int argc, const char **arg=
v, const char *prefix)
 		the_index.split_index =3D NULL;
 		the_index.cache_changed |=3D SOMETHING_CHANGED;
 	}
+	if (untracked_cache =3D=3D UC_TEST) {
+		setup_work_tree();
+		return !test_if_untracked_cache_is_supported();
+	}
 	if (untracked_cache > UC_DISABLE) {
-		if (untracked_cache < UC_FORCE) {
-			setup_work_tree();
-			if (!test_if_untracked_cache_is_supported())
-				return 1;
-			if (untracked_cache =3D=3D UC_TEST)
-				return 0;
-		}
+		if (!use_untracked_cache && git_config_set("core.untrackedCache", "t=
rue"))
+			die("could not set core.untrackedCache to true");
 		add_untracked_cache();
 		if (verbose)
 			printf(_("Untracked cache enabled for '%s'\n"), get_git_work_tree()=
);
 	} else if (untracked_cache =3D=3D UC_DISABLE) {
+		if (use_untracked_cache && git_config_set("core.untrackedCache", "fa=
lse"))
+			die("could not set core.untrackedCache to false");
 		remove_untracked_cache();
 		if (verbose)
 			printf(_("Untracked cache disabled\n"));
diff --git a/cache.h b/cache.h
index c63fcc1..8d09858 100644
--- a/cache.h
+++ b/cache.h
@@ -619,6 +619,7 @@ extern void set_alternate_index_output(const char *=
);
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
 extern int trust_ctime;
+extern int use_untracked_cache;
 extern int check_stat;
 extern int quote_path_fully;
 extern int has_symlinks;
diff --git a/config.c b/config.c
index 86a5eb2..b52916d 100644
--- a/config.c
+++ b/config.c
@@ -691,6 +691,10 @@ static int git_default_core_config(const char *var=
, const char *value)
 		trust_ctime =3D git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "core.untrackedcache")) {
+		use_untracked_cache =3D git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "core.checkstat")) {
 		if (!strcasecmp(value, "default"))
 			check_stat =3D 1;
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 6956807..84bcec3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2055,6 +2055,7 @@ _git_config ()
 		core.sparseCheckout
 		core.symlinks
 		core.trustctime
+		core.untrackedCache
 		core.warnAmbiguousRefs
 		core.whitespace
 		core.worktree
diff --git a/environment.c b/environment.c
index 2da7fe2..9ca71b1 100644
--- a/environment.c
+++ b/environment.c
@@ -14,6 +14,7 @@
=20
 int trust_executable_bit =3D 1;
 int trust_ctime =3D 1;
+int use_untracked_cache;
 int check_stat =3D 1;
 int has_symlinks =3D 1;
 int minimum_abbrev =3D 4, default_abbrev =3D 7;
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untrack=
ed-cache.sh
index 0e8d0d4..253160a 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -8,10 +8,8 @@ avoid_racy() {
 	sleep 1
 }
=20
-# It's fine if git update-index returns an error code other than one,
-# it'll be caught in the first test.
 test_lazy_prereq UNTRACKED_CACHE '
-	{ git update-index --untracked-cache; ret=3D$?; } &&
+	{ git update-index --test-untracked-cache; ret=3D$?; } &&
 	test $ret -ne 1
 '
=20
diff --git a/wt-status.c b/wt-status.c
index bba2596..6766f80 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -578,6 +578,11 @@ static void wt_status_collect_untracked(struct wt_=
status *s)
 	if (!s->show_untracked_files)
 		return;
=20
+	if (use_untracked_cache)
+		add_untracked_cache();
+	else
+		remove_untracked_cache();
+
 	memset(&dir, 0, sizeof(dir));
 	if (s->show_untracked_files !=3D SHOW_ALL_UNTRACKED_FILES)
 		dir.flags |=3D
--=20
2.7.0.rc2.11.g68ccdd4
