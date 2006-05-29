From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] git-send-email.perl extract_valid_address issue
Date: Mon, 29 May 2006 17:06:21 -0400
Message-ID: <200605292106.k4TL6L4o014248@laptop11.inf.utfsm.cl>
References: <ryan@michonline.com>
Cc: Nicolas Troncoso Carrere <ntroncos@alumnos.inf.utfsm.cl>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 23:07:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkoxG-0001vK-9W
	for gcvg-git@gmane.org; Mon, 29 May 2006 23:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWE2VHK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 17:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWE2VHK
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 17:07:10 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:5586 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751296AbWE2VHI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 17:07:08 -0400
Received: from laptop11.inf.utfsm.cl (laptop11.inf.utfsm.cl [200.1.19.198])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k4TL6LHW031702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 May 2006 17:06:21 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k4TL6L4o014248;
	Mon, 29 May 2006 17:06:21 -0400
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: Message from Ryan Anderson <ryan@michonline.com> 
   of "Mon, 29 May 2006 13:00:27 MST." <20060529200026.GA32457@h4x0r5.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 29 May 2006 17:06:21 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20970>

Ryan Anderson <ryan@michonline.com> wrote:
> On Mon, May 29, 2006 at 12:00:44AM -0400, Nicolas Troncoso Carrere wrote:
> > 
> > The third fallback was returning if the match was done or not instead of
> > returning the actual email address that was matched. This prevented sending
> > the mail to the people included in the CC. This bug only affect those that
> > dont have Email::Valid.
> > 
> > I initialized $valid_email as undef so it would mimic the behavior of 
> > Email::Verify->address(), which returns undef if no valid address was found.
> 
> Odd, I noticed the same thing this weekend.
> 
> > Signed-off-by: Nicolas <ntroncos@inf.utfsm.cl>
> Acked-by: Ryan Anderson <ryan@michonline.com>
> 
> (Or pick up my patch that fixes this in a slightly different way)
> 
> > 
> > 
> > ---
> > 
> >  git-send-email.perl |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> > 
> > 84853ca89c15de7a24e9eb9fd422654b86c63be9
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index 312a4ea..dfff3e6 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -316,7 +316,9 @@ sub extract_valid_address {
> >  	} else {
> >  		# less robust/correct than the monster regexp in Email::Valid,
> >  		# but still does a 99% job, and one less dependency
> > -		return ($address =~ /([^\"<>\s]+@[^<>\s]+)/);
> > +                my $valid_email=undef;
> > +                ($valid_email ) = ($address =~ /([^\"<>\s]+@[^<>\s]+)/);
> > +                return ($valid_email);
> >  	}
> >  }

I just looked it over, and this is certainly broken in the original. The
first return gives the string back if it matches, the second one evaluates
the list returned by the match in scalar context, and so returns 1 for a
match or 0 for non-match. Besides, the regexps are fishy...

- The first one won't consider 'Joe.Hacker' as a valid local address
- The second one will consider 'Joe.Hacker@example.com"' valid (note ")

Need to make both branches (with and without @) agree here, at least. And
this is certainly severely underpowered... dunno if it merits a better job
(or just bail out if Email::Valid isn't found, instead of kludgeing
around...)

Will propose a fix ASAP.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
