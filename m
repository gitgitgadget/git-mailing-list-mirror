From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] Revert "rev-parse: remove restrictions on some options"
Date: Fri, 26 Feb 2016 18:29:57 -0500
Message-ID: <20160226232957.GB9552@sigill.intra.peff.net>
References: <20160226232507.GA9404@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 00:30:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZRpo-0006wu-42
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 00:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193AbcBZXaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 18:30:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:50424 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752176AbcBZXaA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 18:30:00 -0500
Received: (qmail 9497 invoked by uid 102); 26 Feb 2016 23:30:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 18:30:00 -0500
Received: (qmail 8855 invoked by uid 107); 26 Feb 2016 23:30:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 18:30:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2016 18:29:57 -0500
Content-Disposition: inline
In-Reply-To: <20160226232507.GA9404@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287636>

This reverts commit 68889b416d5b6a5cf7d280a428281d635fe9b292.

That commit bumped some rev-parse options into the main
option-parsing loop, which meant that they no longer had to
come at the very beginning of the option list. However, that
also means that they now came after our call to
setup_git_directory(), and will no longer run outside of a
git repository.

For --local-env-vars, this is semi-questionable. The main
use of that option is to get a list of environment variables
to clear, and if you are not in a repository, there
_probably_ isn't anything to clear. But it places an
unnecessary restriction on callers who may be using it
preemptively.

For --resolve-git-dir, it is almost certainly a regression.
That option is about finding a git dir in the first place,
so it is reasonably likely to be called from outside an
existing repository.

The best solution here would be to have a full parsing loop
that handles all options, but only calls setup_git_directory
as appropriate. Unfortunately, that's a bit complicated to
implement. We _have_ to handle each option in the order it
appears on the command line. If the caller asked for:

  git rev-parse --resolve-git-dir foo/.git --show-toplevel

then it must receive the two lines of output in the correct
to know which is which. But asking for:

  git rev-parse --show-toplevel --resolve-git-dir foo/.git

is weird; we have to setup_git_directory() for the first
option.

So any implementation would probably have to either:

  - make two passes over the options, first figuring out
    whether we need a git-dir, and then actually handling
    the options. That's possible, but it's probably not
    worth the trouble.

  - call setup_git_directory() on the fly when an option
    needs it; that requires annotating all of the options,
    and there are a considerable number of them.

The original patch was not spurred by an actual bug report,
but by an observation[1] that was essentially "eh, this
looks unnecessarily restrictive". It _is_ restrictive, but
it turns out to be necessarily so. :)

And in practice, it is unlikely anybody was bothered by the
restriction. It's not really sane to use --local-env-vars
with other options, anyway, as it produces unbounded output
(so the caller only know it ends at EOF). It's more
plausible for --resolve-git-dir to be used with other
options, but still unlikely. It's main use is accessing
_other_ repositories (e.g., submodules), so making a query
on the main repository at the same time isn't very useful.

This patch therefore just reverts 68889b416, with a few
caveats:

  1. Since the original change, --resolve-git-dir learned to
     avoid segfaulting on a bogus. We don't know need to
     backport that, because the "restricted" form checks
     argc.

  2. The original patch mentioned that we didn't need to
     clean up any documentation, because the restriction
     wasn't documented. We can at least fix that by
     mentioning the restriction in the manpage.

  3. We can now mark our newly-added tests as passing. :)

[1] http://article.gmane.org/gmane.comp.version-control.git/230849

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-rev-parse.txt   | 27 ++++++++++++++-------------
 builtin/rev-parse.c               | 31 +++++++++++++++----------------
 t/t1515-rev-parse-outside-repo.sh |  4 ++--
 3 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index b6c6326..0f2bb9b 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -28,7 +28,8 @@ OPTIONS
 Operation Modes
 ~~~~~~~~~~~~~~~
 
-Each of these options must appear first on the command line.
+Each of these options must appear first on the command line; they do not
+need to be run in a git repository.
 
 --parseopt::
 	Use 'git rev-parse' in option parsing mode (see PARSEOPT section below).
@@ -38,6 +39,18 @@ Each of these options must appear first on the command line.
 	section below). In contrast to the `--sq` option below, this
 	mode does only quoting. Nothing else is done to command input.
 
+--local-env-vars::
+	List the GIT_* environment variables that are local to the
+	repository (e.g. GIT_DIR or GIT_WORK_TREE, but not GIT_EDITOR).
+	Only the names of the variables are listed, not their value,
+	even if they are set.
+
+--resolve-git-dir <path>::
+	Check if <path> is a valid repository or a gitfile that
+	points at a valid repository, and print the location of the
+	repository.  If <path> is a gitfile then the resolved path
+	to the real repository is printed.
+
 Options for --parseopt
 ~~~~~~~~~~~~~~~~~~~~~~
 
@@ -201,12 +214,6 @@ explicitly.
 Options for Files
 ~~~~~~~~~~~~~~~~~
 
---local-env-vars::
-	List the GIT_* environment variables that are local to the
-	repository (e.g. GIT_DIR or GIT_WORK_TREE, but not GIT_EDITOR).
-	Only the names of the variables are listed, not their value,
-	even if they are set.
-
 --git-dir::
 	Show `$GIT_DIR` if defined. Otherwise show the path to
 	the .git directory. The path shown, when relative, is
@@ -230,12 +237,6 @@ print a message to stderr and exit with nonzero status.
 --is-bare-repository::
 	When the repository is bare print "true", otherwise "false".
 
---resolve-git-dir <path>::
-	Check if <path> is a valid repository or a gitfile that
-	points at a valid repository, and print the location of the
-	repository.  If <path> is a gitfile then the resolved path
-	to the real repository is printed.
-
 --git-path <path>::
 	Resolve "$GIT_DIR/<path>" and takes other path relocation
 	variables such as $GIT_OBJECT_DIRECTORY,
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index cf8487b..ccc0328 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -518,6 +518,21 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 	if (argc > 1 && !strcmp("--sq-quote", argv[1]))
 		return cmd_sq_quote(argc - 2, argv + 2);
 
+	if (argc == 2 && !strcmp("--local-env-vars", argv[1])) {
+		int i;
+		for (i = 0; local_repo_env[i]; i++)
+			printf("%s\n", local_repo_env[i]);
+		return 0;
+	}
+
+	if (argc > 2 && !strcmp(argv[1], "--resolve-git-dir")) {
+		const char *gitdir = resolve_gitdir(argv[2]);
+		if (!gitdir)
+			die("not a gitdir '%s'", argv[2]);
+		puts(gitdir);
+		return 0;
+	}
+
 	if (argc > 1 && !strcmp("-h", argv[1]))
 		usage(builtin_rev_parse_usage);
 
@@ -706,12 +721,6 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				add_ref_exclusion(&ref_excludes, arg + 10);
 				continue;
 			}
-			if (!strcmp(arg, "--local-env-vars")) {
-				int i;
-				for (i = 0; local_repo_env[i]; i++)
-					printf("%s\n", local_repo_env[i]);
-				continue;
-			}
 			if (!strcmp(arg, "--show-toplevel")) {
 				const char *work_tree = get_git_work_tree();
 				if (work_tree)
@@ -767,16 +776,6 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				puts(prefix_filename(pfx, strlen(pfx), get_git_common_dir()));
 				continue;
 			}
-			if (!strcmp(arg, "--resolve-git-dir")) {
-				const char *gitdir = argv[++i];
-				if (!gitdir)
-					die("--resolve-git-dir requires an argument");
-				gitdir = resolve_gitdir(gitdir);
-				if (!gitdir)
-					die("not a gitdir '%s'", argv[i]);
-				puts(gitdir);
-				continue;
-			}
 			if (!strcmp(arg, "--is-inside-git-dir")) {
 				printf("%s\n", is_inside_git_dir() ? "true"
 						: "false");
diff --git a/t/t1515-rev-parse-outside-repo.sh b/t/t1515-rev-parse-outside-repo.sh
index ae33093..3ec2971 100755
--- a/t/t1515-rev-parse-outside-repo.sh
+++ b/t/t1515-rev-parse-outside-repo.sh
@@ -27,14 +27,14 @@ test_expect_success 'rev-parse --sq-quote' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'rev-parse --local-env-vars' '
+test_expect_success 'rev-parse --local-env-vars' '
 	git rev-parse --local-env-vars >actual &&
 	# we do not want to depend on the complete list here,
 	# so just look for something plausible
 	grep ^GIT_DIR actual
 '
 
-test_expect_failure 'rev-parse --resolve-git-dir' '
+test_expect_success 'rev-parse --resolve-git-dir' '
 	git init --separate-git-dir repo dir &&
 	test_must_fail git rev-parse --resolve-git-dir . &&
 	echo "$(pwd)/repo" >expect &&
-- 
2.7.2.767.g705917e
