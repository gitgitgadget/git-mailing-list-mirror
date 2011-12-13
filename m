From: Jeff King <peff@peff.net>
Subject: [PATCH 0/4] exact ref-matching for fetch-pack
Date: Mon, 12 Dec 2011 19:39:25 -0500
Message-ID: <20111213003925.GA28403@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kevin Sawicki <kevin@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 01:39:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaGP6-0001Vi-Uj
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 01:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628Ab1LMAj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 19:39:29 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48415
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753592Ab1LMAj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 19:39:28 -0500
Received: (qmail 8055 invoked by uid 107); 13 Dec 2011 00:46:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 19:46:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 19:39:25 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186987>

I was passed a bug report of clone failing on a repo with an oddly named
ref in it: "refs/for/refs/heads/master". This is probably an error
somebody made while pushing and should simply be deleted. However, it's
curious that "clone" would fail on this, since it should be ignoring
everything outside the "refs/heads/*" refspec.

It turns out that during the fetch-pack phase, we accidentally ask for
the sha1 of "refs/for/refs/heads/master" instead of that of
"refs/heads/master". This can cause "clone" to fail, as we may not have
asked for the object pointed to by "refs/heads/master" at all. This
behavior is due to some questionable suffix-matching deep inside
fetch-pack. The code in question dates back to the beginning of git; I
think it simply hasn't triggered much because the refname you need to
have is so specific (you must be asking to fetch a ref "refs/X", have
"refs/Y/X" on the remote, and "Y" must come alphabetically before "X",
since we match refs in alphabetical order).

As I said, this is probably just a silly one-off error. But I could
imagine this happening legitimately. Here are two possible scenarios:

  1. You are mirroring some meta-information about your refs in a
     parallel namespace. E.g., "refs/descriptions/refs/heads/master"
     contains information about "refs/heads/master".

  2. One of the things we've discussed for future git is mirroring the
     remote ref namespaces more literally. E.g., having something like
     "refs/remotes/origin/refs/heads/master". That won't actually
     trigger this bug because "heads" is alphabetically before
     "remotes". But "tags", for example, is not.

This could possibly be considered a behavior regression for users of the
fetch-pack command line. See patches 2 and 3 for details.

  [1/4]: drop "match" parameter from get_remote_heads
  [2/4]: t5500: give fully-qualified refs to fetch-pack
  [3/4]: fetch-pack: match refs exactly
  [4/4]: connect.c: drop path_match function

-Peff
