From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: inexplicable failure to merge recursively across cherry-picks
Date: Tue, 9 Oct 2007 19:54:21 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710091926560.3838@woody.linux-foundation.org>
References: <20071010015545.GA17336@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Wed Oct 10 04:54:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfRif-00039I-Ln
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 04:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbXJJCyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 22:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752520AbXJJCyf
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 22:54:35 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58760 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752249AbXJJCye (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Oct 2007 22:54:34 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9A2sMNM023386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Oct 2007 19:54:23 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9A2sLjt020278;
	Tue, 9 Oct 2007 19:54:22 -0700
In-Reply-To: <20071010015545.GA17336@lapse.madduck.net>
X-Spam-Status: No, hits=-2.432 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_66
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60459>



On Wed, 10 Oct 2007, martin f krafft wrote:
> 
> There are five commits between mdadm-2.6.2 and
> mdadm-2.6.3+200709292116+4450e59 that affect Monitor.c:
> 
>   01d9299
>   e4dc510
> * 66f8bbb
>   98127a6
>   4450e59
> 
> The third commit, the one with the asterisk is the one that
> I cherry-picked (as 845eef9); the other two cherries I picked do not
> touch Monitor.c.

Side note - run

	gitk --merge

when you have a merge conflict, and it will basically show you the thing 
graphically (ie history as it is relevant to the merge, and only to the 
files that get conflicts).

But basically, both sides have modified the code *around* that line, and 
they have modified it differently.

Do this in your partial merge tree on 'master':

	git diff ...mdadm-2.6.3+200709292116+4450e59 Monitor.c
	git diff mdadm-2.6.3+200709292116+4450e59... Monitor.c

which will show you the diff from the common base ancestor. And in 
particular, it will show how one branch did this:

	@@ -399,9 +401,8 @@ int Monitor(mddev_dev_t devlist,
	                        struct mdstat_ent *mse;
	                        for (mse=mdstat; mse; mse=mse->next)
	                                if (mse->devnum != MAXINT &&
	-                                   (strcmp(mse->level, "raid1")==0 ||
	-                                    strcmp(mse->level, "raid5")==0 ||
	-                                    strcmp(mse->level, "multipath")==0)
	+                                   (strcmp(mse->level, "raid0")!=0 &&
	+                                    strcmp(mse->level, "linear")!=0)
	                                        ) {
	                                        struct state *st = malloc(sizeof *st);
	                                        mdu_array_info_t array;

and the other one did

	@@ -398,10 +402,9 @@ int Monitor(mddev_dev_t devlist,
	                if (scan) {
	                        struct mdstat_ent *mse;
	                        for (mse=mdstat; mse; mse=mse->next)
	-                               if (mse->devnum != MAXINT &&
	-                                   (strcmp(mse->level, "raid1")==0 ||
	-                                    strcmp(mse->level, "raid5")==0 ||
	-                                    strcmp(mse->level, "multipath")==0)
	+                               if (mse->devnum != INT_MAX &&
	+                                   (strcmp(mse->level, "raid0")!=0 &&
	+                                    strcmp(mse->level, "linear")!=0)
	                                        ) {
	                                        struct state *st = malloc(sizeof *st);
	                                        mdu_array_info_t array;

And now maybe git's behaviour makes more sense. See? You basically had two 
different branches that made *almost* the same changes to the same area, 
but not quite. So how is git to know which one was the *right* one to 
pick? The one that changed the "if (mse->devnum != MAXINT &&" line, or the 
one that left it alone?

> I branched master2 off 845eef9b~1, cherry-picked the first two
> commits that touch Monitor.c, cherry-picked all the commits
> 845eef9b..master into master2 and merge upstream...

Cherry-picking is immaterial. It doesn't matter how the changes come into 
the tree. It doesn't matter what the history is. The only thing git cares 
about is the content, and the end result.

Git knows that the two branches got to two different end results. They 
were identical except for that one line, and it asks you to say which 
branch was "right" wrt that one line.

In other words, git never looks at individual commits when trying to 
merge. It doesn't try to figure out what the "meaning" of the changes are, 
it purely looks at the content.

And btw, it *has* to work that way, because if you don't work that way, 
then you get different results depending on which path the development 
took (eg you might get different results if something was considered a 
"revert", for example, or if something was split up into two patches on 
one side but not the other etc etc).

But in this case it's pretty obvious: the commit from one side (the one 
that changes MAXINT->INT_MAX: "Monitor.c s/MAXINT/INT_MAX/g") merged fine 
into the result *except* for that one section that had touched the same 
general area for other reasons. And that one area was seen as a conflict 
because of those other reasons being in the same hunk.

And yes, in this case the "other reasons" happened to be cherry-picked and 
thus "the same" on both sides, but that doesn't mean that they should have 
been considered in any way special: the result of cherry-picking is 
context-dependent and is a part of the history of the target, and does not 
equate any kind of "identity" with the source. Cherry-picking is 100% 
equivalent to re-doing the commit entirely, and for all git knows, there 
was a reason why it wasn't done together with that s/MAXINT/INT_MAX/g 
change.

(Not that git even thinks in those terms - git literally just says: "I 
cannot resolve the _content_ independently and without understanding the 
history and thinking behind the differences, so you'd better help me")

			Linus
