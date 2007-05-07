From: Junio C Hamano <junkio@cox.net>
Subject: Re: 'upstream' branches.
Date: Mon, 07 May 2007 00:40:30 -0700
Message-ID: <7vtzup6pzl.fsf@assigned-by-dhcp.cox.net>
References: <1178368166.11851.60.camel@pmac.infradead.org>
	<20070505174416.GA2898@steel.home>
	<1178387429.17680.35.camel@shinybook.infradead.org>
	<20070505225249.GE2898@steel.home>
	<7v3b2ah30f.fsf@assigned-by-dhcp.cox.net>
	<1178436926.17680.74.camel@shinybook.infradead.org>
	<7vy7k2e606.fsf@assigned-by-dhcp.cox.net>
	<20070506092129.GA2434@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 09:40:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkxpl-0004Js-7C
	for gcvg-git@gmane.org; Mon, 07 May 2007 09:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072AbXEGHkc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 03:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754118AbXEGHkc
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 03:40:32 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:61349 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754072AbXEGHkc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 03:40:32 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070507074032.HKQD2758.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 7 May 2007 03:40:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id w7gW1W00B1kojtg0000000; Mon, 07 May 2007 03:40:31 -0400
In-Reply-To: <20070506092129.GA2434@steel.home> (Alex Riesen's message of
	"Sun, 6 May 2007 11:21:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46423>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Sun, May 06, 2007 10:00:25 +0200:
>> 
>> > Is that possible? I'm fairly sure it used to be.
>> 
>> I doubt we had that bug.  If you allowed overwriting with +, it
>> would not have prevented a rewind (i.e. pull from Linus and then
>> pull from somebody who pulled from Linus earlier than you did).
>> If you didn't, then it would have failed the fetch.
>> 
>
> Maybe we should not fail in the case the remote repo is older then
> local, but just to try to fast-forward local reference after a fetch
> and fail only if the fast-forward fails?
> Or introduce a new syntax for the strict reference succession and make
> fetch+fast-forward the default?
> Or the other way around, use something like "-from:to" to ignore
> fast-forwards failed because the "from" already has all the "to" has,
> which has precedents: make and its "-include", which ignores errors
> from non-existing files.

I think the whole issue would disappear if David stops using the
same 'linus' tracking branch to track origins from *different*
repositories (see my other message on the thread), and I think
it makes the above suggestions fall somewhat in "solutions
looking for a problem" category.  If this is a common enough
misconfiguration, we might want to add a sanity check to catch
Pull: lines in different remotes/ files and remote.*.fetch
configurations for different remotes cause the same tracking
branch to be updated, but I personally do not think it is even
worth it.

Having said that, I suspect that making the default <src>:<dst>
(without 'force') to ignore pure rewind (not rewind+rebuild)
might make sense without having much downside.  If the remote
repository owner rewinds its tip, current code catches it as a
possible mistake of the remote side, but until it starts
building a different history on top of that rewound head, there
really is no harm done.

One common case that can be helped with such a behaviour change
is when your remote.*.url points at a single URL that actually
is backed by more than one mirrors --- think of www.kernel.org
which resolves to two actual hosts via DNS round robin.  If you
fetch from one server, and then fetch again from the other
server that was behind (maybe rsync cron job got stuck for some
unspecified reason), you would observe that the tip was rewound.

Something like this untested patch should be sufficient if we
want to go this route, but I am not convinced yet that this is
the right thing to do.  For one thing, it is not clear to me
what should happen if --force is in effect.  Should this honor
the "wish" of the remote repository owner to rewind this ref, or
should we assume that it was two servers with mirroring
inconsistency fluke and ignore the rewind, hoping that the next
round will straighten the situation out?  What does --force
instructs us to do in such a case?

diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 2065466..29d7fe1 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -119,6 +119,12 @@ static int update_local_ref(const char *name,
 		return update_ref("fast forward", name, sha1_new, sha1_old);
 	}
 	if (!force) {
+		if (in_merge_bases(updated, &current, 1)) {
+			fprintf(stderr, "* %s: ignoring straight rewind %s\n",
+				name, note);
+			fprintf(stderr, "  old..new: %s..%s\n", oldh, newh);
+			return 0;
+		}
 		fprintf(stderr,
 			"* %s: not updating to non-fast forward %s\n",
 			name, note);
