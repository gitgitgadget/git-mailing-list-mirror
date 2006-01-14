From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: My first git success [not quite]
Date: Sat, 14 Jan 2006 11:25:54 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601141117120.13339@g5.osdl.org>
References: <dq8epd$k28$1@sea.gmane.org> <Pine.LNX.4.64.0601130909290.3535@g5.osdl.org>
 <dqb5vg$a09$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 14 20:26:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Exr2H-00080C-6J
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 20:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWANTZ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 14:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWANTZ6
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 14:25:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50904 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750833AbWANTZ5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jan 2006 14:25:57 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0EJPtDZ012852
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 14 Jan 2006 11:25:55 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0EJPsiW012143;
	Sat, 14 Jan 2006 11:25:54 -0800
To: walt <wa1ter@myrealbox.com>
In-Reply-To: <dqb5vg$a09$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.65__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14674>



On Sat, 14 Jan 2006, walt wrote:
> 
> I see I still have a problem:  my mental model of how git
> works is still wrong.
> 
> I used 'git-checkout -b test' to create a disposable place
> to test the patch I was given.
> 
> Okay, making sure I'm now sitting in 'test', I apply the
> patch to foo.c and do my testing.
> 
> Now, intending to delete my 'test' branch, I do git-checkout
> master.  My mental model predicts that 'master' should still
> be identical to 'origin' because I did the patching in 'test'.
> Am I right so far?

Yes.

> The problem I see is that, after switching back to 'master',
> foo.c is the patched version, not your original version.

Ahh. This is very much done on purpose.

Something that hasn't been committed (it is "dirty" in git terms) is 
really not associated with any branch _at_all_. It's purely associated 
with the checked-out directory.

Now, what happens is that when you change branches with a dirty tree, the 
"git checkout" will do one of two things:

 - if the dirty files are _identical_ in both branches, the dirty state 
   (remember: it's not associated with any particular branch) will follow 
   the branch switch.

   This is very convenient. You've edited a file, but you realized that 
   you did this in the wrong branch. For example, you realize that you are 
   in the main development branch, but that your edit is pretty damn 
   experimental. So what you do is _not_ to undo your edit, but to create 
   a new branch and switch to it, and then commit it _there_.

		git checkout -b experimental
		git commit --all

   (you might have an old experimental branch too, in which case you don't 
   need to create it, but then you can only switch to it if the file you 
   edited is the same as in your development branch)

 - otherwise, the switch will fail, and you'll have to either commit the 
   changes in that branch, or you'll have to undo them.

Now, Junio has patches (maybe they even got merged in mainline) to relax 
the "exactly the same" rule a bit, and instead try to merge any dirty 
state into the branch you're switching to. Conceptually nothing changed: 
dirty state is branchless, so when you switch to another branch, the dirty 
state follows you. 

> I figured that the git-checkout would overwrite any changes I
> made to foo.c, but that doesn't seem to be the case.  To get
> your original version back I had to delete foo.c and do a
> git-checkout foo.c (or git-checkout -f master).

Yes. You can either undo the dirty state, or you can do a "forced 
checkout" that will start from scratch. And the dirty state will be _gone_ 
in both cases. It won't be saved away in the "original branch". Again, 
this is 100% consistent with the notion that dirty state is branchless. 
Only _committed_ state is committed to a particular branch.

> So, I clearly don't understand what git-checkout does.  It
> doesn't seem to touch the already-checked-out sources at
> all, which is what I would expect it to do.

No, you understand exactly what git-checkout does, you just didn't realize 
that dirty state was different from committed state.

		Linus
