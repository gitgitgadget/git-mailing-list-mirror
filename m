From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: in_merge_bases() is too expensive for recent "pu" update
Date: Thu, 23 Aug 2012 16:20:41 +0200
Message-ID: <878vd5k7uu.fsf@thomas.inf.ethz.ch>
References: <CACsJy8C-VxzwigyUDHnUkXN7vhB+93X96pH9MvgB0ps7v-_NmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 16:20:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4YHE-0001iE-UL
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 16:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763Ab2HWOUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 10:20:47 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:30186 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753615Ab2HWOUo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 10:20:44 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 23 Aug
 2012 16:20:39 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 23 Aug
 2012 16:20:41 +0200
In-Reply-To: <CACsJy8C-VxzwigyUDHnUkXN7vhB+93X96pH9MvgB0ps7v-_NmQ@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Thu, 23 Aug 2012 19:32:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204149>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> I just did a "git fetch". It took 19 seconds (measured with
> gettimeofday) to finish in_merge_bases() in update_local_ref() in
> fetch.c, just to print this line
>
>  + a4f2db3...b95a282 pu         -> origin/pu  (forced update)
>
> It's partly my fault because I'm on gcc -O0. But should it not take
> that much time for one line? As a grumpy user, I'd be perfectly ok
> with git saying "probably forced update, check it yourself" if the
> spent time exceeds half a second. On the same token, if diffstat takes
> too long for git-pull, then perhaps just stop and print "do it
> yourself".

I missed out on the a4f2db3 update, so I can't test exactly this, but my
reflog tells the I had before b95a282 was d3dd556.  Computing all
merge-bases takes very long indeed:

  $ time git merge-base --all d3dd556 b95a282 | wc -l
  51

  real    0m4.877s
  user    0m4.829s
  sys     0m0.026s

And I think the reason is that the algorithm is just doing too much.
From a quick glance, it appears to first compute the result list rslt[]
of merge bases, then for each pair attempts to eliminate one of them by
determining that rslt[i] or rslt[j] is also a merge base of rslt[j:].
It is thus spending quadratic time in the number of merge-bases, times
the size of history (ok, I can't actually come up with an example that
does the latter).

At the very least it should be possible to change in_merge_bases() to
not do any of the post-filtering; perhaps like the patch below.  It
passes the test suite.  The whole "merge bases of A and a list of Bs"
thing is blowing my overheated mind, though, so I'm not able to convince
myself that it is correct in all cases.

Even if this turns out to be flawed, we should also identify uses of
in_merge_bases() where the real question was is_descendant_of() [I
somewhat suspect that's all of them], and then replace is_descendant_of
with a much cheaper lookup.  This can be as simple as propagating a mark
from the candidate until it either goes beyond all possible ancestors,
or hits one of them.

By the way, the internal slowness of git-merge-base also affects the
A...B syntax.  For example,

  git rev-list --left-right --count @{upstream}...

is used by the __git_ps1 code to determine the prompt display, which
just got very slow for me today.  Again, it should be easy to figure out
the boundary of the symmetric difference simply by propagating two
marks.  I do not think that the result of A...B actually depends on
figuring out exactly what the merge bases are, simply excluding *any*
candidate without pruning is enough.


diff --git i/commit.c w/commit.c
index 65a8485..70427ab 100644
--- i/commit.c
+++ w/commit.c
@@ -837,10 +837,13 @@ int in_merge_bases(struct commit *commit, struct commit **reference, int num)
 	struct commit_list *bases, *b;
 	int ret = 0;
 
-	if (num == 1)
-		bases = get_merge_bases(commit, *reference, 1);
-	else
+	if (num != 1)
 		die("not yet");
+
+	bases = merge_bases_many(commit, 1, reference);
+	clear_commit_marks(commit, all_flags);
+	clear_commit_marks(*reference, all_flags);
+	
 	for (b = bases; b; b = b->next) {
 		if (!hashcmp(commit->object.sha1, b->item->object.sha1)) {
 			ret = 1;


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
