From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Makefile: split prefix flags from GIT-CFLAGS
Date: Tue, 19 Jun 2012 17:43:08 -0400
Message-ID: <20120619214308.GA22166@sigill.intra.peff.net>
References: <20120619195229.GA14692@sigill.intra.peff.net>
 <20120619200354.GC14714@sigill.intra.peff.net>
 <7vmx3zyqil.fsf@alter.siamese.dyndns.org>
 <20120619210426.GA21838@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 23:43:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh6Cl-0001KS-8D
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 23:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144Ab2FSVnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 17:43:14 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:33035
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753799Ab2FSVnL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 17:43:11 -0400
Received: (qmail 14263 invoked by uid 107); 19 Jun 2012 21:43:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Jun 2012 17:43:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2012 17:43:08 -0400
Content-Disposition: inline
In-Reply-To: <20120619210426.GA21838@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200254>

On Tue, Jun 19, 2012 at 05:04:26PM -0400, Jeff King wrote:

> > The damage is not too bad from the point of view of linecount, but
> > this embeds the implicit knowledge of dependencies from $prefix to
> > various path variables to selected object files that embed these
> > paths variables by scattering dependencies on GIT-PREFIX in the
> > Makefile, which does not seem to scale very well.  I wonder if it
> > makes sense to have a single default-paths.o file that holds these
> > strings and recompile only that file when any of the paths change,
> > to localize the damage.
> > 
> > Of course, the current users of GIT_HTML_PATH that expect they can
> > do sizeof(GIT_HTML_PATH)-1 in place of strlen(GIT_HTML_PATH) may
> > need to be adjusted if we go that route.
> 
> Yeah, I think that would be nicer overall. If we move to a link-time
> dependency, then we can even put _all_ of the Makefile-based strings in
> there without ever having to care about who uses it. Of course, it won't
> work for things that truly need to be preprocessor macros (for
> conditional compilation), so we'd still be stuck with those (most of
> them just end up in CFLAGS and trigger a full rebuild, which is probably
> OK).

I started on this, but it is a little bit trickier than that. We can
cover C compilation with one strategy, but make variables end up going
lots of other places, too, like shell scripts, the perl Makefile
generation, etc. Those places all need to individually respect a
separate sentinel-file dependency. So I don't think there is an easy way
out of the sprinkling of dependencies.

At the very least, I tried to keep the dependency close to the
point-of-use, like:

  foo.o: GIT-PREFIX
  foo.o: EXTRA_CPPFLAGS = \
          '-DPREFIX=$(prefix_SQ)'

even if the actual build rules for foo.o are found elsewhere (and
typically they are, as they are part of a big pattern-based rule).

Some of the existing locations did not do a great job of that, and
instead it like this:

  version.o git.spec \
          $(patsubst %.sh,%,$(SCRIPT_SH)) \
          $(patsubst %.perl,%,$(SCRIPT_PERL)) \
          : GIT-VERSION-FILE

  [... 500 lines later ...]

  git.spec: git.spec.in
          sed -e 's/@@VERSION@@/$(GIT_VERSION)/g' <$< >$@+

If you read the latter hunk and wanted to emulate it, there is nothing
to indicate that you must also modify the earlier hunk. I think putting
them together makes more sense (even though it technically takes more
lines).

-Peff
