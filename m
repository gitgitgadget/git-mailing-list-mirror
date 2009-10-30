From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH 06/19] Factor ref updating out of fetch_with_import
Date: Fri, 30 Oct 2009 12:04:11 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910301118070.14365@iabervon.org>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>  <1256839287-19016-7-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0910300221290.14365@iabervon.org> <fabb9a1e0910300557x42d3612pf7e83907e91efdc9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 17:04:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3txc-0004GR-2F
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 17:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbZJ3QEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 12:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbZJ3QEI
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 12:04:08 -0400
Received: from iabervon.org ([66.92.72.58]:51526 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932461AbZJ3QEH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 12:04:07 -0400
Received: (qmail 7825 invoked by uid 1000); 30 Oct 2009 16:04:11 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Oct 2009 16:04:11 -0000
In-Reply-To: <fabb9a1e0910300557x42d3612pf7e83907e91efdc9@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131712>

On Fri, 30 Oct 2009, Sverre Rabbelier wrote:

> On Fri, Oct 30, 2009 at 00:10, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > Actually, I think the problem is that builtin-clone will always default to
> > setting up a refspec of "refs/heads/*:refs/remotes/origin/*", but that
> > doesn't actually make any sense if the source repository isn't presented
> > as having refs names like "refs/heads/*". The immediate problem that you
> > don't get HEAD because it's a symref to something outside the pattern is
> > somewhat secondary to the general problem that you don't get anything at
> > all, because everything's outside the pattern.
> 
> Ah, I didn't realize that as long as HEAD is a symref to something in
> refs/heads/* it would be fetched.

Clone only cares about the remote HEAD for the purpose of making 
refs/remotes/origin/HEAD a symref to something. It doesn't really want a 
SHA1 for it (except in order to guess that it's a symref to something that 
the remote has dereferenced in its list); and, since it's a symref, no 
objects have to be fetched for it -- except for the possibility that it's 
known to be a symref to something that wasn't fetched, in which case, we 
know that HEAD -> something, and something's SHA1 is sha1, but we didn't 
fetch something so we don't have sha1. Of course, I think clone then 
writes a dangling symref anyway and forgets about sha1.

> > I don't really think that presenting the real refs in refs/<vcs>/*, and
> > having the list give symrefs to them from refs/heads/* and refs/tags/*
> > really makes sense; I think it would be better to rework fetch_with_import
> > and the list provided by a foreign vcs helper such that it can present
> > refs with normal names (refs/heads/*, refs/tags/*, etc) if the foreign vcs
> > has standards that correspond to branches and tags. Then "clone" would
> > work normally.
> 
> Perhaps we could introduce an additional phase before import to set
> the default refspec? If we could tell git that we want
> "refs/heads/*:refs/hg/origin/*" before line 468 "if (option_bare) {",
> that would save us a lot of trouble. Does that sound like a good idea?
> It would mean we have to move the transport_get part up a bit, but I
> don't think that will be a problem. A svn helper for example might
> respond the following to the "refspec" command:
> "refs/heads/trunkr:refs/svn/origin/trunk"
> "refs/tags/*:refs/svn/origin/tags/*"
> "refs/heads/*:refs/svn/origin/branches/*"
> 
> How does that sound?

The values you've got for refspecs don't make sense as fetch refspecs; 
these would cause refs with names the helper won't supply to be stored in 
the helper's private namespace, which is certainly wrong. (And I think you 
have the sides backwards)

On the other hand, I think it would make sense to use the same style of 
refspec between the helper and transport-helper.c such that the helper 
reports something like:

refs/svn/origin/trunk:refs/heads/trunkr
refs/svn/origin/branches/*:refs/heads/*
refs/svn/origin/tags/*:refs/tags/*

"list" gives:

000000...000 refs/heads/trunkr

"import refs/heads/trunkr" imports the objects, but the refspecs have to 
be consulted by transport-helper.c in order to determine what ref to read 
to get the value of refs/heads/trunkr. Instead of getting the value with 
read_ref("refs/heads/trunkr", ...) like it does now, it would do 
read_ref("refs/svn/origin/trunk", ...). And systems like p4 that don't 
have a useful standard just wouldn't support the "refspec" command and 
people would have to do site-specific configuration to get anything 
useful.

	-Daniel
*This .sig left intentionally blank*
