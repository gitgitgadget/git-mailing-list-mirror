From: Jeff King <peff@peff.net>
Subject: Re: Is the "text" attribute meant *only* to specify end-of-line
 normalization behavior, or does it have broader implications?
Date: Fri, 30 Mar 2012 17:30:56 -0400
Message-ID: <20120330213055.GC20734@sigill.intra.peff.net>
References: <CANSc5vG0o_eAn7X39XhCzUoN4ab52pGCP+PvzOQCyTV31R8LGg@mail.gmail.com>
 <4F7555BC.1000804@viscovery.net>
 <20120330072546.GC30656@sigill.intra.peff.net>
 <CANSc5vGaodyv4H5qp2ZkjY7q6ot7_JG0jdvNDFRBFW1+p7v4sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Chris Harris <ryguasu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 23:31:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDjPd-00019O-99
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 23:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936113Ab2C3VbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 17:31:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41432
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936109Ab2C3Va6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 17:30:58 -0400
Received: (qmail 20710 invoked by uid 107); 30 Mar 2012 21:30:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Mar 2012 17:30:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2012 17:30:56 -0400
Content-Disposition: inline
In-Reply-To: <CANSc5vGaodyv4H5qp2ZkjY7q6ot7_JG0jdvNDFRBFW1+p7v4sw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194411>

On Fri, Mar 30, 2012 at 10:49:42AM -0700, Chris Harris wrote:

> > However, I find the behavior of "Git Extensions" to be questionable. I
> > can see the rationale for thinking that "-text" means more than just
> > handling line-endings, but I think "-diff" is probably a better choice
> > for seeing if something is binary (or even checking the "binary" macro).
> > Those are what git uses itself.
> [...]
> A related point of confusion: I've noticed that, if you start with a
> question along the lines of "how can I explicitly tell git that a file
> is binary", then the web currently gives a slightly confusing array of
> answers. For example:
> * The Pro Git Book (http://progit.org/book/ch7-2.html) tells you to
> use either "binary" or "-crlf -diff"

I think setting "binary" is the most sane thing. Ultimately, I think
what it comes down to is this: git provides a bunch of per-operation
attributes for treating a file as binary for a particular operation. It
also provides a "binary" macro to conveniently cover all of the
operations.

Git Extensions cares about binary-ness for a _new_ operation, which is
showing the file at all (that is what I got from your original email, at
least; I have never used Git Extensions myself). The equivalent in git
would be perhaps for "git show HEAD:file" to either print a text file,
or to say "This is a binary file". But since git itself does not care
about binary-ness for that operation (we just always show the file), we
have not defined an operation-specific attribute.

So what is something like Git Extensions to do? It can introduce a new
attribute, but of course nobody is likely to be using it. It can depend
on "binary", except that some people will manually spell out "-crlf
-diff" instead of saying "binary". Or it can piggy-back on "-text" or
"-diff", which can be subtly wrong in cases where the file is not
binary, but you want to disable those operations (i.e., your case).

Of those, just checking "binary" seems like the least wrong thing to me.

> * "man gitattributes" has helpful info, but it's scattered across
> different sections. In the section "Marking files as binary", it says
> "The simplest way to mark a file as binary is to unset the diff
> attribute in the .gitattributes file".

Note that "Marking files as binary" is actually a subsection in
"Generating diff text". We could probably do a better job of mentioning
the "binary" macro there, though.

> (Note: This implies that there > are other ways you might also want to
> consider.)

Yes. You can also use a custom diff driver (e.g., "diff=foo"), and then
tell the diff driver that the file should be considered binary (by
setting diff.foo.binary in your config).

> Under "Performing a three-way merge" you also learn that "-merge" is
> "suitable for binary files that do not have a well-defined merge
> semantics".

Arguably the "binary" macro should imply "-merge". And like -diff, we
the documentation should probably reference the section on the "binary"
macro.

> You learn about the "binary" attribute only under the section
> "Defining Macro Attributes", which says that it means "-text -diff",
> but not in what cases you might want to use it. The section describing
> "text"/"-text" does not contain the word "binary" at all, so you have
> to infer whether it's a helpful setting for binary files.

I think it is the case that binary files should imply "-text", but
"-text" does not necessarily imply binary files. But like the other
spots, it should probably say "hey, if you are dealing with a binary
file, you might want to just set the binary attribute macro".

-Peff
