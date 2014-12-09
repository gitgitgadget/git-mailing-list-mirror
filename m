From: Jeff King <peff@peff.net>
Subject: Re: filter-branch performance
Date: Tue, 9 Dec 2014 13:59:34 -0500
Message-ID: <20141209185933.GC31158@peff.net>
References: <548744F1.9000902@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Henning Moll <newsScott@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 09 19:59:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyQ0b-0000Yd-4o
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 19:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbaLIS7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 13:59:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:50626 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751444AbaLIS7g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 13:59:36 -0500
Received: (qmail 13625 invoked by uid 102); 9 Dec 2014 18:59:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 12:59:36 -0600
Received: (qmail 2811 invoked by uid 107); 9 Dec 2014 18:59:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 13:59:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Dec 2014 13:59:34 -0500
Content-Disposition: inline
In-Reply-To: <548744F1.9000902@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261142>

On Tue, Dec 09, 2014 at 07:52:33PM +0100, Henning Moll wrote:

> i am runningthis command
> 
> git filter-branch --env-filter 'export
> GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
> GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME" GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"'
> --prune-empty --tag-name-filter cat -- --all
> 
> in a repository which i copied to /dev/shm before. According to "top", the
> git process only consumes about 5 percent of the CPU. The load is between
> 0.70 and 1.00.
> 
> I assume that there is a lot of process forking going on. Could that be the
> cause?

Yes. filter-branch is a shell scripts, and it is probably running
multiple git commands per commit it is filtering.

> Any ideas how to further improve?

In your case you are not touching the tree contents at all. Last time I
looked into this, I believe that filter-branch always loaded the index
for each commit, even if no --index-filter is being used. So teaching
filter-branch to optimize this case would be one strategy.

Another is to try using "git fast-export | git fast-import", and munging
the data stream in between. That's may be more work, depending how fancy
you want to get with accurate parsing (look into fast-export's
--no-data, which omits blob data; that should make things faster and
make hacky context-less parsing less likely to cause problems).

-Peff
