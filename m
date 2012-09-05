From: Alex Vandiver <alex@chmrr.net>
Subject: Re: [PATCH] cvsimport: strip all inappropriate tag strings
Date: Wed, 05 Sep 2012 02:44:29 -0400
Message-ID: <1346827469.1137.22.camel@umgah.localdomain>
References: <7vsjax6trn.fsf@alter.siamese.dyndns.org>
	 <1346819164-8116-1-git-send-email-ktdreyer@ktdreyer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ken Dreyer <ktdreyer@ktdreyer.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 09:04:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T99ed-0003qJ-P1
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 09:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109Ab2IEHD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 03:03:56 -0400
Received: from chmrr.net ([209.67.253.66]:43668 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957Ab2IEHDz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 03:03:55 -0400
X-Greylist: delayed 1155 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Sep 2012 03:03:55 EDT
Received: from c-65-96-172-157.hsd1.ma.comcast.net ([65.96.172.157] helo=[10.0.1.28])
	by utwig.chmrr.net with esmtpsa (SSLv3:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <alex@chmrr.net>)
	id 1T99Lm-00062m-VZ; Wed, 05 Sep 2012 02:44:39 -0400
In-Reply-To: <1346819164-8116-1-git-send-email-ktdreyer@ktdreyer.com>
X-Mailer: Evolution 2.32.2 
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Exim-Version: 4.76 (build at 25-May-2011 17:04:25)
X-Date: 2012-09-05 02:44:39
X-Connected-IP: 65.96.172.157:41781
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204800>

On Tue, 2012-09-04 at 22:26 -0600, Ken Dreyer wrote:
> When importing CVS tags, strip all the inappropriate strings from the
> tag names as we translate them to git tag names.
>
> [snip]
> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
> index 8d41610..0dc598d 100755
> --- a/git-cvsimport.perl
> +++ b/git-cvsimport.perl
> @@ -889,7 +889,25 @@ sub commit {
>  		$xtag =~ s/\s+\*\*.*$//; # Remove stuff like ** INVALID ** and ** FUNKY **
>  		$xtag =~ tr/_/\./ if ( $opt_u );
>  		$xtag =~ s/[\/]/$opt_s/g;
> -		$xtag =~ s/\[//g;
> +
> +		# See ref.c for these rules.
> +		# Tag cannot end with a '/' - this is already handled above.
> +		# Tag cannot contain bad chars. See bad_ref_char in ref.c.
> +		$xtag =~ s/[ ~\^:\\\*\?\[]//g;
> +		# Tag cannot contain '..'.
> +		$xtag =~ s/\.\.//g;
> +		# Tag cannot contain '@{'.
> +		$xtag =~ s/\@{//g;
> +		# Tag cannot end with '.lock'.
> +		$xtag =~ s/(?:\.lock)+$//;
> +		# Tag cannot begin or end with '.'.
> +		$xtag =~ s/^\.+//;
> +		$xtag =~ s/\.+$//;
> +		# Tag cannot consist of a single '.' - already handled above.
> +		# Tag cannot be empty.
> +		if ($xtag eq '') {
> +			return;
> +		}

Unfortunately, this isn't quite sufficient.  Consider the case of a tag
named "foo.lock."  The .lock rule doesn't match, because it's not at the
end of the string -- but after s/\.+$// runs, it _is_ at the end, and
hence invalid.  A similar problem exists with a tag named "a.@{.b",
given the ordering of @{ and .. removal.

Something like the following would suffice:

    1 while $xtag =~ s/
               (?: \.\.        # Tag cannot contain '..'.
               |   \@{         # Tag cannot contain '@{'.
               |   \.lock $    # Tag cannot end with '.lock'.
               | ^ \.          # Tag cannot begin...
               |   \. $        # ...or end with '.'
               )//xg;

 - Alex
