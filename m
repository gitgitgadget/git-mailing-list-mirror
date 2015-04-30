From: Jeff King <peff@peff.net>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Thu, 30 Apr 2015 14:27:00 -0400
Message-ID: <20150430182659.GB23431@peff.net>
References: <1430343059.14907.18.camel@ubuntu>
 <20150429214817.GA2725@peff.net>
 <1430346576.14907.40.camel@ubuntu>
 <20150429231150.GB3887@peff.net>
 <20150430003750.GA4258@peff.net>
 <1430355983.14907.55.camel@ubuntu>
 <20150430011612.GA7530@peff.net>
 <1430358345.14907.62.camel@ubuntu>
 <20150430033725.GB12361@peff.net>
 <87383ihqzp.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Apr 30 20:27:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YntAy-0007qa-C7
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 20:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbbD3S1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 14:27:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:52377 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751362AbbD3S1C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 14:27:02 -0400
Received: (qmail 11248 invoked by uid 102); 30 Apr 2015 18:27:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Apr 2015 13:27:02 -0500
Received: (qmail 7572 invoked by uid 107); 30 Apr 2015 18:27:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Apr 2015 14:27:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Apr 2015 14:27:00 -0400
Content-Disposition: inline
In-Reply-To: <87383ihqzp.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268087>

On Thu, Apr 30, 2015 at 12:04:10PM +0200, Andreas Schwab wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   4. Return the last object we could resolve, as I described. So
> >      foo/bar/baz (with "../../../external" as its content) in this case.
> >      When you resolve a name, you can ask for the context we discovered
> >      along the way by traversing the tree. The mode is one example we've
> >      already discussed, but the path name is another. So something like:
> >
> >        echo "HEAD^{resolve}:fleem" |
> >        git cat-file --batch="%(objectname) %(size) %(intreepath)"
> >
> >      would show:
> >
> >        1234abcd 17 foo/bar/baz
> >        ../../../external
> >
> >      And then the caller knows that the path is not relative to the
> >      original "fleem", but rather to "foo/bar/baz".
> 
> Note that ".." will always follow the *physical* structure, so if
> foo/bar/baz is walking over symbolic links, "../../.." may lead you to
> somewhere else entirely.

True. I had not considered that, as git does not walk over such symlinks
at all currently. But presumably one would want it to to implement this
kind of "follow symlink" logic. IOW, we cannot just look up
"foo/bar/baz" in the first place, as that may not even exist in the
tree; we may need to realize that "foo" is a symlink and resolve that
first, then find "bar/baz" in the destination.

Which means that I think this has to be implemented as part of the name
resolution (i.e., the "^{resolve}") proposal. cat-file could not say:

  get_sha1_with_context("HEAD:foo/bar/baz", sha1, &ctx);
  if (S_ISLNK(ctx.mode))
     ... resolve ...

The initial get_sha1 would fail if "foo" is a symlink. Likewise, one
cannot implement this by querying cat-file repeatedly without asking for
each leading prefix (so ask for "HEAD:foo", see if it's a link, then
"HEAD:foo/bar", etc).

Of course it does not _have_ to be part of the normal get_sha1 name
resolution. But if not, it would have to reimplement the tree-walking
part of that name resolution.

Thanks for giving another interesting case to consider.

-Peff
