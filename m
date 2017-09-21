Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00F2C202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 04:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbdIUEcS (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 00:32:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:45546 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751361AbdIUEcR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 00:32:17 -0400
Received: (qmail 1003 invoked by uid 109); 21 Sep 2017 04:32:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 04:32:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18916 invoked by uid 111); 21 Sep 2017 04:32:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 00:32:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Sep 2017 00:32:15 -0400
Date:   Thu, 21 Sep 2017 00:32:15 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: [PATCH] git: add --no-optional-locks option
Message-ID: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes, this is an adaptation of your 67e5ce7f63 (status: offer *not*
to lock the index and update it, 2016-08-12). Folks working on GitHub
Desktop complained to me that it's only available on Windows. :)

I expanded the scope a bit to let us give the same treatment to more
commands in the long run.  I'd also be OK with just cherry-picking your
patch to non-Windows Git if you don't find my reasoning below
compelling. But I think we need _something_ like this, as the other
solutions I could come up with don't seem very promising.

-Peff

-- >8 --
Some tools like IDEs or fancy editors may periodically run
commands like "git status" in the background to keep track
of the state of the repository. Some of these commands may
refresh the index and write out the result in an
opportunistic way: if they can get the index lock, then they
update the on-disk index with any updates they find. And if
not, then their in-core refresh is lost and just has to be
recomputed by the next caller.

But taking the index lock may conflict with other operations
in the repository. Especially ones that the user is doing
themselves, which _aren't_ opportunistic. In other words,
"git status" knows how to back off when somebody else is
holding the lock, but other commands don't know that status
would be happy to drop the lock if somebody else wanted it.

There are a couple possible solutions:

  1. Have some kind of "pseudo-lock" that allows other
     commands to tell status that they want the lock.

     This is likely to be complicated and error-prone to
     implement (and maybe even impossible with just
     dotlocks to work from, as it requires some
     inter-process communication).

  2. Avoid background runs of commands like "git status"
     that want to do opportunistic updates, preferring
     instead plumbing like diff-files, etc.

     This is awkward for a couple of reasons. One is that
     "status --porcelain" reports a lot more about the
     repository state than is available from individual
     plumbing commands. And two is that we actually _do_
     want to see the refreshed index. We just don't want to
     take a lock or write out the result. Whereas commands
     like diff-files expect us to refresh the index
     separately and write it to disk so that they can depend
     on the result. But that write is exactly what we're
     trying to avoid.

  3. Ask "status" not to lock or write the index.

     This is easy to implement. The big downside is that any
     work done in refreshing the index for such a call is
     lost when the process exits. So a background process
     may end up re-hashing a changed file multiple times
     until the user runs a command that does an index
     refresh themselves.

This patch implements the option 3. The idea (and the test)
is largely stolen from a Git for Windows patch by Johannes
Schindelin, 67e5ce7f63 (status: offer *not* to lock the
index and update it, 2016-08-12). The twist here is that
instead of making this an option to "git status", it becomes
a "git" option and matching environment variable.

The reason there is two-fold:

  1. An environment variable is carried through to
     sub-processes. And whether an invocation is a
     background process or not should apply to the whole
     process tree. So you could do "git --no-optional-locks
     foo", and if "foo" is a script or alias that calls
     "status", you'll still get the effect.

  2. There may be other programs that want the same
     treatment.

     I've punted here on finding more callers to convert,
     since "status" is the obvious one to call as a repeated
     background job. But "git diff"'s opportunistic refresh
     of the index may be a good candidate.

The test is taken from 67e5ce7f63, and it's worth repeating
Johannes's explanation:

  Note that the regression test added in this commit does
  not *really* verify that no index.lock file was written;
  that test is not possible in a portable way. Instead, we
  verify that .git/index is rewritten *only* when `git
  status` is run without `--no-optional-locks`.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git.txt | 13 +++++++++++++
 builtin/commit.c      |  5 ++++-
 cache.h               |  6 ++++++
 environment.c         |  5 +++++
 git.c                 |  4 ++++
 t/t7508-status.sh     | 10 ++++++++++
 6 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 6e3a6767e5..8dd3ae05ae 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -159,6 +159,10 @@ foo.bar= ...`) sets `foo.bar` to the empty string which ` git config
 	Add "icase" magic to all pathspec. This is equivalent to setting
 	the `GIT_ICASE_PATHSPECS` environment variable to `1`.
 
+--no-optional-locks::
+	Do not perform optional operations that require locks. This is
+	equivalent to setting the `GIT_OPTIONAL_LOCKS` to `0`.
+
 GIT COMMANDS
 ------------
 
@@ -697,6 +701,15 @@ of clones and fetches.
 	which feed potentially-untrusted URLS to git commands.  See
 	linkgit:git-config[1] for more details.
 
+`GIT_OPTIONAL_LOCKS`::
+	If set to `0`, Git will avoid performing any operations which
+	require taking a lock and which are not required to complete the
+	requested operation. For example, this will prevent `git status`
+	from refreshing the index as a side effect. This is useful for
+	processes running in the background which do not want to cause
+	lock contention with other operations on the repository.
+	Defaults to `1`.
+
 Discussion[[Discussion]]
 ------------------------
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 58f9747c2f..fafd492029 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1387,7 +1387,10 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	read_cache_preload(&s.pathspec);
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, &s.pathspec, NULL, NULL);
 
-	fd = hold_locked_index(&index_lock, 0);
+	if (use_optional_locks())
+		fd = hold_locked_index(&index_lock, 0);
+	else
+		fd = -1;
 
 	s.is_initial = get_oid(s.reference, &oid) ? 1 : 0;
 	if (!s.is_initial)
diff --git a/cache.h b/cache.h
index a916bc79e3..fea400c5ec 100644
--- a/cache.h
+++ b/cache.h
@@ -443,6 +443,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_NOGLOB_PATHSPECS_ENVIRONMENT "GIT_NOGLOB_PATHSPECS"
 #define GIT_ICASE_PATHSPECS_ENVIRONMENT "GIT_ICASE_PATHSPECS"
 #define GIT_QUARANTINE_ENVIRONMENT "GIT_QUARANTINE_PATH"
+#define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
 
 /*
  * This environment variable is expected to contain a boolean indicating
@@ -782,6 +783,11 @@ extern int protect_ntfs;
  */
 extern int ref_paranoia;
 
+/*
+ * Returns the boolean value of $GIT_OPTIONAL_LOCKS (or the default value).
+ */
+int use_optional_locks(void);
+
 /*
  * The character that begins a commented line in user-editable file
  * that is subject to stripspace.
diff --git a/environment.c b/environment.c
index f1f934b6fd..8289c25b44 100644
--- a/environment.c
+++ b/environment.c
@@ -338,3 +338,8 @@ void reset_shared_repository(void)
 {
 	need_shared_repository_from_config = 1;
 }
+
+int use_optional_locks(void)
+{
+	return git_env_bool(GIT_OPTIONAL_LOCKS_ENVIRONMENT, 1);
+}
diff --git a/git.c b/git.c
index f31dca6962..9e96dd4090 100644
--- a/git.c
+++ b/git.c
@@ -182,6 +182,10 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			setenv(GIT_ICASE_PATHSPECS_ENVIRONMENT, "1", 1);
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "--no-optional-locks")) {
+			setenv(GIT_OPTIONAL_LOCKS_ENVIRONMENT, "0", 1);
+			if (envchanged)
+				*envchanged = 1;
 		} else if (!strcmp(cmd, "--shallow-file")) {
 			(*argv)++;
 			(*argc)--;
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 43d19a9b22..93f162a4f7 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1670,4 +1670,14 @@ test_expect_success '"Initial commit" should not be noted in commit template' '
 	test_i18ngrep ! "Initial commit" output
 '
 
+test_expect_success '--no-optional-locks prevents index update' '
+	test-chmtime =1234567890 .git/index &&
+	git --no-optional-locks status &&
+	test-chmtime -v +0 .git/index >out &&
+	grep ^1234567890 out &&
+	git status &&
+	test-chmtime -v +0 .git/index >out &&
+	! grep ^1234567890 out
+'
+
 test_done
-- 
2.14.1.1040.gcaf8795f39
