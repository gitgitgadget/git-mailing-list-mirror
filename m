From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-union-merge proposal
Date: Tue, 21 Jun 2011 10:44:56 -0700
Message-ID: <7v4o3j9izr.fsf@alter.siamese.dyndns.org>
References: <20110621022049.GA1632@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Tue Jun 21 19:45:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ50b-0007cA-If
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 19:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757177Ab1FURpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 13:45:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53131 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756950Ab1FURo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 13:44:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1C756582F;
	Tue, 21 Jun 2011 13:47:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZAOqlYtHHujf/29iW022HsMHtdc=; b=QcK853
	3mpUKSeIAH9FCn7qNZFvT62CYEXS6sd4Nm4Z1D4Uchbr8mXMtWAGYqSiO+pFeR35
	o7evrRC52S7d5bjXeGvFZbGJ/pTzvUKr4FKi9Hoc3M3MHoCuqLtH1zjNrjdOC1Mc
	9XYf4dt/AZodxVinZxIHwqVrSnOteqeBFnVQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GzPVGt4mthaDs08ixWGlbl3SpYhvKpwt
	QYytKQhljkIbcgapBvdhQVfOco8V/JlFFec1sxkJMExVez7LiSIr7S8ZW9CpYw64
	u5ia/U16mUH3H/X7jk6QHpzJuH8g78t83/P+1t+b8NdMaS6ln29Ilw0ERrSV8/hY
	5k8HJ9ZLBoI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 15011582E;
	Tue, 21 Jun 2011 13:47:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 38197582D; Tue, 21 Jun 2011
 13:47:10 -0400 (EDT)
In-Reply-To: <20110621022049.GA1632@gnu.kitenet.net> (Joey Hess's message of
 "Mon, 20 Jun 2011 22:20:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7D19CA38-9C2E-11E0-8289-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176177>

Joey Hess <joey@kitenet.net> writes:

> Lately some tools are storing data in git branches or refs, that is not
> source code, and that is designed in some way to be automatically
> merged. Generally merge=union will work for it, but the problem is that
> git-merge can only operate on the checked out branch, not other
> branches.

I think linking "union" merge too tightly into this is going in a wrong
direction. We _could_ do certain merges without using the working tree at
all, and the design of "git merge" has always been to perform the merge
entirely in index. We do check out the contents of cleanly resolved paths
that are different from the merged-into branch to the working tree, but it
is perfectly fine if we made it optional. We also do write out half-merged
content to the working tree, but that is merely to ask the user to help
finishing the merge that is happening in the index (iow, the ultimate goal
is to let the user say "git add" to tell the index what the resolution is,
and is not to let the user remove <<< === >>> markers in the file in the
working tree). If there is no conflict, we should not have to touch the
working tree at all, and "union" is a very narrow special case that we
declare there is no conflict (even if there was).

In other words, I would prefer to see something like:

	$ git merge --index-only [-s <strategy>] <other_branch>

which

    (0) does work without any file checked out in the working tree;

    (1) does not update a path in the working tree even if the merge
        result for the path is different from the original index entry for
        the path;

    (2) updates the index only when everything cleanly merges (depending
        on the definition of "cleanly merges", e.g. "union" may be a lot
        more lenient than the usual "text" merge) and aborts without
        touching anything if there is a conflict (because --index-only
        does not allow us to touch working tree to ask the user to resolve
        the conflict).

"git merge" is designed to work without any file checked out in the
working tree, by considering a _missing_ file in the working tree as if
there is _no change_ to the path during a merge. IOW, we do not say "you
have an uncommitted local removal of a path, which other side tried to
modify, hence we stop the merge to protect your local change".

This is so that you can do something like this:

	$ git checkout v1.7.6-rc2^0
        $ git reset --hard
	$ rm -fr .temp-workdir
	$ mkdir .temp-workdir
        $ cd .temp-workdir
        $ export GIT_DIR=$(git rev-parse --git-dir)
	$ export GIT_WORK_TREE=$(pwd) ;# this is optional, I think.
        $ git merge -s resolve origin/jk/maint-1.7.2-status-ignored
        Trying really trivial in-index merge...
        error: Merge requires file-level merging
        Nope.
        Trying simple merge.
        Simple merge failed, trying Automatic merge.
        Auto-merging Documentation/git-status.txt
        ERROR: content conflict in Documentation/git-status.txt
        Auto-merging t/t7508-status.sh
        ERROR: content conflict in t/t7508-status.sh
        Auto-merging wt-status.c
        fatal: merge program failed
        Automatic merge failed; fix conflicts and then commit the result.
        : alter .temp-workdir/master|MERGING; ls
        ./  ../  Documentation/  t/  wt-status.c

Because .temp-workdir is empty when merge is run, we consider that your
working tree exactly matches what is in your index. We do check out the
cleanly merged result to this temporary working tree (wt-status.c is
cleanly merged and result can be seen there), but it is not strictly
necessary (IOW we could make that part optional). We do write conflicted
half-merge result, as that is the easiest way for the user to help the
index resolve it.

    Side Note: the "recursive" strategy is so broken that it may assume
    the working tree has to be populated and the above may not work as
    nicely.

In other words, we are already half-way there, I think.
