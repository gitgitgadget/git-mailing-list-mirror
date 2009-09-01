From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (Aug 2009, #05; Wed, 26)
Date: Tue, 1 Sep 2009 00:18:25 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908312300250.28290@iabervon.org>
References: <7vfxbeb0mt.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0908292116060.28290@iabervon.org> <7vskfat07h.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0908311130190.28290@iabervon.org> <7vhbvnzhdq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 06:19:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiKqI-0007pi-Jc
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 06:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbZIAESY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 00:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbZIAESY
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 00:18:24 -0400
Received: from iabervon.org ([66.92.72.58]:44782 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732AbZIAESY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 00:18:24 -0400
Received: (qmail 12949 invoked by uid 1000); 1 Sep 2009 04:18:25 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Sep 2009 04:18:25 -0000
In-Reply-To: <7vhbvnzhdq.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127520>

On Mon, 31 Aug 2009, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Sat, 29 Aug 2009, Junio C Hamano wrote:
> >
> >> ..., if only to avoid confusion with our own earlier misdesigned
> >> syntax git+ssh://), so the canonical syntax would be:
> >
> > (with the syntax <helper>+, "git+ssh://" would specify the helper "git", 
> > which is as good an explicit identifier of the internal handling as any)
> 
> Sure but how would you explain "ssh+git://" then ;-)?

That's just weird, and looks wrong to me, like ssh tunnelled over the git 
native protocol. I think, if we support it, it would have to be another 
special case.

> Luckily neither is advertised in our documentation set as far as I can
> tell, so I do not think it is a huge deal between + vs ::, but as Peff
> says in
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/125615
> 
> I think the latter is probably less problematic.
> 
> With plus, a helper that talks with a Subversion repository whose native
> URL is http://host/path would look like svn+http://host/path, which is
> reasonable.  When talking the Subversion protocol over SSH, however, the
> native URL for the repository would be svn+ssh://host/path, so the URL
> with helper name on our side becomes svn+svn+ssh://host/path.  We could
> recognize "svn+" part and implicitly pass the whole thing to svn helper
> upon seeing svn+ssh://host/path, but I do not think we would want to make
> the dispatcher too familiar with what the backends do.  Using something
> other than plus sign would avoid this issue.

I was thinking that the dispatcher would always pass the whole thing, and 
the svn helper would have to deal with svn+http:// and svn+svn:// as well 
as svn+ssh://. The dispatcher shouldn't be familiar with what the backends 
do, but the backends could stand to be familiar with what might be there 
just to get to them. On the other hand, I don't have a good intuition for 
what makes sense to users of such systems, since I've only extensively 
used cvs, git, and perforce.

> > If the policy is that we're going to have "traditionally supported" 
> > schemes, where the internal code knows what helper supports them, I can 
> > fix up the series so that the curl-based helper is named "curl", and we 
> > can say that the check for "http://", "ftp://", and "https://" is
> > recognizing traditionally-supported schemes, and we can defer coming up 
> > with what the syntax for the explicit handler selection is. (For that 
> > matter, if there's a // after the colon, it's obviously not a 
> > handy ssh-style location, since the second slash would do nothing)
> 
> That sounds like a sane approach to first get the "eject curl from
> builtin" out the door.  We might extend the dispatcher in the future by
> changing "traditionally supported" criterion to "commonly used",
> e.g. recognize "svn+ssh://" as something the svn helper would want to
> handle, but that is a future extension we do not have to address right
> now.

Fair enough.

> >> After you explained this in the thread (I think for the second time), I
> >> see no problem with this, except that I think to support this we should
> >> notice and raise an error when we see a remote has both vcs and url,
> >> because the only reason we would want to say "vcs", if I recall your
> >> explanation correctly, is that such a transport does not have the concept
> >> of URL, i.e. a well defined single string that identifies the repository.
> >
> > A user who mostly uses Perforce as a foreign repositories but is using a 
> > SVN repo on occasion might want to use "vcs" regardless, but I agree with 
> > forcing the helper to use a different option for the case of a URL that 
> > git isn't going to look at. That is, you ought to be able to use:
> >
> > [remote "origin"]
> > 	vcs = svn
> > 	(something) = http://svn.savannah.gnu.org/...
> >
> > But "(something)" shouldn't be "url".
> 
> I actuallly do not have a strong opinion on this one either way.  I said
> "I think" when I suggested it, but it was actually without thinking too
> deeply, hoping that you would come up with a good counter-argument.
> 
> For example, if we envision that for most of the helpers there will be one
> primary string that identifies the repository, but the primary string
> alone is not enough for the helper without some auxiliary information, it
> would be natural to use remote.$name.url for that primary string.  I do
> not know if that would be the case, but I was hoping that you would have a
> better intuition[*1*], as you have thought this topic through a lot longer
> and deeper than I have.  So I'd rather leave the decision on that "no
> vcs/url at the same time restriction" up to you.  It is in general easier
> to start more strict and then loosen the restiction later, than the other
> way around, when we cannot decide, though.

Agreed.

> Thanks.
> 
> [Footnote]
> 
> *1* What I mean by intuition is that you do not have to have the right
> answer backed by research _now_, but have a good guess as to what the
> right answer would be.

I don't really have a particularly good guess about the case of vcs and a 
URL, because I haven't used systems that are not git and use URLs.

	-Daniel
*This .sig left intentionally blank*
