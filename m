From: Jeff King <peff@peff.net>
Subject: Re: 2.2.0-rc behavior changes (2/2)
Date: Mon, 10 Nov 2014 04:31:28 -0500
Message-ID: <20141110093128.GB11387@peff.net>
References: <CAGyf7-GWBWrV9SjMY3n3B-0gCMZGfEsYfX-0vSvz6GT6r=vO6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 10:31:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnlJv-00077M-7D
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 10:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbaKJJbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 04:31:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:38679 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751671AbaKJJba (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 04:31:30 -0500
Received: (qmail 23278 invoked by uid 102); 10 Nov 2014 09:31:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 03:31:30 -0600
Received: (qmail 2104 invoked by uid 107); 10 Nov 2014 09:31:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 04:31:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Nov 2014 04:31:28 -0500
Content-Disposition: inline
In-Reply-To: <CAGyf7-GWBWrV9SjMY3n3B-0gCMZGfEsYfX-0vSvz6GT6r=vO6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 10, 2014 at 07:51:00PM +1100, Bryan Turner wrote:

> Second change: git gc --auto now fails if there are loose empty blobs.
> 
> We have a test which just touched empty files in objects/17 to trigger
> the gc --auto preconditions (Note: I realize this is completely
> invalid, and I've changed the test to no longer do this; I'm only
> surfacing the behavioral change).

This is expected. As you noticed here:

> error: object file
> .git/objects/17/02d54e8fba95ef9968a0c9b183fe22ec551c86 is empty
> fatal: unable to get object info for 1702d54e8fba95ef9968a0c9b183fe22ec551c86
> error: failed to run prune

the error comes from "git prune" failing. It is using unreachable but
"recent" objects as graph tips to keep around. If we can't load a tip
object, we abort the prune, because we would not want to delete objects
that might have been referenced (e.g., if it were a real corrupted
object that we could not read).

The second behavior (die on broken objects) has been around for a while.
The new change (in the commit you bisected to) is that we are
considering more objects.

I'll admit I didn't really consider the impact on sticking broken object
files into the object directory, but I think the code is doing the
sensible and safe thing.

-Peff
