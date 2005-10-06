From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] Fall back to three-way merge when applying a patch.
Date: Wed, 05 Oct 2005 23:25:13 -0600
Message-ID: <m1y8575i9y.fsf@ebiederm.dsl.xmission.com>
References: <7vd5mk7pv6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510042155090.31407@g5.osdl.org>
	<7vslvg1mcs.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510050725510.31407@g5.osdl.org>
	<7vslvfcy0g.fsf@assigned-by-dhcp.cox.net>
	<m1mzln9zi1.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0510051909390.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 07:27:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENOHd-0000zx-6c
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 07:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbVJFF0t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 01:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbVJFF0t
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 01:26:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15748 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751230AbVJFF0t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2005 01:26:49 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j965PEe4018904;
	Wed, 5 Oct 2005 23:25:14 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j965PE28018903;
	Wed, 5 Oct 2005 23:25:14 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510051909390.31407@g5.osdl.org> (Linus
 Torvalds's message of "Wed, 5 Oct 2005 19:18:41 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9762>

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 5 Oct 2005, Eric W. Biederman wrote:
>>
>> There is another workable strategy.  Modify git-diff-xxx to report
>> the sha1 of the tree, or the sha1's of the files the patch applies to.
>
> Not workable.
>
> It fundamentally only works for the first patch in a series. After that, 
> the rest will be based off a version that the recipient simply doesn't 
> have (well, if it's the _tree_ SHA1, and the recipient has no other 
> patches, then they'll match, but that case is uninteresting, since it's 
> the trivial case that you always get right by just applying the things in 
> the first place).

But what about the file sha1?  The intuition is that you can
easily provide a lot more context in diffs and that the extra
context might be useful in merging patches.  The part that gives
me how is when I look at if from a diff/patch perspective and
not from a git perspective.

> So you'd have to make it the base for the patch _series_, at a minimum.
>
> And even that likely doesn't work very often. Any time you have a private 
> merge or some other patch in your tree, the recipient wouldn't be able to 
> parse it.

True although in many cases people rework their diffs before sending
them out to avoid situations like the above.

> In practice, I've found that most often it's very trivially obvious _why_ 
> a patch doesn't apply (I remember the "other patch" that happened to the 
> same file, or I just do a "git-whatchanged -p filename"), and it can be 
> useful to allow the person applying the patch to say "ok, try to apply it 
> against version xyz, and do a three-way merge".

Ah.  I had missed that git-whatchanged can be given a filename that is
nice.  One of the better kept secrets of git.  That makes my whole
question worthwhile :)

> But it really tends to be fairly rare.

I don't know how rare it is.  I have had a couple of patches in the last
week that I could successfully auto-merge between branches but the
diffs themselves would actually conflict.

> Now obviously, some of that may be kernel-specific - a large part of the 
> lack of patch conflicts is that we over the years have actively tried to 
> set up the kernel sources so that people seldom step on each other (one 
> example is how we have all modules contain their own "init_module()" thing 
> and sortign it out in the linker - because the old init/main.c approach 
> was _very_ painful since everybody wanted to add lines to the same file).
>
> So it may turn out that other projects might have different wishes for how 
> something like this would work. But I doubt it works very well to rely on 
> commit-level SHA1's - it's more likely to work if you try the "last few 
> tagged releases etc", since patches that don't apply are often against the 
> previous release (and if they don't apply there either, then it's probably 
> not worth fighting over anyway).

Agreed, commit level sha1 are not very interesting.

But if you happen to have at least the file level sha1 you can
actually know if the patch was against what you think it is against.

At one level you could make conflicts more common by dropping any patch
whose source file had the wrong sha1.  At another level you could
test for the sha1 of the source file in the repository and know quickly
if there is something the patch applies cleanly too.

Walking through the list of commits and finding enough information to
merge the patch might still be prohibitive, but at least it is something
that could be automated, and the test to see if it interesting is
cheap.

Eric
