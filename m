From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/19] t5800: document some non-functional parts of
 remote helpers
Date: Thu, 9 Jun 2011 21:18:58 -0400
Message-ID: <20110610011858.GA12256@sigill.intra.peff.net>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-4-git-send-email-srabbelier@gmail.com>
 <20110608192850.GF27715@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 03:19:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUqNR-0007cu-EV
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 03:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757340Ab1FJBTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 21:19:03 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37524
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753992Ab1FJBTC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 21:19:02 -0400
Received: (qmail 22653 invoked by uid 107); 10 Jun 2011 01:19:09 -0000
Received: from 70-36-146-246.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.246)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 21:19:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 21:18:58 -0400
Content-Disposition: inline
In-Reply-To: <20110608192850.GF27715@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175592>

On Wed, Jun 08, 2011 at 02:28:51PM -0500, Jonathan Nieder wrote:

> > but we have no way of
> > communicating to fast-export that this name mapping is
> > happening.
> 
> It's not just name mapping, no?  E.g., I could try
> 
> 	git push testgit::/path/to/repo $(git rev-parse HEAD):new
> 
> So I think the current implementation of "export" by testgit
> is just wrong. ;-)

Yeah, it's the same issue. We have no way of communicating the name of
the right-hand ref at all to a helper, aside from asking fast-export to
munge the refname in its output stream. But we have no way of telling
fast-export that even though we asked for "foo", it needs to write the
result into "bar" (and potentially _also_ into "foo", if it's a ref
found on the RHS of a different refspec).

> This seems like a reasonable solution.  One way would be to teach
> fast-export about refspecs; another way would be to set up refs in a
> private namespace and then munge the stream that fast-export spits out
> before passing it back to the transport-helper; another (more ugly and
> hackish) way would be to set up a private repository with the real
> repository set up as an alternate, put the appropriate refs there, and
> point fast-export to that.

Munging the stream is a little tricky. We have to correctly parse the
stream and not just do something hack-ish like sed (which is what
git-remote-testgit does, but that's OK, because it's a hack-ish
test script).

But we also have to take care to handle duplicates. So exporting
"refs/heads/foo:refs/heads/bar" would mean that we rewrite all of
refs/heads/foo into refs/heads/bar on commit lines. But two refspecs
like "refs/heads/foo:refs/heads/bar refs/heads/foo:refs/heads/foo" mean
we must write all of the commit lines as "foo" and then do a "reset" of
bar to foo at the end (at least this is what fast-export already does).
But we also need to handle criss-crosses, like:

  refs/heads/foo:refs/heads/bar refs/heads/baz:refs/heads/foo

In that case we want change all commit lines for "foo" to "bar", but
also all for "baz" to "foo".

So implementation-wise, the simplest way is if you can give each tip a
name, and then at the end assign all of the tips to refnames (this is
more or less what regular push does internally, of course).

I'm not too familiar with the fast-import protocol or what other
systems' fast importers are capable of. Is it OK to just make a bunch of
commits with marks, and then at the end do our resets? That would make
the problem much simpler, I think.

> Anyway, I don't think this should be in the commit message for the new
> test which doesn't even know about the remote helper protocol. :)

Yeah, maybe not. I wanted to stick the discussion somewhere, and since I
never actually fixed this bug, there wasn't another relevant commit. :)

> > --- a/t/t5800-remote-helpers.sh
> > +++ b/t/t5800-remote-helpers.sh
> > @@ -81,4 +81,51 @@ test_expect_success PYTHON_24 'pushing remote local repo' '
> >  	compare_refs clone HEAD server HEAD
> >  '
> >  
> > +test_expect_failure PYTHON_24 'fetch new branch' '
> 
> Side note: this repeated PYTHON_24 implementation detail as a
> prerequisite feels wrong.  Would it make sense to do something like
> 
> 	if test_have_prereq PYTHON_24
> 	then
> 		test_set_prereq REMOTE_TESTGIT
> 	fi
> 
> at the start and use that?

Really, I think you could just exit early if PYTHON_24 isn't set, as all
of the tests require it. If we end up with other non-python helper
tests, they will probably go in a separate script anyway.

> > +test_expect_failure PYTHON_24 'push new branch with old:new refspec' '
> > +	(cd clone &&
> > +	 git push origin new-name:new-refspec
> > +	) &&
> > +	compare_refs clone HEAD server refs/heads/new-refspec
> > +'
> 
> It would also be interesting to test tag pushes and pushes by object
> name.
> [examples]

Agreed.

-Peff
