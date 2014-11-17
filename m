From: Jeff King <peff@peff.net>
Subject: Re: git merge a b when a == b but neither == o is always a
 successful merge?
Date: Mon, 17 Nov 2014 15:53:04 -0500
Message-ID: <20141117205304.GA15880@peff.net>
References: <21610.16623.746985.383838@perdition.linnaean.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Hagerty <hag@linnaean.org>
X-From: git-owner@vger.kernel.org Mon Nov 17 21:53:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqTIO-000827-Hm
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 21:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091AbaKQUxI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Nov 2014 15:53:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:41271 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752663AbaKQUxH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 15:53:07 -0500
Received: (qmail 1312 invoked by uid 102); 17 Nov 2014 20:53:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Nov 2014 14:53:07 -0600
Received: (qmail 1705 invoked by uid 107); 17 Nov 2014 20:53:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Nov 2014 15:53:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Nov 2014 15:53:04 -0500
Content-Disposition: inline
In-Reply-To: <21610.16623.746985.383838@perdition.linnaean.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 17, 2014 at 01:39:43PM -0500, Daniel Hagerty wrote:

> "git merge b" produces a successful merge, as both branches perform
> the "same" work.

Just to be clear, you were expecting "git merge b" to produce a
conflict?

> For the body of content in question, this is a merge conflict.  Git
> seems to have the hard-coded assumption otherwise.  I had to change
> three source files to get the result I expected, and wasn't seeing
> any indications of parameterization.

I can imagine there might be times you would like to notice this case
and visit it manually (e.g., even though the conflict would show both
sides with the same content, you might want the resolution to take the
two sides sequentially, duplicating them).  But there are also cases
where choosing the new content is helpful (e.g., one side cherry-picks =
a
commit from the other, then later merges; you would not want to see a
conflict there).

> Am I missing some means of getting the results I need?  Thanks!

I don't think there is an easy way to get what you want. You would have
to write a new merge 3-way strategy that handles this case differently.
And most of the file-level heavy lifting in merge strategies is done by
the low-level unpack_trees code, which handles this case. From "git hel=
p
read-tree", which describes the index-level 3-way merge:

  =C2=B7   stage 2 and 3 are the same; take one or the other (it makes =
no
      difference - the same work has been done on our branch in stage 2
      and their branch in stage 3)

So I think you would have to add an option to git to handle this, unles=
s
you want to reimplement quite a lot of code in your merge strategy.

-Peff
