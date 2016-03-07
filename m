From: Jeff King <peff@peff.net>
Subject: [BUG?] fetch into shallow sends a large number of objects
Date: Mon, 7 Mar 2016 17:15:40 -0500
Message-ID: <20160307221539.GA24034@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 23:15:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ad3RN-0007yw-QR
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 23:15:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496AbcCGWPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 17:15:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:55982 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753099AbcCGWPn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 17:15:43 -0500
Received: (qmail 26813 invoked by uid 102); 7 Mar 2016 22:15:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Mar 2016 17:15:42 -0500
Received: (qmail 30018 invoked by uid 107); 7 Mar 2016 22:15:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Mar 2016 17:15:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Mar 2016 17:15:40 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288403>

I came across an interesting shallow-fetch case, and I suspect git is
doing something very sub-optimal.

You can reproduce with:

	git clone --bare git://github.com/CocoaPods/Specs
	cd Specs.git

	time git pack-objects --revs --thin --stdout \
	  --delta-base-offset --include-tag <<\EOF | wc -c
	d7a6d9295d718c6015be496880f1a293bdd89185
	--not
	067f265bb512c95b22b83ccd121b9facbddcf6b1
	EOF

	time git pack-objects --revs --thin --stdout --shallow \
	  --delta-base-offset --include-tag <<\EOF | wc -c
	--shallow ecd7ea6033fe8a05d5c21f3a54355fded6942659
	d7a6d9295d718c6015be496880f1a293bdd89185
	--not
	067f265bb512c95b22b83ccd121b9facbddcf6b1
	EOF

The first is a non-shallow clone; it takes a few hundred milliseconds to
generate the pack, and the result is a few hundred kilobytes. The second
is a shallow clone (logged from a real-world request); it sends 200
times as many objects, totaling 270MB, and takes almost a minute of CPU.

I'm trying to figure out why that is, and whether git can do better.

I think what's happening here is that the history looks like this:

  F ... ecd7ea6 ... 067f265 ... M ... d7a6d929
   \                           /
    X ....................... Y

That is, we are asking for 067f265 to d7a6d929, but that includes some
merge M which _crosses_ our grafted shallow-point ecd7ea6. That pulls in
essentially all of the history for the entire (missing only the commits
from the fork point F up to ecd7ea6).

So I _think_ that pack-objects is doing the best it can with the
information it was given. But presumably in a shallow repo the user
would prefer to have a segmented history rather than pull in all of
those old commits.

I don't know how the client invoked git, but we can guess what happened
and simulate with:

  git tag shallow ecd7ea6033fe8a05d5c21f3a54355fded6942659
  git tag old 067f265bb512c95b22b83ccd121b9facbddcf6b1
  git tag new d7a6d9295d718c6015be496880f1a293bdd89185

  git clone --no-local --bare --branch=shallow --depth=1 . clone.git
  cd clone.git
  git fetch origin old:refs/tags/old
  git fetch origin new:refs/tags/new

Of the two follow-up fetches in the clone, the first is reasonably fast
(it just grabs a few new commits on top of the shallow base), but the
second is expensive (it grabs the merge which pulls in the whole
history). If we add "--depth=1" to each of those fetches, everything
remains fast.

Is this user error to call "git fetch" without "--depth" in the
subsequent cases? Or should git remember that we are in a shallow repo,
and presume that the user by default wants to keep things shallow?

-Peff
