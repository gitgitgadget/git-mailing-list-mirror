From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [git-svn] [FEATURE-REQ] track merges from git
Date: Sat, 5 Sep 2009 01:03:37 -0700
Message-ID: <20090905080337.GE22272@dcvr.yhbt.net>
References: <4A9565ED.4010608@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ximin Luo <xl269@cam.ac.uk>
X-From: git-owner@vger.kernel.org Sat Sep 05 10:03:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjqFS-0000ni-DD
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 10:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756671AbZIEIDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 04:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753949AbZIEIDk
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 04:03:40 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59982 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260AbZIEIDg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 04:03:36 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 4ED3F1F78F;
	Sat,  5 Sep 2009 08:03:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4A9565ED.4010608@cam.ac.uk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127791>

Ximin Luo <xl269@cam.ac.uk> wrote:
> Hi,

Hi, sorry for the late reply.

> I'm have 2 separate svn projects from googlecode imported into a single git
> repo. One is a semi-fork of the other, so I thought I'd be able to use git's
> merge feature to repeatedly merge from the mother project (and possibly vice
> versa too).
> 
> However, this doesn't happen. I "git pull" and this works fine, but when I "git
> svn dcommit" back into svn, this rewrites my git history and it loses track of
> the merge (and next time I try to pull, the same conflicts appear).

You may want to try the "set-tree" function of git svn instead of
dcommit, it was originally named "commit" back in the day  set-tree does
not rewrite any history.

It fell out of favor because you could end up with a lot of non-linear
history making it difficult for sharing diffs with SVN-using cow-orkers.

It is useful if you don't want to share your individual changesets, but
push your work upstream to the SVN repos as one big ugly change.

But if you want a staircase effect in gitk, set-tree can be used to make
individual commits where every change ends up as a merge (and you'll see
two commits for every change you made)

> For now I just have a .git/info/grafts, but this doesn't get exported anywhere,
> so if other people "git svn clone" from svn, or "git clone" from my git repo,
> they don't get the merge information.
> 
> It would be nice if git-svn saved the merge info somewhere instead of getting
> rid of it. #git tells me this is impossible at the moment, hence the mail.
> Relevant parts of the convo are pasted below.

It should actually get logged to the unhandled.log file, but right
now I'm not aware of any tools that reads that file (which is designed
to be machine parseable).

> I understand if this is a low priority, but I don't think it would be a major
> PITA to implement (some suggestions are listed in the convo log). And it'd be
> useful for people converting from svn to git.

I've considered stuffing git commit information in SVN properties,
but that information is likely to not even be useful to git users
other than yourself

> Thanks for your time.
> 
> X
> 
> P.S. please don't troll me.

Don't worry, despite my domain name, it's been a long time since I've
done any real trolling :)

> (17:13:14) infinity0: hi
> (17:13:21) infinity0: i've used git-svn to import two svn repo
> (17:13:23) infinity0: repos*
> (17:13:28) infinity0: and used git to merge the two
> (17:13:45) infinity0: the problem is, when i git-svn dcommit back to svn,
> git-svn rewrites my git history
> (17:13:50) infinity0: and loses the merge i just did
> (17:14:01) offby1: infinity0: of course
> (17:14:04) infinity0: how do i get it to retain knowledge of the merge?
> (17:14:11) offby1: infinity0: you don't.  Next questions.
> (17:14:16) infinity0: why not?
> (17:14:29) offby1: svn is incapable of storing a merge, at least in the sense
> that we git people use the term "merge"

I'm not sure if that statement is still true with newer SVN versions;
I still haven't had the time to look too hard at newer SVN features.

On the other hand, SVN could be storing "merges" that git simply can't
track as merges; SVN branches and directories are interchangeable, so
SVN could be merging from places that git isn't tracking at all or
merging individual files.

> (17:14:46) Grum: you should be able to store the result of a merge as a commit
> (17:14:51) offby1: sure
> (17:14:57) infinity0: sure, but why does git-svn have to rewrite my *git*
> history to remove knowledge of the merge?
> (17:15:02) offby1: but not as a "merge commit", whatever that might mean in svn
> (17:15:35) Grum: because it has to be representative of the svn repo after you
> dcommit there obviously
> (17:15:42) offby1: infinity0: it's trying to mirror the svn repository in your
> git repository.  I assume the original, un-rewritten commits are still in your
> git repository; they're just not pointed at by any branch.  Poke around in the
> reflog; I imagine you'll find 'em in there
> (17:16:09) infinity0: ok, but that's not useful if they're dangling
> (17:16:26) infinity0: it's trying to mirror the svn repo yes... but as you
> said, svn doesn't know about merges
> (17:16:26) ***offby1 idly wonders if it'd be possible for git svn to indeed
> store merge commits, by applying the appropriate svn:mergeinfo properties

Some of should be mappable to git merges, it depends on the project and
the type of merge done.   As I said earlier, SVN could be merging
from places git svn doesn't know about and can't track...  SVN can
get extremely complicated :<

I'm not sure how widely used that feature is used in the SVN world,
either.

> (17:16:40) infinity0: i read a thread where it says those are different things
> (17:16:41) offby1: infinity0: I suspect you're using git svn for something for
> which it wasn't designed.
> (17:17:17) infinity0: would it be possible, in theory, to have git-svn store
> the git merge information in eg. the same way it stores the git-svn tag in the
> svn commit message
> (17:17:33) Grum: then just use svn?
> (17:17:37) Grum: and a postit?

I don't agree with having git-specific metadata on the SVN side itself.
Often times that git-specific metadata has SHA1s unique to the user that
committed it, so it wouldn't be useful to anyone else unless users are
merging from each others git repos (which is not an easy/natural
workflow if SVN is the mainline).  Patch exchange is more
reliable/easier...

I've also worked in places where alternative tools are frowned upon, so
sending git-specific metadata over to SVN should always be optional.

The majority of folks I've worked with on SVN-hosted projects have never
known about my git usage (that is changing as git popularity increases,
however).

> (17:18:01) infinity0: i'm trying to link two separate svn repos together via git
> (17:18:17) Grum: and that is just what offby1 said
> (17:18:30) infinity0: "what" is
> (17:18:40) Grum: I suspect you're using git svn for something for which it
> wasn't designed.
> (17:18:42) infinity0: as you all are saying, git merges and svn "merges" are
> different things
> (17:18:58) infinity0: ok, but it would be possible to make git-svn have this
> functionality? or not
> (17:18:59) offby1: certainly
> (17:19:16) offby1: I fear not, since Eric Wong seems like a smart fella; if it
> were doable, I suspect he'd have done it already.
> (17:19:21) offby1: But then ... who knows, maybe he's busy.

I'm not smart but I am busy :)

Summary of the git svn merge tracking situation:

Mapping git <-> git merges to SVN:

  * already doable for the committing user with set-tree,
    but makes history ugly for:

    a) yourself (with every commit set-tree'd individually)
    b) SVN users (single set-tree with the newest commit)
    c) all of the above (varying granularity)

  * Pushing git metadata to SVN will annoy SVN-only users

  * Putting git metadata in SVN may not be useful since SHA1s
    may be specific to the user that made that commit.

Mapping SVN <-> SVN merges to SVN via git svn:

  * most likely to be doable, they'll become plain SVN <-> SVN merges,
    see problems with getting SVN <-> SVN merges back to git, however...

Mapping SVN <-> SVN merges to git:

  * SVN can represent merges that git can't, SVN can be/is extremely
    complicated when it comes to merges.

  * I don't see many projects (I care about) use SVN merge tracking,
    which projects actually use it?  Maybe it's still too new and
    distros/users are behind the upgrade curve...

I've probably missed some, I've been dozing off while replying to
emails...

-- 
Eric Wong
