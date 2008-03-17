From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: tracking repository
Date: Sun, 16 Mar 2008 22:13:36 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803162143230.19665@iabervon.org>
References: <frh8dg$t9j$1@ger.gmane.org> <7vabkzmltc.fsf@gitster.siamese.dyndns.org> <1205697779.12760.20.camel@duo> <7vwso2ieuu.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803161716470.19665@iabervon.org> <7vlk4ichm4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, kenneth johansson <ken@kenjo.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 03:14:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb4rj-0005Uz-RU
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 03:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbYCQCNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 22:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbYCQCNi
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 22:13:38 -0400
Received: from iabervon.org ([66.92.72.58]:54856 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752309AbYCQCNi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 22:13:38 -0400
Received: (qmail 26869 invoked by uid 1000); 17 Mar 2008 02:13:36 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Mar 2008 02:13:36 -0000
In-Reply-To: <7vlk4ichm4.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77411>

On Sun, 16 Mar 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > We don't currently have any concept of an invalid refspec;
> 
> We don't? or just that parse_ref_spec() does not detect one?

I don't think we ever formalized anything; it just makes sure not to 
actually create anything bad, and doesn't give any feedback on the 
configuration.

> > ... we just have 
> > things that fall back to not being patterns and not being possible to 
> > match (due to one or the other side being invalid as a ref name).
> 
> I am afraid that is an invitation for more bugs and confusions.
> 
> It probably is not too late to fix this; users would rather want to see
> their misconfigurations clearly flagged as such, rather than the code
> letting bogosity through silently and doing something that does not
> exactly match what they configured.

I think I wasn't sure that aborting on invalid input wouldn't cause worse 
problems. There were actually a number of tests, IIRC, that required that 
certain configurations silently did nothing, which I mostly left alone.

Also, it's possible that we're parsing refspecs because we're using "git 
remote" to modify the configuration to replace an invalid refspec, and it 
would be unfortunate to die() because the remote has an invalid refspec.
 
> > diff --git a/remote.c b/remote.c
> > index f3f7375..fffde34 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -404,18 +404,17 @@ struct refspec *parse_ref_spec(int nr_refspec, const char **refspec)
> >  			rs[i].force = 1;
> >  			sp++;
> >  		}
> > -		gp = strchr(sp, '*');
> > +		gp = strstr(sp, "/*");
> >  		ep = strchr(sp, ':');
> >  		if (gp && ep && gp > ep)
> >  			gp = NULL;
> 
> How would this trigger?  We find * (or /*) but that is the one on the LHS,
> which means the spec was like "refs/heads/foobar:refs/remotes/origin/*",
> and it makes me wonder if we should mark this as an configuration error.

It's that case (there's a *, but not until after the :); I think the 
history was that the code first just looked for <a>:<b>, and used it for 
non-pattern matches, and then started using <a>/*:<b>/* as a pattern 
first, and then I made the C version match that shell version.

> Did erroring out on "gp && ep && gp > ep" here have issues (i.e. reject a
> valid configuration)?

Nope.

> >  		if (ep) {
> >  			if (ep[1]) {
> > -				const char *glob = strchr(ep + 1, '*');
> > +				const char *glob = strstr(ep + 1, "/*");
> >  				if (!glob)
> >  					gp = NULL;
> >  				if (gp)
> > -					rs[i].dst = xstrndup(ep + 1,
> > -							     glob - ep - 1);
> > +					rs[i].dst = xstrndup(ep + 1, glob - ep);
> 
> This truncates "refs/heads/*:refs/remotes/origin/*/bar" as if it did not
> have "/bar" without any error indication.  The same questions apply.

That one was just an oversight. I was just glad I didn't have to make it 
actually support that refspec and have it do the obvious (but annoying to 
implement) thing.

	-Daniel
*This .sig left intentionally blank*
