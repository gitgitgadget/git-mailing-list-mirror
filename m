From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: allow to specify svn branch for commands
Date: Tue, 5 Jun 2007 02:56:08 -0700
Message-ID: <20070605095608.GA8215@muzzle>
References: <1181014957993-git-send-email-sam.vilain@catalyst.net.nz> <20070605041446.GA4266@untitled> <4664E546.5060304@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>,
	Git Central <git@vger.kernel.org>, stephen@touset.org,
	Jonathan Rockway <jon@jrock.us>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 11:56:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvVm0-0006r2-AV
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 11:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759618AbXFEJ4M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 05:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763234AbXFEJ4M
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 05:56:12 -0400
Received: from hand.yhbt.net ([66.150.188.102]:52379 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759618AbXFEJ4K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 05:56:10 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id AC5B32DC032;
	Tue,  5 Jun 2007 02:56:08 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 05 Jun 2007 02:56:08 -0700
Content-Disposition: inline
In-Reply-To: <4664E546.5060304@vilain.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49176>

Sam Vilain <sam@vilain.net> wrote:
> Eric Wong wrote:
> > Sam Vilain <sam.vilain@catalyst.net.nz> wrote:
> >> "git-svn dcommit" ends up making an arbitrary decision when pushing
> >> back merges.  Allow the user to specify which one is used, albeit in a
> >> rather hack-ish way.
> > 
> > Frightening...  Perhaps we should echo the final URL out
> > to the user and prompt them for confirmation.
> 
> Actually in between sending this to the list, I figured that it should
> be possible to detect when this is happening, at the expense of an extra
> "git-log" command.  Basically, take the first revision you found a
> commitlog entry in, and then do a log from the indicated head excluding
> that commit.  If you find more valid tips then the user is merging in
> gitspace.
> 
> Of course ideally you want to make sure that merge commits posted back
> are shipped with all of the necessary tokens for the various SVN-land
> tools out there.  eg, svk:merge, svnmerge, and whatever kooky system the
> SVN dev team come up with.  But that's a separate issue.
> 
> The original patch had a fairly dire bug, so here's a version that at
> least doesn't break the test suite.
> 
> Subject: [PATCH] git-svn: allow to specify svn branch for commands
> 
> "git-svn dcommit" ends up making an arbitrary decision when pushing
> back merges.  Allow the user to specify which one is used, albeit in a
> rather hack-ish way.

Actually, I believe 13c823fb520eaf1cded520213cf0ae4c3268208d already
solves this problem.  In fact, I'm not certain if you can find a case
where this will help if 13c823fb520eaf1cded520213cf0ae4c3268208d is in
place.  A test case to prove that this is actually needed would be
greatly appreciated :)

On the other hand (much to my chagrin), I haven't been working much on
git-svn lately and my knowledge could be rusty.

> ---
> 
>  Documentation/git-svn.txt |   11 +++++++++++
>  git-svn.perl              |   17 ++++++++++-------
>  2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index c0d7d95..3e64522 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -69,6 +69,17 @@ COMMANDS
>  	argument if that is what you want.  This is useful if
>  	you wish to track multiple projects that share a common
>  	repository.
> +-B<svn_branch>;;
> +--branch=<svn_branch>;;
> +	Normally, git-svn is capable of figuring out which branch you
> +	are working on.  However, if you are doing merges between svn
> +	branches using git then the decision about which branch to
> +	dcommit to will end up being made based on which of the
> +	branches you are merging has the newest upstream commit.  This
> +	option enables a global filter that tells git-svn what to look
> +	for in the git-svn-id: line - specify a repository UUID or a
> +	branch name here.  So, it may be used with "git-svn log",
> +	"git-svn dcommit", etc.

I think you missed my comment here on it being a regexp :)

>  'fetch'::
>  	Fetch unfetched revisions from the Subversion remote we are
> diff --git a/git-svn.perl b/git-svn.perl
> index e350061..906aa4b 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -54,7 +54,7 @@ $sha1 = qr/[a-f\d]{40}/;
>  $sha1_short = qr/[a-f\d]{4,40}/;
>  my ($_stdin, $_help, $_edit,
>  	$_message, $_file,
> -	$_template, $_shared,
> +	$_template, $_shared, $_branch,
>  	$_version, $_fetch_all, $_no_rebase,
>  	$_merge, $_strategy, $_dry_run, $_local,
>  	$_prefix, $_no_checkout, $_verbose);
> @@ -69,6 +69,7 @@ my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
>  		'useSvmProps' => \$Git::SVN::_use_svm_props,
>  		'useSvnsyncProps' => \$Git::SVN::_use_svnsync_props,
>  		'log-window-size=i' => \$Git::SVN::Ra::_log_window_size,
> +		'branch|B=s' => \$_branch,
>  		'no-checkout' => \$_no_checkout,
>  		'quiet|q' => \$_q,
>  		'repack-flags|repack-args|repack-opts=s' =>
> @@ -367,7 +368,7 @@ sub cmd_dcommit {
>  	my $head = shift;
>  	$head ||= 'HEAD';
>  	my @refs;
> -	my ($url, $rev, $uuid, $gs) = working_head_info($head, \@refs);
> +	my ($url, $rev, $uuid, $gs) = working_head_info($head, \@refs, $_branch);
>  	unless ($gs) {
>  		die "Unable to determine upstream SVN information from ",
>  		    "$head history\n";
> @@ -441,7 +442,7 @@ sub cmd_find_rev {
>  		my $head = shift;
>  		$head ||= 'HEAD';
>  		my @refs;
> -		my (undef, undef, undef, $gs) = working_head_info($head, \@refs);
> +		my (undef, undef, undef, $gs) = working_head_info($head, \@refs, $_branch);
>  		unless ($gs) {
>  			die "Unable to determine upstream SVN information from ",
>  			    "$head history\n";
> @@ -457,7 +458,7 @@ sub cmd_find_rev {
  
I don't think you need this hunk.  You can already pass the remote
branch name here (same with "git svn log").

>  sub cmd_rebase {
>  	command_noisy(qw/update-index --refresh/);
> -	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
> +	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD', undef, $_branch);
>  	unless ($gs) {
>  		die "Unable to determine upstream SVN information from ",
>  		    "working tree history\n";
> @@ -474,7 +475,7 @@ sub cmd_rebase {
>  }
>  
>  sub cmd_show_ignore {
> -	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
> +	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD', undef, $_branch);
>  	$gs ||= Git::SVN->new;
>  	my $r = (defined $_revision ? $_revision : $gs->ra->get_latest_revnum);
>  	$gs->traverse_ignore(\*STDOUT, $gs->{path}, $r);
> @@ -801,12 +802,14 @@ sub cmt_metadata {
>  }

You need to put --branch/-B into %cmd directly, %fc_opts won't cover
this ('fc' => fetch/commit).  On the other hand, we should probably make
this command take a $head from the command-line like "git svn log" and
"git svn find-rev"...

>  sub working_head_info {
> -	my ($head, $refs) = @_;
> +	my ($head, $refs, $grep) = @_;
>  	my ($fh, $ctx) = command_output_pipe('rev-list', $head);
>  	while (my $hash = <$fh>) {
>  		chomp($hash);
>  		my ($url, $rev, $uuid) = cmt_metadata($hash);
>  		if (defined $url && defined $rev) {
> +			next unless (!$grep or
> +				$url =~ m{$grep} or $uuid =~ m{$grep});
>  			if (my $gs = Git::SVN->find_by_url($url)) {
>  				my $c = $gs->rev_db_get($rev);
>  				if ($c && $c eq $hash) {

This last 'if' statement here checking the rev_db (introduced in
13c823fb520eaf1cded520213cf0ae4c3268208d still allows what
this patch is intended to do?

> @@ -3394,7 +3397,7 @@ sub git_svn_log_cmd {
>  		last;
>  	}
>  
> -	my ($url, $rev, $uuid, $gs) = ::working_head_info($head);
> +	my ($url, $rev, $uuid, $gs) = ::working_head_info($head, undef, $_branch);
>  	$gs ||= Git::SVN->_new;
>  	my @cmd = (qw/log --abbrev-commit --pretty=raw --default/,
>  	           $gs->refname);

You don't need this last hunk.   git svn log already takes
remote branches as an argument, and I don't think the -B switch is
passed here where you put it in %fc_opts.

-- 
Eric Wong
