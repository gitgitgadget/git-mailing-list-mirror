From: maximilian attems <max@stro.at>
Subject: Re: [PATCH] am: Allow passing exclude and include args to apply
Date: Sat, 29 Jan 2011 20:31:34 +0100
Message-ID: <20110129193133.GC24622@stro.at>
References: <1292775461-26762-1-git-send-email-max@stro.at>
 <AANLkTik5-oJYsfEoeYjy8E9v4T4_7VBsoGnqg7oXwnbC@mail.gmail.com>
 <20101219171313.GI17034@vostochny.stro.at>
 <7v4oa9frmr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org,
	klibc@zytor.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 29 20:31:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjGWO-00049c-3F
	for gcvg-git-2@lo.gmane.org; Sat, 29 Jan 2011 20:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867Ab1A2Tbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Jan 2011 14:31:38 -0500
Received: from vostochny.stro.at ([78.47.22.85]:44197 "EHLO vostochny.stro.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754736Ab1A2Tbh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jan 2011 14:31:37 -0500
Received: from stro.at (77.116.68.104.wireless.dyn.drei.com [77.116.68.104])
	by vostochny.stro.at (Postfix) with ESMTPA id 9FBAFC05D;
	Sat, 29 Jan 2011 19:31:35 +0000 (UTC)
Received: by stro.at (Postfix, from userid 1000)
	id 34BEE2035E; Sat, 29 Jan 2011 20:31:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v4oa9frmr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165667>

hello,

sorry for the time it took to reply, but "things" went crazy
around christmas.

On Sun, 19 Dec 2010, Junio C Hamano wrote:

> maximilian attems <max@stro.at> writes:
> 
> > ...
> > when one wants to promote a specific new feature, it is much better to
> > come up with it's use case, as burden is on Maintainer to keep it working.
> 
> You need to do that with test suite, not with the log message.  Otherwise
> you are adding undue burden on the Maintainer to download klibc and dash
> just to run regression testing whenever somebody else makes changes to
> "am/apply" callchain down the road.

ok thanks for the point.
 
> While I love patches that are backed by a strong "here is a real-world
> problem we needed to solve, and this change made our life much easier by
> doing so-and-so" statement, I also tend to think twice before considering
> a change that could potentially encourage a bad version control
> discipline.

sure, one sees your careful planning.
 
> Your use case description in the log message however lacks crucial
> information to be useful when judging that aspect.  You said that the
> directory structure is "different", but didn't say they are different in
> what way.  In order to skip one mail exchange turnaround, I'd speculate.

sorry about that, will answer below.
 
> If dash repository keeps (perhaps slightly stale version of) the same
> files as klibc repository in its libc/ subdirectory, a patch to dash that
> fixes its libc part may all have its pathnames prefixed with libc/.  In
> order to apply such a patch to the klibc tree, you would need to give -p2
> to strip one extra level (if you are going the other way, you would
> instead give --directory=libc/ to deepen it).  But then I do not see a
> need for --exclude to remove parts from the patch that touch outside of
> libc/ tree.
> 
> If the dash patch you needed to deal with touched both inside libc/ and
> outside, and if you are taking only libc/ part and discarding everything
> else, I see two issues with respect to promoting pottentially bad version
> control disciplines.
> 
>  - Should you be reusing the information in the commit without editing?  I
>    am not worried about Signed-off-by which is about asserting the origin,
>    and origin of the libc/ part is the same as the origin of the whole.
>    But what about reviewers' and tester's assertion at the end?  Also the
>    description of the change itself may need to be adjusted to the new
>    context you are reusing the change for.
> 
>  - Why does the patch touch two unrelated parts in the first place, if its
>    libc/ part can stand on its own?  This is not about the discipline of
>    the user of "am", but of the originating project.

Life is simpler in effect, considering this usecase.

So the code lives in dash repo and from to time is ported to klibc.
So dash has no klibc code on it's own it's only klibc, which is carrying
a copy of dash in order to have an useful shell for early userspace.

It is not a full copy of dash and some things are not their,
that's the usage case for the exclude argument on the git am call.
 
> Another thing that came to my mind around the vague "different directory
> structure" is this question: what if directory A/ in "dash" corresponded
> to directory B/ in "klibc" and you saw a patch to A/ (and some others) for
> "dash" that you wanted to reuse in "klibc"?  Do we need more changes to
> make it work, or do we already have enough support for this combination?
> 
> I would imagine that "git am --directory=B/ -p2 --exclude=\* --include=A/"
> or something like that should work, but I didn't think it through nor I
> didn't check the command line syntax, either.

well mostly the current workflow looks like this:

1) Generate patches to import on dash git repository:

 git format-patch --keep-subject <changeset>..

 Path fixup:
perl -i -pe 's#^([-+]{3} [ab]/)src/#$1#g' 00*patch

2) Import patches on by one

 git am --directory="usr/dash" --exclude="usr/dash/configure.ac" \
 	--exclude="usr/dash/ChangeLog" --exclude="usr/dash/dash.1" \
	--exclude="usr/dash/Makefile.am" --exclude="usr/dash/mksignames.c" \
	-i -s ../dash/000X-foo.patch


the path fixup with perl is needed as dash code lives in
"src/", but later it lands in "usr/dash/".

I do not have a use case for --include, I only added it out of
completness.

Unless objection I'd repost the patch with exclude only and relevant
testcase.

Of course if you'd know of a trick that makes the perl path mangling
useless I'd be more than happy to hear.

thank you.

-- 
maks
