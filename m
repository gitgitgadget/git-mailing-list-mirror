From: Jeff King <peff@peff.net>
Subject: Re: drop connectivity check for local clones
Date: Wed, 4 Nov 2015 12:34:58 -0500
Message-ID: <20151104173458.GA11917@sigill.intra.peff.net>
References: <CAJR51WY-HSoTHpBm1jek2+fZyHQL3-n2J6aS-MBCDO5WtYTKRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matej Buday <m.buday@o0.sk>
X-From: git-owner@vger.kernel.org Wed Nov 04 18:35:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu1xl-0004Lm-C9
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 18:35:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755956AbbKDRfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 12:35:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:52746 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755171AbbKDRfB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 12:35:01 -0500
Received: (qmail 5710 invoked by uid 102); 4 Nov 2015 17:35:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Nov 2015 11:35:01 -0600
Received: (qmail 4155 invoked by uid 107); 4 Nov 2015 17:35:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Nov 2015 12:35:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Nov 2015 12:34:58 -0500
Content-Disposition: inline
In-Reply-To: <CAJR51WY-HSoTHpBm1jek2+fZyHQL3-n2J6aS-MBCDO5WtYTKRg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280860>

[I'm cc-ing the list, since I think this answer is of general interest.]

On Wed, Nov 04, 2015 at 11:00:34AM +0100, Matej Buday wrote:

> I have a question somewhat regarding this old commit of yours:
> https://github.com/git/git/commit/125a05fd0b45416558923b753f6418c24208d443
> 
> Let me preface this by saying that I don't completely understand what the
> connectivity check does...

One of the invariants git tries to remain in the repository is that for
any object reachable from a ref (i.e., a branch or tag), we have all of
the ancestor objects. So if you have commit 125a05, you also have the
parent, and its parent, and so on, down to the root.

When we fetch or clone from a remote repository, it sends us some
objects, and we plan to point one of our refs at it. But rather than
trust that the remote sent us everything we need to maintain that
invariant, we actually walk the graph to make sure that is the case.

This can catch bugs or transfer errors early. So the operation is safer,
at the expense of spending some CPU time.

We skip it for local disk-to-disk clones. We trust the source clone
more, and since the point of a local clone is to be very fast, the
safety/CPU tradeoff doesn't make as much sense.

> Well, the question is -- is this check necessary
> for local clones that use the --reference option?

Sort of. If you say:

  git clone --reference /some/local/repo git://some-remote-repo

Then we do check the incoming objects from some-remote-repo. However,
there is an optimization we don't do: we could assume that everything in
/some/local/repo is fine, and stop traversing there. So if you fetch
only a few objects from the remote, that is all you would check.

The optimization would look something like this:

  https://github.com/peff/git/commit/1254ff54b49eff19ec8a09c36e3edd24d490cae1

I wrote that last year, but haven't actually submitted the patch yet.
There are two reasons:

  1. It needs minor cleanup due to the sha1/oid transition that is
     ongoing (see the "ugh" comment). I think this could be fixed by
     refactoring some of the callback interfaces, but I haven't gotten
     around to it.

  2. Using alternates to optimize can backfire at a certain scale. If
     you have a very large number of refs in the alternate repository,
     just accessing and processing those refs can be more expensive than
     walking the history graph in the first place.

     This is the case for us at GitHub, where our alternates have the
     refs for _all_ of the forks of a given project. So I would want
     some flag to turn this behavior off.

     Of course, we are in an exceptional circumstance at GitHub, and
     that is no reason the topic cannot go upstream (we already carry
     custom patches to disable alternates for things like receive-pack,
     and could do the same here).

     So that is not a good reason not to submit, only an explanation why
     I have not yet bothered to spend the time on it. :)

-Peff
