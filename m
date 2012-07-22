From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Sun, 22 Jul 2012 09:14:48 -0400
Message-ID: <20120722131448.GA16104@sigill.intra.peff.net>
References: <20120719213225.GA20311@sigill.intra.peff.net>
 <20120719213311.GA20385@sigill.intra.peff.net>
 <50092993.6010203@alum.mit.edu>
 <20120720154403.GB2862@sigill.intra.peff.net>
 <6F148977-4F57-47FF-B43B-0997694F3891@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Alexey Muranov <alexey.muranov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 15:14:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ssvzt-0006wg-F5
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 15:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711Ab2GVNOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 09:14:52 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58106 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670Ab2GVNOv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 09:14:51 -0400
Received: (qmail 26380 invoked by uid 107); 22 Jul 2012 13:14:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 22 Jul 2012 09:14:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Jul 2012 09:14:48 -0400
Content-Disposition: inline
In-Reply-To: <6F148977-4F57-47FF-B43B-0997694F3891@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201848>

On Sun, Jul 22, 2012 at 01:10:55PM +0200, Alexey Muranov wrote:

> >>>   refs/heads/a
> >>>   refs/heads/a/b
> >>>   refs/heads/a/b/c
> >>> 
> >>> will be stored in:
> >>> 
> >>>   logs/graveyard/refs/heads/a~
> >>>   logs/graveyard/refs/heads/a/b~
> >>>   logs/graveyard/refs/heads/a/b/c~
> >>> 
> >>> Putting them in the graveyard namespace ensures they will
> >>> not conflict with live refs, and the tilde prevents D/F
> >>> conflicts within the graveyard namespace.
> 
> Sorry if this idea is stupid or if i miss something, but how about putting deleted reflogs for
> 
> refs/heads/a
> refs/heads/a/b
> refs/heads/a/b/c
> 
> to
> 
> refs/heads/a@yyyy-mm-dd-hhmmss
> refs/heads/a/b@yyyy-mm-dd-hhmmss
> refs/heads/a/b/c@yyyy-mm-dd-hhmmss
> 
> with the time they were deleted?

I like the readability of the resulting file names, but it has three
problems:

  1. "@" is allowed in ref names, so you may be conflicting with
     existing refs. You could fix that by using "@{...}", which is
     disallowed. E.g., refs/heads/a@{yyyy-mm-dd-hhmmss}.

  2. It makes lookup slightly more expensive, because to find a reflog
     for "refs/heads/a", I have to scan "logs/refs/heads" looking for
     any matching entries of the form "a@{.*}". This is probably not a
     huge deal in practice, though it does make the code more complex.

  3. Most importantly, it does not resolve D/F conflicts (it has the
     same problem as "logs/refs/heads/a~"). If you delete "foo/bar", you
     will end up with "logs/refs/heads/foo/bar@{...}". That will prevent
     D/F conflicts with a new branch "foo/bar/baz", but will still have
     a problem with just "foo".

     You need to either mark each directory to avoid the conflict
     (Michael suggested something like "refs/heads~/foo~/bar"), or
     you need to put the deleted logs into a separate hierarchy (I used
     "logs/graveyard" in my patch).

-Peff
