From: Jeff King <peff@peff.net>
Subject: [BUG] rebase -p loses commits
Date: Mon, 16 May 2011 06:33:54 -0400
Message-ID: <20110516103354.GA23564@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 12:34:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLv7l-0003Pn-Bk
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 12:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425Ab1EPKd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 06:33:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58859
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754219Ab1EPKd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 06:33:59 -0400
Received: (qmail 13026 invoked by uid 107); 16 May 2011 10:35:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 May 2011 06:35:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 May 2011 06:33:54 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173722>

I was trying to reproduce somebody's issue with a minimal test case, and
I ran across this setup wherein "rebase -p" silently drops some commits:

  commit() {
    echo $1 >file && git add file && git commit -m $1
  }

  # repo with two branches, each with conflicting content
  git init repo && cd repo &&
  commit base &&
  commit master &&
  git checkout -b feature HEAD^ &&
  commit feature &&

  # now merge them, with some fake resolution
  ! git merge master &&
  commit resolved &&

  # now try to "rebase -p" on top of master.
  git rebase -p master

The rebase completes successfully, but the "feature" commit and the
merge resolution are gone!

I'm totally unfamiliar with the preserve-merges code, and I won't have
time to dig further until later today or tomorrow, so I thought I'd
throw it out here and see if anybody has any clues.

-Peff
