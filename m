From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 0/4] update tracking refs on explicit fetch
Date: Sat, 11 May 2013 18:13:21 +0200
Message-ID: <20130511161320.GA14990@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 18:13:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbCQT-0001JI-Qt
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 18:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834Ab3EKQNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 12:13:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:58735 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672Ab3EKQNY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 12:13:24 -0400
Received: (qmail 9062 invoked by uid 102); 11 May 2013 16:13:49 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (213.221.117.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 11 May 2013 11:13:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 11 May 2013 18:13:21 +0200
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223976>

This is a cleaned-up version of the oft-discussed[1] concept that "git
pull origin master" should update "refs/remotes/origin/master".

It is a little bit of a risky change, in that anybody who deeply cares
about when their tracking ref branches are updated would be impacted.
But I think the general consensus is that while you can come up with a
hypothetical use case, the logic is quite tortured, and you could
accomplish the same thing by keeping a local branch. Most people seem to
have the mental model that remote tracking branches are basically a
cache for what's on the remote, updated opportunistically as
appropriate.

  [1/4]: t5510: start tracking-ref tests from a known state
  [2/4]: fetch/pull doc: untangle meaning of bare <ref>
  [3/4]: refactor "ref->merge" flag
  [4/4]: fetch: opportunistically update tracking refs

The final patch is the moral equivalent of the patch I've posted before
when this topic comes up (and referenced in the threads below). But that
patch did not take care not to write duplicate (mergable!) entries into
FETCH_HEAD, leading to great confusion from git-pull.  This series deals
with that, and takes care to write the exact same FETCH_HEAD we would
have written before the series.

However, Jonathan raised an interesting question: what is the point of
not-for-merge entries at all? We are not going to merge them, so none of
the pull/merge machinery cares about them. We do not consider extra
entries in FETCH_HEAD for reachability or anything like that. Is there
anybody who reads them?

If we do not care about them, we can simplify this much further, and
either write the duplicates as not-for-merge, or even omit not-for-merge
entries entirely. However, it is possible that some third-party scripts
process FETCH_HEAD, so I took the conservative route.

Note that this patch is as greedy as possible[2]; whenever we see the
LHS is fetched, we update the RHS side, even if the user did:

  git fetch origin master:foobar

Some of the discussions below argue that the behavior should not kick in
for such a case. I am not sure I agree (and argue against it in those
discussions). I think at this point that is the only potentially
contentious item.

-Peff

[1] Past discussions:

    http://thread.gmane.org/gmane.comp.version-control.git/127163/focus=127215

    http://thread.gmane.org/gmane.comp.version-control.git/192252

    http://thread.gmane.org/gmane.comp.version-control.git/203357/focus=203442

    http://article.gmane.org/gmane.comp.version-control.git/221234
