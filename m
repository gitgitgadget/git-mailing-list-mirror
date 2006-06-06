From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] Cleanup git-send-email.perl:extract_valid_email
Date: Tue, 06 Jun 2006 11:42:09 -0400
Message-ID: <200606061542.k56Fg9Cm006226@laptop11.inf.utfsm.cl>
References: <junkio@cox.net>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
	Ryan Anderson <ryan@michonline.com>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 17:44:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FndiV-0006c8-F5
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 17:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWFFPnf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 11:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWFFPnf
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 11:43:35 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:60819 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751326AbWFFPne (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 11:43:34 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192] (may be forged))
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k56FgEMb020370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 6 Jun 2006 11:42:15 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k56Fg9Cm006226;
	Tue, 6 Jun 2006 11:42:09 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Mon, 05 Jun 2006 23:59:00 MST." <7v1wu2zs5n.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 06 Jun 2006 11:42:26 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21381>

Junio C Hamano <junkio@cox.net> wrote:
> Horst von Brand <vonbrand@inf.utfsm.cl> writes:
> 
> >> >  	# check for a local address:
> >> > -	return $address if ($address =~ /^([\w\-]+)$/);
> >> > +	return $address if ($address =~ /^([\w\-.]+)$/);
> >> 
> >> I keep forgetting this, '+' is a valid (and useful) setup, too.
> >
> > Oops...
> >> 
> >> Actually, I'm retracting my earlier ack on this.  This is way too
> >> restrictive.  I'd rather allow an occasional invalid email address than
> >> to reject valid ones.  I generally trust git users to know what they're
> >> doing when entering email addresses[1].
> >> 
> >> *, $, ^, +, = are all valid characters in the username portion (not sure
> >> about local accounts, though), and I'm sure there are more that I don't
> >> know about.
> >
> > As a general principle, I prefer to check what is legal instead of trying
> > to filter out what isn't.

> If we start doing addr-spec in RFC2822 (page 17) ourselves, we
> should rather be using Email::Valid.  A permissive sanity check
> to catch obvious mistakes would be more appropriate here than
> being RFC police.

OK.

> I think something like the attached, on top of your patch, would
> be appropriate for upcoming 1.4.0.
> 
> -- >8 --
> send-email: be more lenient and just catch obvious mistakes.
> 
> This cleans up the pattern matching subroutine by introducing
> two variables to hold regexp to approximately match local-part
> and domain in the e-mail address.  It is meant to catch obvious
> mistakes with a cheap check.
> 
> The patch also moves "scalar" to force Email::Valid->address()
> to work in !wantarray environment to extract_valid_address;
> earlier it was in the caller of the subroutine, which was way
> too error prone.

Right.

> ---
> diff --git a/git-send-email.perl b/git-send-email.perl
> index a7a7797..700d0c3 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -312,16 +312,18 @@ our ($message_id, $cc, %mail, $subject, 
>  
>  sub extract_valid_address {
>  	my $address = shift;
> +	my $local_part_regexp = '[^<>"\s@]+';
> +	my $domain_regexp = '[^.<>"\s@]+\.[^<>"\s@]+';

This forces a '.' in the domain, while vonbrand@localhost is perfectly
reasonable. Plus it doesn't disallow adyacent '.'s. What about:

        my $domain_regexp = '[^.<>"\s@]+(\.[^<>"\s@]+)*';

(but this is probably nitpicking...)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
