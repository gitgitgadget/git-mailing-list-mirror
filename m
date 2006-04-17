From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-svnimport symlink support
Date: Mon, 17 Apr 2006 12:29:15 -0700
Message-ID: <7v3bgcngqc.fsf@assigned-by-dhcp.cox.net>
References: <E1FVRRH-0003Wz-6w@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Herbert Valerio Riedel <hvr@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 17 21:29:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVZPU-0003aF-Ty
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 21:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWDQT3S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 15:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWDQT3S
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 15:29:18 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:64490 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751241AbWDQT3R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Apr 2006 15:29:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060417192916.DTYC24255.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 17 Apr 2006 15:29:16 -0400
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Martin Langhoff <martin@catalyst.net.nz>,
	Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <E1FVRRH-0003Wz-6w@fencepost.gnu.org> (Herbert Valerio Riedel's
	message of "Mon, 17 Apr 2006 06:58:39 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18832>

Herbert Valerio Riedel <hvr@gnu.org> writes:

> added svn:special symlink support for access methods other than
> direct-http

I think what the patch does makes sense.  When svn:special
exists, check if it is of form "link " and munge the way a
symlink is represented to match what we expect.  

My understanding is that currently there is any type of special
svn blob defined other than "link ", and dying rather than
punting and silently doing a wrong thing when we see something
else in the future makes sense to me as well.

Previously we were feeding "update-index --cacheinfo" with
'0755' and '0644', but this patch changes it to send
100755/100644; technically this is not necessary, because
create_ce_mode(m) makes it a regular file unless S_ISLNK(m), but
I think this is good for consistency.

Karl, Martin, Smurf, Comments?

> Signed-off-by: Herbert Valerio Riedel <hvr@gnu.org>
>
>
> ---
>
>  git-svnimport.perl |   18 ++++++++++++++++--
>  1 files changed, 16 insertions(+), 2 deletions(-)
>
> edb2adf980e2193570a6910efc01c7ac47dcf474
> diff --git a/git-svnimport.perl b/git-svnimport.perl
> index 4d5371c..60ed7ae 100755
> --- a/git-svnimport.perl
> +++ b/git-svnimport.perl
> @@ -98,6 +98,7 @@ package SVNconn;
>  use File::Spec;
>  use File::Temp qw(tempfile);
>  use POSIX qw(strftime dup2);
> +use Fcntl qw(SEEK_SET);
>  
>  sub new {
>  	my($what,$repo) = @_;
> @@ -143,9 +144,22 @@ sub file {
>  	}
>  	my $mode;
>  	if (exists $properties->{'svn:executable'}) {
> -		$mode = '0755';
> +		$mode = '100755';
> +	} elsif (exists $properties->{'svn:special'}) {
> +		my ($special_content, $filesize);
> +		$filesize = tell $fh;
> +		seek $fh, 0, SEEK_SET;
> +		read $fh, $special_content, $filesize;
> +		if ($special_content =~ s/^link //) {
> +			$mode = '120000';
> +			seek $fh, 0, SEEK_SET;
> +			truncate $fh, 0;
> +			print $fh $special_content;
> +		} else {
> +			die "unexpected svn:special file encountered";
> +		}
>  	} else {
> -		$mode = '0644';
> +		$mode = '100644';
>  	}
>  	close ($fh);
>  
> -- 
> 1.1.3
