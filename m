From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Refspec patterns with * in the middle
Date: Mon, 2 Mar 2009 13:22:45 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0903021231510.19665@iabervon.org>
References: <alpine.LNX.1.00.0903011820590.19665@iabervon.org> <7viqmrn98i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 19:24:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeCoL-0000kJ-Ih
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 19:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbZCBSWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 13:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbZCBSWs
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 13:22:48 -0500
Received: from iabervon.org ([66.92.72.58]:48221 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbZCBSWr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 13:22:47 -0500
Received: (qmail 10178 invoked by uid 1000); 2 Mar 2009 18:22:45 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Mar 2009 18:22:45 -0000
In-Reply-To: <7viqmrn98i.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111956>

On Mon, 2 Mar 2009, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > My use case is actually, more precisely:
> >
> > some/constant/stuff/$PROJ-$NUMBER/junk/my-proj
> >
> > Where $NUMBER is the version number, and $PROJ is usually, but not quite 
> > always "my-proj"; the exception being that it might be effectively a 
> > superproject. So I'd like to have:
> >
> >  fetch = some/constant/stuff/my-proj-*/junk/my-proj:refs/remotes/origin/*
> 
> ... and expect "some/constant/stuff/my-proj-2.5/junk/my-proj" to be mapped
> to "refs/remotes/origin/2.5"?  I think it does not look too bad.

Yeah.

> > But I can live with remote branches like "my-proj-2.4" instead of "2.4".
> >
> > I think it would make sense, and limit typo damage, to say that the * can 
> > only expand to something with a '/' in it if the star has a slash or the 
> > end of the string on each side.
> 
> I do not understand what you mean by "* can only expand to something with
> a '/' in it if ..." part.  None of the examples in your message have a
> case where the asterisk matches across directory boundaries, and I thought
> you would simply say "* does not match /" and be done with that.
> 
> What scenario do you have in mind that wants to match a slash with an
> asterisk?

Backwards compatibility? Currently, refs/heads/*:refs/remotes/origin/* 
will match refs/heads/js/notes with refs/remotes/origin/js/notes, because 
it simply copies everything after the fixed prefix.

I was assuming that that particular matching is an existing requirement 
(and that you used it regularly to share topic-maintenance work between 
machines).

So my idea was that a path component of "*" would be able to match 
multiple levels, while a path component of "something-*" or "*-something" 
can only match a single path component that starts or ends with the right 
thing. Looking at it now, I think it might be more sane to use "%" for the 
second case, and say: "*" must be used as a full path component, and 
matches one or more path components; "%" may be used as part of a path 
component, and doesn't match the path separator; you can only use one such 
character, and both sides of the refspec have to agree on which.

I think the problem cases were typos like:

refs/heads*:refs/remotes/origin/* (used to cause problems)

and

refs/heads/*:refs/remotes/origin* (gives you the originmaster remote?)

	-Daniel
*This .sig left intentionally blank*
