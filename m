From: Jeff King <peff@peff.net>
Subject: Re: scan.coverity: improve the modeling file of git.git
Date: Tue, 22 Jul 2014 04:33:18 -0400
Message-ID: <20140722083318.GA24324@peff.net>
References: <53CC3855.8050500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: john@szakmeister.net, sam@vilain.net,
	GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 10:33:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9VVo-0004IO-OY
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 10:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341AbaGVIdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 04:33:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:38078 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752100AbaGVIdV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 04:33:21 -0400
Received: (qmail 15585 invoked by uid 102); 22 Jul 2014 08:33:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 Jul 2014 03:33:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jul 2014 04:33:18 -0400
Content-Disposition: inline
In-Reply-To: <53CC3855.8050500@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254007>

On Sun, Jul 20, 2014 at 11:44:53PM +0200, Stefan Beller wrote:

> We're currently seeing lots of false positives
> as the xmalloc/xrealloc function is handled not properly
> by coverity. There are lots of errors "Allocation too small for type"

Hmm. Actually, I think this report from coverity kind of makes sense.

If you pass zero bytes to xmalloc, like:

  const char **foo = xmalloc(0);

and your system malloc returns NULL, we convert that into a single-byte
allocation, and it is the caller's responsibility not to actually
dereference it. Coverity doesn't know that, and says "wait, one byte
isn't enough to store *foo", which is right.

Most cases of this are something like:

  const char **foo = xmalloc(nr * sizeof(*foo));
  /* do something nr times */

What coverity _should_ be able to do is realize that we only trigger
this when "nr" is zero, and then make sure that we only dereference foo
when nr is non-zero. But I guess it's not that smart (yet).

As a fallback, we should be able to say "xrealloc is opaque; just trust
us that it will allocate the right amount", which I think is what you
are getting at with the modeling file.

> However I have reviewed the function and I'd be pretty sure it would work as expected.
> According to https://scan.coverity.com/tune we can upload a modelling file, 
> which will allow us to supress such false positive errors.
> I believe we'd need to put in the modelling file something like:
> 
> 	// coverity[+alloc]
> 	void *xrealloc(void *ptr, size_t size);
> 
> and that should do. We'd not need to modify the git.git sources,
> but just add such a declaration to the modelling file.

I think that is how we would comment it in the source code. For the
modeling file, we would actually provide a "fake" implementation of
xmalloc that just calls malloc. I think you shouldn't generally need to
model functions which are actually in your code base (as coverity looks
across all files, not just what gets included when compiling any single
one), but I assume that a model would take precedence over the "real"
one for cases like this.

> Does anyone of you administrators want to experiment with that?

I don't think anybody is actively submitting builds to coverity. I
played with it a while ago and have meant to look again when I got more
time (as there were many false positives that I figured could be removed
with some modeling), but haven't gotten around to it.

I'm happy to upload any model file you want, or if you want to actively
work on this, I can bump you to "maintainer" status and you can fiddle
with the project settings as necessary.

-Peff
