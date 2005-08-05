From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Terminology
Date: Fri, 5 Aug 2005 11:57:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508051104510.3258@g5.osdl.org>
References: <Pine.LNX.4.58.0507311541340.29235@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vhdeaj05n.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508051655480.8418@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 21:05:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E17Tk-0005xI-NN
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 21:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbVHETCW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Aug 2005 15:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbVHES7q
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Aug 2005 14:59:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19889 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262818AbVHES6d (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2005 14:58:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j75IvnjA024180
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 5 Aug 2005 11:58:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j75Ivm6f031240;
	Fri, 5 Aug 2005 11:57:49 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508051655480.8418@wgmdd8.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 5 Aug 2005, Johannes Schindelin wrote:
> 
> Tutorial says "cache" aka "index". Though technically, a cache
> is the index file _plus_ the related objects in the object database.
> git-update-cache.txt even makes the difference between the "index"
> and the "directory cache".

I think we should globally rename it to "index".

The "directory cache" and later "cache" naming came from when I started
doing the work - before git was even git at all, and had no backing store
what-so-ever, I started out writing "cache.h" and "read-cache.c", and it
was really first a trial at doing a totally SCM-neutral directory cache
front-end.

You don't even see that in the git revision history, because that was 
before git was self-hosting - the project was partly started to also work 
as possibly just a fast front-end to something that wasn't as fast (ie 
think something like a front-end to make "monotone" work better).

So the "directory cache" and "cache" naming comes from that historical 
background: it was really started as a front-end cache, and in fact the 
".git" directory was called ".dircache" initially. You can see some of 
that in the very earliest git releases: by then I had already done the 
backing store, and the thing was already called "git", but the "dircache" 
naming still remains in places.

For example, here's my "backup" target in the initial checkin:

	backup: clean
		cd .. ; tar czvf dircache.tar.gz dir-cache

which shows that not only did I call the resulting tar file "dircache", 
the directory I was developing stuff in was called "dir-cache" as well ;)

The index obviously ended up doing a lot more, and especially with the
different stages it became much more than just a directory cache thing:  
it's integral to how git does the fast part of a merge. So we should call
it "index" and edit out the old "cache" and "director cache" naming
entirely.

>   - the directory which corresponds to the top of the hierarchy
>     described in the index file; I've seen words like "working
>     tree", "working directory", "work tree" used.
> 
> The tutorial initially says "working tree", but then "working
> directory". Usually, a directory does not include its
> subdirectories, though. git-apply-patch-script.txt, git-apply.txt,
> git-hash-object.txt, git-read-tree.txt
> use "work tree". git-checkout-cache.txt, git-commit-tree.txt,
> git-diff-cache.txt, git-ls-tree.txt, git-update-cache.txt contain
> "working directory". git-diff-files.txt talks about a "working tree".

I think we should use "working tree" throughout, since "working directory" 
is unix-speak for "pwd" and has a totally different meaning.

>   - When the stat information a cache entry records matches what
>     is in the work tree, the entry is called "clean" or
>     "up-to-date".  The opposite is "dirty" or "not up-to-date".
>
>   - An index file can be in "merged" or "unmerged" state.  The
>     former is when it does not have anything but stage 0 entries,
>     the latter otherwise.

I think the "unmerged" case should be mentioned in the "cache entry" 
thing, since it's really a per-entry state, exactly like "dirty/clean".

Then, explaining a "unmerged index" as being an index file with some 
entries being unmerged makes more sense. 

As it is, the above "explains" an index file as being unmerged by talking 
about "stage 0 entries", which in turn haven't been explained at all.

>   - A "tree object" can be recorded as a part of a "commit
>     object".  The tree object is said to be "associated with" the
>     commit object.
> 
> In diffcore.txt, "changeset" is used in place of "commit".

We really should use "commit" throughout. ex-BK users sometimes lip into
"changeset" (which in turn is probably because BK had these per-file
commits too - deltas), but there's no point in the distinction in git. A 
commit is a commit.

>   - The following objects are collectively called "tree-ish": a
>     tree object, a commit object, a tag object that resolves to
>     either a commit or a tree object, and can be given to
>     commands that expect to work on a tree object.
> 
> We could call this category an "ent".

LOL. You are a total geek.

>   - The files under $GIT_DIR/refs record object names, and are
>     called "refs".  What is under refs/heads/ are called "heads",
>     refs/tags/ "tags".  Typically, they are either object names
>     of commit objects or tag objects that resolve to commit
>     objects, but a tag can point at any object.
> 
> The tutorial never calls them "refs", but instead "references".

It might be worth saying explicitly that a reference is nothing but the 
same thing as a "object name" aka "sha1". And make it very clear that it 
can point to any object type, although commits tend to be the most common 
thng you want to reference. That then leads naturally into a very specific 
_subcase_ of refs, namely a "head":

>   - A "head" is always an object name of a commit, and marks the
>     latest commit in one line of development.  A line of
>     development is often called a "branch".  We sometimes use the
>     word "branch head" to stress the fact that we are talking
>     about a single commit that is the latest one in a "branch".
> 
> In the tutorial, the latter is used in reverse: it talks about a
> "HEAD development branch" and a "HEAD branch".
> 
> I find it a little bit troublesome that $GIT_DIR/branches does not
> really refer to a branch, but rather to a (possibly remote) repository.

Yes, I find the $GIT_DIR/branches naming to be confusing too. 

They are really pointers to external repositories, and "branch" is
confusing. But I suspect the confusion is partly due to me, since I used
to think (and argue) that we should aim for a "separate repositories for
separate branches" approach.

That single-branch-multiple-repository mentality came from my BK
background, and from me thinking that local branches would be confusing.  

Jeff has been dragging me into the "local branches are good" camp, and
these days I'm obviously a big believer. But the blame for this confusion
falls squarely on me, with Pasky picking it up from there into cogito and
using the "branches" name, and then git pickin git back up from cogito
through trying to compatible.

>   - The act of finding out the object names recorded in "refs" a
>     different repository records, optionally updating a local
>     "refs" with their values, and retrieving the objects
>     reachable from them is called "fetching".  Fetching immediately
>     followed by merging is called "pulling".
> 
> In that sense, git-http-pull would be more appropriately named
> git-http-fetch, and analogous git-ssh-pull.
> 
> Also, git-pull-script.txt says "Pull and merge", contradicting this
> definition.

To confuse things even more, cogito calls a fetch "pull" and a pull 
"update".

I personally think "fetch" is unambigious: it's just the act of fetching, 
with no "merge" activity at all. So we should use that.

What to call a "fetch+merge" is a bit ambiguous. I obviously prefer
"pull", but cogito disagrees, and you're right, "git-http-pull" and
"git-ssh-pull" both really do just fetches.

But I think "update" isn't right either: to me, update would be the 
non-merging kind (ie I think "update" implies "refresh" which in turn 
implies a "fetch"-like behaviour).

So I'd vote for making the suggested definition official: "fetch" means
fetching the data, and "pull" means "fetch + merge". 

And "update" would be just something that happens to refs: A "fetch" will
obviously update the reference that we had to the external tree we fetched
from, while a commit/merge/whatever will obviously update the current
branch reference (HEAD).

So "update" would really be just a small technical detail.

>   - a "pack" usually consists of two files: a file containing objects
>     in a compressed format, and an index to the first file. If the
>     pack is uncompressed at once (e.g. when git-clone is called), the
>     index is not necessary.
> 
> git-pack-objects calls this a "packed archive" first, but then reverts
> to "pack". git-show-index.txt and git-verify-pack.txt call the .pack file
> "packed GIT archive", and the index "idx file". git-unpack-objects.txt
> calls the .pack file "pack archive".

We should just call them packs. An archive can be multiple packs and lots 
of non-packed objects too. 

> "plumbing", also referred to as "core": the basic set of programs and
> scripts usable to half-gods like Linus.
> 
> "porcelain", also referred to as "SCM": a thin layer over the plumbing
> making GIT usage nice to regular people.
> 
> "type": one of the identifiers "commit","tree","tag" and "blob" describing
> the type of an object.

Yes. Some old docs may call this type a "tag", since I was really thinking
in not in the SCM meaning at all, but in the _computer_architecture_
meaning, where people usually call objects with enforced types "tagged".

Ie from a computer architecture standpoint you can have "tagged memory" or
"tagged pointers", and LISP machines are often implemented with the
pointers containing the type ("tag") of the thing they point to (for
example, the low two bits might be the "tag" on the pointer). So I was
talking about "tagged objects" when I just meant that the type of the
object was embedded in the object itself, the way tagged memory
architectures work.

In retrospect, that naming _really_ confused some people, I know I had
trouble explaining git concepts to David Wheeler because I used "tagged
objects" _not_ to mean a SCM style "tag", but to mean "typed objects".

If somebody sees an old reference to "object tags", those should all be 
fixed to say "object types".

			Linus
