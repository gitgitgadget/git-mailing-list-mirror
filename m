From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: Subprojects
Date: Sat, 14 Jan 2006 11:16:34 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>
References: <43C52B1F.8020706@hogyros.de>
 <Pine.LNX.4.63.0601111740220.17966@wbgn013.biozentrum.uni-wuerzburg.de>
 <43C537C9.4090206@hogyros.de> <Pine.LNX.4.64.0601110928350.5073@g5.osdl.org>
 <7vacdzkww3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Simon Richter <Simon.Richter@hogyros.de>
X-From: git-owner@vger.kernel.org Sat Jan 14 20:17:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Exqtl-00069C-E4
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 20:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWANTRK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 14:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWANTRK
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 14:17:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19926 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750755AbWANTRI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jan 2006 14:17:08 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0EJGaDZ012384
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 14 Jan 2006 11:16:37 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0EJGYKO011825;
	Sat, 14 Jan 2006 11:16:34 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacdzkww3.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.65__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14672>



On Sat, 14 Jan 2006, Junio C Hamano wrote:

>  + The contained project is kept totally independent and does
>    not have to know it is contained.
> 
>  + The tree for the contained project can be rooted anywhere in
>    the containing project's tree.

Right.

>  - The contained project cannot be rooted at the same level or
>    higher than the containing project; the containing project
>    can only delegate a whole subdirectory to the contained
>    project.

Yes.

However, I think this is actually a _huge_ advantage.

The thing is, if you do the contained projects as "union projects" as you 
suggest, I will bet that it will really really suck, because it ends up 
losing the two positives above.

In particular, any real independent project will have it's own "Makefile" 
or "configure-in", and often its own "src" subdirectory or other 
pseudo-standard names.

And the "contained project as a link" approach has zero problems with that 
at all, exactly because it keeps the projects clearly separate - just 
linked (one way).

> What does "git-diff-index/git-diff-tree/git-diff-files" would do
> with them?

I would actually argue that git itself wouldn't do a whole lot with them. 
There are real advantages to seeing only the diffs wrt _one_ of the 
projects, and I'd argue that

	git-diff-*

would actually act like they now act for directories that they don't 
recurse into, ie you'd see something like

	:160000 160000 5eb57670... 3f1a42aa... M	sub-project

and it would be up to higher-level porcelain to recurse.

Why? Partly because that's actually likely enough for a lot of users: you 
_can_ use just the raw git programs by just doing

	cd sub-project
	git diff
	..
	git commit

and so technically you aren't really missing a lot. The capabilities are 
there, you just have to do some more by hand (but in many ways that is 
_good_: it makes it obvious that you're really committing a _different_ 
subproject).

The other reason? A lot of the git infrastructure really does only work on 
the "one project" level. The programs work with _one_ index, not two. 
Reading two trees is perfectly possible, but unless you keep them in 
separate stages, you can't separate them afterwards. IOW, trying to be 
recursive really does end up being a big change, for very little gain (and 
for a lot of potential bugs and instability).

In contrast, doing it at a higher level means that you have a simple and 
reliable lower level that you can trust. Layering is good.

> Fetching/cloning at the core level is easy.  "git-fetch-pack"
> would just need to do one level, but Porcelains need to address
> how to actually arrange the subprojects cloning to happen, which
> is harder.
> 
> "git clone" would say: "Ah, now I see these gitlinks; we need to
> clone them.

Actually, I would say no - that's actually not a "clone" operation so much 
as a "checkout" operation. There are strong arguments that you should 
_not_ clone sub-projects when you clone the top-level project: there's no 
reason to. Anybody else who clones it will have all the information you 
have, so cloning th esub-project is just extra work.

So only if you actually check it out (which is often in practice the 
second stage of the cloning, of course) do you want to fetch the 
subproject too. But even then you might want to ask the user (he may have 
a local repository for that sub-project somewhere else, so going to the 
"canonical name" might be the wrong thing to do - and he might not even 
care, because he might want to work _just_ on the top-level project).

> Now I'll think aloud about a completely different design.
> 
> We could simply overlay the projects.  I think this is what
> Johannes suggested earlier.
> 
> You keep one branch for each "subproject", and make commits into
> each branch (i.e. if you modified files for the upstream kernel,
> the change is committed to the branch for linux-2.6 subproject),
> but when checking things out, you do an equivalent of octopus
> merge across subprojects.

I think this one has serious disadvantages:

 - it's much less obvious when there are common names and especially 
   common subdirectories.
 - in _practice_, almost all sub-projects are kept in sub-directories. Are 
   you doing to change the sub-project git tree? How are you going to 
   merge back to the original sub-project?
 - iow, I think this only works for sub-projects that are totally 
   controlled by the top-level project - in which case they might as well 
   just be totally merged into the top level (the way we did with the 
   "tools" project, and largely with "gitk").

in the "gitk" case, we could actually continue to keep gitk a separate 
project, but that was really fortunate: it's purely because gitk ends up 
being a single file, with no Makefile at all to build it independently 
etc. The moment we integrated the "tools" sub-project into git, we lost 
the ability to do that, exactly because they now needed to share Makefiles 
etc, making all further development very inter-twined.

Put another way: the moment you have linkages going both ways between the 
subproject and the top-level project, it's no longer two separate 
projects. At that point, it in practice becomes one, since the sub-project 
can no longer do independent development without merging becoming a big 
issue.

The advantage of having a "git link" is exactly the fact that the 
dependency goes only one way. The subproject remains truly independent.

			Linus
