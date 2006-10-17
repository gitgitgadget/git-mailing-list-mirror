From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 08:03:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610170737280.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca>
 <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org> <45345AEF.6070107@utoronto.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 17:03:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZqTd-0001eV-0w
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 17:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWJQPDZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 11:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWJQPDZ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 11:03:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52973 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751100AbWJQPDY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 11:03:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9HF37aX011327
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Oct 2006 08:03:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9HF36WV024166;
	Tue, 17 Oct 2006 08:03:06 -0700
To: Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: <45345AEF.6070107@utoronto.ca>
X-Spam-Status: No, hits=-0.473 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29084>



On Tue, 17 Oct 2006, Aaron Bentley wrote:
> 
> But tags have local meaning only, unless someone has access to your
> repository, right?

Ehh. Exactly like the bzr numbers? You have to have access to the original 
repo to name it.

So your point is?

If you do

	git log v2.6.17

in a kernel repository, you'll see exactly what I see - because you'll 
have gotten the tags, aka the "easy revision names".

Now, I'm obviously biased, but the thing is, git really does do this 
right. No meaningless numbers. You give _meaningful_ revision names, and 
they can be extremely powerful.

And no, it's not just tags or the raw SHA1 numbers. You can do 
relationships like

	git log HEAD~5..

which means "show the log for everything since five parents ago" (which is 
_not_ the same as "show the last five revisions", because one of them may 
have been a merge, and brought in a lot more of new commits).

Or, you can say

	git diff mybranch@{2.days.ago}..nextbranch

which says exactly what you'd read it as: show the diff between what 
"mybranch" looked like 2 days ago and what "nextbranch" looks like right 
now.

Or, since the namespace is the same for commit history _and_ for actual 
file contents, and since some commands don't need commits, you can decide 
to name not a revision, but a specific file or subdirectory in a revision, 
and do things like

	git -p grep -1 request_irq v2.6.17~2:drivers/char

where the "revision" is not a commit revision at all, it's a _tree_ 
revision, because we've looked up the revision for "v2.6.17~2" (which 
means "the grandparent of the tag 2.6.17"), and then within that commit we 
looked up the tree "drivers/char", and then we grepped (recursively) for 
the string "request_irq" within that subtree (with one line of context), 
and then we paginated the output through "less" (or whatever your pager is 
set to).

In other words, yes, the above does _exactly_ what you'd expect it to do.

The fact is, nobody ever uses the SHA1 names directly in their normal 
work. You'd use the branch names, tag-names, or some relationship operator 
like "this long ago" or "the parent of" or similar).

The only time you use actual SHA1 names is when you tell somebody _else_ 
something. Or when you use "gitk" to look something up, and select a 
commit, and then paste that commit name into "git show" (which is 
obviously telling "somebody else" - it's communicating between two 
programs).

There's simply no reason to ever use the SHA1 names directly normally. But 
they are there, and they are the _real_ revision numbers, and they 
actually have real meaning between different repositories.

So that "git grep" example above is actually 100% equivalent to

	git -p grep -1 request_irq 3ff4e205e1

but why would I ever write that? That's just insane. But in case you care, 
the way I got that "3ff4e205e1" number, it was just by doing

	git rev-parse v2.6.17~2:drivers/char

and cutting-and-pasting the first ten hex-digits to  make sure I had 
enough of a name to make it unique.

So the SHA1 names always exist, and they are what git _internally_ uses, 
but you'd normally not use them that much in your daily life. 

They are great for explaining things, though. For example, when somebody 
reports a bug, and has used "git bisect" to figure out where the bug 
started happening, that's when the "real name" matters - since we normally 
didn't tag that commit as being buggy when we created it ;)

So that's when you'd say: "I bisected the problem, and it started 
happening in commit 0123456789abcdef". And now everybody with a git 
repository of the kernel can just look it up locally by 
cutting-and-pasting that one number.

> The key thing about a checkout is that it's stored in a different
> location from its repository.  This provides a few benefits:

Actually, git does something even better.

Git allows the repository to be split up.

You can get a git repository on a CD or DVD, and do

	git clone -l -s /mount/cdrom myrepo

and that "-s" means that the new "myrepo" actually is linked to the 
original CDROM repository, and you can now _commit_ stuff and make changes 
in myrepo, even though all the old history is on that CD-ROM. It won't add 
any unnecessary stuff at all to the new repo.

Or, you could do the "totally naked" checkout, so that the whole 
repository is somewhere else (if that "somewhere else" is the CD-ROM, you 
obviously cannot change anything ;)

Or you can have <n> different repositories that are all related, and all 
contain just the part that _they_ care about.

		Linus
