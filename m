From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: unmerging feature branches
Date: Tue, 23 Oct 2007 10:40:16 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710231026011.30120@woody.linux-foundation.org>
References: <20071023152445.GA10070@piper.oerlikon.madduck.net>
 <alpine.LFD.0.999.0710230922240.30120@woody.linux-foundation.org>
 <20071023171611.GA18783@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Oct 23 19:40:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkNk8-0007Ha-Rl
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 19:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbXJWRk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 13:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbXJWRk3
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 13:40:29 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52226 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751792AbXJWRk2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Oct 2007 13:40:28 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9NHeKjI028990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 23 Oct 2007 10:40:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9NHeGDu030995;
	Tue, 23 Oct 2007 10:40:18 -0700
In-Reply-To: <20071023171611.GA18783@piper.oerlikon.madduck.net>
X-Spam-Status: No, hits=-2.722 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62139>



On Tue, 23 Oct 2007, martin f krafft wrote:
> 
> > So you can revert the data, but then if you want to get it back, you'll 
> > need to revert the revert - you cannot just merge the branch again. 
> 
> Ouch!

Well, it's not necessarily "Ouch".

It actually depends on what you want to do. Sometimes this is a feature, 
and the thing is, it actually works for other things that just merge 
commits.

In other words, think of what happens when you merge some development 
branch, and then "git revert" a single commit from that branch - the exact 
same thing will happen - future merges of that branch will *not* re-do the 
commit, because you "already have it", and you reverted it after-the-fact.

And in many ways, this is "obviously" what you want to happen!

Now, I say "obviously" in quotes, because it's not at all obvious in an 
absolute sense - it may be that you reverted the commit not because it was 
buggy, but because your stable branch wasn't ready for it yet, and maybe 
in the future you do actually want the code that the revert reverted. So 
in that sense, nothing is really "obvious", and this is simply how things 
work. But I think that it's easier to explain why git does something like 
this when you speak about normal commits, and it all makes sense.

When you revert the data from a merge, the exact same issue happens. A 
revert (whether done by "git revert", or by the sequence of events I 
described) very fundamentally undoes the *data* part, but leaves the 
history intact, and that has implications for future events that think 
about history - which is mostly "git merge", but there are other thigns 
too.

As an example of "other things" that take history into account, think 
about something like "git rebase". It's not a merge, but it also takes 
history into account in certain ways: in particular, it may be effectively 
a "series of cherry-picks", but it actually takes the history of both 
branches into account, and will not re-apply a patch that already exists 
in the target history.

What does that mean? Let's say that both histories contain a patch X (not 
the same commit, but the same patch), but one history also contains the 
revert of X. Again, the revert reverts the data, but it does *not* revert 
the history, so when you cherry-pick all the stuff from the other branch, 
X will *not* happen - even if it would apply cleanly, and even if a plain 
"git cherry-pick" would have redone it!

Why? History, again. Because "git rebase" sees that the commit already 
existed, it won't even try to apply it again, never mind that it could 
have worked. The "revert" didn't undo the history, just the data.

So a "revert" is fundamentally different from a "undo". Most of the time 
that's exactly what you want, and I'm not pointing this out as a problem, 
I just wanted to point out that it has "effects". Sometimes the effects 
are good, sometimes they are bad, and while they are always very reliable 
and there's never any question about what git will do, people don't always 
think like git, and whether the effects are "good" or "bad" is probably 
entirely up to whether they match users expectations or not.

So sometimes the behaviour of "git revert" will be exactly what people 
expected and wanted ("good, I'll never get that commit again when I pull, 
because I told git that I don't want that commit"), and sometimes it will 
_not_ be what people expected and wanted ("oh, I didn't get that commit, 
even though I was now ready for it - because I had reverted it back when I 
was *not* ready for it").

See? The logic is exactly the same in both cases, but one was good, the 
other bad, and the only difference was really the mindset of the user.

A tool can't ever get "mindset of the user" differences right. At least 
not until we add the "esp option" ;)

So I really don't want to push this as a problem or deficiency, I think 
it's a good thing. But it's a good thing only when people are *aware* of 
what "revert" really means.

			Linus
