From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Revert "rev-parse: remove restrictions on some
 options"
Date: Mon, 29 Feb 2016 06:01:56 -0500
Message-ID: <20160229110156.GA29697@sigill.intra.peff.net>
References: <20160226232507.GA9404@sigill.intra.peff.net>
 <20160226232957.GB9552@sigill.intra.peff.net>
 <20160226233449.GA9622@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 29 12:02:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaLaX-0002re-Lq
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 12:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbcB2LCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 06:02:00 -0500
Received: from cloud.peff.net ([50.56.180.127]:51294 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752611AbcB2LB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 06:01:59 -0500
Received: (qmail 13235 invoked by uid 102); 29 Feb 2016 11:01:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 06:01:59 -0500
Received: (qmail 24764 invoked by uid 107); 29 Feb 2016 11:02:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 06:02:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Feb 2016 06:01:56 -0500
Content-Disposition: inline
In-Reply-To: <20160226233449.GA9622@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287823>

On Fri, Feb 26, 2016 at 06:34:49PM -0500, Jeff King wrote:

> > So any implementation would probably have to either:
> > 
> >   - make two passes over the options, first figuring out
> >     whether we need a git-dir, and then actually handling
> >     the options. That's possible, but it's probably not
> >     worth the trouble.
> > 
> >   - call setup_git_directory() on the fly when an option
> >     needs it; that requires annotating all of the options,
> >     and there are a considerable number of them.
> 
> Having just sent this, of course, it occurs to me that a loop like:
> 
>    setup_git_directory_gently(&nongit);
>    for (i = 0; i < argc; i++) {
>   	if (!strcmp(argv[i], "--local-env-vars"))
>   	... and other nongit-ok options ...
>   
>   	if (nongit)
>   		die("need a repo");
>   
>   	if (!strcmp(argv[i], "--git-dir"))
>   	... and other options ...
>    }

Actually, it is even easier than that. Those options don't care whether
they are in a repo or not, so we can just wait to call
setup_git_directory() in the loop.

IOW, I think my 2/2 should be replaced with this:

-- >8 --
Subject: [PATCH] rev-parse: let some options run outside repository

Once upon a time, you could use "--local-env-vars" and
"--resolve-git-dir" outside of any git repository, but they
had to come first on the command line. Commit 68889b4
(rev-parse: remove restrictions on some options, 2013-07-21)
put them into the normal option-parsing loop, fixing the
latter. But it inadvertently broke the former, as we call
setup_git_directory() before starting that loop.

We can note that those options don't care even conditionally
about whether we are in a git repo. So it's fine if we
simply wait to setup the repo until we see an option that
needs it.

However, there is one special exception we should make:
historically, rev-parse will set up the repository and read
config even if there are _no_ options. Some of the
tests in t1300 rely on this to check "git -c $config"
parsing. That's not mirroring real-world use, and we could
tweak the test.  But t0002 uses a bare "git rev-parse" to
check "are we in a git repository?". It's plausible that
real-world scripts are relying on this.

So let's cover this case specially, and treat an option-less
"rev-parse" as "see if we're in a repo".

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-parse.c               | 50 +++++++++++++++++++++++++--------------
 t/t1515-rev-parse-outside-repo.sh |  4 ++--
 2 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index cf8487b..c961b74 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -505,6 +505,7 @@ N_("git rev-parse --parseopt [<options>] -- [<args>...]\n"
 int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 {
 	int i, as_is = 0, verify = 0, quiet = 0, revs_count = 0, type = 0;
+	int did_repo_setup = 0;
 	int has_dashdash = 0;
 	int output_prefix = 0;
 	unsigned char sha1[20];
@@ -528,11 +529,40 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	prefix = setup_git_directory();
-	git_config(git_default_config, NULL);
+	/* No options; just report on whether we're in a git repo or not. */
+	if (argc == 1) {
+		setup_git_directory();
+		git_config(git_default_config, NULL);
+		return 0;
+	}
+
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
+		if (!strcmp(arg, "--local-env-vars")) {
+			int i;
+			for (i = 0; local_repo_env[i]; i++)
+				printf("%s\n", local_repo_env[i]);
+			continue;
+		}
+		if (!strcmp(arg, "--resolve-git-dir")) {
+			const char *gitdir = argv[++i];
+			if (!gitdir)
+				die("--resolve-git-dir requires an argument");
+			gitdir = resolve_gitdir(gitdir);
+			if (!gitdir)
+				die("not a gitdir '%s'", argv[i]);
+			puts(gitdir);
+			continue;
+		}
+
+		/* The rest of the options require a git repository. */
+		if (!did_repo_setup) {
+			prefix = setup_git_directory();
+			git_config(git_default_config, NULL);
+			did_repo_setup = 1;
+		}
+
 		if (!strcmp(arg, "--git-path")) {
 			if (!argv[i + 1])
 				die("--git-path requires an argument");
@@ -706,12 +736,6 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
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
@@ -767,16 +791,6 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
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
2.8.0.rc0.276.gddf4100
