From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Tue, 30 Jan 2007 10:06:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701300906260.3611@woody.linux-foundation.org>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mike Coleman <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 19:06:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBxN3-0000N4-2S
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 19:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965648AbXA3SGN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 13:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965673AbXA3SGN
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 13:06:13 -0500
Received: from smtp.osdl.org ([65.172.181.24]:40741 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965672AbXA3SGM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 13:06:12 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0UI691m017889
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 30 Jan 2007 10:06:09 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0UI68XL024601;
	Tue, 30 Jan 2007 10:06:08 -0800
In-Reply-To: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
X-Spam-Status: No, hits=-0.461 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38176>



On Tue, 30 Jan 2007, Mike Coleman wrote:
> 
> 1.  As of today, is there any real safety concern with either tool's
> repo format?  Is either tool significantly better in this regard?
> (Keith Packard's post hints at a problem here, but doesn't really make
> the case.)

I think Keith was nervous about hg, because hg
 (a) has changed repo formats a few times and was talking about changing 
     it again (but since I don't follow hg very closely, I don't know if 
     that has happened, will happen, or was shelved)
 (b) modifies data in-place.

Git doesn't really do either. Git has extended the repository format a few 
times (notably pack-files), but apart from a *really* early change at the 
very beginning of development, the git repo format is identical today to 
what it was originally, and you can read old repositories without any 
converision what-so-ever.

Also, the git repository format is (and has always been) "stable" in 
another sense: we never *ever* re-write any old data. Even when we 
re-pack, we write a totally new copy, and while you'd often then get rid 
of duplicates afterwards, the operation is fundamentally safer that way.

> 2.  Does the git packed object format solve the performance problem
> alluded to in posts from a year or two ago?

If you mean the original discussions in the first few months of git 
development, then yes. People used to worry that git's unpacked format was 
not only slow, but also would chew up disk like mad. Both were true, and 
yes, both were solved by the packed format (to the point where I think git 
uses the *least* amount of disk space of any SCM ever made ;)

HOWEVER. Git definitely has a different "performance profile" than many 
other SCM's do, and it's something worth keeping in mind. That has less to 
do with the pack-files than just very fundamental git design.

In particular, *every* other SCM I am aware of does history on a per-file 
basis. Git very fundamentally does not. This means that while git 
outperforms just about anything else, if you expect "individual file 
history" to be any faster than "whole repository history", you're simply 
going to be in for a surprise. It very fundamentally isn't. 

We had this particular performance "anomaly" be discussed just the other 
week. People seem to be so used to the "file ID" mentality that has its 
roots in RCS etc, that they expect "git log <filename>" to somehow be 
faster than "git log". In git, that's simply not true. History is *always* 
seen as a "full repository history". There simply isn't anything else.

I personally don't see this as a "problem", but it definitely is 
*different*. And it causes a different performance profile for various 
operations than you'd see with other SCM's.

[ The reason I don't think this is a problem is because it's partly what 
  makes whole-repository operations like "merge" so fast. But it's also 
  the thing that causes git to very naturally not care about single files, 
  and anything you can do with a single file you can basically do with an 
  arbitrary set of files or directories. Which is *very* powerful, and as 
  far as I know, no other SCM can effectively do that at all.

  As a top-level maintainer of a project with tens of thousands of files, 
  I end up almost never looking at individual files: I look at collections 
  of files. And that's where git shines, and almost everybody else falls 
  flat on their face. But if you have the "single-file" mentality, you 
  will find operations that you think git does badly. ]

> 3.  Someone mentioned that git bisect can work between any two
> commits, not necessarily just one that happens to be an ancestor of
> the other.  This sounds really cool.  Can hg's bisect do this, too?

I suspect it can - as far as I know, the whole "bisect" thing originated 
with git, and hg picked up the idea from that. You'd have to be really 
stupid (and/or have a horrible repo format) to not be able to do multiple 
unrelated commits.

HOWEVER! One thing that may make it less useful in hg is that last I 
heard, hg didn't do multiple independent branches in the same repository. 
So some of the more useful usage schenarios may simply not be viable in hg 
at all (ie you'd have to merge in order to bring the two unrelated commits 
into the same hg repository, and merging may not always be possible).

So with git, you can say "that branch is good, this branch is bad, what 
caused the regression?" by using "git bisect". In hg, I'm not sure that 
works, simply because of the weakness of branches. But you'd have to ask 
the hg lists. They do have *some* concept of branches within a repo, so it 
may well be that it all works out.

> 4.  What is git's index good for?  I find that I like the idea of it,
> but I'm not sure I could justify it's presence to someone else, as
> opposed to having it hidden in the way that hg's dircache (?) is.  Can
> anyone think of a good scenario where it's a pretty obvious benefit?

It's a huge deal during merging with conflicts.

During merging, the index is the part that shows you what the conflicts 
are, and also where you mark any conflict resolution while the working 
tree is still not fully resolved. However, it's kind of hard to show the 
"obvious benefit" without actually showing an example of a real (and 
complex) merge conflict, and I'm way too lazy for that.

It has advantages in many other situations too, but they are more subtle. 
One of the things _I_ consider to be an advantage (but which confuses some 
people because it's also another thing that makes git different from many 
other SCM systems) is that the index is also where you "prepare" your work 
for committing, and this is especially obvious when adding new files.

Every single SCM has *some* kind of an index, even if it's as simple as 
just the CVS "list of files I know about". So in CVS, the "index" is 
really just the "CVS/Entries" list. You really can think of the git index 
as just a "CVS/Entries" kind of thing, done right.

So what does "done right" mean? It means that the git index not only lists 
the filenames, it lists their *contents* and status too. That means that 
when you do a "git add", you don't just add a filename to the list of 
files you know about, you literally add the *content*.

The reason this is important is that this is fundmanetally how git works: 
git doesn't actually really *ever* work with filenames at any stage all, 
git either works with "content" (which obviously includes the notion of a 
filename, but it is also the mode of the file and the content of the 
file), and git also has a notion of "pathname limiter", which basically 
works on a repository "tree" level, and limits the content to just a 
subset of the whole tree.

So the "index" is very much part of this - it's just another portion of 
the fact that git always tracks *contents* and never tracks "file ID's".

So in CVS (or SVN), when you do a "cvs add", you really don't add any 
content to the repository, you are really adding a new "file ID" to the 
list of files that CVS/SVN tracks. In git, when you do "git add", you are 
really adding content, but that also means that the index - the 
"CVS/Entries" replacement - has to be able to track things differently.

Anyway, if you come from CVS, and have worked with it intimately enough 
that you know how things like CVS/Entries work, it should actually be 
fairly easy to pick up on the git index. You just need to mentally realize 
"oh, it contains the contents, file mode and merge conflict state too!"

> 5.  I think I read that there'd been just one incompatible change over
> time in the git repo format.  What was it?

The original git object naming was to first compress the object, and then 
calculate the SHA1 of the compressed end result. That was stupid, stupid, 
and I admit it.  I switched it around.

However, to get some notion of how early this was, the first git release 
was done on April 7, 2005. The change-over to switch the compression and 
SHA-1 hashing around was done April 20, 2005. There was an additional 
fix to do the date handling more sanely, April 23, 2005. The format has 
been stable since.

So yes, there has been one real format change, and it happened two weeks 
into development, long before git was really usable by mere mortals at 
all.

After that, we have added capabilities to the the database (notably, the 
packed files, and a new simplified loose object format), but as far as I 
know, current git will happily read any git archive written after April 
23rd, 2005. With no data conversion necessary.

Going the other way is obviously not always possible. If you get a git 
from May of 2005, and try to use it on an archive that uses pack-files, it 
obviously will *not* work. But even there, we've been very careful, and 
unless you set some specific options in your config file or do things like 
explicitly pack your branch head/tag references, fairly old versions of 
git will happily read even new archives.

> 6.  Does either tool use hard links?  This matters to me because I do
> development on a connected machine and a disconnected machine, using a
> usb drive to rsync between.  (Perhaps there'll be some way to transfer
> changes using git or hg instead of rsync, but I haven't figured that
> out yet.)

I don't know about hg (but will assume not). Git generally does not, but 
doesn't mind them either if you have them in your working tree.

And yes, there are ways to transfer using git natively, and they tend to 
be a lot more useful and safe than rsync.

> 7.  I'm a fan of Python, and I'm really a fan of using high-level
> languages with performance-critical parts in a lower-level language,
> so in that regard, I really like hg's implementation.  If someone
> wanted to do it, is a Python clone of git conceivable?  Is there
> something about it that just requires C?

It doesn't "require" C in the sense that the object format is actually 
fairly simple, and you could do things natively in python if you *really* 
wanted. That said, the whole approach of git has always been to write the 
"core" core in C, and just make the thing very scriptable. 

Some things simply are not sensible to do in a slow interpreted language. 
Things like generating diffs (another name for "comparing two trees") is 
fundamnetally much too performance-sensitive for anything but a serious 
system language. You need a compiled language with a good compiler, no 
"byte code pre-compilers" need apply. Same goes for the "view repository 
through a filename filter" thing.

We used to have our standard "merge" function written in python, but 
mainly because it was our *only* python dependency, it actually got 
rewritten in C (also, people - including me - really expect to merge two 
branches with 20+ _thousand_ files in them in less than a second, so that 
may explain another reason why the merge got rewritten).

> 8.  It feels like hg is not really comfortable with parallel
> development over time on different heads within a single repo.
> Rather, it seems that multiple repos are supposed to be used for this.
> Does this lead to any problems?  For example, is it harder or
> different to merge two heads if they're in different repo than if
> they're in the same repo?

That is my understanding too, but I've not followed hg actively.

The git branching model really is superior. It might take a while to get 
used to it (it took _me_ a while to get used to it ;), but once you do, 
everybody else so *obviously* does it so horribly badly that it's not even 
funny.

So the whole "multiple branches in the same repo" thing really shines in 
git. SCM's like SVN *claim* that they do multiple branches, but they 
really don't. They are just confused.

		Linus
