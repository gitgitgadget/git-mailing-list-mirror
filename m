From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How to pull only a few files from one branch to another?
Date: Tue, 23 Jan 2007 20:11:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701231937310.3606@woody.linux-foundation.org>
References: <17846.53626.895660.762096@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 05:11:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9ZUI-0007NA-Aa
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 05:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965648AbXAXELu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 23:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965649AbXAXELu
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 23:11:50 -0500
Received: from smtp.osdl.org ([65.172.181.24]:50429 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965648AbXAXELt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 23:11:49 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0O4Bdpa029448
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 Jan 2007 20:11:40 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0O4BcU3008004;
	Tue, 23 Jan 2007 20:11:39 -0800
In-Reply-To: <17846.53626.895660.762096@lisa.zopyra.com>
X-Spam-Status: No, hits=-0.745 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.171 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37601>



On Tue, 23 Jan 2007, Bill Lear wrote:
>
> I have a long-running topic branch.  I have fixed a few nits on
> the master branch that I would like on the topic branch.  How do I
> pull in only a few files from the head of the master branch?
> 
> I tried all sorts of incantations (I am running 1.5.0-rc2), including:
> 
> git pull . origin foo.cc
> git pull origin foo.cc
> git pull foo.cc master
> git pull . master foo.cc
> git pull master foo.cc

Git *very* fundamentally tracks project state, not file state. Which means 
that you very much can NOT try to "merge a file". It is a senseless 
operation in git, and in fact, any SCM that allows it pretty much is 
doomed to be a total piece of sh*t (*).

So if you want to get just one file, you cannot see it as a "project-level 
merge", and you literally have to handle that file as an individual file 
and merge it as such, and then you can commit the result as a regular 
commit (but it will _not_ show up as real "git merge").

So in git, the rule is always that you track the whole state of the 
project. It's a project tracker, not a "file tracker".

That said, if you just want to get the fixes from one branch, and merge 
it, git does allow you to do it, although there isn't any "porcelain". 
You'd basically have to do it by hand, a few different ways

 (1) If you just want to commit the state of a file AS IT IS in another 
     branch, you can just do

	git checkout other-branch filename-goes-here
	git commit

     which will just do it for you.

 (2) However, more commonly, what you actually *want* to do is to merge 
     the changes in the other branch into the current branch (which has 
     its own set of changes), and then things get more interesting and 
     more complex.

     If you have just one simple merge-base, you'd do something like

	git merge-one-file \
		$(git merge-base HEAD other):filename \
		HEAD:filename \
		other:filename \
		filename

     (where those last three things are just the file mode). And then just 
     commit the end result.

     Which is just total git magic. If you understand the above command
     line, I have nothing more to teach you.

Maybe somebody could actually test the above one-liner magic thing, and 
explain how it works. And maybe we could write porcelain to do this ;)

NOTE NOTE NOTE! I don't actually think "git merge-one-file" really works 
correctly as-is for your usage case. It _kind_of_ gets the result you 
want, but it's not really written to be used like that, and you'll get an 
error from the

	git-checkout-index -f --stage=2 -- "$4" &&
		cat "$src1" >"$4"

stage because stage 2 didn't exist ("git-merge-one-file" is really only 
supposed to be called by a real merge).

But it's _almost_ usable that way. Maybe Dscho or Junio wants to make it 
work the extra final mile.

Anyway, the above (2) kind of works, but if you want to avoid the warning 
and want to avoid the magic, you would really have to do something like

	git cat-file blob $(git-merge-base HEAD other):filename > .base
	git cat-file blob other:filename > .other
	git merge-file filename .base .other

which will mostly do what you wanted (without complaints), and is what the 
git-merge-one-file magic actually boils down to.

Not exactly pretty. If this is something people want to do often, we'd 
need to generate some porcelain for it.

But if you understand the above three lines, you're actually doing really 
really well already. And as a "yes, git can do it" kind of demonstration, 
it may even be useful.

FINAL NOTE! After you do file-level merging like this, don't expect future 
merges to that file to be easy if you continue to make changes! This is 
_why_ git doesn't do file-level merges natively - namely it really doesn't 
work well together with future merges.

To keep merges working after more than just one merge, you really need to 
either do _all_ merges on a file-per-file level (which is insane and 
doesn't scale and has serious problems) or you need to do merges at a 
"project level" (which is how git fundamentally works).

		Linus

(*) And I'm not saying that just because git doesn't do it. It's much 
more fundamental than that. Once you start doing per-file branching and 
merging, you've basically screwed yourself, and you'll never be able to 
work on the project as a "whole project" any more - you no longer have a 
well-defined history that actually is the history of the whole project.
