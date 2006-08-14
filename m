From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: git pull <remote> making an octopus?
Date: Mon, 14 Aug 2006 14:45:48 -0700
Message-ID: <7vk65bdm9f.fsf@assigned-by-dhcp.cox.net>
References: <20060814075305.GH21963@mellanox.co.il>
	<20060814175523.GC16821@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 23:46:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCkG3-0006AF-FB
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 23:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWHNVpv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 17:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWHNVpv
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 17:45:51 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:41667 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S964993AbWHNVpu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 17:45:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060814214549.DXLC23903.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Aug 2006 17:45:49 -0400
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25414>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

> Quoting r. Michael S. Tsirkin <mst@mellanox.co.il>:
>> So it seems git pull behaves differently depending on whether
>> the origin pull line is first or not?
>
> Where do I find the code that decides whether to make an octopus
> or many fetches?

After "git fetch" that is called from "git pull",
$GIT_DIR/FETCH_HEAD lists all the refs that were fetched, and
each line has not-for-merge marker (or empty) in the second
column (SHA1 <TAB> marker <TAB> description of what the remote
ref is).  The ones not marked with the not-for-merge marker are
merged into the current head, so if you have more than one that
lack not-for-merge marker, you end up with an octopus.

The rule (the implementation might be broken but nobody other
than you found the breakage so far) to mark not-for-merge is:

 - the refspecs are either given on the command line, or from
   shorthand file (.git/remotes/, or .git/branches/) but never
   from both at the same time;

 - when dealing with the refspecs from the command line all of
   them are for merge;

 - when dealing with the refspecs from the shorthand
   (.git/remotes), the one on the first "Pull: " line is for
   merge and everything else is not.

The case statement in the loop you were touching in your patch
we discussed earlier had four arms (+ref, .+ref, .ref, and ref).
Pluses come from the original refspec given by the user, either
from short-hand file or command line.  Dot is prepended when
reflist is prepared by get_remote_refs_for_fetch which in turn
calls canon_refs_list_for_fetch (git-fetch sources
git-parse-remote and these shell functions are defined there).
