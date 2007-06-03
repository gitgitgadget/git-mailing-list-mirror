From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use git-tag in git-cvsimport
Date: Sun, 03 Jun 2007 01:37:10 -0700
Message-ID: <7v1wgto2mh.fsf@assigned-by-dhcp.cox.net>
References: <11808537962798-git-send-email-el@prans.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elvis Pranskevichus <el@prans.net>
X-From: git-owner@vger.kernel.org Sun Jun 03 10:37:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hulaf-0005IB-6C
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 10:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbXFCIhN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 04:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbXFCIhN
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 04:37:13 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:35826 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbXFCIhM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 04:37:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070603083710.KUZY15717.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 3 Jun 2007 04:37:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6wdA1X0091kojtg0000000; Sun, 03 Jun 2007 04:37:10 -0400
In-Reply-To: <11808537962798-git-send-email-el@prans.net> (Elvis
	Pranskevichus's message of "Sun, 3 Jun 2007 02:56:36 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48978>

Elvis Pranskevichus <el@prans.net> writes:

> Currently git-cvsimport tries to create tag objects directly via git-mktag
> in a very broken way, e.g the stuff it writes into the tagger field of
> the tag object doesn't really resemble the GIT_COMMITTER_IDENT. This makes
> gitweb and possibly other tools that try to interpret tag objects to be
> confused about tag date and authorship.
>
> Fix this by calling git-tag instead. This also has a nice side effect of
> not creating the tag object but only the lightweight tag as that's the only
> thing CVS has anyways.
>
> Signed-off-by: Elvis Pranskevichus <el@prans.net>

This sounds very sane, although I have not thought through the
possible ramifications.

>  git-cvsimport.perl |   26 ++------------------------
>  1 files changed, 2 insertions(+), 24 deletions(-)
>
> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
> index f68afe7..d5ca66b 100755
> --- a/git-cvsimport.perl
> +++ b/git-cvsimport.perl
> @@ -771,31 +771,9 @@ sub commit {
>  		$xtag =~ s/\s+\*\*.*$//; # Remove stuff like ** INVALID ** and ** FUNKY **
>  		$xtag =~ tr/_/\./ if ( $opt_u );
>  		$xtag =~ s/[\/]/$opt_s/g;
> - ...
> +
> +		system("git-tag $xtag $cid") == 0
>  			or die "Cannot create tag $xtag: $!\n";
> - ...
>  
>  		print "Created tag '$xtag' on '$branch'\n" if $opt_v;
>  	}
> -- 
> 1.5.2

Other than that I would write the "system" in a slightly newer
style, i.e.

	system('git-tag', $xtag, $cid)

I do not think of any obvious downside, either in the code nor
the change to use unannotated tag.

Anybody on the list see downsides with this?
