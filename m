From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling renames.
Date: Thu, 14 Apr 2005 11:11:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504141102430.7211@ppc970.osdl.org>
References: <1113501260.27227.26.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, James Bottomley <James.Bottomley@SteelEye.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 20:08:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM8kE-0003px-Nb
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 20:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVDNSKb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 14:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVDNSKb
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 14:10:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:42952 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261582AbVDNSKD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 14:10:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3EI9us4026497
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Apr 2005 11:09:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3EI9tmg009735;
	Thu, 14 Apr 2005 11:09:55 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1113501260.27227.26.camel@hades.cambridge.redhat.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 14 Apr 2005, David Woodhouse wrote:
>
> I've been looking at tracking file revisions. One proposed solution was
> to have a separate revision history for individual files, with a new
> kind of 'filecommit' object which parallels the existing 'commit',
> referencing a blob instead of a tree. Then trees would reference such
> objects instead of referencing blobs directly.

Please don't.  It's fundamentally the git notion of "content determines
objects".

It also has no relevance. A "rename" really doesn't exist in the git 
model. The git model really is about tracking data, not about tracking 
what happened to _create_ that data.

The one exception is the commit log. That's where you put the explanations 
of _why_ the data changed. And git itself doesn't care what the format is, 
apart from the git header.

So, you really need to think of git as a filesystem. You can then 
implement an SCM _on_top_of_it_, which means that your second suggestion 
is not only acceptable, it really is the _only_ way to handle this in git:

> So a commit involving a rename would look something like this...
> 
> 	tree 82ba574c85e9a2e4652419c88244e9dd1bfa8baa
> 	parent bb95843a5a0f397270819462812735ee29796fb4
> 	rename foo.c bar.c
> 	author David Woodhouse <dwmw2@hades.cambridge.redhat.com> 1113499881 +0100
> 	committer David Woodhouse <dwmw2@hades.cambridge.redhat.com> 1113499881 +0100
> 	Rename foo.c to bar.c and s/foo_/bar_/g

Except I want that empty line in there, and I want it in the "free-form"  
section. The "rename" part really isn't part of the git header. It's not 
what git tracks, it was tracked by an SCM system on top of git.

So the git header is an "inode" in the git filesystem, and like an inode 
it has a ctime and an mtime, and pointers to the data. So as far as git is 
concerned, this part:

	tree 82ba574c85e9a2e4652419c88244e9dd1bfa8baa
	parent bb95843a5a0f397270819462812735ee29796fb4
	author David Woodhouse <dwmw2@hades.cambridge.redhat.com> 1113499881 +0100
	committer David Woodhouse <dwmw2@hades.cambridge.redhat.com> 1113499881 +0100

really is the filesystem "inode". The rest is whatever the filesystem user
puts into it, and git won't care.

> Opinions? Dissent? We'd probably need to escape the filenames in some
> way -- handwave over that for now.

The fact that git handles arbitrary filenames (stuff starting with "." 
excepted) doesn't mean that the SCM above it needs to. Quite frankly, I 
think an SCM that handles newlines in filenames is being silly. But a 
_filesystem_ needs to not care.

There are too many messy SCM's out there that do not hav ea "philosophy". 
Dammit, I'm not interested in creating another one. This thing has a 
mental model, and we keep to that model.

The reason UNIX is beautiful is that it has a mental model of processes 
and files. Git has a mental model of objects and certain very very limited 
relationships. The relationships git cares about are encoded in the C 
files, the "extra crap" (like rename info) is just that - stuff that 
random scripts wrote, and that is just informational and not central to 
the model.

		Linus
