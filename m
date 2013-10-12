From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2] fetch: add new fetch.default configuration
Date: Sat, 12 Oct 2013 02:07:05 -0500
Message-ID: <1381561625-20624-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:14:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtPQ-0006OF-Bd
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754459Ab3JLHNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:13:09 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:46795 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404Ab3JLHNH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:13:07 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so2584815oag.31
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ZIuRsbgf+1LRpP+Xs9AzBAHTxi81B2tnaOBxhu0qFyk=;
        b=nheBn3I/+8tW9B5pRPkp2lyzDT7kY+qcgptEUWKfIJ8iu9KkK6QxpjFnNy9llh32Tw
         p9gxkT8qskxmjKT51781+58pyNhdVEFZtbujpTWyb48x8ZsMkE6vNi7ukFZWZ8yAK6kz
         JzZ0xvUnQ2lDKas3tK9d7jLzQzqbVzVXBVDpTpJctQyd9rltYW2zB/tFyqm6GovbJ2GJ
         CR+h7/QkvIjQKZ/fIcEuyRCjBPpk3oQq32xn7b8Uysqf/e0lwn7GWHM0wTXsKjsyGwTl
         7vcJsCteBx6tlQllsi7yWJ3VuSP07yX/U5IdyPCE/MpQ/PVc/sCMdVN1wE1kD8HoFhYs
         qS9g==
X-Received: by 10.60.56.3 with SMTP id w3mr13742156oep.37.1381561986937;
        Sat, 12 Oct 2013 00:13:06 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm28655215obb.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:13:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236033>

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
the want to fetch from, which is 'origin' in many cases, *if* they
manage to notice the '.' at all.

If the user has say, twenty branches, ten with a local upstream
(branch.<name>.remote = '.'), and ten without an upstream. The user
might get used to typing 'git fetch' and expect Git to fetch from
'origin' which would happen 50% of the time, but the other 50%, the user
would be forced to specify the remote.

This inconsistency would be simply one more to join the list of
incomprehensible quirks the user has to put up when using Git, so quite
likely he simply gets used to it, only to complain later in forums or
social media, outside of the dwelling distance of the typical Git
developer.

But we can do better.

We can add a new 'fetch.default' configuration variable (one more to
join the many necessary to force Git to behave in sane manner), so the
user can specify what she wants to be performed when the remote is not
specified in the 'git fetch' command.

This configuration would probably be welcomed by 99% of the user
population, who have no clue what FETCH_HEAD is, and do set local
upstream branches, only to find out weird inconsistent behavior
depending on which branch they happen to be sitting at.

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
allow the user to retain this behavior, if she so wishes,
in case Git developers regain their senses and set a default that most
users would appreciate ("simple").

If the user wants, for whatever strange reason swimming in his/her head,
he can still fetch from a local ('.') remote (even stating that as an
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
index ec57a15..fdf3c77 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1892,6 +1892,15 @@ to `simple`.
 
 --
 
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
index d784b2e..78aada3 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1007,6 +1007,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; i++)
 		strbuf_addf(&default_rla, " %s", argv[i]);
 
+	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
 
@@ -1040,7 +1041,14 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
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
index 85b544f..bbb8406 100644
--- a/cache.h
+++ b/cache.h
@@ -627,9 +627,16 @@ enum push_default_type {
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
index e13a7b6..5c71dfa 100644
--- a/config.c
+++ b/config.c
@@ -906,6 +906,24 @@ static int git_default_push_config(const char *var, const char *value)
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
@@ -934,6 +952,9 @@ int git_default_config(const char *var, const char *value, void *dummy)
 	if (!prefixcmp(var, "push."))
 		return git_default_push_config(var, value);
 
+	if (!prefixcmp(var, "fetch."))
+		return git_default_fetch_config(var, value);
+
 	if (!prefixcmp(var, "mailmap."))
 		return git_default_mailmap_config(var, value);
 
diff --git a/environment.c b/environment.c
index 5398c36..556d367 100644
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
1.8.4-fc
