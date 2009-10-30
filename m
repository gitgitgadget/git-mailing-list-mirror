From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitignore: root most patterns at the top-level
 directory
Date: Fri, 30 Oct 2009 14:24:32 -0400
Message-ID: <20091030182431.GA19901@coredump.intra.peff.net>
References: <20091027011024.GA29361@sigio.peff.net>
 <7vmy3cys0f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 19:24:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3w9g-0004xX-As
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 19:24:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932849AbZJ3SYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 14:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932847AbZJ3SYm
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 14:24:42 -0400
Received: from peff.net ([208.65.91.99]:40465 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932828AbZJ3SYf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 14:24:35 -0400
Received: (qmail 2054 invoked by uid 107); 30 Oct 2009 18:28:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Oct 2009 14:28:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Oct 2009 14:24:32 -0400
Content-Disposition: inline
In-Reply-To: <7vmy3cys0f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131723>

On Tue, Oct 27, 2009 at 11:03:28PM -0700, Junio C Hamano wrote:

> How does .cvsignore and .svnignore work?  Don't they have the same issue,
> and perhaps worse as I do not recall seeing a way to anchor a pattern to a
> particular directory like we do in their .SCMignore files?  And judging
> from the fact that they can get away with the lack of that "feature", this
> perhaps is not an issue in real life?

Happily, I did not remember how .cvsignore worked and had to go read the
documentation. :) The answer is that no, it does not have the recursive
feature in the root .cvsignore list at all. But it does apply the
repo-wide CVSROOT/cvsignore, the user's ~/.cvsignore, and the
environment's $CVSIGNORE to all directories. So it is safe from this
problem (though now that I think on it, I think I was once bitten by
something similar in the CVSROOT/cvsignore).

SVN implements this with "properties" on the directories. They are not
recursive at all. However, it also implements "global-ignores" which
applies everywhere.

So no, they don't have the same issue, because they explicitly split the
"everywhere" and "this directory" cases into two locations. We wouldn't
want to use .git/info/excludes for this, because we do want to support
the project shipping some global excludes itself.

> I am actually a bit reluctant to queue this, even though I most likely
> will, and then hope that we will think of a better solution later, at
> which time this file again needs to change.

I am mixed on it, as well. I did see it bite someone, but I think it's
very rare, and everyone who reads or touches the file will have to deal
with the ugliness every time. If you want to drop the patch, I will not
complain.

> For example, it crossed my mind that perhaps we can change the ignore
> rules so that a non-globbing pattern is automatically anchored at the
> current directly but globbing ones are recursive as before.

That makes some sense to me (and in fact when making the patch, it was
the rule of thumb I used). Though I think you might want to make it
"starts with glob" as the trigger for the rule. We have "git-core-*/?*",
which I would expect to still be anchored at the root.

> If we do so, there is no need to change the current .gitignore entires.
> You need to spell a concrete filename as a glob pattern that matches only
> one path if you want the recursive behaviour.  E.g. if you have a Makefile
> per subdirectory, each of which generates and includes Makefile.depend
> file, you would write "Makefile.depen[d]" in the toplevel .gitignore file.

While clever, that use of '[d]' seems unneccessarily obscure to me. Why
not just give a wildcard for "any subdirectory of me" and do:

  Makefile.depend
  **/Makefile.depend

Since "**" is in common use in other systems, it's pretty clear (to me,
anyway, but then I am the one suggesting the syntax ;) ) what that
means.

-Peff
