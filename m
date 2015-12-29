From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 09/10] config: add core.untrackedCache
Date: Tue, 29 Dec 2015 08:09:33 +0100
Message-ID: <1451372974-16266-10-git-send-email-chriscool@tuxfamily.org>
References: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue Dec 29 08:13:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDoSv-0000Dn-4r
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbbL2HM4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 02:12:56 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36612 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147AbbL2HMY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:12:24 -0500
Received: by mail-wm0-f53.google.com with SMTP id l65so24576057wmf.1
        for <git@vger.kernel.org>; Mon, 28 Dec 2015 23:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/uNeS3p3QgcfpR5eVk2wKN7HU8reMXdlaWNGDeFb4OI=;
        b=uebMWPxtVYjmow/yAKKphBYtaKdeNNx369/O/uP5QM8VNY+6fVmEyd/FGKpilK0Wc5
         vNB1U1UyOOR7YAkL6v9wjbvg8HyabcLsVOLAE0iWPh/XPdnF6LIt/Y/3K/740PR0g8qW
         wIMH7zyypOk9BdhLASku0zNip9eKQWMa0iARkVleRwi/KqZ8aY6McAEQmtPgKMuxSwxO
         uMBpmLzqXme8y34yLkUK7gMAmeK6vL0GQVA2hp2GLea/81cOXQcDmnoLzTqapAzzaYVH
         3XUUIorrHIMuMpx8vYLK19jF4lyuwYoIyTaLkm5N+/y78s3aRuABZumuQffB1JO9wF8x
         uVxA==
X-Received: by 10.28.140.201 with SMTP id o192mr67200672wmd.88.1451373143119;
        Mon, 28 Dec 2015 23:12:23 -0800 (PST)
Received: from localhost.localdomain (243.40.126.78.rev.sfr.net. [78.126.40.243])
        by smtp.gmail.com with ESMTPSA id uw6sm59795661wjc.42.2015.12.28.23.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Dec 2015 23:12:22 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.rc2.10.g544ad6b
In-Reply-To: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283090>

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

This variable is a tristate, `keep`, `false` and `true`, which
default to `keep`.

When "git status" is run, it now adds or removes the untracked
cache in the index to respect the value of this variable. So it
does nothing if the value is `keep` or if the variable is unset;
it adds the untracked cache if the value is `true`; and it
removes the cache if the value is `false`.

`git update-index --[no-|force-]untracked-cache` still adds or
removes the untracked cache from the index, but this now fails
if it goes against the value of core.untrackedCache.

Also `--untracked-cache` used to check that the underlying
operating system and file system change `st_mtime` field of a
directory if files are added or deleted in that directory. But
those tests take a long time and there is now
`--test-untracked-cache` to perform them.

That's why, to be more consistent with other git commands, this
patch prevents `--untracked-cache` to perform tests, so that
after this patch there is no difference any more between
`--untracked-cache` and `--force-untracked-cache`.

This last change is backward incompatible and should be
mentioned in the release notes.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/config.txt               |  7 ++++
 Documentation/git-update-index.txt     | 65 ++++++++++++++++++++++++++=
--------
 builtin/update-index.c                 | 35 ++++++++++++------
 cache.h                                |  1 +
 config.c                               | 11 ++++++
 contrib/completion/git-completion.bash |  1 +
 environment.c                          |  1 +
 t/t7063-status-untracked-cache.sh      |  4 +--
 wt-status.c                            | 13 +++++++
 9 files changed, 109 insertions(+), 29 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f617886..d892127 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -308,6 +308,13 @@ core.trustctime::
 	crawlers and some backup systems).
 	See linkgit:git-update-index[1]. True by default.
=20
+core.untrackedCache::
+	Determines if untracked cache will be automatically enabled or
+	disabled. It can be `keep`, `true` or `false`. Before setting
+	it to `true`, you should check that mtime is working properly
+	on your system.
+	See linkgit:git-update-index[1]. `keep` by default.
+
 core.checkStat::
 	Determines which stat fields to match between the index
 	and work tree. The user can set this to 'default' or
diff --git a/Documentation/git-update-index.txt b/Documentation/git-upd=
ate-index.txt
index a0afe17..813f6cc 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -174,27 +174,31 @@ may not support it yet.
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
+These options cannot override the `core.untrackedCache` configuration
+variable when it is set to `true` or `false` (see
+linkgit:git-config[1]). They can override it only when it is unset or
+set to `keep`. If you want untracked cache to persist, it is better
+anyway to just set this configuration variable to `true` or `false`
+directly.
=20
 --test-untracked-cache::
 	Only perform tests on the working directory to make sure
 	untracked cache can be used. You have to manually enable
-	untracked cache using `--force-untracked-cache` (or
-	`--untracked-cache` but this will run the tests again)
-	afterwards if you really want to use it. If a test fails
-	the exit code is 1 and a message explains what is not
-	working as needed, otherwise the exit code is 0 and OK is
-	printed.
+	untracked cache using `--untracked-cache` or
+	`--force-untracked-cache` or the `core.untrackedCache`
+	configuration variable afterwards if you really want to use
+	it. If a test fails the exit code is 1 and a message
+	explains what is not working as needed, otherwise the exit
+	code is 0 and OK is printed.
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
@@ -385,6 +389,34 @@ Although this bit looks similar to assume-unchange=
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
+instead of using the `--[no-|force-]untracked-cache`, as it is more
+persistant and visible with a configuration variable.
+
+When the `core.untrackedCache` configuration variable is changed, the
+untracked cache is added to or removed from the index the next time
+"git status" is run; while when `--[no-|force-]untracked-cache` are
+used, the untracked cache is immediately added to or removed from the
+index.
=20
 Configuration
 -------------
@@ -410,6 +442,9 @@ It can be useful when the inode change time is regu=
larly modified by
 something outside Git (file system crawlers and backup systems use
 ctime for marking files processed) (see linkgit:git-config[1]).
=20
+The untracked cache extension can be enabled by the
+`core.untrackedCache` configuration variable (see
+linkgit:git-config[1]).
=20
 SEE ALSO
 --------
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7844991..497f904 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1115,19 +1115,32 @@ int cmd_update_index(int argc, const char **arg=
v, const char *prefix)
 		the_index.split_index =3D NULL;
 		the_index.cache_changed |=3D SOMETHING_CHANGED;
 	}
-	if (untracked_cache > UC_DISABLE) {
-		if (untracked_cache < UC_FORCE) {
-			setup_work_tree();
-			if (!test_if_untracked_cache_is_supported())
-				return 1;
-			if (untracked_cache =3D=3D UC_TEST)
-				return 0;
-		}
-		add_untracked_cache();
-		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
-	} else if (untracked_cache =3D=3D UC_DISABLE) {
+
+	switch (untracked_cache) {
+	case UC_UNSPECIFIED:
+		break;
+	case UC_DISABLE:
+		if (use_untracked_cache =3D=3D 1)
+			die("core.untrackedCache is set to true; "
+			    "remove or change it, if you really want to "
+			    "disable the untracked cache");
 		remove_untracked_cache();
 		report(_("Untracked cache disabled"));
+		break;
+	case UC_TEST:
+		setup_work_tree();
+		return !test_if_untracked_cache_is_supported();
+	case UC_ENABLE:
+	case UC_FORCE:
+		if (use_untracked_cache =3D=3D 0)
+			die("core.untrackedCache is set to false; "
+			    "remove or change it, if you really want to "
+			    "enable the untracked cache");
+		add_untracked_cache();
+		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
+		break;
+	default:
+		die("Bug: bad untracked_cache value: %d", untracked_cache);
 	}
=20
 	if (active_cache_changed) {
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
index 86a5eb2..b7d7b25 100644
--- a/config.c
+++ b/config.c
@@ -691,6 +691,17 @@ static int git_default_core_config(const char *var=
, const char *value)
 		trust_ctime =3D git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "core.untrackedcache")) {
+		if (!strcasecmp(value, "keep"))
+			use_untracked_cache =3D -1;
+		else {
+			use_untracked_cache =3D git_config_maybe_bool(var, value);
+			if (use_untracked_cache =3D=3D -1)
+				error("unknown core.untrackedCache value '%s'; "
+				      "using 'keep' default value", value);
+		}
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
index 2da7fe2..394b15c 100644
--- a/environment.c
+++ b/environment.c
@@ -14,6 +14,7 @@
=20
 int trust_executable_bit =3D 1;
 int trust_ctime =3D 1;
+int use_untracked_cache =3D -1; /* keep */
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
index bba2596..75fafe5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -578,6 +578,19 @@ static void wt_status_collect_untracked(struct wt_=
status *s)
 	if (!s->show_untracked_files)
 		return;
=20
+	switch (use_untracked_cache) {
+	case -1: /* keep: do nothing */
+		break;
+	case 0: /* false */
+		remove_untracked_cache();
+		break;
+	case 1: /* true */
+		add_untracked_cache();
+		break;
+	default: /* unknown value: do nothing */
+		break;
+	}
+
 	memset(&dir, 0, sizeof(dir));
 	if (s->show_untracked_files !=3D SHOW_ALL_UNTRACKED_FILES)
 		dir.flags |=3D
--=20
2.7.0.rc2.10.g544ad6b
