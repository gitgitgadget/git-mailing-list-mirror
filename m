From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: cache max revision in rev_db databases
Date: Sat, 30 Jun 2007 20:50:03 -0700
Message-ID: <7vfy48940k.fsf@assigned-by-dhcp.cox.net>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937822346-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937823184-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jul 01 05:50:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4qSA-0006PY-0C
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 05:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243AbXGADuJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 23:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755235AbXGADuI
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 23:50:08 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43045 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755215AbXGADuH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 23:50:07 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070701035005.EYID22777.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Jun 2007 23:50:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id J3q51X0031kojtg0000000; Sat, 30 Jun 2007 23:50:05 -0400
In-Reply-To: <11831937823184-git-send-email-sam.vilain@catalyst.net.nz> (Sam
	Vilain's message of "Sat, 30 Jun 2007 20:56:14 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51273>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> Cache the maximum revision for each rev_db URL rather than looking it
> up each time.  This saves a lot of time when rebuilding indexes on a
> freshly cloned repository.
>
> Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>

I think both the previous one from Sam that makes it use git-log
instead of git-rev-list and this one looks sane.  Ack/Nack is
appreciated.

> ---
>  git-svn.perl |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 556cd7d..a8b6669 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -801,6 +801,7 @@ sub working_head_info {
>  	my ($head, $refs) = @_;
>  	my ($fh, $ctx) = command_output_pipe('log', $head);
>  	my $hash;
> +	my %max;
>  	while (<$fh>) {
>  		if ( m{^commit ($::sha1)$} ) {
>  			unshift @$refs, $hash if $hash and $refs;
> @@ -810,11 +811,14 @@ sub working_head_info {
>  		next unless s{^\s*(git-svn-id:)}{$1};
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
> -- 
> 1.5.2.1.1131.g3b90
