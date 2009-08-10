From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 5/8] Add a config option for remotes to specify a foreign
 vcs
Date: Mon, 10 Aug 2009 15:30:44 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908101205120.27553@iabervon.org>
References: <alpine.LNX.2.00.0908091526060.27553@iabervon.org> <7v1vnk79lt.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0908092153520.27553@iabervon.org> <200908101032.12835.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Aug 10 21:30:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Maaa5-0005AF-Kd
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 21:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbZHJTap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 15:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbZHJTap
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 15:30:45 -0400
Received: from iabervon.org ([66.92.72.58]:37371 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447AbZHJTao (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 15:30:44 -0400
Received: (qmail 24536 invoked by uid 1000); 10 Aug 2009 19:30:44 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Aug 2009 19:30:44 -0000
In-Reply-To: <200908101032.12835.johan@herland.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125498>

On Mon, 10 Aug 2009, Johan Herland wrote:

> On Monday 10 August 2009, Daniel Barkalow wrote:
> > On Sun, 9 Aug 2009, Junio C Hamano wrote:
> > > Daniel Barkalow <barkalow@iabervon.org> writes:
> > > > If this is set, the url is not required, and the transport always
> > > > uses a helper named "git-remote-<value>".
> > > >
> > > > It is a separate configuration option in order to allow a sensible
> > > > configuration for foreign systems which either have no meaningful
> > > > urls for repositories or which require urls that do not specify the
> > > > system used by the repository at that location. However, this only
> > > > affects how the name of the helper is determined, not anything about
> > > > the interaction with the helper, and the contruction is such that, if
> > > > the foreign scm does happen to use a co-named url method, a url with
> > > > that method may be used directly.
> > >
> > > Personally, I do not like this.
> > >
> > > Why isn't it enough to define the canonical remote name git takes as
> > > "<name of the helper>:<whatever string the helper understands>"?
> >
> > [...]
> >
> > The only way I've been able to come up with to support this at all
> > usefully is to have a bunch of helper-specific options that specify what
> > the helper needs to know about the locations you consider to be part of
> > the project and an option that tells git that this remote uses the p4
> > helper. I'm not sure what makes sense for other helpers, but the case I
> > actually use needs something like what's in this patch.
> 
> I'm somewhat agnostic on this issue. At the moment, I follow the P4 cues,
> and use a config like this:
> 
>     [remote "foo"]
>         vcs = cvs
>         cvsRoot = ":pserver:user@cvs.server.example.com/var/cvs/cvsroot"
>         cvsModule = "bar"
>         ...
> 
> But I could just as well use a config like this instead:
> 
>     [remote "foo"]
>         url = "cvs::pserver:user@cvs.server.example.com/var/cvs/cvsroot#bar"
>         ...
> 
> Either is fine with me, although I suspect users might find the
> current/first alternative easier to parse.

I suspect there will be some users who want (1) and some who want (2), and 
both ought to work.

> > I think it makes sense for svn access to support just having a url
> > option like "svn://something (svn native protocol)", or
> > "svn+ssh://something (svn protocol over ssh)" or "svn+https://something
> > (https access to a svn repo)", or some other similar syntax, but this is
> > a poor fit for p4.
> >
> > In order to support this, there just needs to be a call to check whether
> > "remote-<something>" is an available git command (without running it or
> > giving an error), and the helper code should be used if it is. This is
> > actually required so that people with workstations whose domain is
> > .kernel.org and who have cloned "master:/home/linus/something.git" don't
> > start getting "remote-master isn't a git command" errors (that is,
> > misinterpreting ssh-format location hostnames as helper names. Johan,
> > perhaps you could write that for your CVS helper?
> 
> Sorry, not following you here. Write exactly what?
> 
> - The code in the transport layer for checking if "remote-<something>"
>   is an available git command?

That's what I was thinking.

> - The code in my CVS helper for handling the ssh-format misinterpretation,
>   i.e. the case where someone has a git/ssh server called "cvs"? If so,
>   how should this be handled?

I'd been thinking that people's servers wouldn't be named "cvs", but they 
might be named things that aren't clearly not plausible names for helpers. 
So I don't think there should be a need to deal with misdirected names 
going to actual helpers, just names for helpers that don't exist.

> > I think that, ideally, helpers for foreign systems would be portable
> > across multiple native systems. The svn helper could be a program
> > "svn-remote-access-helper", and anything that speaks fast-import (e.g.,
> > bzr or hg) would be able to use it. When installing it for git, you'd
> > symlink it to git-remote-svn; if you decided to install
> > "svn-remote-access-helper-ng", you'd change the symlink.
> 
> In that case, helpers must keep their metadata in a repo-independent
> format. Currently that is outside the scope of my CVS helper, since I'm
> leveraging git-notes for most of the CVS helper's metadata.

Yeah, that's one of several tricky issues. I don't think there's enough 
experience yet to design something to support portable helpers, but I 
think it's worth thinking about.

	-Daniel
*This .sig left intentionally blank*
