From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] Cleanup git-send-email.perl:extract_valid_email
Date: Sat, 03 Jun 2006 20:10:23 -0400
Message-ID: <200606040010.k540ANa4015204@laptop11.inf.utfsm.cl>
References: <normalperson@yhbt.net>
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Sun Jun 04 02:10:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmgCd-0003se-2T
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 02:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWFDAKk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 20:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWFDAKk
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 20:10:40 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:58005 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750913AbWFDAKk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 20:10:40 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192] (may be forged))
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k540AYPH007792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 20:10:34 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k540ANa4015204;
	Sat, 3 Jun 2006 20:10:28 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: Message from Eric Wong <normalperson@yhbt.net> 
   of "Sat, 03 Jun 2006 15:49:36 MST." <20060603224935.GA10324@hand.yhbt.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
X-Greylist: Recipient e-mail whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Sat, 03 Jun 2006 20:10:34 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21233>

Eric Wong <normalperson@yhbt.net> wrote:
> "Horst H. von Brand" <vonbrand@inf.utfsm.cl> wrote:
> > - Fix the regular expressions for local addresses
> > - Fix the fallback regexp for non-local addresses, simplify the logic
> > 
> > Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
> > ---
> >  git-send-email.perl |    9 +++------
> >  1 files changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index ed1d89b..a7a7797 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -314,18 +314,15 @@ sub extract_valid_address {
> >  	my $address = shift;
> >  
> >  	# check for a local address:
> > -	return $address if ($address =~ /^([\w\-]+)$/);
> > +	return $address if ($address =~ /^([\w\-.]+)$/);
> 
> I keep forgetting this, '+' is a valid (and useful) setup, too.

Oops...

> >  	if ($have_email_valid) {
> >  		return Email::Valid->address($address);
> >  	} else {
> >  		# less robust/correct than the monster regexp in Email::Valid,
> >  		# but still does a 99% job, and one less dependency
> > -		my $cleaned_address;
> > -		if ($address =~ /([^\"<>\s]+@[^<>\s]+)/) {
> > -			$cleaned_address = $1;
> > -		}
> > -		return $cleaned_address;
> > +		$address =~ /([\w\-.]+@[\w\-.]+)/;
> > +		return $1;
> 
> Actually, I'm retracting my earlier ack on this.  This is way too
> restrictive.  I'd rather allow an occasional invalid email address than
> to reject valid ones.  I generally trust git users to know what they're
> doing when entering email addresses[1].
> 
> *, $, ^, +, = are all valid characters in the username portion (not sure
> about local accounts, though), and I'm sure there are more that I don't
> know about.

As a general principle, I prefer to check what is legal instead of trying
to filter out what isn't.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
