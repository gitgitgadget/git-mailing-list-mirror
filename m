From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Fri, 20 Jul 2012 10:43:37 -0400
Message-ID: <20120720144337.GA31946@sigill.intra.peff.net>
References: <20120719213225.GA20311@sigill.intra.peff.net>
 <20120719213311.GA20385@sigill.intra.peff.net>
 <7vy5mftm3q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Alexey Muranov <alexey.muranov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 16:43:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsEQj-0000X7-3U
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 16:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637Ab2GTOnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 10:43:40 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56498 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752451Ab2GTOnj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 10:43:39 -0400
Received: (qmail 10794 invoked by uid 107); 20 Jul 2012 14:43:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 Jul 2012 10:43:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jul 2012 10:43:37 -0400
Content-Disposition: inline
In-Reply-To: <7vy5mftm3q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201770>

On Thu, Jul 19, 2012 at 03:36:09PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Only one test needed to be updated; t7701 tries to create
> > unreachable objects by deleting branches. Of course that no
> > longer works, which is the intent of this patch. The test
> > now works around it by removing the graveyard logs.
> 
> I think the work-around indicates the need for regular users to be
> able to also discover, prune and delete these logs.  Do we have
> "prune reflog for _this_ ref (or these refs), removing entries that
> are older than this threshold"?  If so the codepath would need to
> know about the graveyard and the implementation detail of the tilde
> suffix so that the end users do not need to know about them.

We do have it: "git reflog expire --expire=now deleted-branch" is the
right way to do it. Unfortunately, it does not work with my patch. The
dwim_log correctly notes that a reflog exists (because it checks that
the "graveyard" version of the ref exists), but then expire_reflog does
not correctly fallback when opening the log (it usually has to do the
_reverse_ translation, because it gets the graveyard log name from
for_each_reflog, and has to find the correct lock).

I'll fix it in my re-roll, and then have t7701 use it.

> I like the general direction.  Perhaps a long distant future
> direction could be to also use the same trick in the ref namespace
> so that we can have 'next' branch itself, and 'next/foo', 'next/bar'
> forks that are based on the 'next' branch at the same time (it
> obviously is a totally unrelated topic)?

I would love that, as it would mean we could simply leave the reflogs in
place without having a separate graveyard namespace. Which means there
wouldn't need to be any reflog-specific translation at all, and bugs
like the one above wouldn't exist.

But it would mean that you cannot naively run

  echo $sha1 >.git/refs/heads/foo

anymore. I suspect that the packed-refs conversion rooted out many
scripts that did not use update-ref and rev-parse to access refs, but
the above does still work today. So I suspect there would be some
fallout. Not to mention that older versions of git would be completely
broken, which would mean we need a lengthy deprecation period while
everybody upgrades to versions of git that support the reading side.

-Peff
