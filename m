From: Jeff King <peff@peff.net>
Subject: Re: how to remove unreachable objects?
Date: Mon, 19 Sep 2011 20:51:59 -0400
Message-ID: <20110920005159.GA1674@coredump.intra.peff.net>
References: <20110919110831.ewq03vnqos4w8cs8@webmail.edis.at>
 <20110919195335.GA31930@sigill.intra.peff.net>
 <20110919201804.GB31930@sigill.intra.peff.net>
 <7vsjns8b6m.fsf@alter.siamese.dyndns.org>
 <20110919225219.GD4056@sigill.intra.peff.net>
 <7vfwjs82sc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: dieter@schoen.or.at, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 02:52:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5oZE-0001oE-Br
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 02:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323Ab1ITAwC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 20:52:02 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37899
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751987Ab1ITAwB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 20:52:01 -0400
Received: (qmail 11866 invoked by uid 107); 20 Sep 2011 00:56:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with (AES128-SHA encrypted) ESMTPSA; Mon, 19 Sep 2011 20:56:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Sep 2011 20:51:59 -0400
Content-Disposition: inline
In-Reply-To: <7vfwjs82sc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181727>

On Mon, Sep 19, 2011 at 05:40:03PM -0700, Junio C Hamano wrote:

> > Does that work? I had the impression from the documentation that the
> > arguments are purely about the reachability analysis, and that the
> > actual corruption/correctness checks actually look through the object db
> > directly, making sure each object is well-formed. Skimming cmd_fsck
> > seems to confirm that.
> 
> You are right that you may see "corrupt object" for unreachable from the
> tips in the object store, but I was talking more about verifying
> everything that is needed for reachability analysis from the given tips
> can be read, iow, "missing object" errors, lack of which would mean you
> can salvage everything reachable from the refs involved in the traversal.

True. Though one could also do that with "git log", and it would be much
cheaper (since each trial you run with git-fsck is going to actually
fsck the object db, which is expensive).

I can't help but think the right solution there is something like:

  1. If the corrupted or missing object is a blob or tree, figure out
     which commits reference it with something like:

       a. Create a set B of bad objects (blobs or trees).

       b. For each tree in the object db, open and see if it contains
          any elements of B. If so, add the tree to another set, B'.

       c. If B' is empty, done. Otherwise, add elements from B' to B and
          goto step (b).

       d. For each commit in the object db, open and check the tree
          pointer. If it points to an element of B, then the commit is
          bad.

  2. If the object is a commit, or if you arrived at a set of bad
     commits through step (1), then use "branch --contains" on the
     bad commits.

which is algorithmically efficient (though probably slow if you had to
cat-file each tree). It might be a handy special command, though (I have
seen people ask for "which part of history references this blob" on
occasion). I've never bothered writing it because I've never had a
corrupt object. :)

Anyway, that is perhaps not relevant to your point. But I do think that
fsck with arguments is more likely to confuse someone than to actually
be part of a productive use-case. I have no problem with deprecating or
removing it.

-Peff
