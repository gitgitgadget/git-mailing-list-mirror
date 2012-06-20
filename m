From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 1/8] Makefile: apply dependencies consistently to
 sparse/asm targets
Date: Wed, 20 Jun 2012 12:37:14 -0400
Message-ID: <20120620163714.GB12856@sigill.intra.peff.net>
References: <20120619232231.GA6328@sigill.intra.peff.net>
 <20120619232310.GA6496@sigill.intra.peff.net>
 <20120620035015.GA4213@burratino>
 <20120620042607.GA10414@sigill.intra.peff.net>
 <20120620102750.GB4579@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 18:37:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShNuF-0003fo-W0
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 18:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757186Ab2FTQhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 12:37:19 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:38858
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757163Ab2FTQhS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 12:37:18 -0400
Received: (qmail 25189 invoked by uid 107); 20 Jun 2012 16:37:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Jun 2012 12:37:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jun 2012 12:37:14 -0400
Content-Disposition: inline
In-Reply-To: <20120620102750.GB4579@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200302>

On Wed, Jun 20, 2012 at 05:27:50AM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> >   1. The .sp and .s targets _do_ need the same -D macros that the .o
> >      targets get.
> 
> Ah, you mean EXTRA_CPPFLAGS.  Yeah, that's also important, though the
> patch doesn't have anything to do with it.
> 
> Some circuit in my mind missed that you meant EXTRA_CPPFLAGS and not a
> file like GIT-CFLAGS.

No, I meant GIT-CFLAGS. But the point of my series is that the two are
intimately paired: if you are setting EXTRA_CPPFLAGS to mention a make
variable, then you should have a dependency on a file that changes if
that make variable changes.

> > So I think my preference would be to tack on a note to the commit
> > message saying "yeah, this doesn't do anything for meta-dependencies,
> > but it doesn't hurt either". OK?
> 
> What is a meta-dependency?  I would find that even more confusing.

It is my term for things like GIT-CFLAGS; they are not really
dependencies in the sense that the build process even looks at them, but
they are a marker whose timestamp changes when things which we _do_
actually depend on change. Better name suggestions are welcome.

> This change could be motivated more simply by saying that it prevents
> "make git.sp", "make git.s", "make help.s", and "make builtin/help.s"
> from failing when common-cmds.h doesn't exist yet, no?

More simply, perhaps, but that was not the entire motivation when
writing the patch. It is connected with patches later in the series
which update those lines.

> But suggesting that we are supposed to ignore the FORCE just leaves
> the reader wondering why the same patch does not also urgently need
> to make additional changes such as the following, no?
> 
> 	builtin/branch.o builtin/checkout.o builtin/clone.o \
> 	builtin/reset.o branch.o transport.o: branch.h
> 
> to
> 
> 	builtin/branch.sp builtin/branch.o builtin/branch.s \
> [...]

Those lines were not updated because I did not notice them, as I was
keeping the scope of the updates to generated headers and files like
GIT-CFLAGS. IOW, my patch is a step in what I think is the right
direction, but it does not remove all issues, only one class of them.

As a side note, I have to wonder if those lines are really worthwhile.
Everything already depends on LIB_H (when computed header dependencies
are not used). Headers like "branch.h" seem to be split out of LIB_H to
avoid causing a full rebuild when uncommon headers are updated. But it
is a half-hearted attempt; LIB_H has plenty of infrequently used
headers, and a solution which requires manually updating the target
lists seems doomed to staleness. These days COMPUTE_HEADER_DEPENDENCIES
is on by default, and I expect most developers use it.

Can we just fold these few headers into LIB_H, let people without "gcc
-MMD" deal with the extra compilation, and drop MISC_H and these extra
manual dependencies entirely? And note that "extra compilation" there
only happens when you are trying to rebuild a new version of git in a
working tree containing an older version (so probably bisection would be
the only place people would see it, and even then, only when jumping
between versions that update one of the header files listed in MISC_H,
but _not_ any of the ones listed in LIB_H).

-Peff
