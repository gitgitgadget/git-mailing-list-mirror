From: Junio C Hamano <gitster@pobox.com>
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Mon, 12 Dec 2011 00:09:30 -0800
Message-ID: <7vmxay5h0g.fsf@alter.siamese.dyndns.org>
References: <jbvj5o$skt$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gelonida N <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 09:30:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra1HU-0004ht-O6
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 09:30:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023Ab1LLIab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 03:30:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54933 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145Ab1LLIa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 03:30:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7223289F;
	Mon, 12 Dec 2011 03:30:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=BXSZRN00oKP16MFcN3zq7VMbzYg=; b=d69i3KNjsv3s3n3AjYug
	9oCKUsrKeUdrqGSnKS0JLbpmIfXPmkmo3SxqQAFj3Xe2alFRD/Q2ArzMEGxvUsFL
	xkO1f4zQh188VVYoq0QSEKdAuQBcnrNpDKZZiEfL+peEBHGgWa1tnt/hJi0l/d5F
	iCc+0lQI7Jt1kxy4N4c4Bt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=tR+6ghdXkYQCR0ze/hIAMQEv8Cc3tyGs3em+tEkQvUwo0/
	KaTgMmQo0Zu9EDvfRSkVToMUTeP7dQjpMB3VoeoYY0pwPo1OxkrQPkUanGJ3EaLS
	KBCKS9Dm8KxiJaU+7VDiCK/BCU2Ewsq+ruESMUnKYs93Smg9ZJDB+2NWle3dg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE4B9289E;
	Mon, 12 Dec 2011 03:30:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33561289D; Mon, 12 Dec 2011
 03:30:25 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A08FF34-249B-11E1-A438-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186895>

Gelonida N <gelonida@gmail.com> writes:

> What is the best way to fastforward all fastforwardable tracking
> branches after a git fetch?

This lacks context and invites too many tangents, so I'll only touch a few
of them.

First of all, why do you want to do this?

You have many local branches that are forked from remote tracking branches
and can be fast-forwarded to their counterparts, iow, these local branches
are often behind their upstream and you do not have your own development
in this repository. Because you can by definition have only one branch
checked out in your working tree, after a fetch from your origin, they
will further fall behind their counterparts.

Coming from that background, I can see you may want these branches that
are not checked out fast-forwarded to their remote counterparts to keep
them stay current, but I first question that background. Why have these
local branches to begin with, if they always are supposed to match their
remote counterpart?

One possible reason (this is one tangent) is that you want to build and
install tips of many branches fetched from the upstream without doing any
local development in this repository (the "upstream" could be your primary
repository and the changes fed to this repository may be your own
development, so this is different from saying that you as a person is only
following other people's work. It is just that nothing is done to the
history in THIS repository). It could be solved by directly checking out
the remote tracking branches into detached head state, e.g.

    $ for branch in maint master next
      do
        git checkout origin/$branch &&
        make prefix=$HOME/git-$branch all test install || break
      done

and the reason why you want local branches instead may be because your
build infrastructure (i.e. instead of "make" you have a custom script,
just like I use 'Make' script in my 'todo' branch) the does customization
depending on the name of the current branch, and might be more cumbersome
to get the same information for a detached head state (i.e. "the tip of
which remote tracking branch is the current commit?") than asking "git
symbolic-ref" the name of the current branch. But then it is easy to find
out which remote branch was checked out from the reflog for the HEAD (and
it is easier for your script that builds the origin/$branch to use that
information internally when the script calls your 'Make' equivalent). In
any case, it is largely your build customization's problem if this is the
case.

Another tangent. Perhaps the reason why you want these local branches but
they can often be fast-forwarded is because your workflow looks like this:

 (1) you fork a topic from origin/master;
 (2) you develop a bit;
 (3) you push the topic back to origin/master;
 (4) time passes, others push to origin/master, while you work on other
     branches of yours;
 (5) from time to time, you fetch from origin;
 (6) you decide to continue working on the topic, so you check it out,
     and before continuing, you wish it is already up-to-date.

But then after fast-forwarding the topic in (6), your topic's history
contains commits other than those you made to work toward the goal of your
topic, namely, other commits made by others during (4) for random purposes
that do not have anything to do with achieving the goal of the topic of
yours. Your branch is no longer about what you wanted to accomplish on
your topic. This invites two tangents.

One is a question. If you knew that the topic is not cooked fully and
needs further work after step (6), why did you push it back to the
origin/master in the first place at step (3), contaminating the history
everybody else bases their further work on with the contents of your
"half-done" topic?

Another tangent. Perhaps the fork is not made from origin/master but you
are collaboratively working on the same topic with others, and you handed
off the work up to what you have done at step (3), and others continued to
further the goal of the shared topic during (4). If that is the case,
wouldn't it make more sense to delete the topic after you push it back,
and forking at the point when you actually decide to get back into action?

Yet another. Even if you keep the (stale) topic branch that you already
have pushed out to the remote, because you can work on one topic at a time
in a single working tree anyway, perhaps it makes more sense to delay this
fast-forwarding until you actually check out the topic branch? After all,
your wishing to fast-forward "all branches" imply you have many of them,
and it wouldn't be far-fetched for me to imagine that you will check one
of them out a lot less often than you run "git fetch".

In other words, wouldn't a post-checkout hook be a better place to do
this kind of thing, perhaps like this (completely untested)? 

    #!/bin/sh
    old=$1 new=$2 kind=$3

    # did we checkout a branch?
    test "$kind" = 1 || exit 0

    # what did we check out?
    branch=$(git symbolic-ref HEAD 2>/dev/null) || exit 0

    # does it track anything? otherwise nothing needs to be done
    upstream=$(git for-each-ref --format='%(upstream)' "$branch")
    test -z "$upstream" || exit 0

    # are we up-to-date? if so no need to do anything
    test 0 = $(git rev-list "..$upstream" | wc -l) && exit 0

    # do we have something we made? if so no point trying to fast-forward
    test 0 = $(git rev-list "$upstream.." | wc -l) || exit 0

    # attempt a fast-forward merge with it
    git merge --ff-only @{upstream}

That is, of course, assuming that it makes sense to keep these local
branches in the first place.
