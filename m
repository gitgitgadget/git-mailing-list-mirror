Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491281C1AB5
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 22:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726180568; cv=none; b=CeFs5y43JHzPqH90XH+/hAWjW06V8sFvh9nZbvT0t0aChjh2OcSo9q4P1Wi6rMiTPgrLVgh00SyvbP+4/nXjeFVHgOVOOBiAvTIij/Ido2grJGZPCPdwMi/Fa5mQWsIjAWt2TwSPZK0PvhrK/u2ud+HxFmeDsUNOmryPQEPFmXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726180568; c=relaxed/simple;
	bh=lCBt5B6aeEAly74FtQLSqn/rSY2ZxBOai7lHH5Cwi+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ibj4zEifizwmzHYl37LAOzdmFdExMKeJYxLg99gJheT43ZZVmhyzWCexmuoPbJH7T7AZDRxSZpGIqktxspRaOBSsyI4zw1V+QwERPiUq3N7xeJ/aLsckXuFKDCI016fJ7NzLKHVW3QKjPOoaeQVLdZLvAuyvk/ZbbvkOxJOmK6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19385 invoked by uid 109); 12 Sep 2024 22:36:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Sep 2024 22:36:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29364 invoked by uid 111); 12 Sep 2024 22:36:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Sep 2024 18:36:04 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 12 Sep 2024 18:36:04 -0400
From: Jeff King <peff@peff.net>
To: Rodrigo <rodrigolive@gmail.com>
Cc: git@vger.kernel.org
Subject: [PATCH 1/2] Git.pm: fix bare repository search with Directory option
Message-ID: <20240912223604.GA650605@coredump.intra.peff.net>
References: <20240912223413.GA649897@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240912223413.GA649897@coredump.intra.peff.net>

When opening a bare repository like:

  Git->repository(Directory => '/path/to/bare.git');

we will incorrectly point the repository object at the _current_
directory, not the one specified by the option.

The bug was introduced by 20da61f25f (Git.pm: trust rev-parse to find
bare repositories, 2022-10-22). Before then, we'd ask "rev-parse
--git-dir" if it was a Git repo, and if it returned anything, we'd
correctly convert that result to an absolute path using File::Spec and
Cwd::abs_path(). If it didn't, we'd guess it might be a bare repository
and find it ourselves, which was wrong (rev-parse should find even a
bare repo, and our search circumvented some of its rules).

That commit dropped most of the custom bare-repo search code in favor of
using "rev-parse --is-bare-repository" and trusting the "--git-dir" it
returned. But it mistakenly left some of the bare-repo code path in
place, which was now broken. That code calls Cwd::abs_path($dir); prior
to 20da61f25f $dir contained the "Directory" option the user passed in.
But afterwards, it contains the output of "rev-parse --git-dir". And
since our tentative rev-parse command is invoked after changing
directory, it will always be the relative path "."! So we'll end up with
the absolute path of the process's current directory, not the Directory
option the caller asked for.

So the non-bare case is correct, but the bare one is broken. Our tests
only check the non-bare one, so we didn't notice. We can fix this by
running the same absolute-path fixup code for both sides.

Helped-by: Rodrigo <rodrigolive@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 perl/Git.pm         | 10 ++++------
 t/t9700-perl-git.sh |  3 ++-
 t/t9700/test.pl     |  5 +++++
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index aebfe0c6e0..cf1ef0b32a 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -197,11 +197,11 @@ sub repository {
 		my ($bare, $dir) = split /\n/, $out, 2;
 
 		require Cwd;
-		if ($bare ne 'true') {
-			require File::Spec;
-			File::Spec->file_name_is_absolute($dir) or $dir = $opts{Directory} . '/' . $dir;
-			$opts{Repository} = Cwd::abs_path($dir);
+		require File::Spec;
+		File::Spec->file_name_is_absolute($dir) or $dir = $opts{Directory} . '/' . $dir;
+		$opts{Repository} = Cwd::abs_path($dir);
 
+		if ($bare ne 'true') {
 			# If --git-dir went ok, this shouldn't die either.
 			my $prefix = $search->command_oneline('rev-parse', '--show-prefix');
 			$dir = Cwd::abs_path($opts{Directory}) . '/';
@@ -214,8 +214,6 @@ sub repository {
 			$opts{WorkingCopy} = $dir;
 			$opts{WorkingSubdir} = $prefix;
 
-		} else {
-			$opts{Repository} = Cwd::abs_path($dir);
 		}
 
 		delete $opts{Directory};
diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index ccc8212d73..4431697122 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -45,7 +45,8 @@ test_expect_success 'set up test repository' '
 '
 
 test_expect_success 'set up bare repository' '
-	git init --bare bare.git
+	git init --bare bare.git &&
+	git -C bare.git --work-tree=. commit --allow-empty -m "bare commit"
 '
 
 test_expect_success 'use t9700/test.pl to test Git.pm' '
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index d8e85482ab..2e1d50d4d1 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -147,6 +147,11 @@ sub adjust_dirsep {
 unlink $tmpfile3;
 chdir($abs_repo_dir);
 
+# open alternate bare repo
+my $r4 = Git->repository(Directory => "$abs_repo_dir/bare.git");
+is($r4->command_oneline(qw(log --format=%s)), "bare commit",
+	"log of bare repo works");
+
 # unquoting paths
 is(Git::unquote_path('abc'), 'abc', 'unquote unquoted path');
 is(Git::unquote_path('"abc def"'), 'abc def', 'unquote simple quoted path');
-- 
2.46.0.918.gab30941bff

