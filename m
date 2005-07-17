From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] git-revover-tags-script
Date: Sun, 17 Jul 2005 02:40:35 -0600
Message-ID: <m1psthomf0.fsf@ebiederm.dsl.xmission.com>
References: <m1u0iuo63i.fsf@ebiederm.dsl.xmission.com>
	<7vr7dy9rw4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 17 10:41:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Du4i4-000542-Se
	for gcvg-git@gmane.org; Sun, 17 Jul 2005 10:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVGQIk5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 04:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVGQIk5
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 04:40:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64479 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261192AbVGQIkz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2005 04:40:55 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6H8ecAg026449;
	Sun, 17 Jul 2005 02:40:38 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6H8eaWh026448;
	Sun, 17 Jul 2005 02:40:36 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7dy9rw4.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 16 Jul 2005 17:51:23 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> First pass at a script to dig through .git/objects and find dangling
>> tags.  It likely has a lot of weird limitations, I don't know if it
>> will work with packs, and the policy it implments is pretty stupid,
>> but it is a sane start and should keep people from needing to
>> rsync anything except the .git/objects part of the tree.
>
> Also in an earlier message:
>
>> Do we want to put some porcelain around, git-fsck-cache --tags?
>> So we can discover the tag objects in the archive and place
>> them someplace usable.  Jeff Garzik in his howto is still recommending:
>>
>>> git-pull-script only downloads sha1-indexed object data, and the requested
> remote head.
>>> This misses updates to the .git/refs/tags/ and .git/refs/heads/
> directories. It is
>>> advisable to update your kernel .git directories periodically with a full
> rsync command, to
>>>   make sure you got everything:
>>>$ cd linux-2.6
>>>$ rsync -a --verbose --stats --progress \
>>> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ \
>>>   .git/
>>
>> Which feels like something is missing.  Given that tags are
>> sha1-indexed objects we should be pulling them.  And I believe you can
>> have a tag as a parent of a commit, so even with the pack optimized
>> clients we should be pulling them now.  
>
> You cannot have a tag as a parent of a commit.  commit-tree.c
> explicitly checks for "commit" objects, and I think it is the
> right thing to do [*1*].  You will also notice that at the end
> of git-fetch-script, a tag is written in the .git/tag/<name>
> file as fetched, but the .git/FETCH_HEAD file records the commit
> SHA1 if a tag is fetched.  So, no, unless you are using rsync
> transport to pull everything in sight, I do not think you will
> pull tags you do not explicitly request to be pulled as part of
> the commit chain (be it done by the old fashioned commit walker,
> or the on-the-fly pack transfer).  I do not think "finding a
> dangling tag using git-fsck-cache" is something we particularly
> want to have a special wrapper around for [*2*], because the
> user should not be needing to do it.

Sounds fine.  I totally agree that a better method for finding
the tags is preferable.  So far that is all I have and currently 
it works.  However since commit's cannot have tags as their parents
all tags that are no non-local tags will show up as dangling tags
in git-fsck-cache.  So it is a good general technique.  I would
certainly prefer for us to process tags when they come in so we
don't need to play with git-fsck-cache.

> I do think we need a way to discover remote tags, an equivalent
> to "wget $remote_repo/refs/tags/" (non recursive kind, just the
> names).  When to fetch them from remote, and where to store them
> locally, however, are different matter, I think.

What we care about are the tag objects, those are the only kind
that are verifiable and usable remotely.  

Now that I know we do not pull tags currently with any of the
optimized transports, I would suggest taking the list of commit
objects we are transporting and for each commit look in the
remote repo/refs/tags and transferring every tag object we can find
that refers to that commit.

The implementation would likely be different from the description,
above.  Probably simply finding the list of all remote tags (on the
remote end for packs).  Indexing that list by commit sha1 and then
merging that list with the list of commits we are fetching.

Maybe we should create a reverse index like
repo/refs/tag_objects/<object_sha1>/<tag_sha1>s to make finding and
processing tag objects easier?

> Given that tags, especially the signed kind, are almost always
> only made by the project lead and percolate down the patch
> foodchain in practice, copying _all_ tags from the remote
> repository like Jeff suggests makes sense in many situations,
> but in general I think the namespace under the .git/refs
> directory should be controlled by the local user [*3*].  As
> Linus said before, you can choose to pull a tag from him only
> because he told you about it.  After learning about that tag,
> deciding to pull the tag "v2.6.13-rc3" from his repository, and
> storing it in the same ".git/refs/tags/v2.6.13-rc3" path locally
> is your choice, not his [*4*].
>
> I think the same can be said about the remote branch heads; an
> obvious case is ".git/refs/heads/master".

Agreed.  As my script was a first pass I was not handling tag name
conflicts or renaming, I was simply detecting the conflicts.  As to tags
everyone who maintains a public tree for consumption makes tags.

On kernel.org we recognize several trees and their associated tags.
2.6.x (linus's tags)
2.6.12.x  (the sucker tree)
2.4.x  (Marcelo's tags)
2.2.x
2.0.x
2.6.?-acx ( Allen's tree)
2.6.?-mmx ( Andrew's tree)

There are several additional trees by prominent kernel developers.

And then we have the distro vendors trees.

So ultimately there are a lot of tags from a lot of different people
I would care about.  Having to grab the different branches separately
is sane but having to grab each individual tag along the way starts
becoming a major pain.  

Linus's comment about knowing a tag exists when he announces it
is a silly even for Linus because he doesn't always announce his
tags.

The way I envision using tags is that I have a local repository
that is maintained with automated scripts.  Basically pulling
the branches that I think I will care about.  This mirroring needs
the option of happening preemptively because publicly accessible
content from time to time disappears.  So if you don't get it
when it is published you may never get it.  

Eventually I will get a report about something in reference to a
particular tag, that I will care about.  I will find that tag
and perform a checkout and look at the code.

> "git-fetch-script" is very conservative.  Only when you tell it
> to fetch the tag <name>, it stores it in .git/refs/tags/<name>
> locally.  When you tell it to fetch the head via the short-hand
> merchanism by having .git/branch/linus file that records the URL
> of his repository, the head is stored in .git/ref/heads/linus.
> Otherwise it does not touch .git/refs at all, and I think that
> is the right thing to do.

I agree that not updating the local .git/refs/heads or .git/refs/tags
automatically is a good thing.  However none of that precludes
automatically fetching or storing of tag objects.  

What happens in the rsync case of simply fetching the tag objects
is perfectly serviceable, and a simple script is all that it
takes to pull out the tags and make them useful.  The only problem
in usability is that git-fsck-cache is slow, so having an index
is desirable.  

> Maybe we want to have "git-list-remote URL --tags --heads" for
> discovery, and perhaps "--all-tags" flag to "git-fetch-script",
> to cause it to fetch all remote tags.

Something like that.  After we get the tag objects with
the generic git mechanisms it becomes a question for porcelain what
to do with them.  But porcelain can't do anything with tags if
we can't fetch tags or find tags.

> [Footnote]
>
> *1* I think I once sent a patch to break this, but luckily Linus
> had a much better sense than me and dropped it.  It is very nice
> to have adult supervision ;-).

:)  Until you replied I wasn't certain where we stood, and it
seemed faster to ask and start the needed conversation then to read
through the code.

> *2* I noticed you have already sent a patch about it.

What better way to start a conversation.

> *3* I am not saying what Jeff suggests is wrong.  In his
> suggestion, the user is making a conscious decision to accept
> and use all tags Linus has in his repository as they are; and
> that is one valid usage pattern.

Agreed.  A matter for the user or for the porcelain to decide.

> *4* The tag discovery mechanism is one way for the remote
> repository owner to tell you about the tags.

And tag discovery is what we don't have, and that is what
I am picking on.

Eric
