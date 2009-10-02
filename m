From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] do not mangle short options which take arguments
Date: Fri, 2 Oct 2009 02:11:59 -0400
Message-ID: <20091002061159.GA24892@coredump.intra.peff.net>
References: <20090925233226.GC14660@spearce.org>
 <20091001201648.GA12175@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Oct 02 08:12:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtbNH-0002nK-Dk
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 08:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780AbZJBGME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 02:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756731AbZJBGME
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 02:12:04 -0400
Received: from peff.net ([208.65.91.99]:38051 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756723AbZJBGMD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 02:12:03 -0400
Received: (qmail 25853 invoked by uid 107); 2 Oct 2009 06:15:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 02 Oct 2009 02:15:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Oct 2009 02:11:59 -0400
Content-Disposition: inline
In-Reply-To: <20091001201648.GA12175@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129421>

On Thu, Oct 01, 2009 at 10:16:48PM +0200, Clemens Buchacher wrote:

> Instead of
> 
>   $ git commit -a -ammend
>   [work ce38944] mend
>    1 files changed, 2 insertions(+), 0 deletions(-)
> 
> we now get
> 
>   $ git commit -a -ammend
>   error: switch `m' must not be mangled with other options
>   usage: git commit [options] [--] <filepattern>...
>   [...]
> 
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> ---
> On Fri, Sep 25, 2009 at 04:32:26PM -0700, Shawn O. Pearce wrote:
> > I wonder, should the -m flag on commit not allow cuddling its
> > value against the switch when its combined in short form with
> > other switches?
> 
> Here we go.

I thought the proposal was to disallow just cuddling of the value when
the switch was combined with others. So you would disallow "git commit
-ammend" but it would still be legal to do "git commit -am foo". Your
patch disallows the latter.

I would prefer to allow the uncuddled form, as it is something I do
occasionally (and I don't think "git commit -am foo" looks very much
like a typo).

To be honest, I am not sure that even the more restricted proposal is
that good an idea. You are introducing a heuristic to guess at what is a
typo or error from the user; when your guess is wrong, the user will be
annoyed (doubly so if it is buried deep in a script, which this change
will also impact). So you are guessing that people don't use the
cuddled form in this way. I suspect most don't. But I also wonder how
many typos you are really helping to save. This was brought up to make
"-ammend" DWYM. Is that really that common a double-typo?

On the other hand, the cuddled value already has some DWYM magic (it
recognizes -amend), so it is already a little bit unsafe to use
(interestingly, though, the gitcli(7) documentation actually recommends
using the "sticked" form over the separated one. However, it also
recommends splitting your short options).

So I don't feel _too_ strongly. I am just concerned that we are
introducing some DWYM magic that is not really going to help many people
out, and is just going to make understanding the rules for option
parsing more complex, and introduce the possibility (albeit slim) of
breaking people's scripts and trained fingers.

-Peff
