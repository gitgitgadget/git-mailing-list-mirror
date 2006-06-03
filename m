From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Cleanup git-send-email.perl:extract_valid_email
Date: Sat, 3 Jun 2006 15:49:36 -0700
Message-ID: <20060603224935.GA10324@hand.yhbt.net>
References: <11493547080-git-send-email-vonbrand@inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Sun Jun 04 00:49:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmew8-0004Lv-IN
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 00:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbWFCWth (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 18:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbWFCWth
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 18:49:37 -0400
Received: from hand.yhbt.net ([66.150.188.102]:11488 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751823AbWFCWtg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 18:49:36 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 3EFCC7DC005; Sat,  3 Jun 2006 15:49:36 -0700 (PDT)
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <11493547080-git-send-email-vonbrand@inf.utfsm.cl>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21230>

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> wrote:
> - Fix the regular expressions for local addresses
> - Fix the fallback regexp for non-local addresses, simplify the logic
> 
> Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
> ---
>  git-send-email.perl |    9 +++------
>  1 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index ed1d89b..a7a7797 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -314,18 +314,15 @@ sub extract_valid_address {
>  	my $address = shift;
>  
>  	# check for a local address:
> -	return $address if ($address =~ /^([\w\-]+)$/);
> +	return $address if ($address =~ /^([\w\-.]+)$/);

I keep forgetting this, '+' is a valid (and useful) setup, too.

>  
>  	if ($have_email_valid) {
>  		return Email::Valid->address($address);
>  	} else {
>  		# less robust/correct than the monster regexp in Email::Valid,
>  		# but still does a 99% job, and one less dependency
> -		my $cleaned_address;
> -		if ($address =~ /([^\"<>\s]+@[^<>\s]+)/) {
> -			$cleaned_address = $1;
> -		}
> -		return $cleaned_address;
> +		$address =~ /([\w\-.]+@[\w\-.]+)/;
> +		return $1;

Actually, I'm retracting my earlier ack on this.  This is way too
restrictive.  I'd rather allow an occasional invalid email address than
to reject valid ones.  I generally trust git users to know what they're
doing when entering email addresses[1].

*, $, ^, +, = are all valid characters in the username portion (not sure
about local accounts, though), and I'm sure there are more that I don't
know about.

[1] - of course, without address book support in git-send-email, I think
I would've left the 'k' out of Junio's email address by now.  Of course
there's also the issue of where I work and having several people using
variations of rob/robert in their email address.  I'm likely to make
errors like these far more than entering addresses that email systems
consider invalid, and I suspect I'm not the only one.

-- 
Eric Wong
