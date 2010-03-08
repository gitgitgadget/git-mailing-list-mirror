From: Sergio <sergio.callegari@gmail.com>
Subject: Some information that git diff saves and that git status does not
Date: Mon, 8 Mar 2010 10:46:51 +0000 (UTC)
Message-ID: <loom.20100308T111146-322@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 08 11:47:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoaUT-0004g9-BK
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 11:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753985Ab0CHKrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 05:47:07 -0500
Received: from lo.gmane.org ([80.91.229.12]:57933 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753626Ab0CHKrF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 05:47:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NoaUG-0003uF-Ug
	for git@vger.kernel.org; Mon, 08 Mar 2010 11:47:01 +0100
Received: from mars-fw.arces.unibo.it ([137.204.143.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Mar 2010 11:47:00 +0100
Received: from sergio.callegari by mars-fw.arces.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Mar 2010 11:47:00 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.143.2 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100214 Ubuntu/9.10 (karmic) Firefox/3.5.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141757>

Hi,

I happen to work with a (possibly somehow unusual) configuration where 2 laptops
are syncronized via unison (a widely used file syncronizer).

This means that git worktrees and repos are copied around as they are, rather
than transferred through git protocols.  The thing may appear weird, but it
makes sense, since the two laptops need to carry completely identical stuff all
the time (one, say "A", is a lightweight one good for travel, the other one, say
"B" is a desktop replacement).

If I work on "A" in worktree "WT", when I then sync the two machines, WT and the
associated object store and git data remains unchanged in A and gets updated in
B in such a way that git cannot know about it.

As a matter of fact, git copes with all this amazingly well, with the following
quirk:

1) The tree appears dirty on B, even if it was not on A before starting the
sync. I guess this is because the index may contain data that does not make
complete sense on B. As a consequence, gitk shows the tree as containing local
changes even if it does not.

2) By running git status, you make git realize that in fact there are no local
changes in the tree.  After a git status, also gitk is happy.

3) When you run git status, to find out that the local tree is in fact clean,
git status needs to do a significant amount of work.  If filters are defined,
git status runs all the filters on all the files that need to be filtered
(revealed by GIT_TRACE). This can take a significant amount of time.

4) Once git has done that, you would expect git status not to need doing the
filter job any longer.  However, if you run git status again and again, git
again and again spends a significant amount of time re-running all the filters.

5) If rather than running git status, you run git diff, git runs the filters as
for git status, however some info now gets saved about this activity.  After a
git diff, git status becomes almost istantaneous, no filters are run any longer.

It would be nice if:

a) git status could save the same info that git diff saves, so after the first
git status which needs to take a long time, all the subsequent git status are
fast. If I remember properly, this was indeed the behavior before the rewrite of
git status; and

b) before saying that you have local changes, gitk could run git status to be
truly sure about that.

Would a) and b) be easy and sensible changes? Or conversely, would they have
nasty implications and side effects?

Sergio
