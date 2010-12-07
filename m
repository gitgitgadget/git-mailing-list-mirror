From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] logging branch deletion to help recovering from mistakes
Date: Tue, 7 Dec 2010 13:12:01 -0500
Message-ID: <20101207181201.GB26137@sigill.intra.peff.net>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org>
 <20101207162358.GT355@fearengine.rdu.redhat.com>
 <20101207174520.GB21483@burratino>
 <20101207175418.GU355@fearengine.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Casey Dahlin <cdahlin@redhat.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 19:12:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ21N-0007FM-Bi
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 19:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204Ab0LGSMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 13:12:06 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:60144 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752588Ab0LGSMF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 13:12:05 -0500
Received: (qmail 26354 invoked by uid 111); 7 Dec 2010 18:12:03 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 07 Dec 2010 18:12:03 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Dec 2010 13:12:01 -0500
Content-Disposition: inline
In-Reply-To: <20101207175418.GU355@fearengine.rdu.redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163099>

On Tue, Dec 07, 2010 at 12:54:18PM -0500, Casey Dahlin wrote:

> On Tue, Dec 07, 2010 at 11:45:20AM -0600, Jonathan Nieder wrote:
> > Casey Dahlin wrote:
> > 
> > > Could commits made onto a detached head also show up here? Or is that
> > > better thwarted with another mechanism?
> > 
> > I think that's better thwarted with the HEAD reflog:
> > 
> > 	$ git log -g HEAD
> 
> I was more worried about changes that were made onto a detached head,
> and then the head was reattached, leaving the new commits dangling.
> 
> The end result is identical to a deleted branch, just wondering if we
> should note it in the same place.

We have enough information in the HEAD reflog already to reconstruct
those sorts of things.

You can detect entering and leaving the detached HEAD in the reflog. The
reflog comments look something like this:

  checkout: moving from $SOME_BRANCH to $SOME_SHA1
  commit: $SOME_COMMIT_MESSAGE
  checkout: moving from $SOME_OTHER_SHA1 to $BRANCH|$SHA1

So from that you can see that we entered a detached HEAD state, made a
commit, and that commit became dangling when we moved. One could write a
script to search for these cases (but note that most detached instances
just involve rebasing, which is probably not interesting, as we install
the result into the branch tip at the end).

I don't think this belongs in the same realm as "deleted branches", but
I do think we could have a special option to "git fsck" to stick these
into lost-found.

-Peff
