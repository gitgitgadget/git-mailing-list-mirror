From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] bookmarks
Date: Wed, 25 Apr 2007 22:53:11 -0700
Message-ID: <7vmz0vu1fc.fsf@assigned-by-dhcp.cox.net>
References: <200704252004.45112.andyparkins@gmail.com>
	<Pine.LNX.4.64.0704252056210.1005@reaper.quantumfyre.co.uk>
	<200704252142.33756.andyparkins@gmail.com>
	<Pine.LNX.4.64.0704252332170.18446@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Thu Apr 26 07:53:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgwuq-000062-Ow
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 07:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747AbXDZFxN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 01:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754748AbXDZFxN
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 01:53:13 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:53646 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747AbXDZFxM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 01:53:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070426055312.PPHT1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Thu, 26 Apr 2007 01:53:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id rhtB1W00t1kojtg0000000; Thu, 26 Apr 2007 01:53:12 -0400
In-Reply-To: <Pine.LNX.4.64.0704252332170.18446@beast.quantumfyre.co.uk>
	(Julian Phillips's message of "Wed, 25 Apr 2007 23:51:27 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45612>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> While I like the idea of private tags, I find the idea of them having 
> their own namespace to be much more attractive than simply having the 
> ability to not export lightweight tags.
>
> In particular it means that you can control which tags are exported 
> individually.

I do not think this is limited to tags. Sometimes you may want
to make some branches private.  It probably is also a good idea
to hide StGIT patch base refs that live under $GIT_DIR/refs/.

Here, I do not use the word "private" in the sense of being
"secret", as most likely branches that share common root would
have many trees and blobs in common, but in the sense of "less
clutter".

How would one find out about remote refs?  By running
ls-remote.  And that happens to also be how git-fetch follows
tags (the original issue Andy had).

Over native git protocol, upload-pack is the program that runs
in the repote repository and gives list of available refs and
object names they point at (upload-pack.c::send_ref()).  To dumb
clients, update-server-info creates the equivalent information
in $GIT_DIR/info/refs and that is what the ls-remote sees.

So I suspect that a more general solution would be to to teach
these two programs to take notice of a new configuration
variable you can set in the repository to limit the set of refs
to give out.  Then you do not have to introduce a new namespace,

Probably the configuration would be a glob pattern (for pathname
like things, we tend to use shell glob, not regexp) to
include/exclude.  E.g.

	refs.expose = refs/heads/*
        refs.expose = refs/tags/*
        refs.expose = !refs/heads/*/*
        refs.expose = !refs/tags/v[0-9]*

would let you say "I would want to expose all of refs/heads/
(i.e. branches) and refs/tags (i.e. tags), but I do not want to
show branches with '/' in their names, nor tags whose names do
not begin with v[0-9]".
