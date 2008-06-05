From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git clone stable-2.6.25.y fails over HTTP
Date: Thu, 5 Jun 2008 16:53:57 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806051546480.19665@iabervon.org>
References: <200806041511.m54FBPL9006783@pogo.cesa.opbu.xerox.com> <20080604154523.GA25747@kroah.com> <7vr6bdxh3l.fsf@gitster.siamese.dyndns.org> <20080605040315.GA21798@kroah.com> <7vabi05xl1.fsf@gitster.siamese.dyndns.org>
 <20080605050855.GA22825@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Andrew Klossner <andrew@cesa.opbu.xerox.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 22:55:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4MUJ-0000uW-0V
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 22:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761817AbYFEUyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 16:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759724AbYFEUyA
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 16:54:00 -0400
Received: from iabervon.org ([66.92.72.58]:51954 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759688AbYFEUx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 16:53:59 -0400
Received: (qmail 30698 invoked by uid 1000); 5 Jun 2008 20:53:57 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Jun 2008 20:53:57 -0000
In-Reply-To: <20080605050855.GA22825@kroah.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83979>

On Wed, 4 Jun 2008, Greg KH wrote:

> On Wed, Jun 04, 2008 at 09:12:42PM -0700, Junio C Hamano wrote:
> > Greg KH <greg@kroah.com> writes:
> > 
> > > On Wed, Jun 04, 2008 at 10:09:02AM -0700, Junio C Hamano wrote:
> > >
> > >> A quick fix is obviously to remove the extra prefix but it makes me wonder
> > >> how these two "stable" repositories were prepared differently.  Could this
> > >> be a regression in "git clone"?  Or perhaps you "clone -s"'s Linus's
> > >> repository slightly differently between them?
> > >
> > > That's odd.
> > >
> > > Chris was the one that created the .24 tree and I created the .25 tree,
> > > so we must have done so differently, sorry.
> > 
> > No need to be sorry.  Thanks for raising the issue up.
> > 
> > I think I have one possible explanation.  When "git clone" was rewritten
> > in C some time ago, it started to dereference symlinks, and newer git
> > would dereference /pub -> /home/ftp/pub when you do:
> > 
> > 	git clone -s --bare /pub/scm/linux/kernel/git/torvalds/linux-2.6/ linux-2.6.2x.y
> > 
> > while the scripted version used to keep /pub/scm path.
> > 
> > A bit further digging is necessary to make sure if we can fix this easily,
> > but I suspect this is worth fixing.
> 
> I can duplicate what I did, and it did it again:
> 	on master.kernel.org:
> 	$ cd /pub/scm/linux/kernel/git/stable/
> 	$ git clone -s --bare ../torvalds/linux-2.6.git/ test
> 	$ cat test/objects/info/alternates
> 	/home/ftp/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects
> 
> I'm guessing this is because /pub/ is a symlink:
> 	$ ls -l /pub
> 	lrwxrwxrwx 1 root root 13 Feb  4  2006 /pub -> /home/ftp/pub

We're using getcwd() to make the absolute path, but it looks like we 
should check whether $PWD is set and names the same directory, and, if so, 
base on that instead.

Actually, make_absolute_path() seems to go to an awful lot of trouble to 
make sure that there aren't symlinks in the resulting path. Is this 
actually necessary or even desireable for some reason? Should clone be 
just pasting $PWD (or, failing that, getcwd()) and the given path, and 
using that to identify the repo to clone?

	-Daniel
*This .sig left intentionally blank*
