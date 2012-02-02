From: Jeff King <peff@peff.net>
Subject: [PATCH 0/9] respect binary attribute in grep
Date: Thu, 2 Feb 2012 03:17:47 -0500
Message-ID: <20120202081747.GA10271@sigill.intra.peff.net>
References: <20120201221437.GA19044@sigill.intra.peff.net>
 <20120201232109.GA2652@sigill.intra.peff.net>
 <7vhaza12ol.fsf@alter.siamese.dyndns.org>
 <20120202005209.GA6883@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 09:17:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsrrg-00080p-AX
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 09:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702Ab2BBIRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 03:17:51 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52833
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754576Ab2BBIRu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 03:17:50 -0500
Received: (qmail 17707 invoked by uid 107); 2 Feb 2012 08:24:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Feb 2012 03:24:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Feb 2012 03:17:47 -0500
Content-Disposition: inline
In-Reply-To: <20120202005209.GA6883@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189592>

[+cc Thomas, as I am mangling some of his recent work with my
     refactoring]

On Wed, Feb 01, 2012 at 07:52:09PM -0500, Jeff King wrote:

> > Hrm, I would have expected a patch that turns "const char *name" into a
> > structure that has name and drv as its members, so that later we can tell
> > the function more about the nature of the contents. Or a separate pointer
> > to drv in place of your "binary" flag word.
> [...]
> I'll take a look at re-working it that way.

Thanks for a dose of sanity. The result turned out much easier to read
(and explain in the commit messages, as it was simple to break into
smaller commits). In particular, the "don't read binary-marked files at
all with -I" optimization became very natural.

I implemented all of the other optimizations I mentioned except the
"only stream the first few bytes when auto-detecting binary-ness" one.
However, it should be easy to do on top of these changes. I need to
re-visit the similar change to diff_filespec_is_binary, and I'll do both
at the same time.

The patches are:

  [1/9]: grep: make locking flag global
  [2/9]: grep: move sha1-reading mutex into low-level code
  [3/9]: grep: refactor the concept of "grep source" into an object
  [4/9]: convert git-grep to use grep_source interface
  [5/9]: grep: drop grep_buffer's "name" parameter
  [6/9]: grep: cache userdiff_driver in grep_source

    These are all refactoring that should have no behavior change.

  [7/9]: grep: respect diff attributes for binary-ness

    This is the point of the series. :)

  [8/9]: grep: load file data after checking binary-ness
  [9/9]: grep: pre-load userdiff drivers when threaded

    And these two are simple optimizations.

-Peff
