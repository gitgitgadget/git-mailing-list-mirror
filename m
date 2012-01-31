From: Jeff King <peff@peff.net>
Subject: Re: Alternates corruption issue
Date: Tue, 31 Jan 2012 15:44:17 -0500
Message-ID: <20120131204417.GA30969@sigill.intra.peff.net>
References: <1328018729.13744.26.camel@ted>
 <20120131193922.GA31551@sigill.intra.peff.net>
 <7v1uqf8vqu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	"Hart, Darren" <darren.hart@intel.com>,
	"Ashfield, Bruce" <Bruce.Ashfield@windriver.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 31 21:44:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsKYy-0001Y1-Jp
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 21:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861Ab2AaUoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 15:44:20 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51154
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557Ab2AaUoT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 15:44:19 -0500
Received: (qmail 1740 invoked by uid 107); 31 Jan 2012 20:51:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 31 Jan 2012 15:51:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jan 2012 15:44:17 -0500
Content-Disposition: inline
In-Reply-To: <7v1uqf8vqu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189471>

On Tue, Jan 31, 2012 at 12:25:45PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I believe that would work in your case, but it seems like the most
> > correct thing would actually be:
> >
> >   { "", "/.git", ".git" }
> >
> > That is:
> >
> >   1. Try the literal path the user gave as a repo
> >
> >   2. Otherwise, try it as the root of a working tree (containing .git)
> >
> >   3. Otherwise, assume they were too lazy to type ".git" and include it
> 
> That sounds sensible, together with this, to which I agree with:
> [...]
> ... but ...
> [...]
> > -	static char *suffix[] = { "/.git", ".git", "" };
> > +	static char *suffix[] = { "/.git", "", ".git" };
> 
> ... this does not match that simple and clear guideline.
> 
> Shouldn't this simply be { "", "/.git", ".git" }?

No, it does not match. While the sequence I outlined above makes the
most sense to me, it does not match what setup_git_directory does, which
prefers "foo/.git" to using "foo" as a bare repo. I think being
consistent between all of the lookup points makes sense. The patch took
the least-invasive approach and aligned clone and enter_repo with
setup_git_directory.

However, we could also tweak setup_git_directory to prefer bare repos
over ".git" to keep things consistent. While it makes me feel good from
a theoretical standpoint (because the rules above seem simple and
intuitive to me), I'm not sure it's a good idea in practice.

The case we would "catch" with such a change is when you have a ".git"
directory inside a bare repo. Right now, we prefer the ".git" inside it,
and ignore the containing bare repo. With such a change, we would prefer
the outer bare repo. Which makes sense to me. It does break a use
case like this:

  # make a new repo
  git init
  cd .git
  # now track parts of the repo
  git init
  git add config
  git commit -m 'tracking our repo config'

but I'm not sure if that is sane or not.

But also consider false positives. What if you have a repository that
looks like a git repo (i.e., has "objects", "refs", and "HEAD" in it),
but also has ".git". Right now we say "Oh, it has .git, that must be the
repo". But with the proposed change, we could accidentally find the
enclosing repo.

Now, the chances of is_git_directory being wrong seem quite slim to me.
But then, the chances of somebody actually have a repo with a ".git"
_inside_ it seem pretty slim to me. So I think we are really dealing
with a tiny corner case, and it is perhaps anybody's guess whether
anyone is depending on the current behavior in the wild. I don't overly
care either way, but when in doubt, I tend to stick with the existing
behavior.

> >  	if (!strict) {
> >  		static const char *suffix[] = {
> > -			".git/.git", "/.git", ".git", "", NULL,
> > +			"/.git", "", ".git/.git", ".git", NULL,
> >  		};
> 
> Neither does this.
> 
> Shouldn't this be { "", "/.git", ".git", ".git/.git", NULL }?

Right, same case.

> I must be missing something from your description...

I mentioned the issue in my original message, but perhaps didn't
emphasize it very well.

-Peff
