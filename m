From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Makefile: split prefix flags from GIT-CFLAGS
Date: Tue, 19 Jun 2012 17:04:26 -0400
Message-ID: <20120619210426.GA21838@sigill.intra.peff.net>
References: <20120619195229.GA14692@sigill.intra.peff.net>
 <20120619200354.GC14714@sigill.intra.peff.net>
 <7vmx3zyqil.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 23:04:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh5bF-0007Sz-6J
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 23:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318Ab2FSVE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 17:04:29 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:33004
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142Ab2FSVE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 17:04:28 -0400
Received: (qmail 13668 invoked by uid 107); 19 Jun 2012 21:04:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Jun 2012 17:04:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2012 17:04:26 -0400
Content-Disposition: inline
In-Reply-To: <7vmx3zyqil.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200244>

On Tue, Jun 19, 2012 at 01:51:14PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Most of the build targets do not care about the setting of $prefix
> > (or its derivative variables), but will be rebuilt if the prefix
> > changes. For most setups this doesn't matter (they set prefix once
> > and never change it), but for a setup which puts each branch or
> > version in its own prefix, this unnecessarily causes a full
> > rebuild whenever the branc is changed.
> [...]
> 
> I have to wonder if is this something we care about that much.

It does speed up my build a fair bit, but I admit I have a somewhat
uncommon setup.

> The damage is not too bad from the point of view of linecount, but
> this embeds the implicit knowledge of dependencies from $prefix to
> various path variables to selected object files that embed these
> paths variables by scattering dependencies on GIT-PREFIX in the
> Makefile, which does not seem to scale very well.  I wonder if it
> makes sense to have a single default-paths.o file that holds these
> strings and recompile only that file when any of the paths change,
> to localize the damage.
> 
> Of course, the current users of GIT_HTML_PATH that expect they can
> do sizeof(GIT_HTML_PATH)-1 in place of strlen(GIT_HTML_PATH) may
> need to be adjusted if we go that route.

Yeah, I think that would be nicer overall. If we move to a link-time
dependency, then we can even put _all_ of the Makefile-based strings in
there without ever having to care about who uses it. Of course, it won't
work for things that truly need to be preprocessor macros (for
conditional compilation), so we'd still be stuck with those (most of
them just end up in CFLAGS and trigger a full rebuild, which is probably
OK).

-Peff
