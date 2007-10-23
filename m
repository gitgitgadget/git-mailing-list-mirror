From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: unmerging feature branches
Date: Tue, 23 Oct 2007 11:24:27 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710231115060.30120@woody.linux-foundation.org>
References: <20071023152445.GA10070@piper.oerlikon.madduck.net>
 <alpine.LFD.0.999.0710230922240.30120@woody.linux-foundation.org>
 <20071023171611.GA18783@piper.oerlikon.madduck.net>
 <alpine.LFD.0.999.0710231026011.30120@woody.linux-foundation.org>
 <20071023180825.GA20343@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Oct 23 20:25:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkOR4-0008Tc-Uv
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 20:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbXJWSYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 14:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752202AbXJWSYo
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 14:24:44 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55572 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752188AbXJWSYn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Oct 2007 14:24:43 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9NIOSZw031277
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 23 Oct 2007 11:24:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9NIORuR032701;
	Tue, 23 Oct 2007 11:24:28 -0700
In-Reply-To: <20071023180825.GA20343@piper.oerlikon.madduck.net>
X-Spam-Status: No, hits=-1.992 required=5 tests=AWL,BAYES_00,INFO_TLD
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62145>



On Tue, 23 Oct 2007, martin f krafft wrote:
> 
> While this makes perfect sense, I am a bit thrown off now wrt two
> earlier posts by you (in another thread), where you said:
> 
>   In other words, git never looks at individual commits when trying
>   to merge. It doesn't try to figure out what the "meaning" of the
>   changes are, it purely looks at the content.
>     -- http://marc.info/?l=git&m=119198488411957&w=2

This is still true.

Git never looks at individual commits when merging, it looks at the 
*history*.

So it does look at the commits only in the sense that it uses the "shape" 
of the history (which is obviously built up from many individual commits!) 
but it never looks at any individual commit per se.

And the behaviour of "git revert" comes *exactly* from the fact that git 
never even bothers to look at the revert as a "revert" of history! A 
revert is a normal data commit, and has absolutely zero impact on history 
itself. So the reason a merge will never give "back" the data over a 
revert is that the data was already merged, since the history itself 
didn't change!

> I master merged branch Foo, then reverted a commit introduced by
> Foo, and then Foo would be re-merged, the content *will* differ.

No. If you re-merge Foo, nothing at all happens! You're already merged. 
It's a no-op.

If Foo has had *new* commits in the meantime, those new commits will show 
up, of course, but the old commits have absolutely zero effect, because 
they will be part of the common history.

> So Git *has to* look at the list of commits in history to properly 
> handle reverts and *not* redo commits which have since been reverted.
> 
> Is this correct?

No, that's absolutely incorrect. You didn't understand what I meant.

Git merge doesn't look at the revert at all, except (indorectly) when it 
builds up the history and it passes over it in order to find the common 
base for the history.

> > As an example of "other things" that take history into account, think 
> > about something like "git rebase". It's not a merge, but it also takes 
> > history into account in certain ways: in particular, it may be effectively 
> > a "series of cherry-picks", but it actually takes the history of both 
> > branches into account, and will not re-apply a patch that already exists 
> > in the target history.
> 
> In the light of the discussion in
> (http://marc.info/?t=119198137100002&r=1&w=2), I am now completely
> confused. Or well, not confused, but I simply don't know anymore
> what Git does, and I thought I did.

git-rebase is special. It really does look at each commit (obviously), 
since it needs to *move* each commit. 

So git-rebase has nothing at all to do with merges. They have similar 
behaviour (quite often the end result is identical in the *data* - at 
least that's the good case), but at the same time they are very different 
indeed. 

Git-merge *only* cares about the "shape of the history" (to find the 
common commit(s) to use as a merge base) and the actual data, while "git 
rebase" actually goes one commit at a time.

> How can rebase know that the commit already existed when you're
> saying above that it's about patch X, *not* the same commit?

Git-rebase looks at the patch itself, using the "patch fingerprint", and 
when it goes through each commit, it skips commits that have already been 
applied. 

See the man-pages for "git-cherry" and "git-patch-id".

		Linus
