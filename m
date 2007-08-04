From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack-trees.c: assume submodules are clean during check-out
Date: Fri, 03 Aug 2007 22:13:09 -0700
Message-ID: <7v643vj316.fsf@assigned-by-dhcp.cox.net>
References: <20070717182828.GA4583MdfPADPa@greensroom.kotnet.org>
	<7vy7he6ufj.fsf@assigned-by-dhcp.cox.net>
	<20070801140532.GC31114MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eran Tromer <git2eran@tromer.org>
To: skimo@liacs.nl, Sven Verdoolaege <skimo@kotnet.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 07:13:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHBx9-0003OO-8W
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 07:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbXHDFNM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 01:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752228AbXHDFNM
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 01:13:12 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:39524 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216AbXHDFNL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 01:13:11 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070804051311.KCCQ7193.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 4 Aug 2007 01:13:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XhDA1X0011kojtg0000000; Sat, 04 Aug 2007 01:13:10 -0400
In-Reply-To: <20070801140532.GC31114MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Wed, 01 Aug 2007 16:05:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54790>

Sven Verdoolaege <skimo@kotnet.org> writes:

> If you have a submodule checked out and you go back (or forward)
> to a revision of the supermodule that contains a different
> revision of the submodule and then switch to another revision,
> it will complain that the submodule is not uptodate, because
> git simply didn't update the submodule in the first move.
>
> Now, you may say that I simply need to run 'git submodule update'
> after every such move, but this is very inconvenient, especially
> if you're doing a bisect or a rebase.
>
> How do other people deal with this problem?
>
> How about just replacing the body of ce_compare_gitlink
> with "return 0" until git actually (optionally) updates
> the submodules during an update of the supermodule?

Let me understand the problem first.  If your first checkout
does not check out the submodule, switching between revisions
that has different commit of the submodule there would not fail,
but once you checkout the submodule, switching without updating
the submodule would be Ok (because by design updating the
submodule is optional) but then further switching out of that
state will fail because submodule in the supermodule tree and
checked-out submodule repository are now out of sync.  Is that
the problem?

In any case, I doubt ce_compare_gitlink() is the right layer to
work this around -- it is not about "can we switch" but is about
"is it different".  It is at too low a level.

The current policy is to consider it is perfectly normal that
checked-out submodule is out-of-sync wrt the supermodule index,
if I am reading you right.  I think it is a good policy, at
least until we introduce a superproject repository configuration
option that says "in this repository, I do care about this
submodule and at any time I move around in the superproject,
recursively check out the submodule to match".  The most extreme
case of this policy is that the superproject index knows about
the submodule but the subdirectory does not even have to be
checked out, which is what we have now.

Where does the "No you are not up-to-date, I wouldn't let you
switch" come from?  Is that verify_uptodate() called from
merged_entry() called from twoway_merge()?  I think the right
approach to deal with this is to teach verify_uptodate() about
the policy.  The function is about "make sure the filesystem
entity that corresponds to this cache entry is up to date, lest
we lose the local modifications".  As we explicitly allow
submodule checkout to drift from the supermodule index entry,
the check should say "Ok, for submodules, not matching is the
norm" for now.  Later when we have the ability to mark "I care
about this submodule to be always in sync with the superproject"
(thereby implementing automatic recursive checkout and perhaps
diff, among other things), we should check if the submodule in
question is marked as such and perform the current test.

How about doing something like this instead?

 unpack-trees.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 3b32718..dfd985b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -407,6 +407,15 @@ static void verify_uptodate(struct cache_entry *ce,
 		unsigned changed = ce_match_stat(ce, &st, 1);
 		if (!changed)
 			return;
+		/*
+		 * NEEDSWORK: the current default policy is to allow
+		 * submodule to be out of sync wrt the supermodule
+		 * index.  This needs to be tightened later for
+		 * submodules that are marked to be automatically
+		 * checked out.
+		 */
+		if (S_ISGITLINK(ntohl(ce->ce_mode)))
+			return;
 		errno = 0;
 	}
 	if (errno == ENOENT)
