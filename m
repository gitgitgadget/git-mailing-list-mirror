From: Jeff King <peff@peff.net>
Subject: Re: Git Notes idea.
Date: Thu, 18 Dec 2008 08:54:34 -0500
Message-ID: <20081218135433.GA6706@coredump.intra.peff.net>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com> <20081216085108.GA3031@coredump.intra.peff.net> <5d46db230812161043m4a5873a8w4c323d634b639ba0@mail.gmail.com> <20081217093843.GA18265@coredump.intra.peff.net> <5d46db230812170906h7fdcac03o60386504c8df1083@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Govind Salinas <govind@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 14:56:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDJM5-0006kE-7e
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 14:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbYLRNyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 08:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbYLRNyi
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 08:54:38 -0500
Received: from peff.net ([208.65.91.99]:3736 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327AbYLRNyh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 08:54:37 -0500
Received: (qmail 2280 invoked by uid 111); 18 Dec 2008 13:54:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Dec 2008 08:54:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Dec 2008 08:54:34 -0500
Content-Disposition: inline
In-Reply-To: <5d46db230812170906h7fdcac03o60386504c8df1083@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103461>

On Wed, Dec 17, 2008 at 11:06:15AM -0600, Govind Salinas wrote:

> Yes, I was thinking that this is the natural way to do things, save that I
> would be lazy loading the trees into a cache instead of caching them
> all up front.  This is one of the reasons that I think the fan out will
> help.

I was working under the assumption that you are going to do multiple
note lookups. If you are, then the fan-out isn't really going to help,
as you're going to end up pulling in all of the subtrees anyway. It
helps some if you're only doing a single lookup, but I don't know if
that is measurable.

> Yes, I completely agree that I want it to have the same scheme as what
> git will use.  That is the reason I posted this here.  Since no method
> has been formally accepted (checked into master) I wanted to see if
> I could nudge things along.  I wasn't aware that you and Dscho had
> a (very similar) plan.  Please, if you guys are decided on the format
> then I can just go off and start working on it.  But it sounds like there
> isn't consensus yet.

This is probably not the answer you want, but I think the final design
depends on some C experiments. For example, whether or not there should
be fan-out depends on how it affects performance, which means we need to
do at least partial implementations to compare. So it really is just
waiting for somebody to sit down and do it.

> I like the overall plan, but I would suggest that --notes[=default] and
> --note-type=whatever would be a little friendlier and less error prone.

But keeping it as a single string means there is no ambiguity when you
specify multiple notes at once. For example:

  git log \
    --note-filter='test:status == "fail" && importance > 3' \
    --pretty=format:%h%n%N(test:errors)

would do something like:

  foreach commit $C
    compare refs/notes/test:$C/status against the string "fail"
    compare refs/notes/default:$C/importance against the number 3
    if either don't match, skip the commit
    show the hash and the contents of refs/notes/test:$C/errors

and obviously that filter language is totally made up and we may or may
not want to do something that complex. But my point is that we are
defining a namespace of notes, and we want to be able to refer to a
multiple fully qualified names.

-Peff
