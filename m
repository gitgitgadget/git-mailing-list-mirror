From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn failure when symlink added in svn
Date: Sun, 29 Apr 2007 23:31:33 -0700
Message-ID: <20070430063133.GA14414@untitled>
References: <loom.20070428T144858-521@post.gmane.org> <7virbgjthr.fsf@assigned-by-dhcp.cox.net> <m2odl8fjv1.fsf@ziti.fhcrc.org> <7v7irwjql6.fsf@assigned-by-dhcp.cox.net> <m2k5vwfbf6.fsf@ziti.fhcrc.org> <7vwszwi0h2.fsf@assigned-by-dhcp.cox.net> <20070429183136.GE12375@untitled> <7vr6q2dhex.fsf@assigned-by-dhcp.cox.net> <20070429222136.GA1800@untitled> <7vmz0qcuut.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Seth Falcon <sethfalcon@gmail.com>,
	Alexander Klink <ak-git@cynops.de>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 30 08:32:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiPQv-0003jA-9J
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 08:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423070AbXD3GcJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 02:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423080AbXD3GcI
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 02:32:08 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35616 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423070AbXD3Gbl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 02:31:41 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 93D287DC0A0;
	Sun, 29 Apr 2007 23:31:39 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 29 Apr 2007 23:31:33 -0700
Content-Disposition: inline
In-Reply-To: <7vmz0qcuut.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45857>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Junio C Hamano <junkio@cox.net> wrote:
> >> diff --git a/git-svn.perl b/git-svn.perl
> >> index 4be8576..cef6697 100755
> >> --- a/git-svn.perl
> >> +++ b/git-svn.perl
> >> @@ -2464,15 +2464,15 @@ sub close_file {
> >>  	my $hash;
> >>  	my $path = $self->git_path($fb->{path});
> >>  	if (my $fh = $fb->{fh}) {
> >> -		seek($fh, 0, 0) or croak $!;
> >> +		sysseek($fh, 0, 0) or croak $!;
> >>  		my $md5 = Digest::MD5->new;
> >>  		$md5->addfile($fh);
> >
> > We may want to keep the plain seek() here and do both seek and sysseek,
> > I'm not sure if $md5->addfile() uses read or sysread internally.
> 
> Ok.  The seek before Digest::MD5 can stay as it has been that
> way for a long time without causing problems.  How about this as
> an replacement then?

Looks good to me.  Seth?

If Seth is okay with it, then:
Acked-by: Eric Wong <normalperson@yhbt.net>

> -- >8 --
> [PATCH] Fix symlink handling in git-svn, related to PerlIO
> 
> After reading the leading contents from a symlink data obtained
> from subversion, which we expect to begin with 'link ', the code
> forked to hash the remainder (which should match readlink()
> result) using git-hash-objects, by redirecting its STDIN from
> the filehandle we read that 'link ' from.  This was Ok with Perl
> on modern Linux, but on Mac OS, the read in the parent process
> slurped more than we asked for in stdio buffer, and the child
> did not correctly see the "remainder".
> 
> This attempts to fix the issue by using lower level sysseek and
> sysread instead of seek and read to bypass the stdio buffer.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
>  git-svn.perl |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 4be8576..6f509f8 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2470,9 +2470,9 @@ sub close_file {
>  		my $got = $md5->hexdigest;
>  		die "Checksum mismatch: $path\n",
>  		    "expected: $exp\n    got: $got\n" if ($got ne $exp);
> -		seek($fh, 0, 0) or croak $!;
> +		sysseek($fh, 0, 0) or croak $!;
>  		if ($fb->{mode_b} == 120000) {
> -			read($fh, my $buf, 5) == 5 or croak $!;
> +			sysread($fh, my $buf, 5) == 5 or croak $!;
>  			$buf eq 'link ' or die "$path has mode 120000",
>  			                       "but is not a link\n";
>  		}
> -- 
> 1.5.2.rc0.781.g5868

-- 
Eric Wong
