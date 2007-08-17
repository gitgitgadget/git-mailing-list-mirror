From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] - git-send-email.perl
Date: Fri, 17 Aug 2007 16:38:02 -0700
Message-ID: <7vy7g9enqd.fsf@gitster.siamese.dyndns.org>
References: <1186984174.10249.7.camel@localhost>
	<200708131933.10125.m.kozlowski@tuxland.pl>
	<1187026955.2688.4.camel@laptopd505.fenrus.org>
	<1187037445.6628.98.camel@heimdal.trondhjem.org>
	<1187054366.2757.0.camel@laptopd505.fenrus.org>
	<46C10AA8.3090505@gmail.com>
	<20070814102033.604c8695@the-village.bc.nu>
	<46C1CFFE.4000001@gmail.com> <1187110824.32555.76.camel@localhost>
	<7vwsvx8twx.fsf@assigned-by-dhcp.cox.net>
	<1187316783.822.19.camel@localhost>
	<1187317826.822.23.camel@localhost>
	<1187373278.822.100.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rene Herman <rene.herman@gmail.com>, git@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Sat Aug 18 01:38:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMBOL-0001HO-AN
	for gcvg-git@gmane.org; Sat, 18 Aug 2007 01:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581AbXHQXiH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 19:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbXHQXiH
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 19:38:07 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:33429 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbXHQXiE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 19:38:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070817233804.IBSA11194.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 17 Aug 2007 19:38:04 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id dBe21X00D1gtr5g0000000; Fri, 17 Aug 2007 19:38:02 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56098>

Joe Perches <joe@perches.com> writes:

> Here's a path to enable a command line option
> that takes a string argument
>
> 	cc-cmd
>
> This modifies the @cc array to include whatever
> output is produced by cc_cmd $patchfile
>
> cccmd can be stored in a config settings file
>
> previous versions of this patch were submitted
> against an older version of git-send-email.perl

... Signed-off-by: ...


> diff --git a/git-send-email.perl b/git-send-email.perl
> index 69559b2..828a77a 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -46,6 +46,9 @@ Options:
>     --cc           Specify an initial "Cc:" list for the entire series
>                    of emails.
>  
> +   --cc-cmd       Specify a command to execute per file which adds
> +                  per file specific cc address entries
> +
>     --bcc          Specify a list of email addresses that should be Bcc:
>  		  on all the emails.
>  

I do not see a patch to "Documentation/git-send-email.txt" here...

> @@ -652,11 +657,21 @@ foreach my $t (@files) {
>  		}
>  	}
>  	close F;
> +
> +	if (${cc_cmd} ne "") {
> +	    my $output = `${cc_cmd} $t`;
> +	    my @lines = split("\n", $output);
> +	    foreach my $c (@lines) {
> +		push @cc, $c;
> +		printf("(cc-cmd) Adding cc: %s from: '%s'\n", $c, $cc_cmd)
> +		    unless $quiet;
> +	    }
> +	}
> +

Something like this, with appropriate error checking, perhaps?

	open my $cc, "${cc_cmd} $t |";
        while (my $c = <$cc>) {
        	...
	}
        close $cc;
