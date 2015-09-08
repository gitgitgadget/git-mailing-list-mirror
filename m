From: Jeff King <peff@peff.net>
Subject: Re: Questions about git-push for huge repositories
Date: Tue, 8 Sep 2015 17:54:57 -0400
Message-ID: <20150908215457.GC24159@sigill.intra.peff.net>
References: <CAN6cQGPcGpaXUGu_7aaeJtMbruMocte-5po97vG5r39f=YdTZQ@mail.gmail.com>
 <xmqq4mj7bfsf.fsf@gitster.mtv.corp.google.com>
 <CAN6cQGMf089ERn2kZbFpHJ6vyJ4BnjCm-m-E+hQsduH55XFvKw@mail.gmail.com>
 <CAN6cQGNGP+n3L=tuRCymOTWFCnFNsq-tFHkaNm+W=o726mjmmw@mail.gmail.com>
 <CAN6cQGOO540FV9bTQPks+1nHS1xO10Rv8iNzAj8-cBihQ4_kEw@mail.gmail.com>
 <20150908054432.GC26331@sigill.intra.peff.net>
 <xmqq4mj493cp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Levin Du <zslevin@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 23:55:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZQr4-0004br-S7
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 23:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbbIHVzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 17:55:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:56477 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752026AbbIHVzA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 17:55:00 -0400
Received: (qmail 18394 invoked by uid 102); 8 Sep 2015 21:54:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 16:54:59 -0500
Received: (qmail 25889 invoked by uid 107); 8 Sep 2015 21:55:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 17:55:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Sep 2015 17:54:57 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4mj493cp.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277526>

On Tue, Sep 08, 2015 at 11:24:06AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If you turn on reachability bitmaps, git _will_ do the thorough set
> > difference, because it becomes much cheaper to do so. E.g., try:
> >
> >     git repack -adb
> >
> > in repo A to build a single pack with bitmaps enabled. Then a subsequent
> > push should send only a single object (the new commit).
> 
> Hmph, A has the tip of B, and has a new commit B hasn't seen but A
> knows that new commit's tree matches the tree of the tip of B.
> 
> Wouldn't --thin transfer from A to B know to send only that new
> commit object without sending anything below the tree in such a
> case, even without the bitmap?

I started to write about that in my analysis, but it gets confusing
quickly. There are actually many tip trees, because A and B also share
all of their tags. We do not mark every blob of every tip tree as a
preferred base, because it is expensive to do so (and it just clogs our
object array).  Plus this only helps in the narrow circumstance that we
have the exact same tree as the tip (and not, say, the same tree as
master^, which I think it would be unreasonable to expect git to find).

But if we do:

  (cd ../B && git tag | git tag -d)

to delete all of the other tips besides master, leaving only the one
that we know has the same tree, I'd expect git to figure it out.

Certainly I would not expect it to save all of the delta compression,
in the sense that we may throw away on-disk delta bases to older objects
(because we don't realize the other side has those older objects). But I
would have thought before we even hit that phase, adding those objects
as "preferred bases" would have marked them as "do not send" in the
first place.

There is code in have_duplicate_entry() to handle this. I wonder why it
doesn't kick in.

-Peff
