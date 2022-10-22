Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261BEC04A95
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 22:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJVWJD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 18:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJVWJC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 18:09:02 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29CEB274B
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 15:09:00 -0700 (PDT)
Received: (qmail 21742 invoked by uid 109); 22 Oct 2022 22:09:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Oct 2022 22:09:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4757 invoked by uid 111); 22 Oct 2022 22:09:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 Oct 2022 18:09:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 Oct 2022 18:08:59 -0400
From:   Jeff King <peff@peff.net>
To:     Michael McClimon <michael@mcclimon.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] setup: allow Git.pm to do unsafe repo checking
Message-ID: <Y1Rp+7R7e+LFa5k6@coredump.intra.peff.net>
References: <20221016212236.12453-1-michael@mcclimon.org>
 <20221022011931.43992-1-michael@mcclimon.org>
 <20221022011931.43992-3-michael@mcclimon.org>
 <Y1Rdtog/XQV0YLj0@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1Rdtog/XQV0YLj0@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 22, 2022 at 05:16:38PM -0400, Jeff King wrote:

> Again, I'm not too familiar with Git.pm, but it seems it ought to be
> asking Git: are we in a valid Git repo, and if so where is it? Something
> like:
> 
>   my $git_dir = `git rev-parse --absolute-git-dir`;
>   $? and die "nope, not in a git repo";
> 
>   # later, when we run git commands, we do specify this; the script may
>   # have chdir()'d in the meantime, and we want to make sure we are
>   # referring to the same repo via the object.
>   local $ENV{GIT_DIR} = abs_path($git_dir);
>   ...run some git command...
> 
> Looking at the code, we even seem to do that first part! But if it
> returns an error, then we go on to check for a bare repository
> ourselves by looking for refs/, objects/, etc. Which is just...weird.
> 
> It feels like this try/catch should just go away:

It's a little more complicated than that, because presumably people rely
on the error handling for a missing repo to not be noisy. So here's a
polished version of what I showed, along with the tests we were
discussing earlier.

I prepared it on top of your fix in the mm/git-pm-try-catch-syntax-fix
branch. That's not strictly necessary, since my patch deletes the line
you fixed. :) But I think it's nicer to use your fix as the starting
point, since it means the test runs but produces the wrong behavior,
rather than barfing with a syntax error.

-- >8 --
Subject: [PATCH] Git.pm: trust rev-parse to find bare repositories

When initializing a repository object, we run "git rev-parse --git-dir"
to let the C version of Git find the correct directory. But curiously,
if this fails we don't automatically say "not a git repository".
Instead, we do our own pure-perl check to see if we're in a bare
repository.

This makes little sense, as rev-parse will report both bare and non-bare
directories. This logic comes from d5c7721d58 (Git.pm: Add support for
subdirectories inside of working copies, 2006-06-24), but I don't see
any reason given why we can't just rely on rev-parse. Worse, because we
treat any non-error response from rev-parse as a non-bare repository,
we'll erroneously set the object's WorkingCopy, even in a bare
repository.

But it gets worse. Since 8959555cee (setup_git_directory(): add an owner
check for the top-level directory, 2022-03-02), it's actively wrong (and
dangerous). The perl code doesn't implement the same ownership checks.
And worse, after "finding" the bare repository, it sets GIT_DIR in the
environment, which tells any subsequent Git commands that we've
confirmed the directory is OK, and to trust us. I.e., it re-opens the
vulnerability plugged by 8959555cee when using Git.pm's repository
discovery code.

We can fix this by just relying on rev-parse to tell us when we're not
in a repository, which fixes the vulnerability. Furthermore, we'll ask
its --is-bare-repository function to tell us if we're bare or not, and
rely on that.

Signed-off-by: Jeff King <peff@peff.net>
---
I didn't dig into the "oops, we set WorkingCopy" thing beyond manually
verifying that it happens. It doesn't look like its really used beyond
the wc_path() method, so it's not like it would have been breaking git
sub-commands, etc. I guess we could add a test that wc_path() returns
undef in a bare repository, though.

 perl/Git.pm         | 36 ++++++++++++++++--------------------
 t/t9700-perl-git.sh |  4 ++++
 t/t9700/test.pl     | 12 ++++++++++++
 3 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index cf15ead664..117765dc73 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -177,16 +177,27 @@ sub repository {
 		-d $opts{Directory} or throw Error::Simple("Directory not found: $opts{Directory} $!");
 
 		my $search = Git->repository(WorkingCopy => $opts{Directory});
-		my $dir;
+
+		# This rev-parse will throw an exception if we're not in a
+		# repository, which is what we want, but it's kind of noisy.
+		# Ideally we'd capture stderr and relay it, but doing so is
+		# awkward without depending on it fitting in a pipe buffer. So
+		# we just reproduce a plausible error message ourselves.
+		my $out;
 		try {
-			$dir = $search->command_oneline(['rev-parse', '--git-dir'],
-			                                STDERR => 0);
+		  # Note that "--is-bare-repository" must come first, as
+		  # --git-dir output could contain newlines.
+		  $out = $search->command([qw(rev-parse --is-bare-repository --git-dir)],
+			                  STDERR => 0);
 		} catch Git::Error::Command with {
-			$dir = undef;
+			throw Error::Simple("fatal: not a git repository: $opts{Directory}");
 		};
 
+		chomp $out;
+		my ($bare, $dir) = split /\n/, $out, 2;
+
 		require Cwd;
-		if ($dir) {
+		if ($bare ne 'true') {
 			require File::Spec;
 			File::Spec->file_name_is_absolute($dir) or $dir = $opts{Directory} . '/' . $dir;
 			$opts{Repository} = Cwd::abs_path($dir);
@@ -204,21 +215,6 @@ sub repository {
 			$opts{WorkingSubdir} = $prefix;
 
 		} else {
-			# A bare repository? Let's see...
-			$dir = $opts{Directory};
-
-			unless (-d "$dir/refs" and -d "$dir/objects" and -e "$dir/HEAD") {
-				# Mimic git-rev-parse --git-dir error message:
-				throw Error::Simple("fatal: Not a git repository: $dir");
-			}
-			my $search = Git->repository(Repository => $dir);
-			try {
-				$search->command('symbolic-ref', 'HEAD');
-			} catch Git::Error::Command with {
-				# Mimic git-rev-parse --git-dir error message:
-				throw Error::Simple("fatal: Not a git repository: $dir");
-			};
-
 			$opts{Repository} = Cwd::abs_path($dir);
 		}
 
diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 4aa5d90d32..b105d6d9d5 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -45,6 +45,10 @@ test_expect_success \
      git config --add test.pathmulti bar
      '
 
+test_expect_success 'set up bare repository' '
+	git init --bare bare.git
+'
+
 test_expect_success 'use t9700/test.pl to test Git.pm' '
 	"$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl 2>stderr &&
 	test_must_be_empty stderr
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index e046f7db76..6d753708d2 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -30,6 +30,18 @@ sub adjust_dirsep {
 # set up
 our $abs_repo_dir = cwd();
 ok(our $r = Git->repository(Directory => "."), "open repository");
+{
+	local $ENV{GIT_TEST_ASSUME_DIFFERENT_OWNER} = 1;
+	my $failed;
+
+	$failed = eval { Git->repository(Directory => $abs_repo_dir) };
+	ok(!$failed, "reject unsafe non-bare repository");
+	like($@, qr/not a git repository/i, "unsafe error message");
+
+	$failed = eval { Git->repository(Directory => "$abs_repo_dir/bare.git") };
+	ok(!$failed, "reject unsafe bare repository");
+	like($@, qr/not a git repository/i, "unsafe error message");
+}
 
 # config
 is($r->config("test.string"), "value", "config scalar: string");
-- 
2.38.1.497.g093b959162

