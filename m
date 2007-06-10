From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: cache max revision in rev_db databases
Date: Sun, 10 Jun 2007 14:47:53 -0700
Message-ID: <20070610214753.GC12222@muzzle>
References: <20070610091304.C3E0413A4F8@magnus.utsl.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 23:48:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxVGW-0007t6-19
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 23:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760021AbXFJVr4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 17:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759706AbXFJVrz
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 17:47:55 -0400
Received: from hand.yhbt.net ([66.150.188.102]:48327 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759487AbXFJVry (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 17:47:54 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 440747DC09D;
	Sun, 10 Jun 2007 14:47:53 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 10 Jun 2007 14:47:53 -0700
Content-Disposition: inline
In-Reply-To: <20070610091304.C3E0413A4F8@magnus.utsl.gen.nz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49776>

Sam Vilain <sam@vilain.net> wrote:
> Cache the maximum revision for each rev_db URL rather than looking it
> up each time.  This saves a lot of time when rebuilding indexes on a
> freshly cloned repository.

It looks correct, but I'm not sure how often we can even hit this
optimization to make it worth it.

Any live repositories and benchmarks you've run this on?
(without the rev-list => log patch applied, which would be a big
performance improvement if all log messages were under 16k).

> Signed-off-by: Sam Vilain <sam@vilain.net>
> ---
>  git-svn.perl |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 610563c..c9758a0 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -804,6 +804,7 @@ sub working_head_info {
>  	my ($head, $refs) = @_;
>  	my ($fh, $ctx) = command_output_pipe('log', $head);
>  	my $hash;
> +	my %max;
>  	while (<$fh>) {
>  		if ( m{^commit ($::sha1)$} ) {
>  			$hash = $1;
> @@ -812,11 +813,14 @@ sub working_head_info {
>  		next unless s{^\s+(git-svn-id:)}{$1};
>  		my ($url, $rev, $uuid) = extract_metadata($_);
>  		if (defined $url && defined $rev) {
> +			next if $max{$url} and $max{$url} < $rev;
>  			if (my $gs = Git::SVN->find_by_url($url)) {
>  				my $c = $gs->rev_db_get($rev);
>  				if ($c && $c eq $hash) {
>  					close $fh; # break the pipe
>  					return ($url, $rev, $uuid, $gs);
> +				} else {
> +					$max{$url} ||= $gs->rev_db_max;
>  				}
>  			}
>  		}

-- 
Eric Wong
