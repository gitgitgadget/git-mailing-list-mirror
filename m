From: Jeff King <peff@peff.net>
Subject: [RFC PATCH 0/5] valgrind in test scripts
Date: Wed, 22 Oct 2008 16:28:10 -0400
Message-ID: <20081022202810.GA4439@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 22:29:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KskKb-0006uS-Jo
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 22:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbYJVU2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 16:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbYJVU2N
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 16:28:13 -0400
Received: from peff.net ([208.65.91.99]:3566 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939AbYJVU2M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 16:28:12 -0400
Received: (qmail 4102 invoked by uid 111); 22 Oct 2008 20:28:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 22 Oct 2008 16:28:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Oct 2008 16:28:10 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98898>

I spent some time last week running git through the paces with
valgrind's memcheck tool. The good news is that I didn't find any
serious issues, so we are doing a pretty good job overall. The bad news
is that running the whole test suite with valgrind takes a few hours on
a quad-core (but thank goodness for "make -j4 test").

I did uncover a few potential problems, and patches are in the latter
part of the series. I suppose an argument could be made that these fixes
are code churn, since these are not problems in practice, but I think
they are worth fixing. The fixes are few in number and small, and we are
very close to a valgrind-error-free code-base, which would make it easy
to spot any new problems when they arise. We could always suppress these
errors, but there is the possibility of an overzealous suppression
masking a real problem (especially if one of these issues changes from
theoretical to practical).

There are a few things I don't like:

 1. The "fake git PATH" is set up by the Makefile, since it needs to
    know which dashed commands to override (based on $(PROGRAMS)).

    I think it would be nicer if the test script itself set this up when
    --memcheck was requested, so that we always know it is fresh. But:

      - if the fake PATH isn't inside the trash directory, then we have
        a problem with multiple tests trying to set it up at the same
        time

      - if the fake PATH is inside the trash directory, I'm not sure of
        the best place to put it, as I don't want to influence the
        outcome of the tests. It could go into .git/valgrind, without
        hurting anything.

 2. I wanted to have a completely clean valgrind run before posting.
    With these patches, the only errors I get are for an uninitialized
    "struct stat" in t4121 and t4127. After much looking (including
    carefully reading the code, and using a a debugger, which shows the
    data in question looking very much initialized) I can't figure out
    what the problem might be. So it might simply be a false positive in
    valgrind, but I would like another set of eyes.

-Peff
