From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Patch (apply) vs. Pull
Date: Wed, 22 Jun 2005 23:09:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506222258290.11175@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506230025420.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 08:02:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlKmg-0007kO-My
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 08:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVFWGIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 02:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVFWGIG
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 02:08:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43977 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262141AbVFWGH5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 02:07:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5N67ijA028961
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Jun 2005 23:07:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5N67gDV029895;
	Wed, 22 Jun 2005 23:07:42 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0506230025420.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 23 Jun 2005, Daniel Barkalow wrote:
> 
> I bet I'm misunderstanding fuzz; what I actually mean is that, if a patch
> applies after moving it, then regenerating it from the result would give
> the a patch with different line numbers; if these affect the hash, the
> author's tools will be sad.

What GNU patch calls "fuzz" is how badly the context can "not match". A 
"fuzz factor" of one allows the patch to apply even if the "outermost" of 
the context lines don't match up. See "man patch".

What you talk about is what they (and I) call "offset", and yes, you must
ignore the line numbers when considering two patches identical, exactly
because other patches may change their offsets.

So "git-apply" does apply patches that are offset from where the patch 
claims (and the "claimed position" is really nothing more than a "start 
searching here" parameter), but git-apply does not allow any fuzz.

> > In fact, you could probably replace every run of contiguous whitespace
> > with a single space, and then you'd not have to worry about whitespace
> > differences either. That would be very simple to do, and quite workable: I
> > certainly think it sounds more reliable than just hoping that people
> > always pass on a "patch ID" in their emails..
> 
> That's actually quite plausible. The only case it wouldn't handle is when
> you actually discard parts, and I'm not sure at this point what other
> people should see there.

Yes. One small note of warning: different "diff" algorithms may under some
(mostly unlikely) circumstances result in different patches for the
difference between the same two files. So when comparin SHA1's of diffs
this way, you should also hopefully have the same diff generation
algorithm.

That's not likely to be a problem in practice, but it migh be something to 
keep in mind as a _possible_ source of confusion, where a patch isn't 
recognized only because it was generated differently from the one that we 
compare against.

In practice, this can happen today with the "-C" and "-M" flags to diff,
of course: two patches look different (and get different SHA1 values) just
because one was generated with "rename logic" turned on and the other
wasn't..

> > Yeah. It probably works well in 99% of the cases to just do a simple
> > "export as patch" + "apply on top with old commit message, author and
> > author-date".
> 
> I think that you'll get better results out of "merge with top" + "commit
> with old commit info, but not listing old commit as a parent".

If I understand you correctly, that assumes that you followed the whole
chain, though, and that there was no cherry-picking.

I'd like to keep the door open here for cherry-picking or other 
transformations ("recreate tree _without_ that one commit"), because it 
would seem to also be a potentially good way to clean up history, not 
just move it forward, no?

		Linus
