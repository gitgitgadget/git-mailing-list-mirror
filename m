From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] test-lib: filesystem prerequisites
Date: Thu, 26 Jul 2012 14:43:37 -0400
Message-ID: <20120726184337.GB16037@sigill.intra.peff.net>
References: <5001B82B.1060201@web.de>
 <cover.1343309173.git.git@drmicha.warpmail.net>
 <7vtxwu75gy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	tboegi@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 20:43:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuT2G-0004CJ-Rv
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 20:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176Ab2GZSnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 14:43:40 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37479 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481Ab2GZSnj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 14:43:39 -0400
Received: (qmail 12115 invoked by uid 107); 26 Jul 2012 18:43:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jul 2012 14:43:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jul 2012 14:43:37 -0400
Content-Disposition: inline
In-Reply-To: <7vtxwu75gy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202291>

On Thu, Jul 26, 2012 at 11:16:45AM -0700, Junio C Hamano wrote:

> Consolidating the logic to set necessary prerequisites used in
> various scripts is very good, but I am not sure adding them to
> test-lib and run them unconditionally is a good idea.  SYMLINKS is
> used by 47 among 595 tests, which is common enough, but the new ones
> are not common enough.  I do not think we want to create a temporary
> "junk" dir, two temporary "camelcase" files, read and compare them,
> when nobody in the script cares.
> 
> We do not have to split them into separate include files, though, in
> order to avoid such waste.  Instead, you can make the logic to set
> prerequisite conditional inside test-lib.sh and update the users.
> 
> Something like:
> [...]
> 	(at the beginning of t/t0003-attributes.sh)
> 	#!/bin/sh
>         test_description=gitattributes
>         TEST_WANT_PREREQ=CASE_INSENSITIVE_FS,SYMLINKS
> 	. ./test-lib.sh

That looks like a maintenance annoyance. Can't we just have the
prerequisite-checker lazily perform the test on demand and cache the
result?  It should be OK as long as:

  1. The prereq is careful about its pre- and post- conditions. We
     already make sure to clean up after those tests so as not to taint
     later tests. We would probably want to also make them more careful
     about preconditions like which directory they are in (so, for
     example, refer to "$TRASH_DIRECTORY/junk" and not "junk").

  2. The prereq test does not accidentally munge any existing test
     state from previous tests. That should not be a big deal as long as
     we avoid names like "junk" in favor of more unique names like
     "check-case-sensitivity-prereq".

-Peff
