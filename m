From: Jeff King <peff@peff.net>
Subject: Re: git bundle vs git rev-list
Date: Sat, 6 Dec 2014 00:16:51 -0500
Message-ID: <20141206051651.GC31301@peff.net>
References: <CAL3By--xYnXFUdDP3MDxAxvfeBT3ArFrdAV=apzdWg6_kiD2Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jesse Hopkins <jesse.hops@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 06:16:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx7jl-0001sF-Gy
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 06:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbaLFFQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2014 00:16:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:49294 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751061AbaLFFQx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2014 00:16:53 -0500
Received: (qmail 5565 invoked by uid 102); 6 Dec 2014 05:16:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Dec 2014 23:16:53 -0600
Received: (qmail 9474 invoked by uid 107); 6 Dec 2014 05:16:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 06 Dec 2014 00:16:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Dec 2014 00:16:51 -0500
Content-Disposition: inline
In-Reply-To: <CAL3By--xYnXFUdDP3MDxAxvfeBT3ArFrdAV=apzdWg6_kiD2Yg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260936>

On Fri, Dec 05, 2014 at 03:36:18PM -0700, Jesse Hopkins wrote:

> #Create the bundle
> git bundle create out.bundle --all "--since=<last_bundle_date>"

Others pointed out that a bug in the handling of --since may be the
culprit here. However, I'd encourage you to use actual sha1s, as they
are going to be more robust (especially in the face of any clock skew in
the commit timestamps).

You should be able to follow a procedure like:

  1. On day 1, create a bundle from scratch:

       git bundle create out.bundle --all

  2. Before you send it out, record its tips in the local repository
     for later reference:

       git fetch out.bundle +refs/*:refs/remotes/bundle/*

  3. On day 2, create a bundle from the previously recorded tips:

       git bundle create out.bundle --all --not --remotes=bundle

  4. Update your tips in the same way:

       git fetch out.bundle +refs/*:refs/remotes/bundle/*

and so on for day 3 and onward.

Note that this is not the only way to store those tips (I just did it
using git refs because it's simple to manipulate). You could also just
store it in a file:

      # checkpoint
      git ls-remote out.bundle | cut -f1 | sort -u >tips

      # make incremental bundle
      git bundle create out.bundle --all --not $(cat tips)

This also makes it easy to recover if the other side ever gets out of
sync (say you create and checkpoint a bundle on the sending side, but it
never makes it to the remote; how do you know where to start from?). You
can always get the latest set of tips from the remote by running:

      git ls-remote . | cut -f1 | sort -u >tips

on it and then sneaker-netting the tips file back to the sender.

-Peff
