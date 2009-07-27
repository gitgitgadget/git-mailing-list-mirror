From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-add -p: be able to undo a given hunk
Date: Mon, 27 Jul 2009 06:36:09 -0400
Message-ID: <20090727103609.GB3131@coredump.intra.peff.net>
References: <20090723074104.GI4750@laphroaig.corp>
 <20090725145237.GB18545@artemis.corp>
 <20090726153950.GA16780@sigill.intra.peff.net>
 <200907271206.11431.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pierre Habouzit <madcoder@madism.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 27 12:36:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVNZ6-0001ku-KD
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 12:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003AbZG0KgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 06:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756000AbZG0KgK
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 06:36:10 -0400
Received: from peff.net ([208.65.91.99]:59533 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755992AbZG0KgK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 06:36:10 -0400
Received: (qmail 23548 invoked by uid 107); 27 Jul 2009 10:38:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 27 Jul 2009 06:38:15 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jul 2009 06:36:09 -0400
Content-Disposition: inline
In-Reply-To: <200907271206.11431.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124162>

On Mon, Jul 27, 2009 at 12:06:10PM +0200, Thomas Rast wrote:

> >   5. Commit 'b' on top of new HEAD (and this would probably actually
> >      mean the changes from 'b' to the old HEAD, not setting the new HEAD
> >      state to what's in 'b').
> > 
> > So it's sort of a generalized form of the index, where you have N "index
> > registers" and you sort your changes into them. And during steps 2 and
> > 3, you could also make more changes, pick them out, etc.
> 
> I think the parenthetical remark actually contradicts the notion that
> it's an index.  It's more like a place to hold a patch.  Which then
> makes it rather similar to a temporary branch and cherry-pick, or
> interactive rebase, or whatever.

Sort of. It's not an index in the sense that you might make a tree and
commit directly from it. But I think of it as an index in that it holds
a particular state, and you can diff that state against other things. I
would probably implement it as an index via GIT_INDEX_FILE (though I
guess performance would not be as nice as if it shared the cache parts
of the main index).

Implicit in my thinking was that you could actually get rid of the
concept of "the index" and simply replace it with such a register (which
maybe would be the "default register" or something). So whether you
committed directly from it, or whether you applied its diff would be
decided not at creation time, but at the time you wanted to commit. And
that would depend on what operations you were doing (simply making a
commit, sorting changes for multiple commits, etc).

> Granted, the register idea does not directly map to interactive rebase
> because that cannot (automatically) add changes to an older commit.
> So I frequently wind up making a series of commits along the lines of
> 
>   WIP implement foo
>   WIP implement bar
>   WIP fix foo some
>   WIP docs for bar
>   WIP docs for foo
>   WIP tests for foo
> 
> and then have to sort and squash them with rebase -i.

Yes, I do that a lot. And maybe this whole thing is a stupid idea; git
already has lots of tools for working with _commits_, so maybe registers
should really just be commits. So in that sense what I am asking for is
just a multi-headed stash, and tools for doing interactive, incremental
stashing to those heads.

-Peff
