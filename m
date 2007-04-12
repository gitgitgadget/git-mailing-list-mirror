From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/6] Teach "fsck" not to follow subproject links
Date: Wed, 11 Apr 2007 17:34:49 -0700
Message-ID: <7vslb6mnva.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0704092115020.6730@woody.linux-foundation.org>
	<461D6432.90205@vilain.net>
	<Pine.LNX.4.64.0704111545040.6730@woody.linux-foundation.org>
	<461D6858.4090007@vilain.net>
	<Pine.LNX.4.64.0704111605210.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 02:35:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbnHN-0008Fq-Ht
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 02:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161427AbXDLAev (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 20:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161430AbXDLAev
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 20:34:51 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:38782 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161427AbXDLAeu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 20:34:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070412003450.LNQF1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Apr 2007 20:34:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id m0ap1W00w1kojtg0000000; Wed, 11 Apr 2007 20:34:50 -0400
In-Reply-To: <Pine.LNX.4.64.0704111605210.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 11 Apr 2007 16:16:53 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44292>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So I think that the way to verify a superproject is:
>
>  - fsck each and every project totally independently. This is something 
>    you have to do *anyway*.
>
>  - either as you fsck, or as a separate phase after the fsck, just 
>    traverse the trees and spit out "these are the SHA1's of subprojects"
>
>  - finally, just go through the list of SHA1's (after every project has 
>    been fsck'd) and verify that they exist (since if they exist, they will 
>    have everything that is reachable from them, as that's one of the 
>    things that the *local* fsck verifies)

The small detail in the last step is wrong, though.  Even if
they EXIST, they may be isolated commits that are note connected
to refs, and fsck in the repository would not have warned about
unreachable trees from such unconnected commits.  So you would
need to do a reachability from these commits to the refs in the
subproject.

This would be similar to the quick-fetch topic I sent out a
couple of patches for, that implements logic to skip fetching
objects from your alternate.  You would have rev-list --objects
traverse from them with "--not --all" in the subproject
repository and make sure it does not trigger "I could not list
all objects reachable from the commits you wanted because such
and such tree/blob are missing".

    That reminds me of one thing I haven't verified.  I am not
    absolutely sure that rev-list --objects makes sure that
    blobs it lists exist (trees are checked as it needs to read
    them, and if they are missing or corrupt it would notice and
    barf).  When it is used for the purpose of this "subproject
    boundary fsck" and the quick-fetch, it should.  Perhaps a
    specialized option to check deeper than usual is needed.  I
    dunno.

> Notice? At no point do you actually need to do a "global fsck". You can do 
> totally independent local fsck's, and then a really cheap test of 
> connectedness once those fsck's have completed.

This is still true.
