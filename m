From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fix simple deepening of a repo
Date: Mon, 24 Aug 2009 23:12:48 -0700
Message-ID: <20090825061248.GG1033@spearce.org>
References: <alpine.LFD.2.00.0908220106470.6044@xanadu.home> <alpine.LFD.2.00.0908232320410.6044@xanadu.home> <7vocq5q0j7.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0908240144530.28290@iabervon.org> <alpine.LNX.2.00.0908242212260.26869@reaper.quantumfyre.co.uk> <alpine.LFD.2.00.0908242001250.6044@xanadu.home> <20090825021223.GE1033@spearce.org> <7vab1osc2m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 08:12:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfpH7-0006C7-S3
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 08:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbZHYGMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 02:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753693AbZHYGMr
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 02:12:47 -0400
Received: from george.spearce.org ([209.20.77.23]:41174 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbZHYGMr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 02:12:47 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A92D8381FD; Tue, 25 Aug 2009 06:12:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vab1osc2m.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127009>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > We aren't quite at the 50k ref stage yet, but we're starting to
> > consider that some of our repositories have a ton of refs, and
> > that the initial advertisement for either fetch or push is horrid.
> >
> > Since the refs are immutable I could actually teach the JGit
> > daemon to hide them from JGit's receive-pack, thus cutting down the
> > advertisement on push, but the refs exist so you can literally say:
> 
> What do you mean "refs are immutable"?
> 
> Do you mean "In the particular application, Gerrit, the server knows that
> certain refs will never move nor get deleted, once they are created"?  If
> so, then I would understand, but otherwise what you are describing is not
> git anymore ;-)

The former.  :-)

I mean that this particular server implementation will deny any
update made to refs/changes/, as if one had the following as the
update hook on that repository:

  #!/bin/sh
  case "$1" in
  refs/changes/*) exit 1;;
  *) exit 0;
  esac

This of course is completely legal, and since the server knows the
ref cannot be moved, there is no need to advertise it to the client.
But this is a very specialized thing, its rare that the thing that
formats the advertisement knows what the update hook will permit
to be modified.
 
> >   git fetch --uploadpack='git upload-pack --ref refs/changes/88/4488/2' URL refs/changes/88/4488/2
> >
> > Personally I'd prefer extending the protocol, because making the
> > end user supply information twice is stupid.
> 
> In the upload-pack protocol, the server talks first, so it is rather hard
> to shoehorn a request from a client to ask "I know about refs/changes/*
> hiearchy, so don't talk about them".

Actually, that assumption is still a problem.

The client knows the *name* of the ref, but not the SHA-1 the ref is
currently valued at.  Thus when the client knows it wants a certain
ref by name, it needs to send a "want " line to the server that would
give it whatever that ref currently points at.  Unfortunately since we
have not obtained that value yet, we are stuck.

However, we do have one name we want to know about, but the server may
have 50k other names in the same namespace we do not know about.

I was thinking instead that we have a new protocol extension:

  S: ... HEAD\0side-band ... expand-refs
  S: ... refs/heads/master
  S: 0000

  C: ... expand refs/changes/88/4488/2
  C: 0000

  S: ... refs/changes/88/4488/2
  S: 0000

  C: ... want XXXXXX\0side-band-64k ...
 
> Of course, the client side cannot grab everything with refs/*:refs/remotes/*
> wildcard refspecs from such a server, but I think that can be considered a
> feature.

If expand accepted globs like fetch does, then fetch can ask for
expand of refs/changes/* if it does not see any refs/changes/*
on advertisement.  Or just expand a particular ref, or handful of
refs, that the user has asked for on the fetch line.

The problem with this is servers which are sending this expand-refs
tag have hidden certain namespaces from older clients.  Those names
can't be seen by older git clients, unless the user does an upgrade.

This might be OK for Gerrit Code Review's refs/changes/ namespace,
but it may not be good for others.


-- 
Shawn.
