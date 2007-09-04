From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32 API
Date: Tue, 4 Sep 2007 22:54:08 +0100
Message-ID: <3f4fd2640709041454jcb361d7p7e96ac1cf0062987@mail.gmail.com>
References: <46DACE0D.5070501@trolltech.com> <46DBFA2A.7050003@trolltech.com>
	 <Pine.LNX.4.64.0709031428080.28586@racer.site>
	 <46DC5ED4.8050202@trolltech.com> <46DD0C16.70101@eudaptics.com>
	 <Pine.LNX.4.64.0709041145230.28586@racer.site>
	 <46DD433A.5040604@eudaptics.com>
	 <Pine.LNX.4.64.0709041324420.28586@racer.site>
	 <Pine.LNX.4.64.0709041356070.28586@racer.site>
	 <20070904210200.GA32472@nospam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@wingding.demon.nl,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Johannes Sixt" <j.sixt@eudaptics.com>,
	"Marius Storm-Olsen" <marius@trolltech.com>,
	"Johannes Sixt" <johan
X-From: git-owner@vger.kernel.org Tue Sep 04 23:54:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISgLh-0004FP-EE
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 23:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbXIDVyK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 17:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752202AbXIDVyK
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 17:54:10 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:60816 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbXIDVyI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 17:54:08 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2363535wah
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 14:54:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iv0zxp7Ik0eP1XmgncMc6Q/VjnZR7g/8lsDV3GelnYw4rUYIzT54rHIEe5c1cEsQWI9xUZKDJ4vqwj5titfyihHR5ozNG5mIpG9EdwSIzxnY++ZSdmNRbEnpUJvVyF/g9OVnDtAbNxKkdPhyDMTYX3Kq1vUGoWig65UdOKOlYyY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s/Tn9N0uJSi68qrtzZrFnUIAZknby3RCW1O1LJr16xU9dmX8bP8dHVxF2pVSIqIhtM/WZ3ygJSJoUxba0FcQDDd7ulB8HUmfp8+foZKdrTK8Xn7knQlEl7qMRU5q0lxrZByT3gQWkLzowtikyKOx3agEolHMhiwOVhrBoyspVqw=
Received: by 10.140.148.3 with SMTP id v3mr2488195rvd.1188942848201;
        Tue, 04 Sep 2007 14:54:08 -0700 (PDT)
Received: by 10.141.32.14 with HTTP; Tue, 4 Sep 2007 14:54:08 -0700 (PDT)
In-Reply-To: <20070904210200.GA32472@nospam.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57653>

On 04/09/07, Rutger Nijlunsing <rutger@nospam.com> wrote:
> On Tue, Sep 04, 2007 at 01:57:38PM +0100, Johannes Schindelin wrote:
> > Hi,
> >
> > On Tue, 4 Sep 2007, Johannes Schindelin wrote:
> >
> > > On Tue, 4 Sep 2007, Johannes Sixt wrote:
> > >
> > > > Johannes Schindelin schrieb:
> > > > > On Tue, 4 Sep 2007, Johannes Sixt wrote:
> > > > > > Therefore, I've pushed out a fixup patch at the top of mingw.git's
> > > > > > devel branch that converts mtime to local time
> > > > >
> > > > > On Linux, we compare to UTC to begin with, right?  We should do that
> > > > > here, too...  So if time(NULL) does not return UTC on MinGW, we have
> > > > > to wrap that function, too.
> > > >
> > > > According to MSDN, time(NULL) returns "the number of seconds elapsed
> > > > since [epoch] according to the system clock". Please don't ask me what
> > > > "the system clock" is.
> > >
> > > I think I know.  From my QEmu adventures I know that DOS/Windows expects
> > > the system clock to be set to local time, in contrast to _all_ other
> > > operating systems.
> >
> > Now I am utterly confused.  MSDN says
> >
> >       FILETIME
> >
> >       Contains a 64-bit value representing the number of 100-nanosecond
> >       intervals since January 1, 1601 (UTC).
> >
> > Hmm.
>
>
> [Warning: war stories ahead...]
>
> If you really, really want to know more:
>
> http://search.cpan.org/~shay/Win32-UTCFileTime-1.45/lib/Win32/UTCFileTime.pm

Hmm, this may explain something that I have been observing on
Windows+cygwin. When I run `git diff`, I sometimes get it reporting
that all (from what I can tell) files have changed, like a `find .
-type f -exec touch {} \;` command was run.

I was going to report this on a new thread, but this looks like a more
relevant place to do so.

My Windows machine is currently in Daylight Savings Time mode, and
from my observations, I have only seen this repeat first thing the
next day. I am not sure why, but every 24hrs, it looks as if the file
time reported by and checked from git is different to that reported by
stat.

I have not had time yet to play around with the mingw port and this
new stat implementation to see if it addresses this issue.

- Reece
