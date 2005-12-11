From: Junio C Hamano <junkio@cox.net>
Subject: Re: Branches merging by only overwrite files
Date: Sun, 11 Dec 2005 01:33:18 -0800
Message-ID: <7vbqzonfkx.fsf@assigned-by-dhcp.cox.net>
References: <439BE3B9.3040308@ust.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 11 10:34:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElNaL-0006fB-4L
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 10:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161111AbVLKJdV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 04:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbVLKJdV
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 04:33:21 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:38589 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1161111AbVLKJdU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2005 04:33:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051211093243.HCFN3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 11 Dec 2005 04:32:43 -0500
To: Ben Lau <benlau@ust.hk>
In-Reply-To: <439BE3B9.3040308@ust.hk> (Ben Lau's message of "Sun, 11 Dec 2005
	16:30:49 +0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13493>

Ben Lau <benlau@ust.hk> writes:

>    I am looking for a solution to merge two branches but do not perform 
> file level merge. Instead, I wish the result file is the copy from any 
> one of the branches.

It might be better to state why you need this first.  It could
be that what you really want to solve is not related to merge at
all.

>    For example, assumes it has two branches A and B,  some of the files 
> are modified in both of them. In this case, `/usr/bin/merge` could not 
> be execated, it just have to choose the revision from branch A and 
> discards all the changes from B. For the rest of files, it just simply 
> choose the newest copy from A or B.

I wonder why you say "could not be executed".  I take it to mean
you just do not want to even when it could.

Now, it is not clear if you always want copy from branch A and
not from branch B when both branches have the same path, or you
want to pick one at random between A and B.  If branch A kept
the file intact and branch B modified it, what do you want to
happen?  The default "merge" semantics in git (unless you are
using "ours" strategy) in such a case is always to take the
version from branch B.  Is that consistent with what you want?

What do you exactly mean "newest copy from A or B"?  What are
you basing the "newest" determination on?  The commit date of A
and B commits, or the author date ot two?

Assuming that you can give reasonable and consistent answer to
the above question to define the semantics of your "new merge
algorithm", what you would do is to write a new script
git-merge-benlau to implement whatever semantics you picked.
You could model it after existing merge strategy, such as
git-merge-resolve.sh or git-merge-stupid.sh.  Then you give the
new merge strategy to "git-merge" or "git-pull".

For example, if you want all the usual "trivial merges" to work
just like the default git merge algorithms, but always take
"our" version instead of running file-level merge when both
sides modified a file, then you start from a copy of
git-merge-stupid.sh, and replace "git-merge-one-file" with
"git-merge-one-file-benlau'.  Copy "git-merge-one-file.sh" to
create another new script, "git-merge-one-file-benlau", and
replace this line:

	merge "$src1" "$orig" "$src"

with

	cat "$orig" >"$src1"

and you are done.

I outlined the above without knowing what you really want to
achieve, and I do not think the resulting merge strategy makes
much sense, but that is what I get form hacking without knowing
what you are really trying to do ;-).
