From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] pull: gracefully recover from delta retrieval failure.
Date: Sun, 5 Jun 2005 16:02:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506051523280.30848-100000@iabervon.org>
References: <7vekbg3de7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jason McMullan <jason.mcmullan@timesys.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 22:01:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df1Il-0002yK-UW
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 22:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVFEUEN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 16:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVFEUEN
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 16:04:13 -0400
Received: from iabervon.org ([66.92.72.58]:13063 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261507AbVFEUEF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 16:04:05 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1Df1Kj-0005Qe-00; Sun, 5 Jun 2005 16:02:57 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vekbg3de7.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 5 Jun 2005, Junio C Hamano wrote:

> >>>>> "JM" == Jason McMullan <jason.mcmullan@timesys.com> writes:
> 
> JM> Sorry about being a pest, but this worries me. Please assuage my fears.
> 
> Earlier I said I suspected that the original code mishandled
> recovery from a botched tree/commit dependent transfer, but that
> was not the case.  The last test in the new test script I added
> in the patch you are responding to covers that case.

It does the O(history) method for correctness at the expense of
efficiency; my hope is that a bit of caching can fix the efficiency issue
as well. So the question is not really "not safe" as "slow". Of course, it
takes a while for this to become an issue, given the relationship of
remote access latency to local access bandwidth. That is, you need a
really big history and to be getting very little new data before you'll
complain.

> JM> (Or, if you'd like, I can rework pull.c to use the
> JM>  verification-before-store technique I used in my git-daemon patch, so
> JM>  all the *-pull mechanisms will be 'safe')
> 
> I would appreciate the offer.  I, however, would have to warn
> you that the "problem" lies in the way the current pull
> structure devides responsibility between the pull.c and transfer
> backends.  The pull.c implements the dependency logic, and
> transfer backends are to populate the database while being
> oblivious of that logic.  From the purist point of view (I am
> sympathetic to your "place only the verified objects in the
> database" principle), I am not entirely happy with that
> division, but at the same time I understand why it is done that
> way and even like it from practical standpoint.

At one point I'd written a patch that split out the tmpfile usage of
write_sha1_file(), made the filenames predictable, and used it for
everything that writes those files. It had an "open" part and a
"close" part (where the close also moved the file into place). This would
give the code better atomicity and protect against races between reading
and validation. On the other hand, there's no reason to use an anonymous
temp file; just <filename>.partial or similar (with the proper open
flags) would be sufficient and easier to clean or commit. Note that we
want to support /tmp and the object directory being on different
filesystems, also. (And all the open and place logic is nicely wrapped up
in sha1_file.c)

Aside from the question of whether we want to insist that the object
database only includes objects such that everything reachable is also
present, we certainly want to only include objects which we have
completely fetched, which are generically well-formed, and which have the
advertized hash, and having there never be an unvalidated file at the
filename would be good.

By this reasoning, a file should only be renamed after all of the delta
requirements are satisfied, but before tree and commit requirements are
satisfied. We certainly aren't going to have much use for files whose
contents we cannot get. This means that we'd like to have multiple
unplaced files, but we don't need to read the contents of an unplaced
file.

	-Daniel
*This .sig left intentionally blank*

