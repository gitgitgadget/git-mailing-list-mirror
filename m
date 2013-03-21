From: Jeff King <peff@peff.net>
Subject: [PATCH 0/4] drop some "int x = x" hacks to silence gcc warnings
Date: Thu, 21 Mar 2013 07:03:38 -0400
Message-ID: <20130321110338.GA18552@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 21 12:04:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIdI9-0002CR-9i
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 12:04:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756684Ab3CULDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 07:03:49 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33658 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754555Ab3CULDt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 07:03:49 -0400
Received: (qmail 20632 invoked by uid 107); 21 Mar 2013 11:05:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Mar 2013 07:05:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Mar 2013 07:03:38 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218707>

I was fooling around with clang and noticed that it complains about the
"int x = x" construct under -Wall. That is IMHO a deficiency in clang,
since the idiom has a well-defined use in silencing -Wuninitialized
warnings. But I've also always been nervous about the idiom, because
it's easy to get the analysis wrong (after all, the compiler gets these
cases wrong because they're complex), and it's possible for the code to
change later, introducing a new problem.

So I investigated our uses of the idiom. Many of them are correct and
still necessary. Some are correct but no longer necessary with modern
gcc. And some are technically correct, but the code and its assumptions
can be made clearer (to both a reader and the compiler) with a simple
rewrite. Patches are below for the latter two types.

Note that none of these fixes an actual bug in the current code; this is
purely maintenance hygiene. Nor do any of the patches depend on each
other; we can drop any of them that do not look they are providing a net
benefit.

  [1/4]: wt-status: fix possible use of uninitialized variable
  [2/4]: fast-import: use pointer-to-pointer to keep list tail
  [3/4]: drop some obsolete "x = x" compiler warning hacks
  [4/4]: transport: drop "int cmp = cmp" hack

-Peff
