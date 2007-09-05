From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC/PATCH] git-svn: add support for --first-parent
Date: Wed, 5 Sep 2007 03:19:29 -0700
Message-ID: <20070905101929.GB11074@soma>
References: <1188984929315-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 12:19:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISryz-00024o-Fp
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 12:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755454AbXIEKTc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 06:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755812AbXIEKTb
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 06:19:31 -0400
Received: from hand.yhbt.net ([66.150.188.102]:56241 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755018AbXIEKTa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 06:19:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 028047F4110;
	Wed,  5 Sep 2007 03:19:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1188984929315-git-send-email-hjemli@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57708>

Lars Hjemli <hjemli@gmail.com> wrote:
> When git-svn uses git-log to find embedded 'git-svn-id'-lines in commit
> messages, it can get confused when local history contains merges with
> other git-svn branches. But if --first-parent is supplied to git-log,
> working_head_info() will only see 'branch-local' commits and thus the
> first commit containing a 'git-svn-id' line should refer to the correct
> subversion branch.
> 
> Signed-off-by: Lars Hjemli <hjemli@gmail.com>
> ---
> 
> This passes the test-suite and I've used it to correctly dcommit against a
> real-life repository after merging subversion-branches in git ('dcommit -n'
> reported the wrong subversion branch while 'dcommit -n --first-parent' got
> it right, so I did 'dcommit --first-parent' and then inspected the logs and
> diffs in the subversion repo and everything looked swell).
> 
> But I'm not a perl person, my understanding of git-svn is limited and the
> use of --first-parent may not be the right solution to the problem...

At first glance this seems reasonable.  I didn't know about git-log
--first-parent until now, but it seems like a good 80% solution.

Ideally, we'd probably stop, say something and give the user the choice
of branches if multiple parents available.

Acked-by-for-next-or-pu: Eric Wong <normalperson@yhbt.net>

>  Documentation/git-svn.txt |   10 ++++++++++
>  git-svn.perl              |   17 +++++++++++++----
>  2 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index be2e34e..42d7b82 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -317,6 +317,16 @@ This is only used with the 'dcommit' command.
>  Print out the series of git arguments that would show
>  which diffs would be committed to SVN.
>  
> +--first-parent::
> +
> +This is only used with the 'dcommit', 'rebase', 'log', 'find-rev' and
> +'show-ignore' commands.
> +
> +These commands tries to detect the upstream subversion branch by means of
> +the embedded 'git-svn-id' line in commit messages. When --first-parent is
> +specified, git-svn only follows the first parent of each commit, effectively
> +ignoring commits brought into the current branch through merge-operations.
> +
>  --
>  
>  ADVANCED OPTIONS
> diff --git a/git-svn.perl b/git-svn.perl
> index d3c8cd0..d21eb7f 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -59,7 +59,7 @@ my ($_stdin, $_help, $_edit,
>  	$_template, $_shared,
>  	$_version, $_fetch_all, $_no_rebase,
>  	$_merge, $_strategy, $_dry_run, $_local,
> -	$_prefix, $_no_checkout, $_verbose);
> +	$_prefix, $_no_checkout, $_verbose, $_first_parent);
>  $Git::SVN::_follow_parent = 1;
>  my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
>                      'config-dir=s' => \$Git::SVN::Ra::config_dir,
> @@ -119,12 +119,15 @@ my %cmd = (
>  			  'dry-run|n' => \$_dry_run,
>  			  'fetch-all|all' => \$_fetch_all,
>  			  'no-rebase' => \$_no_rebase,
> +			  'first-parent' => \$_first_parent,
>  			%cmt_opts, %fc_opts } ],
>  	'set-tree' => [ \&cmd_set_tree,
>  	                "Set an SVN repository to a git tree-ish",
>  			{ 'stdin|' => \$_stdin, %cmt_opts, %fc_opts, } ],
>  	'show-ignore' => [ \&cmd_show_ignore, "Show svn:ignore listings",
> -			{ 'revision|r=i' => \$_revision } ],
> +			{ 'revision|r=i' => \$_revision,
> +			  'first-parent' => \$_first_parent
> +			} ],
>  	'multi-fetch' => [ \&cmd_multi_fetch,
>  	                   "Deprecated alias for $0 fetch --all",
>  			   { 'revision|r=s' => \$_revision, %fc_opts } ],
> @@ -145,15 +148,19 @@ my %cmd = (
>  			  'authors-file|A=s' => \$_authors,
>  			  'color' => \$Git::SVN::Log::color,
>  			  'pager=s' => \$Git::SVN::Log::pager,
> +			  'first-parent' => \$_first_parent
>  			} ],
>  	'find-rev' => [ \&cmd_find_rev, "Translate between SVN revision numbers and tree-ish",
> -			{ } ],
> +			{
> +			  'first-parent' => \$_first_parent
> +			} ],
>  	'rebase' => [ \&cmd_rebase, "Fetch and rebase your working directory",
>  			{ 'merge|m|M' => \$_merge,
>  			  'verbose|v' => \$_verbose,
>  			  'strategy|s=s' => \$_strategy,
>  			  'local|l' => \$_local,
>  			  'fetch-all|all' => \$_fetch_all,
> +			  'first-parent' => \$_first_parent,
>  			  %fc_opts } ],
>  	'commit-diff' => [ \&cmd_commit_diff,
>  	                   'Commit a diff between two trees',
> @@ -811,7 +818,9 @@ sub cmt_metadata {
>  
>  sub working_head_info {
>  	my ($head, $refs) = @_;
> -	my ($fh, $ctx) = command_output_pipe('log', '--no-color', $head);
> +	my @args = ('log', '--no-color');
> +	push @args, '--first-parent' if $_first_parent;
> +	my ($fh, $ctx) = command_output_pipe(@args, $head);
>  	my $hash;
>  	my %max;
>  	while (<$fh>) {

-- 
Eric Wong
