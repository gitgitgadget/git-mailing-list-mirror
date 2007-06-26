From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-rev-list: give better diagnostic for failed write
Date: Tue, 26 Jun 2007 05:06:05 -0400
Message-ID: <20070626090605.GA4349@coredump.intra.peff.net>
References: <87r6nzu666.fsf@rho.meyering.net> <alpine.LFD.0.98.0706251349540.8675@woody.linux-foundation.org> <878xa7u2gh.fsf@rho.meyering.net> <alpine.LFD.0.98.0706251505570.8675@woody.linux-foundation.org> <alpine.LFD.0.98.0706251536240.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 26 11:06:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3700-0001DL-45
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 11:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbXFZJGK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 05:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbXFZJGK
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 05:06:10 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4430 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbXFZJGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 05:06:09 -0400
Received: (qmail 10367 invoked from network); 26 Jun 2007 09:06:25 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 26 Jun 2007 09:06:25 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Jun 2007 05:06:05 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0706251536240.8675@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50956>

On Mon, Jun 25, 2007 at 03:56:11PM -0700, Linus Torvalds wrote:

> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -408,5 +408,6 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
>  		shown = 1;
>  	}
>  	opt->loginfo = NULL;
> +	flush_or_die(stdout, "stdout");
>  	return shown;
>  }

I think flushing here is a good change regardless of the error checking.
Sometimes, when you are severely limiting commits, the whole output is
smaller than the buffer, and you end up waiting a long time for any
output even though your answer may have been found immediately.

For example, 'git-whatchanged -Sfoo' when 'foo' was introduced in the
last couple of commits (but wasn't referenced before) will have to
calculate diffs on all of history before producing output. Flushing
after every commit restores the illusion that git provides your answer
instaneously. :)

-Peff
