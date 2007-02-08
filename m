From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git rescue mission
Date: Thu, 8 Feb 2007 09:27:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702080858430.8424@woody.linux-foundation.org>
References: <17866.27739.701406.722074@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Feb 08 18:27:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFD3t-00054Z-FC
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 18:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423240AbXBHR1y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 12:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965738AbXBHR1y
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 12:27:54 -0500
Received: from smtp.osdl.org ([65.172.181.24]:53047 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965737AbXBHR1x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 12:27:53 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l18HRpdD025102
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 8 Feb 2007 09:27:52 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l18HRp5t020164;
	Thu, 8 Feb 2007 09:27:51 -0800
In-Reply-To: <17866.27739.701406.722074@lisa.zopyra.com>
X-Spam-Status: No, hits=-0.438 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.114__
X-MIMEDefang-Filter: osdl$Revision: 1.175 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39066>



On Wed, 7 Feb 2007, Bill Lear wrote:
> 
> I have a public bare repo on my machine that I have cloned to make a
> private repo.  I just want to sync my branches on my public and
> private repos.  I do not want to merge across branches, I just want to
> "sync".

Ok, others already replied, but here's a few rules to ease your mind in 
general:

 - First off: you can always _trivially_ get back to whatever state you 
   had before, as long as you committed it, and didn't have any dirty 
   state (uncommitted patches) in your working tree.

This is something that it's worth repeating, and even perhaps 
experimenting with to get really comfortable with. Why? Because once you 
learn to get back to any random state you had before, and once you are 
comfortable with that, you suddenly lose the fear of experimenting. 
Whatever you screw up, if you're confident you can get back, who cares?

So the "get back from a mistake" should probably be at the very front of 
our manuals and tutorials. I don't think it currently is, but it's 
actually not that hard. There's just one command to remember: "git reset", 
and the only issue you might ever have with it is:

 - make sure you're on the right branch first! If the problem you had is 
   that you're on the wrong branch, switch branches first! Don't try to 
   make the wrong branch "look right". But once you know you're on the 
   right branch, you know that "git reset" is your friend to getting it 
   anywhere you want.

 - do you want to throw away all your working tree changes (and if 
   you screwed up some git operation, the answer is usually "Yes!"). If 
   so, add the "--hard" flag. It's not on by default, exactly because it 
   *will* throw away all state in your tracked working tree, and reset it 
   to whatever you want to go back to.

 - exactly *what* do you want to go back to? The default is to go back to 
   the state at the last successful commit, but sometimes what you screwed 
   up was exactly the last commit (eg an unintentional "pull" that 
   actually succeeded), and then you need to tell it *what* to reset to.

That's really all there is to it. It's really simple, although especially 
the second point can take some practice to get right.

So NORMALLY, if you did something bad - say, you edited a file, and just 
realized that the whole edit was just crap, and you want to start over - 
you just do a simple

	git reset --hard

and it will just reset all your git state to the last commit you did. 

This is what you'd do in this case, when you had a "git pull" that simply 
*failed* due to conflicts, and you realize that you didn't do that merge 
at all.

However, what happens if you actually do a "git pull" that doesn't have 
any conflicts (or at least they merge fine), so the pull actually 
*succeeds*, but you realize that wasn't what you wanted to do at all?

In that case, you need to say

	git reset --hard <point-you-want-to-go-back-to>

to just reset to the previous state. Now we get to that "how do I figure 
out what state that was?" part of the question, and usually it's trivial 
to answer.

For example, a command like "git pull" will leave a special magic name 
around to tell you what the original HEAD was before the pull, and that 
magic name is (surprise surprise) called ORIG_HEAD. So if the pull 
succeeded, but you realized it was an error (perhaps you had even intended 
to do it, but once you pulled, you just saw that what you pulled was crap, 
so you decide that you didn't really want to do it after all), you can 
just do

	git reset --hard ORIG_HEAD

and you're back to where you were _before_ the pull.

It really is that easy. And once you get comfortable with it, and you 
really know deep down how easy it is, that should just relax you a lot. 
When you go "AIEE! I made a horrible mistake!" you should just laugh, and 
say "and I don't *care*, because I can just trivially undo it!".

Now, usually it's really as simple as just using ORIG_HEAD (or the 
top-of-the-branch itself when the pull simply failed), but you can 
actually do it for any commit. Say, you've worked for a week, and have 
committed five or six things (and you don't even quite remember), and you 
are just weary, and realize that IT IS ALL CRAP!

Now, before you just decide to drown your sorrows in a bottle (or, 
perhaps, the morning after), you realize that you haven't actually pushed 
it out to anybody else yet (because it wasn't ready anyway), and that you 
can just undo the whole thing!

So what do you do?

You just fire up gitk, or whatever your favourite history viewer is (git 
log, qgit, whatever), and you select the last good commit by hand, and do

	git reset --hard <selected-commit-sha1-name>

which you just cut-and-paste from your history viewer. And magic happens. 
It's all gone, and you're now at that old state in history, and all your 
crap is gone, gone, gone. You can now have a drink or five, happy in the 
knowledge that you just wasted five days of your life, but nobody will 
ever even know your dark dirty little secret, and hopefully you're getting 
paid by the hour, not by the end result anyway.

Of course, if you have reflogs enabled (see previous discussions), it's 
even easier. In particular, it's easier if you do a "git reset" to some 
other point in history, and suddenly realize that what you want to undo is 
really that "git reset" itself ;)

(Even if you undo things, that's also recoverable, as long as you haven't 
done any garbage collection. But it can be harder, because now you won't 
get "git log" or "gitk" to show the stuff you undid, so this is where 
reflogs can save your bacon, since they will remember the old stuff too. 
Without reflogs, you either need to have it in ORIG_HEAD, or you need to 
run "git fsck-objects" and look at all the dangling commits by hand).

So be happy. "git reset" can be dangerous (you *are* throwing things 
away), but it's also very powerful, and pretty easy to use. And git makes 
it fairly hard to *really* throw anything committed away, so even if you 
undo something, and realize you want to re-do it again, it's possible to 
go back - at most it's just a bit more involved to *find* the place to go 
back to.

One final (and unrelated) note. If all you want to do is "sync up", and 
not actually merge anything new into your current branch, you should just 
do "git fetch". Not "git pull". Doing a "pull" implies merging into your 
current branch, and thus does more than just "sync up" the branches you 
are tracking.

			Linus
