From: Jeff King <peff@peff.net>
Subject: Re: "git notes show" is orders of magnitude slower than doing it
 manually with ls-tree and cat-file
Date: Tue, 25 Nov 2014 23:46:42 -0500
Message-ID: <20141126044642.GA15252@peff.net>
References: <20141126004242.GA13915@glandium.org>
 <20141126010051.GA29830@peff.net>
 <20141126012448.GA11183@peff.net>
 <20141126022553.GA16199@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Nov 26 05:46:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtUV5-00047i-L4
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 05:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbaKZEqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 23:46:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:45100 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751795AbaKZEqn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 23:46:43 -0500
Received: (qmail 26305 invoked by uid 102); 26 Nov 2014 04:46:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Nov 2014 22:46:43 -0600
Received: (qmail 4146 invoked by uid 107); 26 Nov 2014 04:46:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Nov 2014 23:46:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Nov 2014 23:46:42 -0500
Content-Disposition: inline
In-Reply-To: <20141126022553.GA16199@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260268>

On Wed, Nov 26, 2014 at 11:25:53AM +0900, Mike Hommey wrote:

> Now, looking at the notes tree reflog, I see that at some point, some
> notes were added at the top-level of the tree, without being nested,
> which is strange.

That's somewhat expected. The fanout is dynamic based on the number of
notes, so early on I think some notes may be found at the top of the tree.

> And it looks like it's related to how I've been adding them, through
> git-fast-import. I was using notemodify commands, and was using the
> filemodify command to load the previous notes tree instead of using the
> from command because I don't care about keeping the notes history.
> So fast-import was actually filling the notes tree as if it were
> starting over with whatever new notes were added with notemodify (which,
> in a case where there were many, it filled with one level of
> indirection)

Ah, that sort of makes sense. This confused the code to adjust the
fanout, because we track "number of notes" independently of "number of
files" (even though they are really the same thing in a notes tree).

> I'm not sure this is a case worth fixing in fast-import. I can easily
> work around it.

Yeah. Probably fast-import could be smarter here, but I think ultimately
it makes sense to stick to using the note commands. I think what you
want is a version of "from" that takes an existing tree (and number of
notes!) from a commit, but does not add it as a parent. AFAIK,
fast-import doesn't have a way to do that.

Probably the simplest thing is to build it with history via fast-import,
and then just truncate the history at the end with:

  commit=$(echo "final notes tree" | git commit-tree refs/notes/foo^{tree})
  git update-ref refs/notes/foo $commit

-Peff
