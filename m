From: Steven Grimm <koreth@midwinter.com>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 10:35:36 -0700
Message-ID: <46DEE8E8.2000801@midwinter.com>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <69b0c0350709050947k5e32ba7fj38924a0968569d9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Govind Salinas <govindsalinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 19:35:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISymz-0007w3-1s
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 19:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623AbXIERfg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 13:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753503AbXIERfg
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 13:35:36 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:58066 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754015AbXIERfe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 13:35:34 -0400
Received: (qmail 6623 invoked from network); 5 Sep 2007 17:35:34 -0000
Received: from c-76-21-16-80.hsd1.ca.comcast.net (HELO pinklady.local) (koreth@76.21.16.80)
  by tater.midwinter.com with SMTP; 5 Sep 2007 17:35:34 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <69b0c0350709050947k5e32ba7fj38924a0968569d9a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57726>

Govind Salinas wrote:
> This is one reason why I really think that gc should be *plumbing*
> and *not* porcelain.
>   

That's a good way to think of it IMO. It's a low-level operation (albeit 
one that encapsulates other, lower-level ones) that tells git to 
rearrange its internal data structures. It is not something that has any 
user-visible effect. Every other porcelain-level git command *does 
something* from the user's point of view. Running git-gc is basically a 
no-op, which from the user's point of view makes it a waste of 
keystrokes and an annoying distraction from focusing on the stuff 
they're using git to help them build.

> The user should never have to trigger a gc, they should even be
> discouraged from doing so.  That is how other gc systems are.  Can you
> imagine if you had a Java app that had a button on it to do a gc?
> When should I push it?  Should I wait till the system is getting slow
> or just start spamming the button whenever I'm bored?  I know that
> Java/c#/py GC are different than git gc, but they fulfill the same
> basic purpose as git gc.  IE to clean up unused items and free up
> resources.  Git additionally may do some re-optimization, but that is
> not relevant to a user.
>   

I'll play devil's advocate for a moment here, though, and say that, as 
others have suggested in this thread, git could be made to tell you when 
it's appropriate to run gc. So the "I don't know when to run it" 
argument isn't a hard one to address.

With that in mind, here's what the message should look like IMO:

---
Your repository can be optimized for better performance and lower disk 
usage.
Please run "git gc" to optimize it now, or run "git config gc.auto true" 
to tell
git to automatically optimize it in the future (this will launch 
processes in the
background.) For more information, "man git-gc".
---

And that "gc.auto" config option (just an arbitrary name, call it 
something else if that's no good) actually has four settings:

warn (the default) - prints the warning message, at most once every N 
minutes (we can determine a good value for N)
true - launches git-gc in the background as needed
false - suppresses the warning and the check that triggers the warning
foreground - launches git-gc in the foreground as needed (to make it 
easier to abort)


I don't buy the "git gc takes too much memory to run in the background" 
argument as a reason automatic git-gc is a bad idea. Many of us (me 
included) work on machines with plenty of memory to launch a background 
git-gc without hampering our development work, and/or on repositories 
small enough that it doesn't eat that much memory in the first place. 
And if you make it an option that the user has to enable, people on 
low-memory machines can simply not enable it, end of problem.

One big problem with git-gc now is that it's not discoverable. Or 
rather, the need for it isn't discoverable. So at the very least we 
should print the warning, IMO -- and if we're already going to all the 
trouble to determine whether or not git-gc needs to be run, it will 
reduce the "why are you telling me to run something when you could just 
do it for me, you stupid machine?" factor if there's an easily 
discoverable way to just do it as needed.

-Steve
