From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/3] builtin-remote: teach show to display remote HEAD
Date: Thu, 12 Feb 2009 17:55:04 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0902121656570.19665@iabervon.org>
References: <1234332083-45147-1-git-send-email-jaysoffian@gmail.com>  <1234332083-45147-2-git-send-email-jaysoffian@gmail.com>  <1234332083-45147-3-git-send-email-jaysoffian@gmail.com>  <20090212002612.GC30231@coredump.intra.peff.net> 
 <76718490902111748j58f80591ma149f8ec9fb8b352@mail.gmail.com>  <alpine.LNX.1.00.0902121519160.19665@iabervon.org> <76718490902121337l4b7f6f1dh25e6daa9adb48160@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 23:56:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXkU0-0007vt-J7
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 23:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038AbZBLWzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 17:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbZBLWzI
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 17:55:08 -0500
Received: from iabervon.org ([66.92.72.58]:34652 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751238AbZBLWzH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 17:55:07 -0500
Received: (qmail 9592 invoked by uid 1000); 12 Feb 2009 22:55:04 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Feb 2009 22:55:04 -0000
In-Reply-To: <76718490902121337l4b7f6f1dh25e6daa9adb48160@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109675>

On Thu, 12 Feb 2009, Jay Soffian wrote:

> On Thu, Feb 12, 2009 at 3:27 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> >
> > struct ref *head = locate_head(refs, refs, NULL);
> > return head ? xstrdup(abbrev_branch(head->name)) : NULL;
> >
> > ?
> 
> No, I don't _think_ so. refs is everything from the remote side (tags,
> etc). I want to only match those things under refs/heads.

I was looking at your code and comparing with locate_head; it looks to me 
like you're using "ref" for both of the lists of refs that locate_head() 
gets. I think, actually, that checking for refs/heads in locate_head() 
would be a reasonable thing in general, and might avoid getting surprising 
results in clone with --mirror and odd refs or such.

> I think I have to do something like this (this is more or less what
> builtin-clone does):
> 
> struct ref *remote_refs, *mapped_refs = NULL;
> struct refspec branch_refspec;
> 
> branch_refspec.force = 0;
> branch_refspec.src = branch_refspec.dst = "refs/heads";
> 
> remote_refs = transport_get_remote_refs(transport);
> get_fetch_map(remote_refs, branch_refspec, &mapped_refs, 0);
> head_points_at = locate_head(refs, mapped_refs, NULL);

You should be able to filter the ref list you already have, rather than 
refetching, if nothing else.

> > I'd somehow thought I'd moved locate_head() somewhere common, but it
> > really ought to be done.
> 
> I plan to move it into remote.c.

Good.

> > There were periodic discussions of how you find
> > out when the remote repo changes its HEAD and you might want to do
> > something locally about it, and we never came up with a specific thing
> > for git to do, but the facility is probably useful.
> 
> Thus "git remote set-head -a" is the best I could come up with for
> setting it to what the remote has.

Yeah, that seems like a good interface.

> > I have the vague memory, as well, that there's some way for a transport to
> > report that it actually knows that HEAD is a symref to something in
> > particular, and so git shouldn't guess.
> 
> I think for http://, but not for git://, but I'm *far* from an expert
> in this area.

Yes, it was information only available for http, but there's no reason to 
assume that other protocols couldn't provide it, and Junio mentioned a 
series from December (maybe never applied) to get the same info for the 
native git protocol.

	-Daniel
*This .sig left intentionally blank*
