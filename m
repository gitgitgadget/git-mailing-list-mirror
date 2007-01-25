From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: .git/info/refs
Date: Thu, 25 Jan 2007 09:14:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701250900380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45B70D06.3050506@zytor.com> <ep78r0$h2u$1@sea.gmane.org>   
 <45B7818F.6020805@zytor.com> <200701242140.07459.jnareb@gmail.com>
 <2197.69.104.58.50.1169671494.squirrel@www.zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Jan 25 09:14:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9zkK-0005Te-Ru
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 09:14:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965695AbXAYIOI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 03:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965696AbXAYIOI
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 03:14:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:33268 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965695AbXAYIOH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 03:14:07 -0500
Received: (qmail invoked by alias); 25 Jan 2007 08:14:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 25 Jan 2007 09:14:05 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <2197.69.104.58.50.1169671494.squirrel@www.zytor.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37710>

Hi,

On Wed, 24 Jan 2007, hpa@zytor.com wrote:

> > H. Peter Anvin wrote:
> >
> >>> Besides, we can't rely that .git/info/refs is up to date, or even
> >>> exists.
> >>> It is for dumb protocols, not for gitweb.
> >>
> >> Well, SOMETHING needs to be done for this page, since it can take 15
> >> minutes or more to generate.  Caching doesn't help one iota, since it's
> >> stale before being generated.
> >
> > The simple and fast solution would be to make post-update hook contain
> > the git-for-each-ref with parameters like in git_get_last_activity,
> > saving e.g. to .git/info/last-committer, and in gitweb read this file
> > if it exist, run git-for-each-ref otherwise (similar to what we used to
> > do with .git/info/refs and git-peek-remote in gitweb).
> >
> 
> Right, this is basically what I'm saying; the question is only whether or
> not this fits into .git/info/refs or should be a separate file.
> 
> Either way, I think git-update-server-info should generate all these files.

Well, no. At least not per default. What you want is _very_ special to 
gitweb. It is _only_ needed by gitweb. And .git/info/refs is for _dumb 
transports_, _not_ for gitweb.

That said, I think it makes sense _in your setup_ to trigger updating 
_another_ file for use in gitweb.

Remember, this is all very, very special for gitweb. So let's separate it 
cleanly from all which is not special for gitweb.

I hope I have made it clear why (at least IMHO) it would be wrong, wrong, 
wrong to change the format of .git/info/refs _only_ for gitweb, which it 
is not meant for to begin with.

So let's introduce another file in .git/info/ especially dedicated to 
gitweb.

Then we are free to introduce real cool performance hacks, like using 
Storable to store the parsed data structures (I was alluding to this in an 
earlier reply, as "serializing"). Then you just retrieve the file -- if it 
exists -- or call for-each-ref (like Jakub said).

By separating this gitweb-special thing cleanly, maybe into a hook, we can 
have a perl script which writes this file. We can write a simple hash, 
which may or may not contain keys, thus being of "extensible format".

By having this perl script, you can -- as root -- run it as the 
appropriate user for each repository where it does not exist yet.

Remains the problem: how do we _force_ this hook enabled site-wide, i.e. 
in _all_ repos?

But that is too easy: just edit the existing template, and then replace 
the update hooks in all repos (possibly verifying that the existing update 
hook indeed matches the old template).

So what problems remain with this approach?

Ciao,
Dscho
