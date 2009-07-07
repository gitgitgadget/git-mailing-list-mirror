From: Jeff King <peff@peff.net>
Subject: Re: =?utf-8?Q?Schr=C3=B6dinger's?= diff
Date: Tue, 7 Jul 2009 15:36:05 -0400
Message-ID: <20090707193605.GA30945@coredump.intra.peff.net>
References: <279b37b20907062353k34bca06erf035458e80933c8d@mail.gmail.com>
 <alpine.LNX.2.00.0907071316490.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 21:36:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOGSf-0005t7-TR
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 21:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247AbZGGTgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 15:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754084AbZGGTgI
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 15:36:08 -0400
Received: from peff.net ([208.65.91.99]:46659 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754049AbZGGTgI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 15:36:08 -0400
Received: (qmail 5840 invoked by uid 107); 7 Jul 2009 19:38:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 07 Jul 2009 15:38:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jul 2009 15:36:05 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0907071316490.2147@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122861>

On Tue, Jul 07, 2009 at 01:36:08PM -0400, Daniel Barkalow wrote:

> > 	# I realize that switching is ill-advised, but I'm
> > 	# trying to track down a possibly related problem...
> > 	git config core.autocrlf true
> > 
> > 	# This sometimes produces output and sometimes it doesn't.
> > 	# Either way rerunning just git-diff always gives the same result
> > 	# as the first run in this repo.
> > 	git diff
> 
> If git knows the file hasn't been modified, it doesn't produce a diff. 
> 
> If it doesn't know the file hasn't been modified, it looks at the actual 
> contents and it find that the result of reading the disk applying autocrlf 
> now doesn't match the contents of the index.

Yes, that was my analysis upon reading the original mail, as well (and I
have been bitten by this before while testing crlf stuff). The same
thing can happen with clean/smudge, I think.

When you set up config that changes how we view worktree files (like
crlf or clean/smudge) and there is already cached stat information in
the index, you really need to invalidate the matching stat information
in the index to get sane results[1]. It might be nice for "git config"
to do this for you, but:

    1. You could just as easily be hand-editing the config.

    2. It feels wrong from a modularity standpoint. Right now "git
       config" doesn't actually care about the semantics of config,
       just the syntax. Which makes it exactly equivalent to
       hand-editing.

    3. It doesn't cover every situation. Files can also be "changed" in
       this way by editing .gitattributes, which can be changed manually
       or by any number of git commands (like checkout, reset, etc).

So I think automatically detecting this situation would require flags in
the index to say "this stat information is valid only over these
particular settings". And you would want it per-file to avoid having to
re-hash every file when you change the .gitattributes for one file. The
command using the index would check it. But even that might have holes,
I'm afraid -- we don't always look at all of the config in every
command, though perhaps we do for such core functionality.

-Peff

[1] Is there an easy way to do this with update-index? I didn't see one,
and had to resort to "git read-tree HEAD".
