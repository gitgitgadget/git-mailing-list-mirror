From: Jeff King <peff@peff.net>
Subject: Re: [BUG/PATCH] t9350-fast-export: Add failing test for
 symlink-to-directory
Date: Mon, 24 Aug 2015 01:25:49 -0400
Message-ID: <20150824052548.GA14403@sigill.intra.peff.net>
References: <alpine.DEB.2.10.1508191532330.31851@buzzword-bingo.mit.edu>
 <20150821145827.GA565@sigill.intra.peff.net>
 <alpine.DEB.2.10.1508211238570.31851@buzzword-bingo.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Anders Kaseorg <andersk@mit.edu>
X-From: git-owner@vger.kernel.org Mon Aug 24 07:25:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTkGb-0002Gd-D9
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 07:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbbHXFZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 01:25:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:48881 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932388AbbHXFZv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 01:25:51 -0400
Received: (qmail 2519 invoked by uid 102); 24 Aug 2015 05:25:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Aug 2015 00:25:51 -0500
Received: (qmail 20159 invoked by uid 107); 24 Aug 2015 05:25:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Aug 2015 01:25:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Aug 2015 01:25:49 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1508211238570.31851@buzzword-bingo.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276432>

On Fri, Aug 21, 2015 at 12:47:30PM -0400, Anders Kaseorg wrote:

> On Fri, 21 Aug 2015, Jeff King wrote:
> >   - we may still have the opposite problem with renames. That is, a
> >     rename is _also_ a deletion, but will go to the end. So I would
> >     expect renaming the symlink "foo" to "bar" and then adding
> >     "foo/world" would end up with:
> > 
> >        M 100644 :3 foo/world
> >        R foo bar
> > 
> >     (because we push renames to the end in our sort). And indeed,
> >     importing that does seem to get it wrong (we end up with "bar/world"
> >     and no symlink).
> > 
> > We can't fix the ordering in the second case without breaking the first
> > case. So I'm not sure it's fixable on the fast-export end.
> 
> Hmm, renames have a more fundamental ordering problem: swapping two 
> (normal) files and using fast-export -C -B results in
> 
>   R foo bar
>   R bar foo
> 
> which cannot be reimported correctly without fast-import fixes.

Yeah, you're right. Fast-export's view of the world comes from diff,
which is that the "source" side is immutable. Whereas fast-import seems
to mutate the tree in-place as it reads the set of operations. I wonder
what would break if we simply fixed that. I.e., is anybody else
depending on:

  R foo bar
  M bar ...

to modify "foo" and not "bar". I kind of wonder if it is insane to turn
on renames at all in fast-export.

-Peff
