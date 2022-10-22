Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61196C433FE
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 21:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJVVQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 17:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJVVQl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 17:16:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746609DDAF
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 14:16:39 -0700 (PDT)
Received: (qmail 21388 invoked by uid 109); 22 Oct 2022 21:16:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Oct 2022 21:16:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4173 invoked by uid 111); 22 Oct 2022 21:16:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 Oct 2022 17:16:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 Oct 2022 17:16:38 -0400
From:   Jeff King <peff@peff.net>
To:     Michael McClimon <michael@mcclimon.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] setup: allow Git.pm to do unsafe repo checking
Message-ID: <Y1Rdtog/XQV0YLj0@coredump.intra.peff.net>
References: <20221016212236.12453-1-michael@mcclimon.org>
 <20221022011931.43992-1-michael@mcclimon.org>
 <20221022011931.43992-3-michael@mcclimon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221022011931.43992-3-michael@mcclimon.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 09:19:32PM -0400, Michael McClimon wrote:

> diff --git a/perl/Git.pm b/perl/Git.pm
> index cf15ead6..002c29bb 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -1674,6 +1674,7 @@ sub _cmd_exec {
>  sub _setup_git_cmd_env {
>  	my $self = shift;
>  	if ($self) {
> +		$ENV{GIT_PERL_FORCE_OWNERSHIP_CHECK} = 1;
>  		$self->repo_path() and $ENV{'GIT_DIR'} = $self->repo_path();
>  		$self->repo_path() and $self->wc_path()
>  			and $ENV{'GIT_WORK_TREE'} = $self->wc_path();

I'm not familiar enough with Git.pm to know if this is the right spot.
But we'd not want to break the case where GIT_DIR is set already. I.e.:

  GIT_DIR=/path/to/repo.git perl -MGit -e 'Git->repository'

should continue to work regardless of the ownership of repo.git. Only
the repo-discovery phase would want to force the ownership check.

Again, I'm not too familiar with Git.pm, but it seems it ought to be
asking Git: are we in a valid Git repo, and if so where is it? Something
like:

  my $git_dir = `git rev-parse --absolute-git-dir`;
  $? and die "nope, not in a git repo";

  # later, when we run git commands, we do specify this; the script may
  # have chdir()'d in the meantime, and we want to make sure we are
  # referring to the same repo via the object.
  local $ENV{GIT_DIR} = abs_path($git_dir);
  ...run some git command...

Looking at the code, we even seem to do that first part! But if it
returns an error, then we go on to check for a bare repository
ourselves by looking for refs/, objects/, etc. Which is just...weird.

It feels like this try/catch should just go away:

diff --git a/perl/Git.pm b/perl/Git.pm
index cf15ead664..7a7d8a2987 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -177,13 +177,7 @@ sub repository {
 		-d $opts{Directory} or throw Error::Simple("Directory not found: $opts{Directory} $!");
 
 		my $search = Git->repository(WorkingCopy => $opts{Directory});
-		my $dir;
-		try {
-			$dir = $search->command_oneline(['rev-parse', '--git-dir'],
-			                                STDERR => 0);
-		} catch Git::Error::Command with {
-			$dir = undef;
-		};
+		my $dir = $search->command_oneline(['rev-parse', '--git-dir']);
 
 		require Cwd;
 		if ($dir) {

And then the code below that to check for bare/not-bare should be using
"git rev-parse --is-bare-repository" or similar. Something like:

diff --git a/perl/Git.pm b/perl/Git.pm
index 7a7d8a2987..280df9cee1 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -179,8 +179,14 @@ sub repository {
 		my $search = Git->repository(WorkingCopy => $opts{Directory});
 		my $dir = $search->command_oneline(['rev-parse', '--git-dir']);
 
+		# could be merged with command above to be more efficient; or
+		# could probably use --show-toplevel to avoid prefix query
+		# below
+		my $bare = $search->command_oneline(['rev-parse', '--is-bare-repository'])
+		             eq 'true';
+
 		require Cwd;
-		if ($dir) {
+		if (!$bare) {
 			require File::Spec;
 			File::Spec->file_name_is_absolute($dir) or $dir = $opts{Directory} . '/' . $dir;
 			$opts{Repository} = Cwd::abs_path($dir);
@@ -198,21 +204,6 @@ sub repository {
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
 

But given how much more complicated the current code is, I wonder if I
am missing some case. Or perhaps this code is just so old that it used
to do this stuff itself (because rev-parse didn't give us so much help).

-Peff
