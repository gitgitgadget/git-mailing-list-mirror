From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH not-for-mainline] Implement git-vcs-p4
Date: Wed, 27 Jan 2010 12:28:07 -0500 (EST)
Message-ID: <alpine.LNX.2.00.1001271218360.14365@iabervon.org>
References: <alpine.LNX.2.00.1001251628431.14365@iabervon.org> <1a6be5fa1001270318h4ac8ac3bnaba48787a5b3efa6@mail.gmail.com> <20100127155636.GA18210@Knoppix> <alpine.LNX.2.00.1001271145500.14365@iabervon.org> <20100127171426.GA20820@Knoppix>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tor Arvid Lund <torarvid@gmail.com>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Jan 27 18:28:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaBgj-0000YA-3F
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 18:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755649Ab0A0R2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 12:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755587Ab0A0R2P
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 12:28:15 -0500
Received: from iabervon.org ([66.92.72.58]:44719 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754150Ab0A0R2P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 12:28:15 -0500
Received: (qmail 11643 invoked by uid 1000); 27 Jan 2010 17:28:07 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Jan 2010 17:28:07 -0000
In-Reply-To: <20100127171426.GA20820@Knoppix>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138175>

On Wed, 27 Jan 2010, Ilari Liusvaara wrote:

> On Wed, Jan 27, 2010 at 11:49:02AM -0500, Daniel Barkalow wrote:
> > On Wed, 27 Jan 2010, Ilari Liusvaara wrote:
> > 
> > > On Wed, Jan 27, 2010 at 12:18:35PM +0100, Tor Arvid Lund wrote:
> > > 
> > > > Then, I did 'git fetch', and got a seg fault. I got around it by
> > > > commenting out a line:
> > > > 
> > > > diff --git a/transport.c b/transport.c
> > > > index 7714fdb..5b404f7 100644
> > > > --- a/transport.c
> > > > +++ b/transport.c
> > > > @@ -924,7 +924,7 @@ struct transport *transport_get(struct remote
> > > > *remote, const char *url)
> > > >         ret->url = url;
> > > > 
> > > >         /* In case previous URL had helper forced, reset it. */
> > > > -       remote->foreign_vcs = NULL;
> > > > +/*     remote->foreign_vcs = NULL;*/
> > > > 
> > > >         /* maybe it is a foreign URL? */
> > > >         if (url) {
> > > > 
> > > 
> > > Hmm... And just commenting out that line will break case if you have
> > > push URL using remote helpers and second one for same remote that
> > > doesn't. 
> > > 
> > > I'll look into that issue.
> > 
> > I think that field should only be used for things like:
> > 
> > [remote "foo"]
> > 	vcs = something
> > 	...
> > 
> > and the case where the helper is inferred from the URL shouldn't use a 
> > field on the remote, but be passing the information around in function 
> > arguments. A field of the struct remote only really makes sense with 
> > information that applies to the whole remote.
> 
> Why that 'remote->foreign_vcs = NULL;' is there is the following case:
> 
> [remote "origin"]
> url = gits::git://[@/tmp/gits]/git-d2
> url = ssh://repo.or.cz/srv/git/git-daemon2.git
> 
> The first URL is handled by 'gits' helper (as it should). But without
> resetting the helper, it tries to pass that ssh:// URL to 'gits' helper
> too (instead of handling it internally).
> 
> But, that reset didn't take the vcs setting into account.

Yes, but the first URL should be directed to the 'gits' helper 
without setting remote->foreign_vcs. That is, instead of setting 
remote->foreign_vcs, you should just call transport_helper_init(ret, 
xstrndup(url, p - url));

	-Daniel
*This .sig left intentionally blank*
