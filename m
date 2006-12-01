X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 12:13:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612011134080.3695@woody.osdl.org>
References: <20061130170625.GH18810@admingilde.org> <200612010902.51264.andyparkins@gmail.com>
 <20061201110032.GL18810@admingilde.org> <45701B8D.1030508@b-i-t.de>
 <20061201121234.GQ18810@admingilde.org> <4570289D.9050802@b-i-t.de>
 <20061201133558.GU18810@admingilde.org> <45703174.8000609@op5.se>
 <20061201134610.GW18810@admingilde.org> <457041AD.4010601@op5.se>
 <20061201150045.GZ18810@admingilde.org> <45705A94.2070509@op5.se>
 <Pine.LNX.4.64.0612010844380.3695@woody.osdl.org> <457061A7.2000102@b-i-t.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 1 Dec 2006 20:13:50 +0000 (UTC)
Cc: git@vger.kernel.org, Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <457061A7.2000102@b-i-t.de>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32963>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqElU-0005YD-0H for gcvg-git@gmane.org; Fri, 01 Dec
 2006 21:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758823AbWLAUNl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 15:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759287AbWLAUNl
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 15:13:41 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48867 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1758823AbWLAUNk (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 15:13:40 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB1KDAjQ030812
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Fri, 1
 Dec 2006 12:13:11 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB1KD94E025276; Fri, 1 Dec
 2006 12:13:09 -0800
To: sf <sf@b-i-t.de>
Sender: git-owner@vger.kernel.org



On Fri, 1 Dec 2006, sf wrote:
>
> Linus Torvalds wrote:
> ...
> > Think of it this way: one common use for submodules is really to just
> > (occasionally) track somebody elses code. The submodule should be a
> > totally pristine copy from somebody else (ie it might be the "intel driver
> > for X.org" submodule, maintained within intel), and the supermodule just
> > refers to it indirectly (ie the supermodule might be the "Fedora Core X
> > group" which contains all the different drivers from different people).
> 
> Could you please be a little bit more specific about how you would store the
> "pristine copy".

Note that it's not necessarily "pristine", since the submodule clearly is 
a local git repository in its own right. So like _any_ git repository, you 
can (and may well end up) having your own local branches in the submodule, 
with your own local modifications.

So I'm not claiming that a submodule must always match some external git 
tree 100%, and that it must be read-only or anything like that. I'm just 
saying that I suspect that quite often, one of the MOST IMPORTANT parts is 
that the submodule is really something that somebody else technically 
maintains, and that this is actually one of the _reasons_ why it is a 
submodule in the first place. 

For example, a lot of projects end up having some kind of "library 
component" as a submodule. Take something like a video player project, 
which would have something like ffmpeg as a submodule, not because you'd 
maintain ffmpeg yourself, but simply because (let's say) the library 
interface changes enough, or you need a specific version with some of your 
own fixes that haven't been released widely yet, so you want to carry all 
the libraries you need _with_ you, even though you don't really maintain 
that submodule. You at most have some small extensions of your own.

Now, in this situation, it's relaly really _important_ that the submodule 
really is totally independent of the supermodule, for several reasons.

For example, since you don't "really" own that project, carrying around 
your own fixes is really really painful. We know it happens all the time, 
and a lot of projects end up needing their own version, but the _last_ 
thing you want is to be in merge hell all the time. So as a supermodule 
maintainer, the best possible thing for you is to be able to push back 
those local changes to the original project maintainer, so that you 
_don't_ have to maintain your own changes.

But you need to realize that the real maintainer of the submodule is 
TOTALLY UNINTERESTED in your supermodule. He's not going to maintain it, 
and in fact, if you have anything in the submodule that ends up talking 
about your supermodule, that's just going to make it a lot less likely 
that the upstream maintainer will ever pull your changes. He might take a 
diff from you, but in a perfect world, you'd actually be able to tell him: 

 "Hey, I've got a git repository with a few fixes to your ffmpeg git tree, 
  please pull from git://myhost.com/submodule.git to get these fixes:

	... explanation of fixes and commits that are relevant to
	ffmpeg, and have nothing to do with the supermodule, except
	that you need those bug-fixes because you _use_ ffmpeg ...

  Thanks"

See?

So this is why it's really important that the submodule really is a git 
repository in its own right, and why committing stuff in the supermodule 
NEVER affect the submodule itself directly (it might _cause_ you to also 
do a commit in the submodule indirectly, but the submodule commit MUST be 
totally independent, and stand on its own).

Now, you don't _have_ to push things upstream, of course. You can always 
just maintain your own submodule branch, and every once in a while, inside 
the submodule, you do

	# fetch the development in the origin/master branch
	git fetch submodule-origin origin/master

	# rebase our own special magic sauce on top of that
	git rebase origin/master

to update your submodule, and _then_ you do a commit in the supermodule 
(after testing that the update is all ok, of course) which will update the 
"commit" pointer in the supermodule.

Notice? In this example, we really maintained the submodule AS a 
submodule. It was independent, but tied into the supermodule, so that when 
we clone the supermodule, or do things like bisection on a supermodule, we 
always end up cloning the submodule too (and in the case of bisection, we 
really only bisect the supermodule, but the submodule always gets 
"tracked" in the sense that we would always check out the state of the 
submodule that was appropriate for that particular commit in the 
supermodule).

> There seems to be some agreement to store the commit id of
> the submodule instead of a plain tree id in the supermodules tree object, and
> that all objects that are reachable from this commit are made part of the
> supermodule repository (either fetched or via alternates). Do you agree?

Well, I would actually argue that you may often want to have a supermodule 
and then at least have the _option_ to decide to not fetch all the 
submodules.

For an example of this kind of usage, let me tell you how we operated at 
Transmeta a few years ago, which I'm not saying is the _only_ way to 
operate, but it's ONE way to do it, and I'll also explain _why_ we did it, 
and why we had submodules.

In the case of transmeta, we had our own tools, our own programs, and we 
"owned" all of those. We _also_ used a lot of external tools, like gcc 
etc. However, different people worked on different parts, and if you 
worked on the actual x86 JIT part, you probably didn't want to have all of 
the gcc stuff in your tree _too_. That just took a lot of space, and you 
really didn't want to compile the whole toolchain (which took hours), 
since there were precompiled binaries readily available.

Still, from a _release_ standpoint, when we released a new binary, that 
binary very much depended not just on the actual JIT sources, but on the 
whole toolchain. So if you wanted to be able to re-create a release, you 
really needed _everything_. You couldn't just take the "current version" 
of the toolchain, you needed to have the toolchain that was used AT THE 
TIME OF THE RELEASE.

And this is a _classic_ example of when you'd want to use submodules. 
Notice how everybody wanted _some_ of the submodules, but really only the 
release people wanted them _all_. The higher up the chain you were, the 
less likely you were to really want to muck around with the compiler and 
the linker, for example. 

And nobody really owned all modules. 

So what you really want is:

 - a supermodule maintainer that is not really the maintainer of _any_ of 
   the submodules, but that does the main "build world" infrastructure 
   (and generally would tend to also maintain the source control 
   infrastructure itself)

 - submodules that had their own maintainers, and where the maintainers 
   may or may not have wanted the supermodule, but even when they wanted 
   the supermodule, they might not want _all_ of the submodules, simply 
   because they just didn't care.

 - some of the submodules then have _upstream_ sources that were totally 
   independent, and that you would want to track, but you had zero power 
   AT ALL over them, and yet you migt well want to push back at least some 
   of the fixes you did - at least the ones that made sense even outside 
   your own project - just to avoid having to maintain a _huge_ set of 
   internal patches.

So no, I don't think the supermodule should even _force_ people to always 
get all the submodules. It migth be the default case, but at the same 
time, it's just being polite to let users decide on their own whether they 
really want _all_ of the build infrastructure sources.

> If I understand you correctly you cannot make any changes to the submodules
> code _in the supermodule's repository_, no bugfixes, no extensions, no
> adaptions, nothing. Do you mean that?

Yes. I think you should make all changes _within_ the submodule, because 
the submodule should still be an independent git tree in its own right.

But obviously, you'd often use a private _branch_ in the submodule beause 
you end up having whatever private extensions. That's always true: we 
always have the "master" branch that is kind of the default "private 
branch" for any repository, but obviously that is often extended upon, and 
you may have several private branches. 

For example, after you've done a big update (from some external upstream 
source) in the submodule that you are using, you migth decide that you do 
all the work on that new big update in a _new_ private branch within the 
submodule - and get the submodule changes all squared away on its own 
_before_ you then decide to commit the end result (the tip of that new 
private branch) within the supermodule.

Ie, you very much should be able to to do

	git clone supermodule/that/one/submodule my-own-version-of-submodule

to clone a submodule _without_ getting anything else (but still get all 
the work you did within he submodule - very much including your own 
private branch work).

And the importance of keeping the submodule independent is partly just 
stability and sanity, but partly also scalability. For example, the 
"index" in a supermodule should NOT include the indexes of all the 
submodules. That's really important, because the index doesn't really 
scale. Things do slow down with large indexes. 

For example, git can handle tens of thousands of files easily. I suspect 
it scales well to hundreds of thousands of filenames. But with 
supermodules, you really can end up in the situation where you have _tens_ 
of these submodules, maybe even hundreds. And if you try to maintain one 
unified index for the _whole_ thing, I guarantee you that you'll start 
feeling the pain. Indexing millions of files is just not going to be 
pretty.

So just from a git stability and scalability point, it's important to keep 
subprojects _separate_. There is obviously integration stuff, but they 
should still be seen as truly independent projects. Even the supermodule 
should have clearly its own life even _regardless_ of submodules, because 
(as I said) quite often you may want the supermodule, but you don't want 
to have _all_ of the submodules.

But it's more than that stability and scalability thing too - keeping them 
separate is what allows you to do pulls and pushes on an individual 
subproject basis, and have people really work at that level. For example, 
if you're the compiler guy at a company, you really do want to work with 
other compiler people _outside_ the company, but you sure as hell may not 
be able to give them access to your supermodule. But you may want to work 
on _just_ the compiler parts (or at least share some branches in public), 
which means that the subproject really has to be able to work 
_independently_ of the supermodule.

So "independent" here is really key, for several reasons. And that all 
means, for example, that here must NEVER be any "backpointers". A 
subproject really can _never_ have backpointers to the superproject, 
because that fundamentally means that the above kind of "compiler guy 
works on the compiler subproject in public" cannot work, if your 
supermodule isn't public.

