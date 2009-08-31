From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (Aug 2009, #05; Wed, 26)
Date: Mon, 31 Aug 2009 13:06:24 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908311130190.28290@iabervon.org>
References: <7vfxbeb0mt.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0908292116060.28290@iabervon.org> <7vskfat07h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 19:06:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiAKz-0001k7-4y
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 19:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbZHaRG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 13:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbZHaRG1
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 13:06:27 -0400
Received: from iabervon.org ([66.92.72.58]:57036 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365AbZHaRG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 13:06:26 -0400
Received: (qmail 5843 invoked by uid 1000); 31 Aug 2009 17:06:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Aug 2009 17:06:24 -0000
In-Reply-To: <7vskfat07h.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127487>

On Sat, 29 Aug 2009, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> >> There was a discussion that suggests that the use of colon ':' before vcs
> >> helper name needs to be corrected.  Nothing happened since.
> >
> > I believe the outcome of that discussion was:
> >
> >  - We want to keep supporting using regular location URLs that are URLs of 
> >    git repositories (e.g., http://git.savannah.gnu.org/cgit/xboard.git), 
> >    and we probably want to do it with a helper which runs when 
> >    run_command() is given "remote-<scheme>". I think installing hardlinks 
> >    in EXECPATH ended up being the best implementation here.
> 
> That is different from what I recall.
> 
> I think you said <scheme> in the above to mean that in the general URL
> syntax, <scheme> refers to the token before the colon, and you would be
> feeding the rest (i.e. after the colon, and for many <scheme>'s it
> typically begins with //) to the scheme.
>
> A flaw with this that was pointed out was that this conflicts with the
> scp-like syntax.  A remote.$name.url of foo:bar/baz could name
> $HOME/bar/baz on host foo (perhaps a nickname in .ssh/config), or the
> source "foo" helper recognizes with the name bar/baz.
>
> If I recall correctly, suggestions made later in the discussion were to
> use either <helper>+ or <helper>:: as the prefix to avoid this issue, and
> use it to choose remote-<helper> (and I think I probably would vote for
> double-colon, if only to avoid confusion with our own earlier misdesigned
> syntax git+ssh://), so the canonical syntax would be:

(with the syntax <helper>+, "git+ssh://" would specify the helper "git", 
which is as good an explicit identifier of the internal handling as any)

> 
> 	<helper>::<whatever is fed to the helper, typicall a URL>
> 
> while we would support obvious short-hands for transports we traditionally
> supported without explicit "<helper>::" prefix when we choose to eject it
> from "built-in" set of transports.
>
> E.g. http://git.savannah.gnu.org/cgit/xboard.git would be handled by curl
> based walker, so if you spell it in the very canonical form, the url would
> be curl::http://git.savannah.gnu.org/cgit/xboard.git, but nobody has to
> use it.  Instead, the transport dispatcher internally recognizes http://
> and picks the curl based walker helper, which is remote-curl without any
> extra hardlinks.

If the policy is that we're going to have "traditionally supported" 
schemes, where the internal code knows what helper supports them, I can 
fix up the series so that the curl-based helper is named "curl", and we 
can say that the check for "http://", "ftp://", and "https://" is 
recognizing traditionally-supported schemes, and we can defer coming up 
with what the syntax for the explicit handler selection is. (For that 
matter, if there's a // after the colon, it's obviously not a 
handy ssh-style location, since the second slash would do nothing)

I think you're right that we decided that things we used to support 
internally are a special case, and there's no need to try to generalize 
them to be the general mechanism (even though I think we simultaneously 
worked out how to implement the design we were abandoning, which confused 
my memory).

> >  - We want to support a separate "vcs" option for cases where repositories 
> >    in the foreign system need to be addressed through the combination of a 
> >    bunch of options, which will be read from the configuration by the 
> >    helper. The helper which gets run is "remote-<value of vcs option>". 
> >    This is in pu.
> 
> After you explained this in the thread (I think for the second time), I
> see no problem with this, except that I think to support this we should
> notice and raise an error when we see a remote has both vcs and url,
> because the only reason we would want to say "vcs", if I recall your
> explanation correctly, is that such a transport does not have the concept
> of URL, i.e. a well defined single string that identifies the repository.

A user who mostly uses Perforce as a foreign repositories but is using a 
SVN repo on occasion might want to use "vcs" regardless, but I agree with 
forcing the helper to use a different option for the case of a URL that 
git isn't going to look at. That is, you ought to be able to use:

[remote "origin"]
	vcs = svn
	(something) = http://svn.savannah.gnu.org/...

But "(something)" shouldn't be "url".

So my changes will be:

 - name the curl-based helper executable "git-remote-curl", and run it for 
   traditionally supported schemes by special-case.
 - prohibit using both "vcs" and "url" in a remote.

Agreed?

	-Daniel
*This .sig left intentionally blank*
