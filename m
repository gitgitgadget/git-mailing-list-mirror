From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: avoid string eval for defining functions
Date: Fri, 15 Jun 2007 17:22:54 -0700
Message-ID: <20070616002254.GB26502@untitled>
References: <11818790393274-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Jun 16 02:23:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzM4G-0005fF-JK
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 02:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758081AbXFPAXD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 20:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757703AbXFPAXB
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 20:23:01 -0400
Received: from hand.yhbt.net ([66.150.188.102]:44341 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757491AbXFPAXB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 20:23:01 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 370587DC09D;
	Fri, 15 Jun 2007 17:22:59 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 15 Jun 2007 17:22:55 -0700
Content-Disposition: inline
In-Reply-To: <11818790393274-git-send-email-sam.vilain@catalyst.net.nz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50282>

Sam Vilain <sam.vilain@catalyst.net.nz> wrote:
> You don't need to use string eval to define new functions; assigning a
> code reference to the target symbol table is enough.

Cool.

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  git-svn.perl |   64 +++++++++++++++++++++++++++++----------------------------
>  1 files changed, 33 insertions(+), 31 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 4d35895..4ba0813 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -38,14 +38,16 @@ use IPC::Open3;
>  use Git;
>  
>  BEGIN {
> -	my $s;
> +	# import functions from Git into our packages, en masse
> +	no strict 'refs';
>  	foreach (qw/command command_oneline command_noisy command_output_pipe
>  	            command_input_pipe command_close_pipe/) {
> -		$s .= "*SVN::Git::Editor::$_ = *SVN::Git::Fetcher::$_ = ".
> -		      "*Git::SVN::Migration::$_ = ".
> -		      "*Git::SVN::Log::$_ = *Git::SVN::$_ = *$_ = *Git::$_; ";
> +		for my $package ( qw(SVN::Git::Editor SVN::Git::Fetcher
> +			Git::SVN::Migration Git::SVN::Log Git::SVN),
> +			__PACKAGE__) {
> +			*{"${package}::$_"} = \&{"Git::$_"};
> +		}
>  	}
> -	eval $s;
>  }
>  
>  my ($SVN);
> @@ -898,26 +900,26 @@ BEGIN {
>  	# some options are read globally, but can be overridden locally
>  	# per [svn-remote "..."] section.  Command-line options will *NOT*
>  	# override options set in an [svn-remote "..."] section
> -	my $e;
> -	foreach (qw/follow_parent no_metadata use_svm_props
> -	            use_svnsync_props/) {
> -		my $key = $_;
> +	no strict 'refs';
> +	for my $option (qw/follow_parent no_metadata use_svm_props
> +			   use_svnsync_props/) {
> +		my $key = $option;
>  		$key =~ tr/_//d;
> -		$e .= "sub $_ {
> -			my (\$self) = \@_;
> -			return \$self->{-$_} if exists \$self->{-$_};
> -			my \$k = \"svn-remote.\$self->{repo_id}\.$key\";
> -			eval { command_oneline(qw/config --get/, \$k) };
> -			if (\$@) {
> -				\$self->{-$_} = \$Git::SVN::_$_;
> +		my $prop = "-$option";
> +		*$option = sub {
> +			my ($self) = @_;
> +			return $self->{$prop} if exists $self->{$prop};
> +			my $k = "svn-remote.$self->{repo_id}.$key";
> +			eval { command_oneline(qw/config --get/, $k) };
> +			if ($@) {
> +				$self->{$prop} = ${"Git::SVN::_$option"};
>  			} else {
> -				my \$v = command_oneline(qw/config --bool/,\$k);
> -				\$self->{-$_} = \$v eq 'false' ? 0 : 1;
> +				my $v = command_oneline(qw/config --bool/,$k);
> +				$self->{$prop} = $v eq 'false' ? 0 : 1;
>  			}
> -			return \$self->{-$_} }\n";
> +			return $self->{$prop};
> +		}
>  	}
> -	$e .= "1;\n";
> -	eval $e or die $@;
>  }
>  
>  my %LOCKFILES;
> @@ -2956,17 +2958,17 @@ my ($can_do_switch, %ignored_err, $RA);
>  
>  BEGIN {
>  	# enforce temporary pool usage for some simple functions
> -	my $e;
> -	foreach (qw/rev_proplist get_latest_revnum get_uuid get_repos_root/) {
> -		$e .= "sub $_ {
> -			my \$self = shift;
> -			my \$pool = SVN::Pool->new;
> -			my \@ret = \$self->SUPER::$_(\@_,\$pool);
> -			\$pool->clear;
> -			wantarray ? \@ret : \$ret[0]; }\n";
> +	no strict 'refs';
> +	for my $f (qw/rev_proplist get_latest_revnum get_uuid get_repos_root/) {
> +		my $SUPER = "SUPER::$f";
> +		*$f = sub {
> +			my $self = shift;
> +			my $pool = SVN::Pool->new;
> +			my @ret = $self->$SUPER(@_,$pool);
> +			$pool->clear;
> +			wantarray ? @ret : $ret[0];
> +		};
>  	}
> -
> -	eval "$e; 1;" or die $@;
>  }
>  
>  sub new {
> -- 
> 1.5.2.0.45.gfea6d-dirty
> 

-- 
Eric Wong
