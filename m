From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] fetch: add new fetch.default configuration
Date: Fri, 17 May 2013 21:18:56 -0500
Message-ID: <1368843536-19781-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 18 04:20:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdWlH-00087V-7M
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 04:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757355Ab3ERCUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 22:20:30 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:63429 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756075Ab3ERCU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 22:20:27 -0400
Received: by mail-oa0-f51.google.com with SMTP id f4so5852154oah.38
        for <git@vger.kernel.org>; Fri, 17 May 2013 19:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=/G2ipM/dHxbSAOSw6m5AwAeY1gPCjqlplC1R8J0YUvY=;
        b=zfcPC1zZf8RGJ4CEj1yXiTANKvW2llvXneU+8VyVgHRVYj7DFjfOBSP1U72BBUFrwr
         zqCA1wIMlMEyd5GOSmgIh/eRV5Xq3ZwOALJtjNiylQTYfJhgJKNUq5IAztDAWFJKU7sE
         KZZPKF2jG9aJMtQtf0f50//mEv2rhTRmpjwAxmpw0NMv0RU5juYO2mup+ujdKvGZCQtf
         OGaBSVI0Zapg9jEIf8kPEzDA5tED6tmIyPJ3F6kPPgUvzRCNWCyW0Jn9LYbzdGMavoku
         FKvTslQyB+divZsVFwU9Fxca8f79PVS6SiFzR3kQ1P+RbGqhXW6PN003N/UPiCTxpOr2
         HdPg==
X-Received: by 10.182.131.133 with SMTP id om5mr22845113obb.79.1368843626962;
        Fri, 17 May 2013 19:20:26 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b5sm7288650oby.12.2013.05.17.19.20.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 19:20:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224752>

When the user has an upstream branch configured to track a remote
tracking branch:

  % git checkout --set-upstream-to github/master

Doing a 'git fetch' without any arguments would try to fetch 'github',
because it's configured as current branch's remote
(branch.<current>.remote).

However, if we do something slightly different:

  % git checkout --set-upstream-to master

Doing a 'git fetch' without any arguments would try to fetch the remote
'.', for the same reason.

But, unlike the in the first instance, the second command would not
update any remote tracking branch, in fact, it would not update any
branch at all. The only effect is that it would update FETCH_HEAD.

FETCH_HEAD is a special symbol that is used to store the result of a
fetch. It can be used by other commands of git, specially 'git merge'.

It is however, barely mentioned in the documentation, and can be
considered a plumbing concept at best, that few Git users would benefit
from using, and indeed, quite likely very few use it, or are even aware
of it.

So when the user is presented with a message like this:

  % git fetch
  From .
   * branch            master     -> FETCH_HEAD

The vast majority of them would have absolutely no idea what's going on.
Many of them would probably just shrug, and manually specify the remote
the want to fetch from, which is 'origin' in many cases.

If the user has say, twenty branches, ten with a local upstream
(branch.<name>.remote = '.'), and ten without an upstream. The user
might get used to typing 'git fetch' and expect Git to fetch from
'origin' which would happen 50% of the time, but the other 50%, the user
would be forced to specify the remote.

This inconsistency would be simply one more to join the list of
incomprehensible quirks the user has to put up when using Git, so quite
likely (s)he simply gets used to it, only to complain later in forums or
social media, outside of the dwelling distance of the typical Git
developer.

But we can do better.

We can add a new 'fetch.default' configuration variable (one more to
join the many necessary to force Git to behave in sane manner), so the
user can specify what (s)he wants to be performed when the remote is not
specified in the 'git fetch' command.

This configuration would probably be welcome by 99% of the user
population, who have no clue what FETCH_HEAD is, and do set local
upstream branches, only to find out weird inconsistent behavior
depending on which branch the happen to be sitting at.

We add documentation and testing as expected, and also introduce other
changes necessary to make the configuration enter into effect when it's
needed.

The default (FETCH_DEFAULT_UNSPECIFIED), allows the current behavior to
be unmodified, so remote_get(NULL) is called, and the current rules to
determine the default branch remain.

The new option "simple" allows Git to always fetch from "origin", which
is what most users would expect, and it's 100% consistent.

Alternatively, the user can manually specify the current behavior with
"current" (alluding to the current branch), so that the behavior changes
depending on which branch the user happens to be sitting at. This would
allow the user to retain this behavior, if (s)he so wishes,
in case Git developers regain their sense and set a default that most
users would appreciate ("simple").

If the user wants, for whatever strange reason swimming in his/her head,
(s) can still fetch from a local ('.') remote (even stating that as an
English sentence doesn't make any sense).

  % git fetch .
  From .
   * branch            master     -> FETCH_HEAD

And to any number of weird hacks with FETCH_HEAD.

The average user lucky enough to find the 'fetch.default' configuration,
however, would never have to enter the word of "local remote"
strangeness, and would remain comfortably in the place where locals are
locals, and remotes are remotes, and 'git fetch' is always consistent,
and always does something useful.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config.txt    |  9 +++++++++
 Documentation/git-fetch.txt |  4 ++++
 builtin/fetch.c             | 10 +++++++++-
 cache.h                     |  7 +++++++
 config.c                    | 21 +++++++++++++++++++++
 environment.c               |  1 +
 t/t5513-fetch-track.sh      | 43 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6e53fc5..0c48490 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1860,6 +1860,15 @@ branches are not yet ready to be pushed out. If you are working with
 other people to push into the same shared repository, you would want
 to use one of these.
 
+fetch.default::
+	Defines the action `git fetch` should take if no remote is specified
+	on the command line. Possible values are:
++
+--
+* `current` - fetch from the upstream of the current branch.
+* `simple` - always fetch from `origin`.
+--
+
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
 	rebase. False by default.
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index e08a028..5c4afdc 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -37,6 +37,10 @@ or from several repositories at once if <group> is given and
 there is a remotes.<group> entry in the configuration file.
 (See linkgit:git-config[1]).
 
+When no remote is specified, by the default the `origin` remote will be used,
+unless there's an upstream branch configured for the current branch. This can
+be configured with `fetch.default`.
+
 OPTIONS
 -------
 include::fetch-options.txt[]
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4b6b1df..8e1a79d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -973,6 +973,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; i++)
 		strbuf_addf(&default_rla, " %s", argv[i]);
 
+	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
 
@@ -1006,7 +1007,14 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		result = fetch_multiple(&list);
 	} else if (argc == 0) {
 		/* No arguments -- use default remote */
-		remote = remote_get(NULL);
+		switch (fetch_default) {
+		case FETCH_DEFAULT_SIMPLE:
+			remote = remote_get("origin");
+			break;
+		default:
+			remote = remote_get(NULL);
+			break;
+		}
 		result = fetch_one(remote, argc, argv);
 	} else if (multiple) {
 		/* All arguments are assumed to be remotes or groups */
diff --git a/cache.h b/cache.h
index 7ce9061..bb646bb 100644
--- a/cache.h
+++ b/cache.h
@@ -603,9 +603,16 @@ enum push_default_type {
 	PUSH_DEFAULT_UNSPECIFIED
 };
 
+enum fetch_default_type {
+	FETCH_DEFAULT_UNSPECIFIED = 0,
+	FETCH_DEFAULT_SIMPLE,
+	FETCH_DEFAULT_CURRENT
+};
+
 extern enum branch_track git_branch_track;
 extern enum rebase_setup_type autorebase;
 extern enum push_default_type push_default;
+extern enum fetch_default_type fetch_default;
 
 enum object_creation_mode {
 	OBJECT_CREATION_USES_HARDLINKS = 0,
diff --git a/config.c b/config.c
index 830ee14..1ce8543 100644
--- a/config.c
+++ b/config.c
@@ -849,6 +849,24 @@ static int git_default_push_config(const char *var, const char *value)
 	return 0;
 }
 
+static int git_default_fetch_config(const char *var, const char *value)
+{
+	if (strcmp(var, "fetch.default"))
+		return 0;
+
+	if (!value)
+		return config_error_nonbool(var);
+	else if (!strcmp(value, "simple"))
+		fetch_default = FETCH_DEFAULT_SIMPLE;
+	else if (!strcmp(value, "current"))
+		fetch_default = FETCH_DEFAULT_CURRENT;
+	else {
+		error("Malformed value for %s: %s", var, value);
+		return error("Must be simple, or current.");
+	}
+	return 0;
+}
+
 static int git_default_mailmap_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "mailmap.file"))
@@ -877,6 +895,9 @@ int git_default_config(const char *var, const char *value, void *dummy)
 	if (!prefixcmp(var, "push."))
 		return git_default_push_config(var, value);
 
+	if (!prefixcmp(var, "fetch."))
+		return git_default_fetch_config(var, value);
+
 	if (!prefixcmp(var, "mailmap."))
 		return git_default_mailmap_config(var, value);
 
diff --git a/environment.c b/environment.c
index e2e75c1..f24873b 100644
--- a/environment.c
+++ b/environment.c
@@ -51,6 +51,7 @@ unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
 enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
+enum fetch_default_type fetch_default = FETCH_DEFAULT_UNSPECIFIED;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
diff --git a/t/t5513-fetch-track.sh b/t/t5513-fetch-track.sh
index 65d1e05..dcd4a8b 100755
--- a/t/t5513-fetch-track.sh
+++ b/t/t5513-fetch-track.sh
@@ -27,4 +27,47 @@ test_expect_success fetch '
 	)
 '
 
+cat >expected <<EOF
+236e830928a4295f5473416501dd777933bb778e		branch 'master' of .
+EOF
+
+test_expect_success 'fetch default' '
+	test_when_finished "rm -rf another" &&
+
+	(
+		test_create_repo another &&
+		cd another &&
+		git remote add origin .. &&
+		echo test > file &&
+		git add . &&
+		git commit -m test &&
+		git checkout -t -b local-tracking master &&
+		git fetch &&
+		test_cmp ../expected .git/FETCH_HEAD
+	)
+'
+cat >expected <<EOF
+9d34b142e42f6b3dbab46dd4b9bc515e0ab16101	not-for-merge	branch 'b-0' of ..
+9d34b142e42f6b3dbab46dd4b9bc515e0ab16101	not-for-merge	branch 'b/one' of ..
+9d34b142e42f6b3dbab46dd4b9bc515e0ab16101	not-for-merge	branch 'b1' of ..
+9d34b142e42f6b3dbab46dd4b9bc515e0ab16101	not-for-merge	branch 'master' of ..
+EOF
+
+test_expect_success 'fetch default simple' '
+	test_when_finished "rm -rf another" &&
+
+	(
+		test_create_repo another &&
+		cd another &&
+		git config fetch.default simple &&
+		git remote add origin .. &&
+		echo test > file &&
+		git add . &&
+		git commit -m test &&
+		git checkout -t -b local-tracking master &&
+		git fetch &&
+		test_cmp ../expected .git/FETCH_HEAD
+	)
+'
+
 test_done
-- 
1.8.3.rc2.542.g24820ba
