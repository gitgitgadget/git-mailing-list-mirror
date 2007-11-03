From: Dan Zwell <dzwell@zwell.net>
Subject: Re: *[PATCH 2/2] Let git-add--interactive read colors from
 .gitconfig
Date: Sat, 3 Nov 2007 02:26:26 -0500
Message-ID: <20071103022626.253dcd93@paradox.zwell.net>
References: <471045DA.5050902@gmail.com>
	<19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com>
	<20071013172745.GA2624@coredump.intra.peff.net>
	<20071013175127.GA3183@coredump.intra.peff.net>
	<47112491.8070309@gmail.com>
	<20071015034338.GA4844@coredump.intra.peff.net>
	<20071016194709.3c1cb3a8@danzwell.com>
	<20071017015152.GN13801@spearce.org>
	<20071022164048.71a3dceb@danzwell.com>
	<20071023042702.GB28312@coredump.intra.peff.net>
	<20071023035221.66ea537f@danzwell.com>
	<20071102224111.7f7e165c@paradox.zwell.net>
	<7vy7dfyl33.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 08:27:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoDPK-0005iQ-4f
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 08:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756603AbXKCH0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 03:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756529AbXKCH0s
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 03:26:48 -0400
Received: from gator290.hostgator.com ([74.53.26.226]:54965 "EHLO
	gator290.hostgator.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754788AbXKCH0r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 03:26:47 -0400
Received: from [143.44.70.185] (port=57861 helo=paradox.zwell.net)
	by gator290.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <dzwell@zwell.net>)
	id 1IoDP0-0001mH-3B; Sat, 03 Nov 2007 02:26:42 -0500
In-Reply-To: <7vy7dfyl33.fsf_-_@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.0.0 (GTK+ 2.10.14; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator290.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - zwell.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63212>

On Fri, 02 Nov 2007 22:06:08 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Dan Zwell <dzwell@zwell.net> writes:
> 
> How big is Term::ANSIColor, and how universally available is it?
> Implementing the ANSI "ESC [ %d m" arithmetic color.c in Perl
> ourselves does not feel too much effort, compared to the
> potential hassle of dealing with extra dependencies and
> potential drift between scripts and C implementation.
20K on my machine, and part of the core library since Perl 5.6.0.
This was released in 2000. With your addition (the eval check to make
sure the module is loaded), nobody should be harmed if they don't have a
modern perl, either. My vote would be to reimplement the coloring if we
actually notice these problems.

<snip>
> 
> By the way, coloring the diff text itself may be just the matter
> of doing something like this (except that you now need to snarf
> OLD, NEW, METAINFO and FRAGINFO colors for diff configuration as
> well.
> 
> In addition to a small matter of testing, a more practical issue
> would be to add PAGER support there, I think.
You mean in general, so that users can view a hunk in the PAGER, then
be prompted for what to do with it? (Because it doesn't solve the color
problems, because calling "diff --color" here creates other problems.)

> 
> ---
> 
>  git-add--interactive.perl |   32 ++++++++++++++++++++++++--------
>  1 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 2bce5a1..1063a34 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -388,6 +388,27 @@ sub parse_diff {
>  	return @hunk;
>  }
>  
> +sub print_diff_hunk {
> +	my ($text) = @_;
> +	for (@$text) {
> +		if (!$use_color) {
> +			print;
> +			next;
> +		}
> +		if (/^\+/) {
> +			print_colored $new_color, $_;
> +		} elsif (/^\-/) {
> +			print_colored $old_color, $_;
> +		} elsif (/^\@/) {
> +			print_colored $fraginfo_color, $_;
> +		} elsif (/^ /) {
> +			print_colored $normal_color, $_;
> +		} else {
> +			print_colored $metainfo_color, $_;
> +		}
> +	}
> +}
> +
>  sub hunk_splittable {
>  	my ($text) = @_;
>  
> @@ -610,9 +631,7 @@ sub patch_update_cmd {
>  	my ($ix, $num);
>  	my $path = $it->{VALUE};
>  	my ($head, @hunk) = parse_diff($path);
> -	for (@{$head->{TEXT}}) {
> -		print;
> -	}
> +	print_diff_hunk($head->{TEXT});
>  	$num = scalar @hunk;
>  	$ix = 0;
>  
> @@ -654,9 +673,7 @@ sub patch_update_cmd {
>  		if (hunk_splittable($hunk[$ix]{TEXT})) {
>  			$other .= '/s';
>  		}
> -		for (@{$hunk[$ix]{TEXT}}) {
> -			print;
> -		}
> +		print_diff_hunk($hunk[$ix]{TEXT});
>  		print_colored $prompt_color, "Stage this hunk
> [y/n/a/d$other/?]? "; my $line = <STDIN>;
>  		if ($line) {
> @@ -794,8 +811,7 @@ sub diff_cmd {
>  				     HEADER => $status_head, },
>  				   @mods);
>  	return if (!@them);
> -	system(qw(git diff-index -p --cached HEAD --),
> -	       map { $_->{VALUE} } @them);
> +	system(qw(git diff -p --cached HEAD --), map { $_->{VALUE} }
> @them); }
>  
>  sub quit_cmd {
> 
In a previous incantation of this thread, coloring the diff output was
discussed. Your patch works, I tested it, but it does not highlight
whitespace at the end of lines or space/tab errors. If this is the only
case that more than one color may appear per line, it should not be
hard to match it as a special case (assuming this check isn't disabled
in .gitconfig), and print the rest of the line as we otherwise would.

Dan
