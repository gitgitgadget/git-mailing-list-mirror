From: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Sun, 8 Jan 2006 19:50:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601081927520.3169@g5.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13489@hdsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.64.0601081100220.3169@g5.osdl.org> <20060109004844.GG27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-From: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org Mon Jan 09 04:52:51 2006
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Envelope-to: glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Evo5R-0000AQ-GQ
	for glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Mon, 09 Jan 2006 04:52:50 +0100
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand
	id S1751228AbWAIDwp (ORCPT <rfc822;glad-acpi-devel@m.gmane.org>);
	Sun, 8 Jan 2006 22:52:45 -0500
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org id S1751233AbWAIDwp
	(ORCPT <rfc822;linux-acpi-outgoing>); Sun, 8 Jan 2006 22:52:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9092 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751230AbWAIDwo (ORCPT
	<rfc822;linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>); Sun, 8 Jan 2006 22:52:44 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k093oXDZ011911
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 8 Jan 2006 19:50:34 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k093oW0J015911;
	Sun, 8 Jan 2006 19:50:32 -0800
To: Al Viro <viro-rfM+Q5joDG/XmaaqVzeoHQ@public.gmane.org>
In-Reply-To: <20060109004844.GG27946-rfM+Q5joDG/XmaaqVzeoHQ@public.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Precedence: bulk
X-Mailing-List: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org



On Mon, 9 Jan 2006, Al Viro wrote:
> 
> How do you deal with conflict resolution?  That's a genuine question -
> I'm not talking about deliberate misuse to hide an attack, just a normal
> situation when you have to resolve something like
> 
> A:
> 	if (foo)
> 		bar
> 
> B:
> 	if (foo & baz)
> 		bar
> 
> A':
> #ifdef X
> 	if (foo)
> 		bar
> 	...
> #endif
> 
> merge of A' and B: trivial conflict

Actually, these days git is pretty good at it. Much better than CVS, 
certainly. You can see the "conflict against my old tree", or "conflict 
against the remote tree" by using the "--ours" or "--theirs" flag to "git 
diff" respectively.

(Or "diff conflict against common base": "git diff --base").

So for your particular example with a trivial base file:

	line    1
	        2
	        3
	        if (foo)
	                bar
	        6
	        7
	        8

and then the changes you had as an example in the A' and B branches, if I 
from A' do a "git pull . B", I get:

	Trying really trivial in-index merge...
	fatal: Merge requires file-level merging
	Nope.
	Merging HEAD with ad56343c578785b8d932224a8676615e7a3e191f
	Merging: 
	9d619225e3adecee6432a36d67d140e29b0acf62 A' case 
	ad56343c578785b8d932224a8676615e7a3e191f B: case 
	found 1 common ancestor(s): 
	93765ba3f64e9c73438e52683fffa68e5a493df7 Base commit 
	Auto-merging A 
	CONFLICT (content): Merge conflict in A 

	Automatic merge failed; fix up by hand

and then the file contains the contents

	line    1
	        2
	        3
	<<<<<<< HEAD/A
	#ifdef X
	        if (foo)
	=======
	        if (foo && baz)
	>>>>>>> ad56343c578785b8d932224a8676615e7a3e191f/A
	                bar
	        6
	#endif
	        7
	        8

ie it will have does a CVS-like merge for me, and I need to fix this up. 
However, to _help_ me fix it up, I can now see what the diff is aganst my 
original version (A'), with "git diff --ours" (the "--ours" is default, so 
it's unnecessary, but just to make it explicit):

	* Unmerged path A
	diff --git a/A b/A
	index 06dd3bc..7334364 100644
	--- a/A
	+++ b/A
	@@ -1,8 +1,12 @@
	 line   1
	        2
	        3
	+<<<<<<< HEAD/A
	 #ifdef X
	        if (foo)
	+=======
	+       if (foo && baz)
	+>>>>>>> ad56343c578785b8d932224a8676615e7a3e191f/A
	                bar
	        6
	 #endif

which is very helpful especially once I have resolved it. IOW, I just edit 
the file and do the trivial resolve, and now I can do a "git diff" again 
to make sure that it looks ok:

	* Unmerged path A
	diff --git a/A b/A
	index 06dd3bc..924fc97 100644
	--- a/A
	+++ b/A
	@@ -2,7 +2,7 @@ line    1
	        2
	        3
	 #ifdef X
	-       if (foo)
	+       if (foo && baz)
	                bar
	        6
	 #endif

ahh, looks good, so I just do "git commit A" and that creates the 
resolved merge.

>  The obvious way (edit file in question, update-index, commit) will not 
> only leave zero information about said conflict and actions needed to 
> deal with it, but will lead to situation when git whatchanged will not 
> show anything useful.

Now, this is a real issue. 

The resolve part is pretty easy, but the fact that it's hard to see in 
"git-whatchanged" is a limitation of git-whatchanged. 

You need to use "gitk", which _does_ know how to show merges as a diff 
(and yes, I just checked).

> Is there any SOP I'm missing here?

You're just missing the fact that git-whatchanged (or rather, 
"git-diff-tree") isn't smart enough to show merges nicely. It really 
_should_. It doesn't. You can choose to show merges with the "-m" flag, 
but that will show diffs against each parent, which really isn't what you 
want. 

I should do the same thing gitk does in git-diff-tree.

> Worse (for my use), format-patch on such tree will not give a useful patchset.
> You get a series of patches that won't apply to _any_ tree. 

Now, git-diff-tree _does_ do that. Use the "-m" flag, and choose the tree 
you want.

And btw, that works with "git-whatchanged" too. You _can_ pass the "-m" 
flag to git-whatchanged, and it will show you each side of the merge 
correctly. So it _works_. It's just such a horrible format that by default 
it prefers to shut up about merges entirely. 

(I don't know of a good three-way diff format. "gitk" can do it, because 
gitk can show colors. That's a big deal when you do three-way - or 
more-way - diffs).

> And that's a fundamental problem behind all that rebase activity, AFAICS.

You do _not_ want to rebase a merge. It not only won't work, it's against 
the whole point of rebasing.

Rebasing is really only a valid operation when you have a few patches OF 
YOUR OWN that you want to move up to a new version of somebody elses tree 
that you are tracking. You fundamentally _cannot_ rebase if you've done 
anything but a linear set of patches. And that has nothing to do with the 
patch difficulty - it simply isn't an operation that makes sense.

(Btw, not making sense doesn't mean it might not work. It sometimes might 
actually work and do what you _hoped_ it would do, but it's basically by 
pure luck, and not because it is a sensible operation. Even stupid 
people hit on the right solution every once in a while - not because 
they thought about things right, but just because they happened to try 
something that worked. The same is true of "git rebase" with merges ;^).

The fundamental reason a rebase doesn't make sense is that if you've done 
a merge, it obviously means that some other branch has done development, 
and already has the commits that you're trying to rebase. And you CANNOT 
rebase for them.

So instead of rebasing across a merge, what you can do is to not do the 
merge at all, but instead rebase one of the two branches against the 
other. Then you can rebase the result against the thing that you wanted to 
rebase them both against. Now you've never rebased a merge - you've just
linearised branches that were linear in themselves against each other.

Basically, a merge ties two branches together. Once you've merged, you 
can't make a linear history any more. The merge fundamentally is not 
linear.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
