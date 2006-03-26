From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Following renames
Date: Sun, 26 Mar 2006 10:10:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603260947100.15714@g5.osdl.org>
References: <20060326014946.GB18185@pasky.or.cz> <7virq1sywj.fsf@assigned-by-dhcp.cox.net>
 <e06fl8$p9f$1@sea.gmane.org> <Pine.LNX.4.64.0603260843250.15714@g5.osdl.org>
 <e06hts$1ne$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 20:12:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNZhk-0001RW-3A
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 20:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWCZSLE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 13:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWCZSLD
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 13:11:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33478 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932261AbWCZSLA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 13:11:00 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2QIAvDZ028808
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Mar 2006 10:10:57 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2QIAueW013474;
	Sun, 26 Mar 2006 10:10:56 -0800
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e06hts$1ne$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18051>



On Sun, 26 Mar 2006, Jakub Narebski wrote:
> 
> If (2) is common enough then discussed improvements to rename detection, 
> namely comparing basenames as a base for candidate selection is a good idea.

BK had this "renametool" which got started automatically when you applied 
a patch that removed one or more files and added one or more files, so 
that you could then pair up the files manually.

It left the rename pairing 100% to the user, but it helped a bit by 
guessing what the pairing might be, and yes, it used the basenames to set 
up that initial guess.

It worked in many cases, but it also failed in many cases. I do think it 
was a useful heuristic within the BK model (since the _real_ choice was 
left to the user), but I don't think it's very useful for git.

The thing is, the fast rename detection that is in the "next" branch 
really does a lot better, and it's fast enough.

(If you wanted to make it even faster, but less precise, you could limit 
it to the first few kilobytes of file contents - still a _lot_ better 
heuristic than the actual filename, and it would make the worst-case 
behaviour much better).

> I wonder how common is (2) compared to (1)+(2) i.e. move to other dir 
> and rename, old-dir/old-file.c to new-dir/new-subdir/new-file.c

I don't have any numbers, but from usign renametool for a few years, my 
gut feel/recollection is that about half of renames in the kernel were 
moving to a new directory, and about half changed names (often in 
_addition_ to moving). But I didn't much think about it, so that's just a 
very rough guess based on using a tool that helped you do these things 
manually.

For example, one common case was a directory structure like

	..
	type-file1.c
	type-file2.c
	otherfiles.c
	yet-more.c
	..

being split up into a subdirectory

	..
	type/file1.c
	type/file2.c
	otherfiles.c
	yet-more.c
	..

(eg drivers/scsi/aic7xx-* being given a subdirectory of it's own, as 
drivers/scsi/aic7xx/*). So the basename wouldn't stay the same, because it 
contained some piece of data that became redundant with the move.

> >> 3.) splitting file into modules, huge-file.c to file1.c, file2.c?
> >> 4.) copying fragment of one file to other?
> >> 5.) moving fragment of code from one file to other?
> > 
> > I'd say that (5) is very common. And (4) happens a lot under certain
> > circumstances (new driver, new architecture, new filesystem..).
> > 
> > Doing (3) happens, but probably less often that it should ;/
> 
> Detecting (4) and (5) fast (i.e. for merges) without auxilary (helper) 
> information would probably be hard. For interrogation/porcellanish commands
> (like pickaxe) would probably be easier.

Yes. I don't think we necessarily want to merge automatically across 
things like that, even if it sounds like something you'd want in a perfect 
world. Stupid and obvious (and fails) is often better than smart and 
complex (and succeeds), because at least you _understand_ what happens. 

But _following_ a particular change back is important, and should be both 
efficient and simple to do. Ie the example tool I talked about in

        http://article.gmane.org/gmane.comp.version-control.git/217

is still relevant and important, I think.

I literally think that people wouldn't even _want_ a "git annotate", if 
they instead had more of a visual tool that showed the current state of 
the file, and you could click on a line/set of lines to follow it back to 
the previous change to that area. I'd argue that almost always when you 
want "annotate", you already have the particular place that you want to 
look at in mind (you're really not interested in the whole file).

So wouldn't it be _much_ nicer to have a "graphical git-whatchanged", 
where you just delve deeper (and you don't even look at the whole file 
like git-whatchanged does, but you ask for a very particular region).

Ie, what I imagine would be something gitk/qgit like, where you see the 
file content, select a line or two (or a whole function), and it goes back 
in history and shows you the last diff that changed that 
line/two/function. We can do that EFFICIENTLY. Much more efficiently than 
git-annotate, in fact. And then when you see the diff, you might say "I'm 
not interested in this one, that was just a re-indent" and then continue 
back. 

THAT is the kind of graphical tool I'd want. And dammit, it should even be 
_easy_. I'm just a total clutz myself when it comes to doing things like
QT or nice tcl/tk text-panes, and this really does have to be visual, 
since the whole point is that "select text" and interactive part.

So if somebody wants to be a hero, and feels comfortable with those kinds 
of things, this really should be a fairly straightforward thing to do (it 
would be useful even without rename detection or data movement detection, 
but it's also something where you really _could_ do efficient data 
movement detection by just looking at the "whole diff" when something 
changed in that small area).

		Linus
