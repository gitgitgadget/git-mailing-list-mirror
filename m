From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] cogito: Avoid slowness when timewarping large trees.
Date: Fri, 24 Mar 2006 05:55:44 -0500
Message-ID: <20060324105543.GA2543@coredump.intra.peff.net>
References: <20060324084423.GA30213@coredump.intra.peff.net> <7vd5gc16u2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Mar 24 11:56:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMjxU-0004x0-2u
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 11:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422840AbWCXKzq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 05:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422846AbWCXKzq
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 05:55:46 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:25052 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S1422840AbWCXKzq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 05:55:46 -0500
Received: (qmail 27764 invoked from network); 24 Mar 2006 10:55:44 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 24 Mar 2006 10:55:44 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Mar 2006 05:55:44 -0500
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vd5gc16u2.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17908>

On Fri, Mar 24, 2006 at 02:21:25AM -0800, Junio C Hamano wrote:

> Metainformation fields are internally separated with SP and a
> TAB comes before pathname; you can just say:
> 
> 	sed -ne 's/^:[^	]* D	//p'

That is much cleaner (I stupidly just converted the original regex
verbatim).

> a SP).  You might also want to consider "xargs rm -f --", BTW.

Oops, you're right. In particular, rm complains when there are no
deletions. 

> However, I wonder why it does not do this instead:
> 
> 	... stash away the local changes
> 	git-read-tree -m "$base" ;# reset the index to $base
> 
> 	# switch to $branch -- removing gone files as well
> 	git-read-tree -m -u "$base" "$branch"
> 
> Then you can also lose diff-tree and checkout-index there.

This doesn't deal very well with local changes. The second read-tree
complains about a not uptodate entry during the merge. Since we've
already stashed the local changes as a diff, we should be able to simply
ignore them during the read-tree. Should the first read-tree actually
be:
  git-read-tree --reset "$base"
?

-Peff
