From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Sun, 6 May 2007 10:25:16 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun May 06 19:26:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkkV0-0007uv-03
	for gcvg-git@gmane.org; Sun, 06 May 2007 19:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbXEFR0H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 13:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754257AbXEFR0G
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 13:26:06 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:34751 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754117AbXEFR0F (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 13:26:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l46HPHDg027683
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 May 2007 10:25:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l46HPGG9001287;
	Sun, 6 May 2007 10:25:17 -0700
In-Reply-To: <vpqwszm9bm9.fsf@bauges.imag.fr>
X-Spam-Status: No, hits=-3.302 required=5 tests=ALL_NATURAL,AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46348>



On Sun, 6 May 2007, Matthieu Moy wrote:
> 
> But the fact that git actually remembers the _content_ of files in the
> index, and that the default behavior for "commit" is to commit only
> the content that is explicitely "git add"ed is something I've never
> seen outside git.

Yeah. You'd better get used to it, because it's fundamental.

Here's the rationale list:

 - It's fundamentally the only sane thing to do.

   Git tracks content at _all_ levels, not "files". So this is more than 
   an implementation issue, it's a fundamental "how the world works" 
   issue. The fact that everybody else gets it wrong is _their_ problem. 

   [ Corollary: the fact that your brain has rotted from using those 
     broken systems is obviously your problem, and sadly, there's nothing 
     else we can do than try to show the right way and hope that the 
     neurons re-generate. CVS has caused endless suffering, this is just 
     one small example of it ]

 - You fundamentally cannot do it any other way. 

   Not doing it the way git does it (point to the content) means that the 
   index-replacement has to point to something else, namely a "file ID". 

   That's so broken as to be really really sad. In CVS, for example, there 
   obviously isn't any "file ID", so what does the "index" in CVS point 
   at? 

   Right. The "index" in CVS is the Entries file, and it not only lacks 
   stat information, it also lacks any other information, which means that 
   the "file ID" is _literally_ just the pathname itself. That causes 
   obvious problems, so nobody sane would ever suggest that this is a good 
   idea.

   So what do other people use? They tend to not have understood the 
   "content is king" thing (which is what git uses), so they add somethng 
   *else* to the "index" file than the content. What can I say? People are 
   morons. I'm constantly amazed at just how stupid SCM people seem to be.

   In most systems, that "something else" is a "file ID". That just means 
   that they are fundamentally broken whenever they do any trivial merge 
   with renames. Just don't do it. I've talked before about why tracking 
   file ID's is wrong - it's just as wrong as thinking that the "ID" of a 
   file is the path. 

 - Tracking content in the index is fundamentally how and why git can do 
   merges so much better than anything else, and how we handle conflicts 
   gracefully.

   Trust me, you haven't seen good merge conflict support until you've 
   done a git merge, and realized that you can do things like just

	git diff

   to see just the *conflicting* parts, not the stuff you don't need to 
   worry about. And it's why you can do

	git diff --base/--ours/--theirs

   to see what the diffs of the conflicting files are wrt the versions 
   that got us there. Again, a big part of this is that the index tracks 
   *content* rather than some totally idiotic secondary notion that has 
   nothing to do with anything sane.

That's the three major reasons. The first one may not seem relevant to 
you, but when you start to understand that "content is the only thing that 
matters", you'll move to a whole new level. Not just in git, but in 
general. So the first argument is purely philosophical, but it's still 
important.

The two other rationales are purely practical. It's why git is simply 
_better_ than the alternatives. It's why git can do things that others 
cannot do, or that they have to do strange and weird things for, and git 
does totally naturally without having to even think about it.

A file-ID-based thing will always have fundamental problems with file ID 
clashes - issues that cause annoyances both small and big. Git just 
doesn't have that fundamental design bug.

> At first, I find it rather annoying. My usual workflow is

You'll just need to get used to it. The git way is actually much better. 
You'll get used to it quickly enough, but once you do, what's the problem 
with the workflow you already quote:

> <hack hack hack>
> % git status -a
> % git commit -a -m "..."

What's so hard with adding that "-a" to "git commit"? You don't even need 
it on the status line, the status is relevant and understandable (and 
actually tells you more) even without it.

> In the former case, I have more commands to type, and in the second
> case, I loose part of the stat-cache benefit: If I run "git status -a"
> twice, the second run will actually diff all the files touched since
> the last run, since "git status -a" actually updated a temporary
> index, and discarded it afterwards, so it doesn't update the stat
> information in the index (while "git status" would have).

WHY do you care?

Git is still about an order of magnitude faster than anything that you can 
compare with, so I really don't see what you're complaining about?

You seem to be complaining about the fact that:

 - git does extra and unnecessary work when you give it an extra and 
   unnecessary flag (the "-a" to "git status".

 - despite the fact that you can make git do unnecessary things, I can 
   pretty much guarantee that your workflow is still faster with git than 
   with pretty much anything else, so why complain?

So both of your complaints seem to be a bit pointless to me. But the real 
answer really is:

 - git does things better, and the git approach actually allows you a 
   better workflow. Now, admittedly that better workflow is especially 
   notable when you have a merge conflict or other nastier situation and 
   not as obvious when you just don't do anything exciting, but it's 
   actually also more *logical* even in the absense of any merge issues 
   (ie the whole "content vs filenames" issue).

 - but git doesn't *force* that better workflow, and you can always just 
   use "git commit -a" to emulate the stupidity that is CVS and SVN. 

Basically, I use the "git commit -a" for all the trivial cases, but 
equally often I carry around independent changes in my tree (often for 
long times - right now my tree has some experimental stuff I haven't 
committed yet in fs/ext3/ialloc.c for example) and I work with a dirty 
tree and commit and change _parts_ of it. And then the "-a" thing is 
wrong, and having it as the default would just cause mistakes.

So git really does the right thing, for so many reasons. But yeah, the 
right thing is different from what CVS does. 

(That statement is so true that it basically could be used ass a 
definition of CVS: "tThe right thing is different from what CVS does" is 
not about the index, it's about almost _everything_)

		Linus
