From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Make list of features auto-managed.
Date: Fri, 22 Jun 2007 00:33:29 -0400
Message-ID: <20070622043329.GE17393@spearce.org>
References: <20070621045903.GA14047@spearce.org> <7v1wg55065.fsf@assigned-by-dhcp.pobox.com> <20070621061045.GG8477@spearce.org> <7vr6o5zt76.fsf@assigned-by-dhcp.pobox.com> <7vhcp1y954.fsf_-_@assigned-by-dhcp.pobox.com> <7vwsxxwtrh.fsf@assigned-by-dhcp.pobox.com> <alpine.LFD.0.99.0706211137020.20596@xanadu.home> <7v7ipxw1bq.fsf@assigned-by-dhcp.pobox.com> <20070622032502.GA17393@spearce.org> <alpine.LFD.0.99.0706212337030.20596@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Jun 22 06:33:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1aq4-0003MP-No
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 06:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbXFVEdh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 00:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbXFVEdh
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 00:33:37 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46615 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbXFVEdg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 00:33:36 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I1apx-00081L-8k; Fri, 22 Jun 2007 00:33:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 46FAE20FBAE; Fri, 22 Jun 2007 00:33:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99.0706212337030.20596@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50674>

Nicolas Pitre <nico@cam.org> wrote:
> First of all, I mentioned at the time that using a . for separator 
> between the tagged version and the number of commits since then in the 
> git-describe output was a bad idea.  You just made the perfect 
> demonstration of that.  If it was just me I'd change that . for a + or a 
> : like the original patch did.

I preferred + as well, but we wound up with - in the final patch,
and GIT-VERSION-GEN replaces the - with a . because that makes RPM
happier or something:

  VN=$(echo "$VN" | sed -e 's/-/./g');

> Now you say that you don't want to wait for the release to happen before 
> using this cool new feature.  Well, I'd reply that life is tough.  

In comparsion to other things we all must deal with in life, this
is a cakewalk.  ;-) But yes, your point is well made.

> Either you 
> trick Junio into making a release sooner because the feature is just too 
> valuable to wait.  Or you try the feature (git-blame -w) and hope for 
> the best.  Certainly in that case you can predict the behavior of 
> older git-blame versions if you pass it -w which they don't understand?

I think that's where we are.  I can develop the feature, trick
git-gui into enabling it, but most end-users won't be able to use
it until Junio makes a 1.5.3-rc* or 1.5.3 final.  Tough for them.
Tricking Junio is very hard, he isn't easily tricked.  A good
quality for a mantainer to have.

> > I'd like to at least gracefully fail by
> > disabling an option, or suggesting the user upgrade their plumbing,
> > if an option isn't supported.
> 
> Well you should be able to just try the option and detect it when it 
> isn't supported.

Sure.

Except sometimes we have been lax about option checking and don't
always fail (though we usually do, but haven't always).  And on
Windows doing a fork+exec to poll an option is expensive.  Worse,
some options are destructive.  For example `update-ref -d`.

Should I run `update-ref -d refs/heads/master` to see if the
-d option is supported by update-ref, so that I know if I should
create a particular UI widget or not?  No, of course not.  I should
use a special temporary name, like GITGUI_TEST_FEATURE.  But now
I have to create and delete a temporary item just to decide if a
UI feature should be enabled.  And if the feature doesn't exist,
then I have to cleanup the temporary item "by hand".

Annoying.  Like this email thread I'm sure has become.
 
> > Unlike how we gracefully fail with a useful error message say
> > when an early 1.4 release that doesn't support offset deltas is
> > given a packfile with an OFS_DELTA in it (corrupt pack, recently
> > rediscussed on list).  Or when a 1.5.1 client tries to checkout
> > a tree that uses the new subproject mode in 1.5.2 (missing blob,
> > recently discussed on #git).
> 
> Those are different as you have an older version that couldn't 
> anticipate the future.  In your case you can "anticipate the past".

Yes, however my point here is that I think we have historically
been bad about making our software reasonably future-proof.

The .pack file has a version field, with value 2.  REF_DELTA is not
supported by those binaries that predated its introduction.  They are
unable to properly unpack, index or read a packfile using REF_DELTA.
Why did the .pack version stay at 2 if REF_DELTA is used in the file?

The packed-refs file was introduced without a version header
(whoops).  Later Junio had to wedge things into there in order to
get a version header of sorts so we could have the tag deref values
cached in the packed-refs.

We weren't strict enough in checking file modes in the tree parser
(yes, that was actually a real bug) but basically we didn't think
ahead to what an older binary should do when a future binary used a
file mode we didn't understand.  For example, the user setuid bit.
Or the new dirlink thing, which isn't even a valid mode in UNIX.

I think we are getting a little better at it, but in general we
have a really poor track record in this area.

-- 
Shawn.
