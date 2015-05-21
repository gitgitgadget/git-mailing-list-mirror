From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 0/3] --seed as an alias for --dissociate --reference
Date: Thu, 21 May 2015 00:14:35 -0400
Message-ID: <20150521041435.GA18978@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 06:14:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvHsZ-0007SD-Je
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 06:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbbEUEOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 00:14:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:33621 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750996AbbEUEOi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 00:14:38 -0400
Received: (qmail 551 invoked by uid 102); 21 May 2015 04:14:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 23:14:38 -0500
Received: (qmail 30724 invoked by uid 107); 21 May 2015 04:14:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 00:14:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 May 2015 00:14:35 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269537>

In a thread a few months ago[1], we discussed the idea that the
"--dissociate --reference=foo" interface was somewhat awkward for
somebody who just wants to optimize their clone. This is mostly due to
the historical development of the features. The logical interface for
somebody who just wants a faster clone is something like

   git clone --optimize-my-clone-from=foo.git git://example.com/bar.git

But we got stuck in that thread on coming up with a decent name for the
option. Having just read through it, I think a succinct name for the
idea is "seed". That is, we seed the clone with objects from another
repository.

That thread also brought up the idea that we do not necessarily need to
seed from a local repository; we could do something like:

  1. Fetch from the seed repo into refs/seed/*

  2. Fetch from the real clone source; the fetch is optimized by the
     presence of refs/seed/*.

  3. Delete refs/seed/*. Optionally repack to drop any objects needed
     only by the seed refs.

This is awkward with the "--reference" interface, because its
implementation is publicly tied to the concept of alternates. Whereas
"--seed" is about the end result you want; we can implement it using
alternates or with a clone, depending on where the repo is located.

There are a few open issues with this series:

  1. Assuming that "seed" is a reasonable verb for this concept, is
     "--seed=<repo>" OK for the option?  Would "--seed-from=<repo>" be
     better? (Also, the response "bleh, seed is a terrible name" is
     fine, too, but only if accompanied by your own suggestion :) ).

  2. My main goal here is making the concept easier to explain to users.
     The documentation in the third patch explains "--seed" as an alias
     for the other options, which probably isn't helping much. It might
     make sense to have a patch 4/3 that explains "--seed" first, and
     then explains "--reference" as "like --seed, but keep the
     relationship after the clone". Or maybe they should just get their
     own descriptions entirely.

  3. We can't dissociate from a specific alternate, so using "--seed"
     implies that all "--reference" options get dissociated. In this
     series, I issue a warning in that case.  But that would be easily
     solved if "--seed" used the fetch strategy described above, even
     for local clones (which would probably still be quite fast if we
     took clone's usual hard-link shortcut instead of actually fetching
     from a local clone).

I don't have particular plans to implement generic "--seed" from remotes
anytime soon. I think this takes us a step in the right direction
interface-wise, and it does introduce a succinct concept and option. But
the abstraction does leak (e.g., in that it implies "--dissociate"). So
one response might be "yes, this is a good building block, and later we
can extend --seed; how it works is an implementation detail". But
equally valid would be "eh, I like the name and the concept, but this
implementation is too hacky; let's wait for somebody to implement it for
real". Hence the RFC label.

The patches are:

  [1/3]: clone: use OPT_STRING_LIST for --reference
  [2/3]: clone: reorder --dissociate and --reference options
  [3/3]: clone: add `--seed` shorthand

The third one is the interesting one, and the first two are nearby
cleanups. Whether we pursue the third one or not, I think the first two
are worth taking by themselves.

-Peff

[1] http://thread.gmane.org/gmane.comp.version-control.git/264178/focus=264234
