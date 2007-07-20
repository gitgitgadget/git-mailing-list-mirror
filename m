From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Fri, 20 Jul 2007 14:48:51 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707201421110.27249@woody.linux-foundation.org>
References: <858x9ez1li.fsf@lola.goethe.zz> <7vk5svxt1f.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0707201210550.27249@woody.linux-foundation.org>
 <200707202302.57788.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Jul 20 23:49:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC0LY-0004RO-O9
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 23:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757871AbXGTVtI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 17:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757369AbXGTVtH
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 17:49:07 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53551 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756683AbXGTVtE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2007 17:49:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6KLmuuT004965
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Jul 2007 14:48:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6KLmp2H018228;
	Fri, 20 Jul 2007 14:48:51 -0700
In-Reply-To: <200707202302.57788.johan@herland.net>
X-Spam-Status: No, hits=-3.208 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53122>



On Fri, 20 Jul 2007, Johan Herland wrote:
> 
> Does this mean that you are firmly opposed to the concept of storing 
> directories in the index/tree as such, or that you are only opposed to 
> (some of) the implementation ideas that have been discussed so far?

I've already sent out a *patch* to do so, for chissake. It handled all 
these cases perfectly fine, as far as I know, but I didn't test it all 
that deeply (and made it clear when I sent that patch out).

In fact, in this whole pointless discussion, I think I'm so far the only 
one to have done anything constructive at all. Sad.

So here's my standpoint:

 - people who use git natively might as well use the ".gitignore" trick. 
   It really *does* work, and there really aren't any downsides. Those 
   directories will stay around forever, until you decide that you don't 
   want them any more. Problem solved.

   Sure, if you export the git archive into some other format, you might 
   well want to do something about the ".gitignore" files (like just 
   delete them, since they won't be meaningful in an SVN environment, for 
   example, but you might also just convert them into SVN's "attributes" 
   or whatever it is that SVN uses to ignore files).

 - If you don't use git natively, but just to track another thing, you 
   could easily use the patches that I already sent out. Yes, they need 
   more testing. Yes, you'd also probably like some user interface updates 
   (notably "git add/rm" should be taught about directories).

   And yes, I probably (almost certainly) didn't handle all cases, but the 
   patch I sent out was actually a working one. It really *did* pass my 
   trivial tests.

But once you start tracking empty directories *without* a .gitignore file, 
some things fall out of that:

 - git really *really* is designed to track "snapshots in time". You 
   generate history from these snapshots. This is a very fundmanetal 
   issue, and a lot of people seem to have trouble understanding the 
   deeper implications.

   For example, git and hg may look similar, but git tracks "snapshots in 
   time", and hg tracks "file histories tied together in snapshots". That 
   really is a fundamentally different thing. 

   And one of the fundamental results of git's approach is that content is 
   content. There is *never* any notion of "history".  A snapshot really 
   is just that: it's a standalone thing. It *has* no history. The history 
   comes entirely from outside.

   This means that the whole notion of "this directory will not go away 
   because I added it explicitly" is a totally broken notion in git. It 
   has a notion of "history" - something that simply DOES NOT EXIST, 
   unless you seriously break the whole notion of "snapshots in time".

   In other words, when I say that git is a "content tracker", I'm 
   serious. It tracks nothing *but* content. If some concept doesn't exist 
   in the working tree, git doesn't track it. If it cannot be seen in the 
   filesystem, it doesn't exist.

 - Contrast this with a lot of totally broken SCM's, that track "history" 
   of files. As a result, they have absolutely *horrid* merge problems, 
   because you can no longer just merge things in the working directory, 
   and "the result" is the result. No, if you track history, you now have 
   to tell the SCM about how the *history* moved, not just the content.

So this is why git MUST NOT make the difference between

 - a directory was was created explicitly and then had a few files added 
   to it, and then had those files deleted from it

and

 - we added a few files, we removed them

The end result MUST BE the same, because the  state IN THE WORKING TREE is 
the same!

If the contents are the same, the end result must be the same. It's that 
simple. And it all comes down to: "git tracks contents".

Now, having said that, it doesn't matter *what* the end result is, as long 
as it's the same for both cases. What we do now is that when the files go 
away, the directory is no longer tracked.

But we *could* say that when we remove files, we always add back the 
directory they were in if that directory still exists in the filesystem.

See? Both are consistent with the "git tracks contents" notion. The only 
thing that is *not* consistent with that notion is to have a flag that we 
carry along that says "keep this directory". That's no longer content, and 
now you'd be tracking some internal SCM history instead. And that is a 
mistake. It may sound like a small mistake (and it is), but down that path 
lies madness. It's much better to teach people _why_ git doesn't do it, 
than to say "ok, git tracks content, but we have this special case where 
we also track something else, namely a git internal "stickiness" notion".

SCM is too important to play games with. Git gets things right, and I 
doubt people really _realize_ that the "tracks content" is why git is so 
much better, and why git can do merges so much faster and more reliably 
than anybody else.

So the rule really *must* be:

 - if two trees look the same in the filesystem, they *must* have the same 
   git SHA1, because by definition, they have the same content.

Anything that breaks that very simple statement is fundamentally broken.

			Linus

PS. I realize that nobody actually seems to be writing code, and that this 
is a "paint the bike shed" discussion for everybody else, but just in case 
there are people who don't just masturbate about the color of the shed, 
I'd like to point out that we really *do* need to enhance the "diff" rules 
too, so that you can express the changes in a tree as a diff too. Because 
if we track empty directories, then we need to be able to also *show* the 
difference between a tree that has an empty directory, and one that does 
not.
