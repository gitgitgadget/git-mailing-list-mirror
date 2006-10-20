From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: Re: [PATCH] git-svnimport.perl: copying directory from original SVN place
Date: Fri, 20 Oct 2006 02:22:19 +0200
Message-ID: <20061020002219.GF24676@sashak.voltaire.com>
References: <20061008213118.GA1367@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 02:16:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gai46-00081L-Dl
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 02:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946735AbWJTAQn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 20:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946742AbWJTAQn
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 20:16:43 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:64799 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1946735AbWJTAQm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 20:16:42 -0400
Received: from sashak ([172.25.5.107]) by taurus.voltaire.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 20 Oct 2006 02:16:39 +0200
Received: by sashak (sSMTP sendmail emulation); Fri, 20 Oct 2006 02:22:19 +0200
To: Junio C Hamano <junkio@cox.net>,
	Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <20061008213118.GA1367@sashak.voltaire.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 20 Oct 2006 00:16:39.0873 (UTC) FILETIME=[0380C310:01C6F3DD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29390>

Hi guys,

On 23:31 Sun 08 Oct     , Sasha Khapyorsky wrote:
> 
> When copying whole directory, if source directory is not in already
> imported tree, try to get it from original SVN location. This happens
> when source directory is not matched by provided 'trunk' and/or
> 'tags/branches' templates or when it is not part of specified SVN
> sub-project.

Any news with it?

Sasha

> 
> Signed-off-by: Sasha Khapyorsky <sashak@voltaire.com>
> ---
>  git-svnimport.perl |   93 ++++++++++++++++++++++++++++++----------------------
>  1 files changed, 54 insertions(+), 39 deletions(-)
> 
> diff --git a/git-svnimport.perl b/git-svnimport.perl
> index 988514e..4ae0eec 100755
> --- a/git-svnimport.perl
> +++ b/git-svnimport.perl
> @@ -193,6 +193,13 @@ sub ignore {
>  	}
>  }
>  
> +sub dir_list {
> +	my($self,$path,$rev) = @_;
> +	my ($dirents,undef,$properties)
> +	    = $self->{'svn'}->get_dir($path,$rev,undef);
> +	return $dirents;
> +}
> +
>  package main;
>  use URI;
>  
> @@ -342,35 +349,16 @@ if ($opt_A) {
>  
>  open BRANCHES,">>", "$git_dir/svn2git";
>  
> -sub node_kind($$$) {
> -	my ($branch, $path, $revision) = @_;
> +sub node_kind($$) {
> +	my ($svnpath, $revision) = @_;
>  	my $pool=SVN::Pool->new;
> -	my $kind = $svn->{'svn'}->check_path(revert_split_path($branch,$path),$revision,$pool);
> +	my $kind = $svn->{'svn'}->check_path($svnpath,$revision,$pool);
>  	$pool->clear;
>  	return $kind;
>  }
>  
> -sub revert_split_path($$) {
> -	my($branch,$path) = @_;
> -
> -	my $svnpath;
> -	$path = "" if $path eq "/"; # this should not happen, but ...
> -	if($branch eq "/") {
> -		$svnpath = "$trunk_name/$path";
> -	} elsif($branch =~ m#^/#) {
> -		$svnpath = "$tag_name$branch/$path";
> -	} else {
> -		$svnpath = "$branch_name/$branch/$path";
> -	}
> -
> -	$svnpath =~ s#/+$##;
> -	return $svnpath;
> -}
> -
>  sub get_file($$$) {
> -	my($rev,$branch,$path) = @_;
> -
> -	my $svnpath = revert_split_path($branch,$path);
> +	my($svnpath,$rev,$path) = @_;
>  
>  	# now get it
>  	my ($name,$mode);
> @@ -413,10 +401,9 @@ sub get_file($$$) {
>  }
>  
>  sub get_ignore($$$$$) {
> -	my($new,$old,$rev,$branch,$path) = @_;
> +	my($new,$old,$rev,$path,$svnpath) = @_;
>  
>  	return unless $opt_I;
> -	my $svnpath = revert_split_path($branch,$path);
>  	my $name = $svn->ignore("$svnpath",$rev);
>  	if ($path eq '/') {
>  		$path = $opt_I;
> @@ -435,7 +422,7 @@ sub get_ignore($$$$$) {
>  		close $F;
>  		unlink $name;
>  		push(@$new,['0644',$sha,$path]);
> -	} else {
> +	} elsif (defined $old) {
>  		push(@$old,$path);
>  	}
>  }
> @@ -480,6 +467,27 @@ sub branch_rev($$) {
>  	return $therev;
>  }
>  
> +sub expand_svndir($$$);
> +
> +sub expand_svndir($$$)
> +{
> +	my ($svnpath, $rev, $path) = @_;
> +	my @list;
> +	get_ignore(\@list, undef, $rev, $path, $svnpath);
> +	my $dirents = $svn->dir_list($svnpath, $rev);
> +	foreach my $p(keys %$dirents) {
> +		my $kind = node_kind($svnpath.'/'.$p, $rev);
> +		if ($kind eq $SVN::Node::file) {
> +			my $f = get_file($svnpath.'/'.$p, $rev, $path.'/'.$p);
> +			push(@list, $f) if $f;
> +		} elsif ($kind eq $SVN::Node::dir) {
> +			push(@list,
> +			     expand_svndir($svnpath.'/'.$p, $rev, $path.'/'.$p));
> +		}
> +	}
> +	return @list;
> +}
> +
>  sub copy_path($$$$$$$$) {
>  	# Somebody copied a whole subdirectory.
>  	# We need to find the index entries from the old version which the
> @@ -488,8 +496,11 @@ sub copy_path($$$$$$$$) {
>  	my($newrev,$newbranch,$path,$oldpath,$rev,$node_kind,$new,$parents) = @_;
>  
>  	my($srcbranch,$srcpath) = split_path($rev,$oldpath);
> -	unless(defined $srcbranch) {
> -		print "Path not found when copying from $oldpath @ $rev\n";
> +	unless(defined $srcbranch && defined $srcpath) {
> +		print "Path not found when copying from $oldpath @ $rev.\n".
> +			"Will try to copy from original SVN location...\n"
> +			if $opt_v;
> +		push (@$new, expand_svndir($oldpath, $rev, $path));
>  		return;
>  	}
>  	my $therev = branch_rev($srcbranch, $rev);
> @@ -503,7 +514,7 @@ sub copy_path($$$$$$$$) {
>  	}
>  	print "$newrev:$newbranch:$path: copying from $srcbranch:$srcpath @ $rev\n" if $opt_v;
>  	if ($node_kind eq $SVN::Node::dir) {
> -			$srcpath =~ s#/*$#/#;
> +		$srcpath =~ s#/*$#/#;
>  	}
>  	
>  	my $pid = open my $f,'-|';
> @@ -582,10 +593,12 @@ sub commit {
>  		if(defined $oldpath) {
>  			my $p;
>  			($parent,$p) = split_path($revision,$oldpath);
> -			if($parent eq "/") {
> -				$parent = $opt_o;
> -			} else {
> -				$parent =~ s#^/##; # if it's a tag
> +			if(defined $parent) {
> +				if($parent eq "/") {
> +					$parent = $opt_o;
> +				} else {
> +					$parent =~ s#^/##; # if it's a tag
> +				}
>  			}
>  		} else {
>  			$parent = undef;
> @@ -651,9 +664,10 @@ #	}
>  				push(@old,$path); # remove any old stuff
>  			}
>  			if(($action->[0] eq "A") || ($action->[0] eq "R")) {
> -				my $node_kind = node_kind($branch,$path,$revision);
> +				my $node_kind = node_kind($action->[3], $revision);
>  				if ($node_kind eq $SVN::Node::file) {
> -					my $f = get_file($revision,$branch,$path);
> +					my $f = get_file($action->[3],
> +							 $revision, $path);
>  					if ($f) {
>  						push(@new,$f) if $f;
>  					} else {
> @@ -668,19 +682,20 @@ #	}
>  							  \@new, \@parents);
>  					} else {
>  						get_ignore(\@new, \@old, $revision,
> -							   $branch, $path);
> +							   $path, $action->[3]);
>  					}
>  				}
>  			} elsif ($action->[0] eq "D") {
>  				push(@old,$path);
>  			} elsif ($action->[0] eq "M") {
> -				my $node_kind = node_kind($branch,$path,$revision);
> +				my $node_kind = node_kind($action->[3], $revision);
>  				if ($node_kind eq $SVN::Node::file) {
> -					my $f = get_file($revision,$branch,$path);
> +					my $f = get_file($action->[3],
> +							 $revision, $path);
>  					push(@new,$f) if $f;
>  				} elsif ($node_kind eq $SVN::Node::dir) {
>  					get_ignore(\@new, \@old, $revision,
> -						   $branch,$path);
> +						   $path, $action->[3]);
>  				}
>  			} else {
>  				die "$revision: unknown action '".$action->[0]."' for $path\n";
> -- 
> 1.4.2.3
> 
