From: Jeff King <peff@peff.net>
Subject: Re: How to fork a file (git cp ?)
Date: Thu, 5 May 2011 16:07:15 -0400
Message-ID: <20110505200715.GC1770@sigill.intra.peff.net>
References: <4DC1934D.6070608@aldan.algebra.com>
 <4DC19955.7040503@kdbg.org>
 <7viptqdvrf.fsf@alter.siamese.dyndns.org>
 <4DC20461.4090703@aldan.algebra.com>
 <7v1v0ddhbz.fsf@alter.siamese.dyndns.org>
 <4DC2FB0A.2090100@aldan.algebra.com>
 <BANLkTikE8aMh6RUDzrh=SuOxvKxuPShQhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Mikhail T." <mi+thun@aldan.algebra.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 22:07:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI4pX-0000A0-Vc
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 22:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207Ab1EEUHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 16:07:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54477
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297Ab1EEUHR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 16:07:17 -0400
Received: (qmail 2785 invoked by uid 107); 5 May 2011 20:09:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 May 2011 16:09:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 May 2011 16:07:15 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikE8aMh6RUDzrh=SuOxvKxuPShQhQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172902>

On Thu, May 05, 2011 at 10:01:32PM +0200, Piotr Krukowiecki wrote:

> >> I think that is what exactly "blame -C -C" gives you.
> >
> > For that to be useful, one has to suspect, the file was derived by copying
> > something else... Simple "git log" will not suggest that -- unless the
> > commit message, that adds the new copy of a file points to it...
> 
> Maybe it should be the default (performance issues?)

Performance is part of it, but also the fact that "--follow" has some
limitations. For example, you can't use it with arbitrary pathspecs. I
hope to fix that at some point. There was a GSoC proposal, but it didn't
get selected; I'm hoping to work on it myself sometime this summer.

> BTW, I don't understand why 'status' shows renames but not copies:
> 
> $ cp f fcp && git add fcp && git status
> # Changes to be committed:
> #	new file:   fcp
> 
> $ mv f fmv && git add fmv && git rm f && git status
> # Changes to be committed:
> #	renamed:    f -> fmv
> 
> I would expect sth like "copied: f -> fcp".

Yeah, we probably should do copy detection. Even weirder, we seem to do
rename detection for what's to be committed, but not for what's in the
worktree.

If you want to do a patch, the changes would go in wt-status.c, in the
functions:

  wt_status_collect_changes_worktree
  wt_status_collect_changes_index

> It should not be a problem performance-wise...

For people running "git status" manually, no. But something like
FIND_COPIES_HARDER may be expensive on a big tree for people who use
"git status" output as part of their shell prompt. So probably it should
be configurable.

-Peff
