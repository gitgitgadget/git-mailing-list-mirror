From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: bad git pull
Date: Fri, 16 Dec 2005 14:12:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512161347490.3698@g5.osdl.org>
References: <68948ca0512151537v2d8f22c8x962c55bd507af8cf@mail.gmail.com>
 <7vzmn2kjw1.fsf@assigned-by-dhcp.cox.net> <7vu0d9lxx9.fsf@assigned-by-dhcp.cox.net>
 <118833cc0512161007k38fdd15w2dcdf0c93f26d29e@mail.gmail.com>
 <7vfyoshmp6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Morten Welinder <mwelinder@gmail.com>,
	Don Zickus <dzickus@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 23:15:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnNog-0007x7-8U
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 23:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbVLPWMk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 17:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbVLPWMj
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 17:12:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46747 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932526AbVLPWMj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2005 17:12:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBGMCBDZ007392
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Dec 2005 14:12:12 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBGMC89S014323;
	Fri, 16 Dec 2005 14:12:09 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyoshmp6.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13759>



On Fri, 16 Dec 2005, Junio C Hamano wrote:
>
> Morten Welinder <mwelinder@gmail.com> writes:
> 
> >> While I am sympathetic, this "Oops, I said pull when I meant
> >> fetch" sounds remotely similar to "oops, I said 'rm -r' when I
> >> meant to say 'ls -r'".  Is it that the tool is too fragile?
> >
> > Didn't bk come with some kind of (one-level) undo pull?  It should not
> > be too hard to create something similar considering that one could
> > just leave new objects in the db orphaned.
> 
> Yes, that is called "git reset".

Well, this is one area where BK and git differ a lot. BK didn't overload 
many things onto the same "reset" functionality, but had specific 
operations for specific cases.

Also BK would never leave a merge in the git kind of half-merged state, 
because BK refuses to have two branches open. Instead, BK had a special 
way of handling merges, which worked fine but quite frankly I have very 
little idea of how it worked (it was some kind of "shadow BK tree", it was 
called ".bk/RESOLVE/" or something like that - but because the tools 
were so nice, you never really had any reason to look into it, so I 
don't know what it did).

BK would never change the working tree itself until the merge was done, so 
you would never need to do what a plain "git reset --hard" (without any 
arguments) does.

In many ways the BK thing was very nice, although the git way is perhaps a 
bit more flexible (because git makes the intermediate tree visible you can 
easily edit the merge errors, and compile/test the result, before you 
decide to commit any manual merge).

I really do like the way git does merges now (especially after the last 
round of git-diff-tree fixes that allow comparing the different stages), 
but the BK way is in some ways cleaner and leaves less potential for 
confusion since it avoids ever exposing you to any half-merged state.

You may remember how I initially argued that we should always try to merge 
stuff outside of the normal working directory. And I still _like_ that 
approach, although I've since decided that I actually prefer the current 
git way is even better in practice.

But "git reset" is a lot more than the "revert to previous state". It 
_also_ does - without the error checking - what "bk fix" used to do 
(which is to undo the last commit, so that you can re-commit it), and it 
also does what "bk undo" used to do. It also does "bk unpull".

So "git reset" really does a whole lot of different and _mostly_ related 
things:

 - undo any half-way changes (very similar to just "git checkout -f"), and 
   just reset to the state of the last successful commit (ie "current 
   HEAD"):

	git reset --hard

   BK didn't need this, although if you just want to remove your edits 
   (which "git reset --hard" also does), you could - like with git - just 
   do a "checkout" operation, of course.

 - undo the last commit, but don't undo the working tree ("soft reset to
   parent of head").

	git reset HEAD^

   I think this was "bk fix -C".

 - undo the last commit entirely ("hard reset to previous state"):

	git reset --hard HEAD^

   This was "bk undo"

 - undo the last pull ("bk unpull"): "hard reset to ORIG_HEAD":

	git reset --hard ORIG_HEAD

   This was "bk unpull".

where the last two are obviously just special cases of a generic "undo to 
arbitrary previous commit state".

BK in many ways had more hand-holding (which I think is good, and "git" to 
some degree has an unnecessarily "hard core" approach to these things). 

For example, I think "bk undo" not only asked you about it, but it also 
only ever undid the last commit (and refused to undo a pull or merge). If 
you wanted to undo to some arbitrary state, you had to use the "-a" flag, 
iirc. 

Of course, under BK the "undo" operation was final, so BK _had_ to be more 
careful. With git, if you undo to some arbitrary state, you can still 
"re-do" all your commits if you just find the old head (and 
git-fsck-objects will help you do that), so in that sense git doesn't 
_need_ to be as careful as BK was.

		Linus
