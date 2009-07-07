From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 2/2] git-svn: Fix branch detection when repository root
 is inaccessible
Date: Tue, 07 Jul 2009 11:30:46 -0400
Message-ID: <4A536A26.7090102@xiplink.com>
References: <20090706212742.GA8219@dcvr.yhbt.net> <1246923602.4618.18.camel@kea>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Mattias Nissler <mattias.nissler@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 07 17:32:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOCeR-0004ZB-AD
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 17:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756236AbZGGPb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 11:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757845AbZGGPbY
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 11:31:24 -0400
Received: from smtp122.iad.emailsrvr.com ([207.97.245.122]:44655 "EHLO
	smtp122.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757761AbZGGPbW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 11:31:22 -0400
Received: from relay32.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay32.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 7F88E1B4084;
	Tue,  7 Jul 2009 11:31:20 -0400 (EDT)
Received: by relay32.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 4EF381B406D;
	Tue,  7 Jul 2009 11:31:20 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <1246923602.4618.18.camel@kea>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122849>

Loveley!  That aspect of -d was bothersome...

Acked-by: Marc Branchaud <marcnarc@xiplink.com>

		M.


Mattias Nissler wrote:
> For the case of multiple projects sharing a single SVN repository, it is
> common practice to create the standard SVN directory layout within a
> subdirectory for each project. In such setups, access control is often
> used to limit what projects a given user may access. git-svn failed to
> detect branches (e.g. when passing --stdlayout to clone) because it
> relied on having access to the root directory in the repository. This
> patch solves this problem by making git-svn use paths relative to the
> given repository URL instead of the repository root.
> 
> Signed-off-by: Mattias Nissler <mattias.nissler@gmx.de>
> ---
>  git-svn.perl                         |   42 +++++++++++++---------------------
>  t/t9138-git-svn-multiple-branches.sh |    8 +++---
>  2 files changed, 20 insertions(+), 30 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 57d13af..cf3948c 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -876,10 +876,6 @@ sub cmd_multi_init {
>  		usage(1);
>  	}
>  
> -	# there are currently some bugs that prevent multi-init/multi-fetch
> -	# setups from working well without this.
> -	$Git::SVN::_minimize_url = 1;
> -
>  	$_prefix = '' unless defined $_prefix;
>  	if (defined $url) {
>  		$url = canonicalize_url($url);
> @@ -1180,7 +1176,7 @@ sub complete_url_ls_init {
>  		    "wanted to set to: $gs->{url}\n";
>  	}
>  	command_oneline('config', $k, $gs->{url}) unless $orig_url;
> -	my $remote_path = "$ra->{svn_path}/$repo_path";
> +	my $remote_path = "$gs->{path}/$repo_path";
>  	$remote_path =~ s#/+#/#g;
>  	$remote_path =~ s#^/##g;
>  	$remote_path .= "/*" if $remote_path !~ /\*/;
> @@ -2177,16 +2173,6 @@ sub ra {
>  	$ra;
>  }
>  
> -sub rel_path {
> -	my ($self) = @_;
> -	my $repos_root = $self->ra->{repos_root};
> -	return $self->{path} if ($self->{url} eq $repos_root);
> -	my $url = $self->{url} .
> -	          (length $self->{path} ? "/$self->{path}" : $self->{path});
> -	$url =~ s!^\Q$repos_root\E(?:/+|$)!!g;
> -	$url;
> -}
> -
>  # prop_walk(PATH, REV, SUB)
>  # -------------------------
>  # Recursively traverse PATH at revision REV and invoke SUB for each
> @@ -2512,10 +2498,7 @@ sub match_paths {
>  	if (my $path = $paths->{"/$self->{path}"}) {
>  		return ($path->{action} eq 'D') ? 0 : 1;
>  	}
> -	my $repos_root = $self->ra->{repos_root};
> -	my $extended_path = $self->{url} . '/' . $self->{path};
> -	$extended_path =~ s#^\Q$repos_root\E(/|$)##;
> -	$self->{path_regex} ||= qr/^\/\Q$extended_path\E\//;
> +	$self->{path_regex} ||= qr/^\/\Q$self->{path}\E\//;
>  	if (grep /$self->{path_regex}/, keys %$paths) {
>  		return 1;
>  	}
> @@ -2545,7 +2528,7 @@ sub find_parent_branch {
>  	return undef unless defined $paths;
>  
>  	# look for a parent from another branch:
> -	my @b_path_components = split m#/#, $self->rel_path;
> +	my @b_path_components = split m#/#, $self->{path};
>  	my @a_path_components;
>  	my $i;
>  	while (@b_path_components) {
> @@ -2563,11 +2546,11 @@ sub find_parent_branch {
>  	my $r = $i->{copyfrom_rev};
>  	my $repos_root = $self->ra->{repos_root};
>  	my $url = $self->ra->{url};
> -	my $new_url = $repos_root . $branch_from;
> +	my $new_url = $url . $branch_from;
>  	print STDERR  "Found possible branch point: ",
>  	              "$new_url => ", $self->full_url, ", $r\n";
>  	$branch_from =~ s#^/##;
> -	my $gs = $self->other_gs($new_url, $url, $repos_root,
> +	my $gs = $self->other_gs($new_url, $url,
>  		                 $branch_from, $r, $self->{ref_id});
>  	my ($r0, $parent) = $gs->find_rev_before($r, 1);
>  	{
> @@ -2752,9 +2735,9 @@ sub parse_svn_date {
>  }
>  
>  sub other_gs {
> -	my ($self, $new_url, $url, $repos_root,
> +	my ($self, $new_url, $url,
>  	    $branch_from, $r, $old_ref_id) = @_;
> -	my $gs = Git::SVN->find_by_url($new_url, $repos_root, $branch_from);
> +	my $gs = Git::SVN->find_by_url($new_url, $url, $branch_from);
>  	unless ($gs) {
>  		my $ref_id = $old_ref_id;
>  		$ref_id =~ s/\@\d+$//;
> @@ -4436,14 +4419,20 @@ sub get_log {
>  	# passed pool (instead of our temporary and quickly cleared pool in
>  	# Git::SVN::Ra) does not help matters at all...
>  	my $receiver = pop @args;
> +	my $prefix = "/".$self->{svn_path};
> +	$prefix =~ s#/+($)##;
> +	my $prefix_regex = qr#^\Q$prefix\E#;
>  	push(@args, sub {
>  		my ($paths) = $_[0];
>  		return &$receiver(@_) unless $paths;
>  		$_[0] = ();
>  		foreach my $p (keys %$paths) {
>  			my $i = $paths->{$p};
> -			my %s = map { $_ => $i->$_ }
> -				      qw/copyfrom_path copyfrom_rev action/;
> +			# Make path relative to our url, not repos_root
> +			$p =~ s/$prefix_regex//;
> +			my %s = map { $_ => $i->$_; }
> +				qw/copyfrom_path copyfrom_rev action/;
> +			$s{'copyfrom_path'} =~ s/$prefix_regex// if $s{'copyfrom_path'};
>  			$_[0]{$p} = \%s;
>  		}
>  		&$receiver(@_);
> @@ -4461,6 +4450,7 @@ sub get_log {
>  			push(@args, sub { &$receiver(@_) if (--$limit >= 0) });
>  		}
>  	}
> +
>  	my $ret = $self->SUPER::get_log(@args, $pool);
>  	$pool->clear;
>  	$ret;
> diff --git a/t/t9138-git-svn-multiple-branches.sh b/t/t9138-git-svn-multiple-branches.sh
> index cb9a6d2..3cd0671 100755
> --- a/t/t9138-git-svn-multiple-branches.sh
> +++ b/t/t9138-git-svn-multiple-branches.sh
> @@ -99,22 +99,22 @@ test_expect_success 'Multiple branch or tag paths require -d' '
>  
>  test_expect_success 'create new branches and tags' '
>  	( cd git_project &&
> -		git svn branch -m "New branch 1" -d project/b_one New1 ) &&
> +		git svn branch -m "New branch 1" -d b_one New1 ) &&
>  	( cd svn_project &&
>  		svn_cmd up && test -e b_one/New1/a.file ) &&
>  
>  	( cd git_project &&
> -		git svn branch -m "New branch 2" -d project/b_two New2 ) &&
> +		git svn branch -m "New branch 2" -d b_two New2 ) &&
>  	( cd svn_project &&
>  		svn_cmd up && test -e b_two/New2/a.file ) &&
>  
>  	( cd git_project &&
> -		git svn branch -t -m "New tag 1" -d project/tags_A Tag1 ) &&
> +		git svn branch -t -m "New tag 1" -d tags_A Tag1 ) &&
>  	( cd svn_project &&
>  		svn_cmd up && test -e tags_A/Tag1/a.file ) &&
>  
>  	( cd git_project &&
> -		git svn tag -m "New tag 2" -d project/tags_B Tag2 ) &&
> +		git svn tag -m "New tag 2" -d tags_B Tag2 ) &&
>  	( cd svn_project &&
>  		svn_cmd up && test -e tags_B/Tag2/a.file )
>  '
