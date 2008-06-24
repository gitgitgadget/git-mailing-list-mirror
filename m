From: "David Jeske" <jeske@google.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 20:04:30 -0000
Message-ID: <26999.3299422369$1214338338@news.gmane.org>
References: <m31w2mlki4.fsf@localhost.localdomain>
	<willow-jeske-01l5PFjPFEDjCfzf-01l5zrLdFEDjCV3U>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Boaz Harrosh" <bharrosh@panasas.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 22:12:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBEs2-0000GF-6Y
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 22:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294AbYFXULK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 16:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752934AbYFXULJ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 16:11:09 -0400
Received: from w2.willowmail.com ([64.243.175.54]:60244 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751810AbYFXULI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 16:11:08 -0400
Received: (qmail 17675 invoked by uid 90); 24 Jun 2008 20:11:02 -0000
X-Mailer: Willow v0.02
Received: from 67.188.42.104 at Tue, 24 Jun 2008 20:04:30 -0000
In-Reply-To: <m31w2mlki4.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86135>

> -- David Jeske wrote:
>> - improve the man page description of "reset --hard"
>> - standardize all the potentially destructive operations
>> (after gc) on "-f/--force" to override
>
> The thing is 'force' is not always the most descriptive word
> for the behavior that you propose enabling with --force.
I'm not talking about switching "git reset --hard" to "git reset -f". I'm
talking about requiring a "-f" option to "git reset --hard" when it would
destroy or dangle information.

(a) If you have a clean working directory which is fully checked in and has
another branch tag other than the current branch tag, then "git reset --hard
<commitish>" is non-destructive, and would complete happily.

(b) If you have local modifications to working files it would complain "hey,
your working files are dirty, 'reset --hard' will blow them away, either revert
them or use -f". This is what Boaz asked for, and I doubt it would change along
would alter workflow much for people who are using "git reset --hard" to toss
attempted patches (since they were fully committed anyhow), or even undo a
clone or pull operation. If people use it as a combo "revert and reset", they
would notice.

(c) If the current location is only pointed to by the current branch (which you
are going to move with 'reset --hard') tell the user that those changes will be
dangling and will be eligible for garbage collection if they move the branch.
What to do in this case seems more controversial. I would prefer for this to
error with "either label these changes with 'branch', or use 'reset --hard -f'
to force us to leave these in the reflog unnamed".  --- Some here say that
being in the reflog is enough, and the -f is overkill here. If we define
destructive as dropping code-commits, then that's true. If we define
destructive as leaving code-commits unreferenced, then -f is warranted.
Personally, I'd rather git help me avoid dropping the NAMES to tips, because
even with GC-never, I don't really want to find myself crawling through SHA1
hashes and visualization trees to find them later, when git could have reminded
me to name a branch that would conveniently show up in 'git branch'. It's easy
enough to avoid dropping the names, or force git to not care with '-f'. I
personally would like to avoid dealing with reflog or SHA1 hashes 99% of the
time.

> 'gc' is another command that has been mentioned along
> with its '--aggressive' option.

This was an accident. When I made my "mv --aggressive" joke I was NOT intending
to reference "gc --aggressive", that is just a coincidence. I was trying to
make up another 'semi-dangerous sounding name that might or not might be
destructive". It's comical that it's in use for gc. I don't see any
relationship between "gc --aggressive" and destructive behavior.

However, there IS a situation to require a "-f" on a, because again, "-f" would
be required for operations which destroy commits. If we think commits being in
the reflog is good enough to hold onto them, and users are thinking that items
being in the reflog are 'safe', then a GC where reflog entry expiration is
going to cause DAG entries to be removed could print an error like:

error: the following entries are beyond the expiration time,
...<base branchname>/<commit-ish>: 17 commits, 78 lines, 3 authors
...use diff <commit-ish> , to see the changes
...use gc -f, to cause them to be deleted

This wouldn't happen very often, and would make "gc" a safe operation even on
trees with shorter expiration time. In fact, if this were the way it worked, I
might set my GC back from never to "30 days", because this would not only allow
me to safely cleanup junk, but it would also allow me to catch unnamed and
dangling references before they became so old I didn't remember what to name
them.

This would make a "non forced gc" safe from throwing away commits, but still
make it really easy to do so for people who want to. Likewise, we could make
any "auto-gc" that happens not forced by default.
