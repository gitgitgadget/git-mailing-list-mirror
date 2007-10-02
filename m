From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Tue, 2 Oct 2007 16:48:48 -0400
Message-ID: <20071002204848.GA8284@coredump.intra.peff.net>
References: <20071002155800.GA6828@coredump.intra.peff.net> <200710021916.44388.andyparkins@gmail.com> <20071002191104.GA7901@coredump.intra.peff.net> <7vsl4tjo28.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 22:49:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icofr-0008Sy-Hp
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 22:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528AbXJBUsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 16:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753505AbXJBUsv
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 16:48:51 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4014 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753367AbXJBUsu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 16:48:50 -0400
Received: (qmail 7659 invoked by uid 111); 2 Oct 2007 20:48:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 02 Oct 2007 16:48:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2007 16:48:48 -0400
Content-Disposition: inline
In-Reply-To: <7vsl4tjo28.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59731>

On Tue, Oct 02, 2007 at 12:47:59PM -0700, Junio C Hamano wrote:

>  - it makes typo harder to make and easier to spot
>    (e.g. "refs/head/");
> 
>  - it makes miscount harder to make and easier to spot (e.g.
>    what is this magic constant 11? Is it strlen("refs/heads/")?);
> 
>  - it makes reviewing the resulting code, and more importantly,
>    future patches on the resulting code, easier.
> [...]
> It however actively hurts on the third count.  These long

Yes, I find some of the substitutions more readable, but some are a bit
less readable. The parts of the patch I found the _most_ improved are
the ones that get rid of a memcmp in favor of a prefixcmp (i.e.,
removing the count entirely).

Perhaps a better quest would be to eliminate all of those counts
entirely with code that is obviously correct. I think it is much more
readable to replace:

  url = xmalloc(strlen(repo->base) + 64);
  sprintf(url, "%s/objects/pack/pack-%s.idx", repo->base, hex);

with something like:

  strbuf_init(&url);
  strbuf_addf(&url, "%s/objects/pack/pack-%s.idx", repo->base, hex);

which has the same number of lines, but no magic numbers at all. Or
since most of the uses of things like PATH_OBJECTS are more or less the
same, maybe something like:

  mkpath_object(&url, "pack/pack-%s.idx", hex);

i.e., rather than fiddling with string constants, wrap them
functionally.

> constants in CAPITAL_LETTERS_WITH_UNDERSCORE shout too loudly to

Part of the problem is also that they're long. Perhaps REFS_HEADS, while
being less unique in the C namespace, would look better?

-Peff
