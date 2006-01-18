From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Joining Repositories
Date: Wed, 18 Jan 2006 08:23:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601180813170.3240@g5.osdl.org>
References: <200601181325.59832.Mathias.Waack@rantzau.de>
 <20060118125158.GN28365@pasky.or.cz> <20060118140917.GA15438@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>,
	Mathias Waack <Mathias.Waack@rantzau.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 17:26:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzG5h-00046Z-5C
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 17:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbWARQXS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 11:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbWARQXS
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 11:23:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33970 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030374AbWARQXR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 11:23:17 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0IGN4DZ010520
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Jan 2006 08:23:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0IGN3O7008109;
	Wed, 18 Jan 2006 08:23:03 -0800
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20060118140917.GA15438@mythryan2.michonline.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.66__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14835>



On Wed, 18 Jan 2006, Ryan Anderson wrote:
>
> Assuming both repositories are clean, no extraneous files, and without
> testing, of course:
> 
> In r1:
> 	mkdir r1
> 	# move everything into the subdirectory called r1.
> 	git mv $(ls -a | grep -v -e ^.git$ -e ^r1$) r1/
> 	git commit -a "Restructure directory"
> 
> In r2:
> 	mkdir r2
> 	# move all files into r2/
> 	git mv $(ls -a | grep -v -e ^.git$ -e ^r2$) r2/
> 	git commit -a "Restructure directory"
> 
> 	git fetch ../r1/
> 	GIT_INDEX_FILE=.git/tmp-index git-read-tree FETCH_HEAD
> 	GIT_INDEX_FILE=.git/tmp-index git-checkout-cache -a -u
> 	git-update-cache --add -- $(GIT_INDEX_FILE=.git/tmp-index git-ls-files)
> 	cp .git/FETCH_HEAD .git/MERGE_HEAD
> 	git commit
> 
> No history rewritten,

Right.

> merging with the old repositories should, at least theoretically, work, 
> etc.

No. This - and the history rewriting - both have a fundamental problem: it 
becomes totally impossible to merge back any changes of the subprojects, 
at least automatically. The renaming just ends up making pretty much any 
merge a manual affair (git can _help_, but it's going to be a matter of 
luck if it works or not - and it usually won't work very well, because 
you'll probably end up having files that have the same name in the new and 
the old repo, and eventually you'll just have tons of confusion).

So it works only if you want to _really_ join the projects (like in the 
"git tools" case), and never touch the old one again but it sucks 
otherwise.

In the "gitk" case, we could actually continue to merge stuff after a 
join, but that was largaly because there was no renaming. That's a very 
special case, and it also became impossible to merge back.

Now, let's see what Junio comes up with, but in the meantime, I'd almost 
suggest just something like

	git clone oldrepo r1
	cd r1
	git checkout -b join-branch
	cd ..
	git add r1/.git/refs/heads/join-branch
	git commit -m "Join repo 'oldrepo' at 'r1'"

which should actually work except for the fact that we don't like the 
".git" component even as part of a sub-component (ie small hack to git 
required to make it not ignore that path).

		Linus
