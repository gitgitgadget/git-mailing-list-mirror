From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-add -p: be able to undo a given hunk
Date: Mon, 27 Jul 2009 06:30:32 -0400
Message-ID: <20090727103031.GA3131@coredump.intra.peff.net>
References: <20090723074104.GI4750@laphroaig.corp>
 <7veis7yxwx.fsf@alter.siamese.dyndns.org>
 <20090724193207.6117@nanako3.lavabit.com>
 <7v8wienk07.fsf@alter.siamese.dyndns.org>
 <20090725145237.GB18545@artemis.corp>
 <20090726153950.GA16780@sigill.intra.peff.net>
 <20090727082623.GB18268@laphroaig.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@madism.org>
X-From: git-owner@vger.kernel.org Mon Jul 27 12:30:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVNTi-0007p5-DZ
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 12:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755985AbZG0Kag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 06:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755963AbZG0Kaf
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 06:30:35 -0400
Received: from peff.net ([208.65.91.99]:48299 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755929AbZG0Kaf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 06:30:35 -0400
Received: (qmail 23515 invoked by uid 107); 27 Jul 2009 10:32:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 27 Jul 2009 06:32:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jul 2009 06:30:32 -0400
Content-Disposition: inline
In-Reply-To: <20090727082623.GB18268@laphroaig.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124161>

On Mon, Jul 27, 2009 at 10:26:24AM +0200, Pierre Habouzit wrote:

> > No, I don't really think so in terms of implementation, but it is
> > really about a different mental model:
> > 
> >   1. You never delete things. You only copy or move them into registers.
> > 
> >   2. The interface should be the same whether you are moving between
> >      registers, or to/from the working tree.
> > 
> >   3. It extends naturally to multiple registers.
> 
> I like the general idea, I'm unsure what the UI for such tools would
> look like though.

I was thinking of unifying the multiple interfaces that we use to move
content and changes around into a single "git sort" and "git sort -i"
(and yes, I just made those names up, so feel free to call them crappy),
which would take a source and a destination (which would probably
default to the working tree and index respectively).

So you could do the equivalent of:

  - git add foo => git sort foo
  - git add -p => git sort -i foo
  - git checkout -- foo => git sort --from=index --to=tree foo
  - git checkout HEAD -- foo => git sort --from=HEAD --to=tree foo
  - git reset --mixed => git sort --from=HEAD --to=index
  - git reset --mixed foo => git sort --from=HEAD --to=index foo
    (note that this reset doesn't actually exist now, but is something
    that people try to do)
  - git stash save => git sort --to=%mystash
    (and note that I just made up some "this is a register" syntax;
     we maybe would really just want these as refs like refs/registers,
     so you would specify registers/mystash)
  - git stash -i => git sort --to=%mystash -i
    (interactive stash doesn't exist yet, of course)
  - git stash foo => git sort --to=%mystash foo
    (partial stash doesn't exist yet)
  - git diff HEAD stash -- foo | git apply => git sort --from=%mystash foo

So really, it could be a new way of interacting with the _regular_
index, as well, though perhaps it is overboard to completely redesign
the git interface. :) I just think it introduces a consistency to the
interface around the single concept of "moving your content around". So
in a sense it would be a good candidate for an alternative porcelain.
But do note that many common operations are more typing (like the
checkout replacements); that would be something to fix.

Again, just thinking out loud. Feel free to ignore, but if you think
there is anything interesting to pick out, let me know.

-Peff
