From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-revover-tags-script
Date: Sat, 16 Jul 2005 17:51:23 -0700
Message-ID: <7vr7dy9rw4.fsf@assigned-by-dhcp.cox.net>
References: <m1u0iuo63i.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 17 02:51:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtxNS-00066C-BO
	for gcvg-git@gmane.org; Sun, 17 Jul 2005 02:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVGQAvZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jul 2005 20:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVGQAvZ
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jul 2005 20:51:25 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:40884 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261675AbVGQAvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2005 20:51:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050717005125.KFTE16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Jul 2005 20:51:25 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <m1u0iuo63i.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's message of "Sat, 16 Jul 2005 14:20:49 -0600")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> First pass at a script to dig through .git/objects and find dangling
> tags.  It likely has a lot of weird limitations, I don't know if it
> will work with packs, and the policy it implments is pretty stupid,
> but it is a sane start and should keep people from needing to
> rsync anything except the .git/objects part of the tree.

Also in an earlier message:

> Do we want to put some porcelain around, git-fsck-cache --tags?
> So we can discover the tag objects in the archive and place
> them someplace usable.  Jeff Garzik in his howto is still recommending:
>
>>   git-pull-script only downloads sha1-indexed object data, and the requested remote head.
>>   This misses updates to the .git/refs/tags/ and .git/refs/heads/ directories. It is
>>   advisable to update your kernel .git directories periodically with a full rsync command, to
>>   make sure you got everything:
>>$ cd linux-2.6
>>$ rsync -a --verbose --stats --progress \
>>   rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ \
>>   .git/
>
> Which feels like something is missing.  Given that tags are
> sha1-indexed objects we should be pulling them.  And I believe you can
> have a tag as a parent of a commit, so even with the pack optimized
> clients we should be pulling them now.  

You cannot have a tag as a parent of a commit.  commit-tree.c
explicitly checks for "commit" objects, and I think it is the
right thing to do [*1*].  You will also notice that at the end
of git-fetch-script, a tag is written in the .git/tag/<name>
file as fetched, but the .git/FETCH_HEAD file records the commit
SHA1 if a tag is fetched.  So, no, unless you are using rsync
transport to pull everything in sight, I do not think you will
pull tags you do not explicitly request to be pulled as part of
the commit chain (be it done by the old fashioned commit walker,
or the on-the-fly pack transfer).  I do not think "finding a
dangling tag using git-fsck-cache" is something we particularly
want to have a special wrapper around for [*2*], because the
user should not be needing to do it.

I do think we need a way to discover remote tags, an equivalent
to "wget $remote_repo/refs/tags/" (non recursive kind, just the
names).  When to fetch them from remote, and where to store them
locally, however, are different matter, I think.

Given that tags, especially the signed kind, are almost always
only made by the project lead and percolate down the patch
foodchain in practice, copying _all_ tags from the remote
repository like Jeff suggests makes sense in many situations,
but in general I think the namespace under the .git/refs
directory should be controlled by the local user [*3*].  As
Linus said before, you can choose to pull a tag from him only
because he told you about it.  After learning about that tag,
deciding to pull the tag "v2.6.13-rc3" from his repository, and
storing it in the same ".git/refs/tags/v2.6.13-rc3" path locally
is your choice, not his [*4*].

I think the same can be said about the remote branch heads; an
obvious case is ".git/refs/heads/master".

"git-fetch-script" is very conservative.  Only when you tell it
to fetch the tag <name>, it stores it in .git/refs/tags/<name>
locally.  When you tell it to fetch the head via the short-hand
merchanism by having .git/branch/linus file that records the URL
of his repository, the head is stored in .git/ref/heads/linus.
Otherwise it does not touch .git/refs at all, and I think that
is the right thing to do.

Maybe we want to have "git-list-remote URL --tags --heads" for
discovery, and perhaps "--all-tags" flag to "git-fetch-script",
to cause it to fetch all remote tags.


[Footnote]

*1* I think I once sent a patch to break this, but luckily Linus
had a much better sense than me and dropped it.  It is very nice
to have adult supervision ;-).

*2* I noticed you have already sent a patch about it.

*3* I am not saying what Jeff suggests is wrong.  In his
suggestion, the user is making a conscious decision to accept
and use all tags Linus has in his repository as they are; and
that is one valid usage pattern.

*4* The tag discovery mechanism is one way for the remote
repository owner to tell you about the tags.
