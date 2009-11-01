From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Fw: git-core: SIGSEGV during {peek,ls}-remote on HTTP remotes.
Date: Sun, 1 Nov 2009 16:19:34 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911011518590.14365@iabervon.org>
References: <20091101.010702.527849118592864646._deepfire@feelingofgreen.ru> <7v8weq50pm.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0911011348190.14365@iabervon.org> <7vljiqxapw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Samium Gromoff <_deepfire@feelingofgreen.ru>,
	git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>,
	Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 22:19:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4hpt-0008Gj-HP
	for gcvg-git-2@lo.gmane.org; Sun, 01 Nov 2009 22:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625AbZKAVTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2009 16:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753535AbZKAVTa
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 16:19:30 -0500
Received: from iabervon.org ([66.92.72.58]:60374 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753482AbZKAVTa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2009 16:19:30 -0500
Received: (qmail 22310 invoked by uid 1000); 1 Nov 2009 21:19:34 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Nov 2009 21:19:34 -0000
In-Reply-To: <7vljiqxapw.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131881>

On Sun, 1 Nov 2009, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Sat, 31 Oct 2009, Junio C Hamano wrote:
> > ...
> >> Attached is a minimum fix/work around, but this is done without being very
> >> familiar with the current assumptions in the codepaths involved.
> >> 
> >> Issues I want area experts to consider before coming up with the final fix
> >> are:
> >> ... 
> > I think there's no benefit to allowing NULL for the remote; I think you 
> > can always get a struct remote for what you want to access. So it's 
> > probably just as well to require it, particularly because, as in the case 
> > of cmd_ls_remote() below, you'd need a special case to not get a struct 
> > remote.
> >
> > Is there any way in which the intended semantics of "transport_get(NULL, 
> > url)" is not the same as "transport_get(remote_get(url), url)"?
> > (And, in the extended series, I make "transport_get(remote_get(url), 
> > NULL)" also mean the same thing as above, while "transport_get(NULL, 
> > NULL)" is obviously underspecified.)
> 
> That was really my question to people who are involved in the transport
> layer code.  I didn't know how transport->url and transport->remote->url
> are intended to relate to each other, for example, and that was why you
> were on Cc list.  In other words, you are the area expert, you tell me ;-)

transport->remote->url[...] has all of the URLs for a remote; 
transport->url has the particular one this struct transport is supposed to 
contact. At least, that was my intent, but I think some of the code that 
uses struct transports didn't realize that remote_get() will work in any 
context where transport_get() will work. (And this might have been broken 
at the time).

> Sverre seemed to think slightly differently; perhaps having worked on the
> foreign vcs interface he has some other input.

I think we agree that transport-helper.c ought to be able to deal with 
anything transport.c will put together. But I'd also like to tighten what 
transport.c will put together and I don't think he considered that 
possibility.

> > Do things like git_path() fail cleanly if there was no git directory?  If
> > not, there should probably be tests of nongit on paths that actually need 
> > a git directory,...
> 
> I don't know.  Again, you tell me ;-)

I'm not an expert on that part. But it looks like it misbehaves, returning 
".git/foo" even when that path doesn't make sense.

> It probably makes sesne as you outlined in the earlier part of your
> response for the caller to give a bit more clue to the helper to help
> making such a decision.

Yeah, it's probably worth getting that in at this point. I'll write up 
some patches.

	-Daniel
*This .sig left intentionally blank*
