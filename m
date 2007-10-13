From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Color support added to git-add--interactive.
Date: Sat, 13 Oct 2007 13:25:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710131321520.25221@racer.site>
References: <471045DA.5050902@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Wincent Colaiuta <win@wincent.com>,
	Jonathan del Strother <maillist@steelskies.com>
To: Dan Zwell <dzwell@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 13 14:26:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Igg4Q-0007Ym-HK
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 14:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbXJMM0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 08:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752890AbXJMM0E
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 08:26:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:50066 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752723AbXJMM0D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 08:26:03 -0400
Received: (qmail invoked by alias); 13 Oct 2007 12:25:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp003) with SMTP; 13 Oct 2007 14:25:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19uEREuYhZuLdX7Ynb6bTtVskd4l6KFLJoLJ93JrV
	mcFTQUWmimWXv4
X-X-Sender: gene099@racer.site
In-Reply-To: <471045DA.5050902@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60728>

Hi,

[Cc'ed Wincent correctly]

On Fri, 12 Oct 2007, Dan Zwell wrote:

> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index be68814..f55d787 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -2,6 +2,18 @@
> 
>  use strict;
> 
> +my $use_color;
> +my $color_config = qx(git config --get color.add-interactive);
> +if ($color_config=~"true" || -t STDOUT && $color_config=~"auto") {
> +	$use_color = "true";
> +	require Term::ANSIColor;
> +}

Good.  If you do not have color enabled, it does not require that package 
that is only default with modern Perl.

> @@ -175,7 +187,9 @@ sub list_and_choose {
>  			if (!$opts->{LIST_FLAT}) {
>  				print "     ";
>  			}
> +			print_ansi_color "bold";
>  			print "$opts->{HEADER}\n";
> +			print_ansi_color "clear";

Here you say "clear", and ...

>  		}
>  		for ($i = 0; $i < @stuff; $i++) {
>  			my $chosen = $chosen[$i] ? '*' : ' ';
> @@ -205,7 +219,9 @@ sub list_and_choose {
> 
>  		return if ($opts->{LIST_ONLY});
> 
> +		print_ansi_color "bold blue";
>  		print $opts->{PROMPT};
> +		print_ansi_color "reset";

here you say "reset".  Is it because of the added colour?

> @@ -338,6 +354,16 @@ sub add_untracked_cmd {
> 
>  sub parse_diff {
>  	my ($path) = @_;
> +	# FIXME: the following breaks git, and I'm not sure why. When
> +	# the following is uncommented, git no longer asks whether we
> +	# want to add given hunks.
> +	#my @diff;
> +	#if ($use_color) {
> +	#    #@diff = run_cmd_pipe(qw(git diff-files --color -p --), $path);
> +	#}
> +	#else {
> +	#    #@diff = run_cmd_pipe(qw(git diff-files -p --), $path);
> +	#}
>  	my @diff = run_cmd_pipe(qw(git diff-files -p --), $path);
>  	my (@hunk) = { TEXT => [] };

This fails because of the next two lines:

        for (@diff) {
                if (/^@@ /) {

Replace the if with "if (/^[^-+ ]*@@ /)", or something even stricter.  
--color adds magic sequences to make color.

I cannot comment on the Perl style ;-)

Ciao,
Dscho
