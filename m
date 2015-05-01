From: Jeff King <peff@peff.net>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Fri, 1 May 2015 16:11:36 -0400
Message-ID: <20150501201136.GA3152@peff.net>
References: <1430346576.14907.40.camel@ubuntu>
 <20150429231150.GB3887@peff.net>
 <20150430003750.GA4258@peff.net>
 <1430355983.14907.55.camel@ubuntu>
 <20150430011612.GA7530@peff.net>
 <1430358345.14907.62.camel@ubuntu>
 <20150430033725.GB12361@peff.net>
 <1430450954.22711.69.camel@ubuntu>
 <20150501053559.GA13393@peff.net>
 <1430501355.2806.2.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 01 22:11:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoHHk-0008Ag-HE
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 22:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbbEAULj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 16:11:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:52985 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750737AbbEAULj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 16:11:39 -0400
Received: (qmail 9278 invoked by uid 102); 1 May 2015 20:11:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 15:11:39 -0500
Received: (qmail 19301 invoked by uid 107); 1 May 2015 20:12:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 16:12:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 May 2015 16:11:36 -0400
Content-Disposition: inline
In-Reply-To: <1430501355.2806.2.camel@ubuntu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268179>

On Fri, May 01, 2015 at 10:29:15AM -0700, David Turner wrote:

> > > Actually, I think 4 has an insurmountable problem.  Here's the case I'm
> > > thinking of:
> > > 
> > > ln -s ..  morx
> > > 
> > > Imagine that we go to look up 'morx/fleem'.  Now morx is the "last
> > > object we could resolve", but we don't know how much of our input has
> > > been consumed at this point.  So consumers don't know that after they
> > > exit the repo, they still need to find fleem next to it.
> > 
> > Yes, agreed (my list was written before Andreas brought up the idea of
> > symlinks in the intermediate paths). I think to let the caller pick up
> > where you left off, you would have to create a new string that has the
> > "remainder" concatenated to it.
> 
> Since that new string does not exist in the object db, isn't that pretty
> much proposal 3?  We could, in this case, provide a fake sha as well
> ("0"*40), to make it clear that the object does not exist.

Yes, I think it is the same as proposal 3. Complete with all of the
fake-object awkwardness. I'm not sure I like the fake-sha1 idea. The
general pattern for accessing an object is:

  1. Turn some user-provided name into an object (get_sha1).

  2. Retrieve that object content (read_sha1_file).

By pushing the symlink resolution into step 1, it "just works"
everywhere. But if we hand back a fake sha1, now every call-site has to
be aware of it.

I think the solutions range from:

  a. Put resolution in get_sha1. Return an error when we can't
     resolve. Callers are on their own to do anything else.

  b. Put resolution in get_sha1. If we can't resolve, return an error.
     If the _with_context variant is called, leave our partial result
     string there. Some callers may choose to expose that information
     (e.g., cat-file might), at which point the user can "pick up" where
     git leaves off for out-of-tree links.

  c. Forget about get_sha1. This gets implemented elsewhere (e.g., as a
     cat-file feature as you originally proposed).

Certainly (a) is tempting and simple, but my understanding of your use
case is that you would like to follow out-of-tree links.

It seems like (b) is the most flexible, in the sense that it would
solve your case, and allows "git rev-parse HEAD^{resolve}:foo" when the
result is well-formed inside the repository. But I wonder if it's
actually worth the complexity. Without exposing the information for the
user to continue the traversal, it seems like only half a solution for
those parts of the code. And we still have to design some kind of custom
output for cat-file to expose the context.

So maybe (c) really is the simplest way forward. I dunno. I know that's
coming full circle to your original proposal. Hopefully that isn't too
infuriating for you. ;)

-Peff
