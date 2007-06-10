From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: use git-log rather than rev-list | xargs cat-file
Date: Sun, 10 Jun 2007 14:24:59 -0700
Message-ID: <20070610212459.GA12222@muzzle>
References: <20070610091259.48F8D13A4F8@magnus.utsl.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 23:25:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxUuM-0004RK-42
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 23:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756069AbXFJVZD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 17:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757470AbXFJVZD
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 17:25:03 -0400
Received: from hand.yhbt.net ([66.150.188.102]:48111 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756069AbXFJVZB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 17:25:01 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 44E207DC09D;
	Sun, 10 Jun 2007 14:24:59 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 10 Jun 2007 14:24:59 -0700
Content-Disposition: inline
In-Reply-To: <20070610091259.48F8D13A4F8@magnus.utsl.gen.nz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49768>

Sam Vilain <sam@vilain.net> wrote:
> This saves a bit of time when rebuilding the git-svn index.

Does git-log still have the 16k buffer limit?  If so then we can't use
it because commit messages over 16k will be truncated and the git-svn-id
line will not show up.  Also, if that limit is removed I'd prefer to
just add --pretty=raw to rev-list because git-log is stil porcelain and
more likely to change.

> Signed-off-by: Sam Vilain <sam@vilain.net>
> ---
>  git-svn.perl |   30 +++++++++++++++++++-----------
>  1 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index e350061..610563c 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -802,10 +802,15 @@ sub cmt_metadata {
>  
>  sub working_head_info {
>  	my ($head, $refs) = @_;
> -	my ($fh, $ctx) = command_output_pipe('rev-list', $head);
> -	while (my $hash = <$fh>) {
> -		chomp($hash);
> -		my ($url, $rev, $uuid) = cmt_metadata($hash);
> +	my ($fh, $ctx) = command_output_pipe('log', $head);
> +	my $hash;
> +	while (<$fh>) {
> +		if ( m{^commit ($::sha1)$} ) {
> +			$hash = $1;
> +			next;
> +		}
> +		next unless s{^\s+(git-svn-id:)}{$1};
> +		my ($url, $rev, $uuid) = extract_metadata($_);
>  		if (defined $url && defined $rev) {
>  			if (my $gs = Git::SVN->find_by_url($url)) {
>  				my $c = $gs->rev_db_get($rev);
> @@ -1964,16 +1969,19 @@ sub rebuild {
>  		return;
>  	}
>  	print "Rebuilding $db_path ...\n";
> -	my ($rev_list, $ctx) = command_output_pipe("rev-list", $self->refname);
> +	my ($log, $ctx) = command_output_pipe("log", $self->refname);
>  	my $latest;
>  	my $full_url = $self->full_url;
>  	remove_username($full_url);
>  	my $svn_uuid;
> -	while (<$rev_list>) {
> -		chomp;
> -		my $c = $_;
> -		die "Non-SHA1: $c\n" unless $c =~ /^$::sha1$/o;
> -		my ($url, $rev, $uuid) = ::cmt_metadata($c);
> +	my $c;
> +	while (<$log>) {
> +		if ( m{^commit ($::sha1)$} ) {
> +			$c = $1;
> +			next;
> +		}
> +		next unless s{^\s*(git-svn-id:)}{$1};
> +		my ($url, $rev, $uuid) = ::extract_metadata($_);
>  		remove_username($url);
>  
>  		# ignore merges (from set-tree)
> @@ -1991,7 +1999,7 @@ sub rebuild {
>  		$self->rev_db_set($rev, $c);
>  		print "r$rev = $c\n";
>  	}
> -	command_close_pipe($rev_list, $ctx);
> +	command_close_pipe($log, $ctx);
>  	print "Done rebuilding $db_path\n";
>  }
>  
> -- 
> 1.5.0.4.210.gf8a7c-dirty
> 

-- 
Eric Wong
