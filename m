From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: teach to create and operate on bare
	repositories
Date: Tue, 21 Apr 2009 11:01:01 -0700
Message-ID: <20090421180101.GA16642@dcvr.yhbt.net>
References: <lGoUDENjg0Z+sDE9v/txzTLyfk8@7qgLKkvX/1U6eu9avhKQpU/1pEI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Tue Apr 21 20:05:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwKJA-0003fN-K2
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 20:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757073AbZDUSBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 14:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756055AbZDUSBF
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 14:01:05 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57191 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757075AbZDUSBD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 14:01:03 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E70C1F799;
	Tue, 21 Apr 2009 18:01:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <lGoUDENjg0Z+sDE9v/txzTLyfk8@7qgLKkvX/1U6eu9avhKQpU/1pEI>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117142>

Eygene Ryabinkin <rea-git@codelabs.ru> wrote:
> This mode is useful when we're mirrorring one-to-one Subversion and Git
> repositories and then using Git as the repository to base other work on.
> 
> Bare mode is currently restricted only to init, clone, fetch, log,
> find-rev, show-ignore, show-externals, create-ignore, propget, proplist
> and info commands.  Others won't work at all and error message will
> be produced.

Hi Eygene,

This definitely seems useful.  I'd like a basic test to ensure it
continues working in the future.

More comments inline.

> Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>

> index c5965c9..4756abf 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -63,13 +63,14 @@ $sha1 = qr/[a-f\d]{40}/;
>  $sha1_short = qr/[a-f\d]{4,40}/;
>  my ($_stdin, $_help, $_edit,
>  	$_message, $_file,
> -	$_template, $_shared,
> +	$_template, $_shared, $_bare,
>  	$_version, $_fetch_all, $_no_rebase, $_fetch_parent,
>  	$_merge, $_strategy, $_dry_run, $_local,
>  	$_prefix, $_no_checkout, $_url, $_verbose,
>  	$_git_format, $_commit_url, $_tag);
>  $Git::SVN::_follow_parent = 1;
>  $_q ||= 0;
> +$_bare = 0;
>  my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
>                      'config-dir=s' => \$Git::SVN::Ra::config_dir,
>                      'no-auth-cache' => \$Git::SVN::Prompt::_no_auth_cache,

>  }
>  
>  sub do_git_init_db {
> -	unless (-d $ENV{GIT_DIR}) {
> +	unless (-d $ENV{GIT_DIR} && !$_bare) {
>  		my @init_db = ('init');
>  		push @init_db, "--template=$_template" if defined $_template;
>  		if (defined $_shared) {
> @@ -325,8 +327,15 @@ sub do_git_init_db {
>  				push @init_db, "--shared";
>  			}
>  		}
> +		push @init_db, "--bare" if $_bare;
>  		command_noisy(@init_db);
> -		$_repository = Git->repository(Repository => ".git");
> +		if ($_bare && -d $ENV{GIT_DIR}) {
> +			$_repository =
> +			    Git->repository(Repository => $ENV{GIT_DIR});
> +		} else {
> +			$_repository =
> +			    Git->repository(Repository => ".git");
> +		}
>  	}
>  	command_noisy('config', 'core.autocrlf', 'false');
>  	my $set;
> @@ -344,9 +353,20 @@ sub do_git_init_db {
>  
>  sub init_subdir {
>  	my $repo_path = shift or return;
> +	my $full_path;
> +	if ($repo_path =~ /^\//) {
> +		$full_path = $repo_path;
> +	} else {
> +		use POSIX qw(getcwd);
> +		$full_path = POSIX::getcwd() . "/" . $repo_path;
> +	}
>  	mkpath([$repo_path]) unless -d $repo_path;
>  	chdir $repo_path or die "Couldn't chdir to $repo_path: $!\n";
> -	$ENV{GIT_DIR} = '.git';
> +	if (!$_bare) {
> +		$ENV{GIT_DIR} = $full_path . '/.git';
> +	} else {
> +		$ENV{GIT_DIR} = $full_path;
> +	}
>  	$_repository = Git->repository(Repository => $ENV{GIT_DIR});
>  }
>  
> @@ -389,6 +409,7 @@ sub cmd_fetch {
>  	if (@_ > 1) {
>  		die "Usage: $0 fetch [--all] [--parent] [svn-remote]\n";
>  	}
> +	get_bareness();
>  	if ($_fetch_parent) {
>  		my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
>  		unless ($gs) {
> @@ -408,6 +429,12 @@ sub cmd_fetch {
>  
>  sub cmd_set_tree {
>  	my (@commits) = @_;
> +
> +	get_bareness();
> +	if ($_bare) {
> +		fatal("'set-tree' isn't supported for bare repositories.");
> +	}
> +

This repetition with get_bareness() and then checking for $_bare all
over the place bothers me a bit.  I'd rather just have something like
this:

	fatal_if_bare('set-tree');

Or even:

	fatal_if_bare($cmd);

> +# Initialize bareness flag for an existing repository
> +sub get_bareness {
> +	return unless -d $ENV{GIT_DIR};
> +	my $result = Git::config_bool('core.bare');
> +	$result = 0 unless defined($result);
> +	$_bare = $result;
> +}

Perhaps this function can go into Git.pm since core.bare affects all
of git, not just git-svn.  I'd also like to just use something like

	if (Git::config_bare()) { ... }

...rather than having to check/initialize a variable every time.

Of course, we can have config caching for platforms that really need
it done via Sam's Git::Config module when it gets merged.

>  sub extract_metadata {
>  	my $id = shift or return (undef, undef, undef);
>  	my ($url, $rev, $uuid) = ($id =~ /^\s*git-svn-id:\s+(.*)\@(\d+)
> @@ -1527,6 +1588,51 @@ sub parse_revision_argument {
>  	die "revision argument: $::_revision not understood by git-svn\n";
>  }
>  
> +#
> +# While we are fetching to bare repositories, we should update branch
> +# heads manually, because it is not possible to do merges within bare
> +# repositories.
> +#
> +# Arguments:
> +# - name of remote branch, for example 'refs/remotes/git-svn';
> +# - name of the corresponding local head, for example 'refs/heads/master'.
> +#
> +sub fast_forward_bare_fetch {
> +	return unless defined($_bare);
> +	return unless defined($_[0]);
> +	return unless defined($_[1]);

Checking for arguments here seems unnecessarily defensive.

> +	my $remote = $_[0];
> +	my $localhead = $_[1];

The general git-svn style is this:

	my ($remote, $localhead) = @_;

> +	# Update (fast-forward) heads for bare repository.
> +	if (defined($_bare)) {
> +		foreach my $gs (@gs) {
> +			my $remote = 'refs/remotes/' . $gs->{ref_id};
> +			my $localhead = 'refs/heads/master';
> +			if (open(FH, "<", "HEAD")) {
> +				chomp(my $head = <FH>);
> +				close FH;
> +				if ($head =~ /^ref: (.*)$/) {
> +					$localhead = $1;
> +				}
> +			}

"git rev-parse --symbolic-full-name HEAD" should work better
than parsing HEAD ourselves.

Thanks!

-- 
Eric Wong
