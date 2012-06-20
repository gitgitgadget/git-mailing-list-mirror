From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 07/11] Makefile: split prefix flags from GIT-CFLAGS
Date: Wed, 20 Jun 2012 18:22:24 -0400
Message-ID: <20120620222224.GD3302@sigill.intra.peff.net>
References: <20120620182855.GA26948@sigill.intra.peff.net>
 <20120620183155.GG30995@sigill.intra.peff.net>
 <20120620212833.GF6142@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 00:22:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShTIG-00042j-4O
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 00:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758239Ab2FTWW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 18:22:28 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39357
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757676Ab2FTWW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 18:22:28 -0400
Received: (qmail 31115 invoked by uid 107); 20 Jun 2012 22:22:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Jun 2012 18:22:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jun 2012 18:22:24 -0400
Content-Disposition: inline
In-Reply-To: <20120620212833.GF6142@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200372>

On Wed, Jun 20, 2012 at 04:28:33PM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > Most of the build targets do not care about the setting of
> > $prefix (or its derivative variables), but will be rebuilt
> > if the prefix changes. For most setups this doesn't matter
> > (they set prefix once and never change it), but for a setup
> > which puts each branch or version in its own prefix, this
> > unnecessarily causes a full rebuild whenever the branc is
> > changed.
> 
> Micronit: s/branc/branch/.

The worst part is that Junio already corrected that in v1 and I didn't
propagate it into my re-roll. <sigh>

> >  ### Detect prefix changes
> > -TRACK_CFLAGS = $(CC):$(subst ','\'',$(ALL_CFLAGS)):\
> > -             $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ):\
> > -             $(localedir_SQ):$(USE_GETTEXT_SCHEME)
> > +TRACK_PREFIX = $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ):\
> > +		$(localedir_SQ)
> > +
> > +GIT-PREFIX: FORCE
> > +	@FLAGS='$(TRACK_PREFIX)'; \
> > +	if test x"$$FLAGS" != x"`cat GIT-PREFIX 2>/dev/null`" ; then \
> > +		echo 1>&2 "    * new prefix flags"; \
> > +		echo "$$FLAGS" >GIT-PREFIX; \
> > +	fi
> 
> Hmm, nothing to do with this particular patch but the above list
> includes gitexecdir and not htmldir.  Is there any particular logic
> behind the list of variables?

The list came from what was in CFLAGS before. But looking at it again, I
think it is not right (e.g., git.o builds with $(htmldir_SQ), but nobody
actually depends on it). IOW, it was broken before, and I have
propagated that breakage. But nobody has noticed because they usually
set prefix and not the htmldir separately.

I probably need to go through the whole Makefile again and make sure
everything is in the list.  What a royal pain. I can't help but feel
that there is a better way to do this. GNU make supports user-defined
functions via the "call" function. Maybe we can turn this into a
single-line of Makefile per variable, and get per-variable resolution of
rebuilding, and still end up with fewer lines.

I'll take a look.

> Nit: I think it would be easier to understand a name like GIT-PATHS
> (making the absence of htmldir a bug, if not a particularly important
> one).  No other complaints. :)

Yeah, I hate the name GIT-PREFIX. But I was worried people might
misinterpret GIT-PATHS. Maybe these should all go into a subdir full of
auto-built file magic, which will make it more obvious what they are
(and we would want to do that anyway if we start having a larger number
of them).

-Peff
