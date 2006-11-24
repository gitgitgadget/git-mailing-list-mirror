X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/5] fetch-pack: Do not fetch tags for shallow clones.
Date: Fri, 24 Nov 2006 12:28:54 -0800
Message-ID: <7v3b88bncp.fsf@assigned-by-dhcp.cox.net>
References: <87k61kubya.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 20:29:04 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87k61kubya.fsf@wine.dyndns.org> (Alexandre Julliard's message of
	"Fri, 24 Nov 2006 16:00:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32235>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnhfP-0002NR-IT for gcvg-git@gmane.org; Fri, 24 Nov
 2006 21:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935043AbWKXU24 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 15:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935045AbWKXU24
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 15:28:56 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:49302 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S935043AbWKXU2z
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 15:28:55 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061124202855.BZVK4226.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Fri, 24
 Nov 2006 15:28:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qkV31V0051kojtg0000000; Fri, 24 Nov 2006
 15:29:03 -0500
To: Alexandre Julliard <julliard@winehq.org>
Sender: git-owner@vger.kernel.org

Alexandre Julliard <julliard@winehq.org> writes:

> A better fix may be to only fetch tags that point to commits that we
> are downloading, but git-clone doesn't have support for following
> tags. This will happen automatically on the next git-fetch though.
>
> Signed-off-by: Alexandre Julliard <julliard@winehq.org>

All five patches look sane.  Thanks.

The last one made me go "Huh?" at first, but it indeed is an
improvement.  It wouldn't make much sense to "shallow clone" by
two commits near the tip of the 'master' branch from Linus's
kernel, and then having to "shallow clone" all of his tags down
to v2.6.12-rc2, each with two commit depths limit.

I however think a better "fix" is not to use shallow "clone" but
shallowly fetch branches you are interested in into an empty
repository for such a use scenario.  Just like making two-depth
shallow copy of all the old tags do not help when the user is
interested in the recent history of the tip of the 'master'
branch, it does not help much to get near the tip of all other
branches with a uniform depth when one particular branch from a
remote repository is of interest.  I can imagine that somebody
who fully follows the 'master' branch from git.git repository
from time to time wants to take a peek at near the tip of 'pu'
(perhaps because the 'shallow clone' topic is interesting) or
wants to fetch near the tip of Jakub's gitweb work to see what
area is still being improved, and shallowly fetching them into a
repository that has full history of my 'master' would be a
useful way to do so, provided if 'pu' and/or Jakub's tree have
deep enough histories since 'master' that the benefit of saved
bandwidth and disk usage outweighs the complexity of "shallow".

I haven't tried these usage scenarios myself.  I wonder if a
shallow "clone" with non-uniform depths from possible more than
one repository work sensibly?
