From: Jeff King <peff@peff.net>
Subject: Re: git stash data loss
Date: Tue, 21 Aug 2012 02:55:27 -0400
Message-ID: <20120821065527.GC3238@sigill.intra.peff.net>
References: <55831343358368@web1e.yandex.ru>
 <20120727132953.GA8263@sigill.intra.peff.net>
 <20120727135051.GA10303@sigill.intra.peff.net>
 <7vy5lew5xz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Aleksandr Pryimak <tramsmm-mirror@yandex.ru>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 08:55:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3iNG-0003VZ-Sr
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 08:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688Ab2HUGzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 02:55:32 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43485 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753644Ab2HUGza (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 02:55:30 -0400
Received: (qmail 28774 invoked by uid 107); 21 Aug 2012 06:55:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Aug 2012 02:55:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2012 02:55:27 -0400
Content-Disposition: inline
In-Reply-To: <7vy5lew5xz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203946>

On Thu, Aug 16, 2012 at 08:30:48PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Jul 27, 2012 at 09:29:53AM -0400, Jeff King wrote:
> >
> >> If we put actual files inside "x", which git does track, then they would
> >> be part of the stash, and should be properly retained. But they're not:
> >> 
> >>   $ rm x && mkdir x && echo foo >x/file
> >> 
> >> Now we have some precious contents in the form of "x/file". They are
> >> untracked by git, but git should be careful about removing them.
> >> 
> >>   $ git stash
> >>   Saved working directory and index state WIP on master: 2d32d3a initial
> >>   HEAD is now at 2d32d3a initial
> >>   $ ls -l x
> >>   -rw-r--r-- 1 peff peff 0 Jul 27 09:19 x
> >>   $ git stash show --raw
> >>   :100644 000000 e69de29... 0000000... D  x
> >> 
> >> Now this _is_ data loss. Stash blows away untracked files inside the
> >> directory, but does not record them in the resulting stash. And that
> >> should be fixed.
> >
> > Hrm. The problem is that after creating the stash, we then run "git
> > reset --hard" to drop the changes that we just stashed. But that is not
> > always accurate. It will not usually touch untracked files, but it might
> > if they have D/F conflicts with tracked files. So we need to replace
> > that "git reset --hard" with some safer command that will notice we are
> > about to overwrite untracked files. But I am not sure what that command
> > would be.
> 
> Is this something we still want to keep track of?

Yeah, I think it is worth fixing. It's a somewhat rare case, but data
loss is bad. I was hoping you would respond with "...and here is the
magical incantation of git commands to make the working directory look
like we want". I couldn't come up with one. We may need a new option to
reset or read-tree.

-Peff
