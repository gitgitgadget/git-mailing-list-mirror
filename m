From: Jeff King <peff@peff.net>
Subject: Re: jc/shortstatus
Date: Sat, 15 Aug 2009 04:45:53 -0400
Message-ID: <20090815084552.GA29136@coredump.intra.peff.net>
References: <7vtz0co3xe.fsf@alter.siamese.dyndns.org>
 <20090815070904.GA23389@coredump.intra.peff.net>
 <7v8whltrqj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 10:46:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McEu1-00042c-3w
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 10:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbZHOIpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 04:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbZHOIpy
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 04:45:54 -0400
Received: from peff.net ([208.65.91.99]:40903 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767AbZHOIpy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 04:45:54 -0400
Received: (qmail 18350 invoked by uid 107); 15 Aug 2009 08:45:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 15 Aug 2009 04:45:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Aug 2009 04:45:53 -0400
Content-Disposition: inline
In-Reply-To: <7v8whltrqj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125986>

On Sat, Aug 15, 2009 at 01:18:28AM -0700, Junio C Hamano wrote:

> It is handy to have both available while asking others help debugging the
> version in 'pu', and that is the only reason for the separate command.  It
> could have been named 'git frotz' for all I care ;-)
> 
> I do not intend to make it another "git merge-recur"; I would actually
> want to have it replace "status" before the series goes to 'next'.

Ah, OK. I thought we were going to live through 1.6.5 with the dual
commands. But if it is going to be "status", I don't care at all what it
is called in the interim. :)

>  - What should its exit code be?  Should it be consistent with the
>    traditional "git status" at least when no paths are given, signallying
>    failure when nothing is staged for committing, so that ancient out of
>    tree scripts people may have written would not break too badly when we
>    make the switch?

If I were designing it from scratch, I would say the exit code should be
the opposite. That is, it is really about doing several diffs, and if
there are no changes, then we should, like diff, exit zero.

If you want to know whether there is something to commit, you wouldn't
to use this tool. If you just want to know if there is something in the
index to commit, you would use diff-index. If you want to see if
some set of commit parameters would make a commit, you would use "commit
--dry-run".

So really there is only the historical argument. I am inclined not to
worry about it. We are already breaking compatibility in other ways
(like how command line parameters are treated), so you are really only
helping people whose scripts use a subset of the current "git status"
functionality. And since this is the time for breaking, I think it's
best to make all of the changes we want, and not have another
half-breakage later.

>  - What should its default mode of output be?  Do people prefer "svn st"
>    style short-format output, or should we stay verbose and explanatory?

Personally I prefer the long format, but maybe just because I'm used to
it. I suspect others want the short format. This really should be a
porcelain command[1], so I don't see a problem with a
status.outputformat config option.

[1] One can, after all, call diff-index, diff-files, and "ls-files -o"
to get the same information from plumbing. If we really want to provide
plumbing that pulls them all together (e.g., because it is more
efficient or more convenient to do it all in one command), then I think
we should provide "git status --porcelain".

>  - Is it handling corner cases correctly?  e.g. Does it operate correctly
>    when run from a subdirectory?  How should it handle submodules?  Before
>    the initial commit?  Use of colors?

I'll try out a few things, but I think largely we will need to put it in
"next" to shake out any bugs.

-Peff
