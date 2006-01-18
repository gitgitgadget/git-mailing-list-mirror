From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Joining Repositories
Date: Wed, 18 Jan 2006 10:22:02 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601181010410.3240@g5.osdl.org>
References: <200601181325.59832.Mathias.Waack@rantzau.de>
 <20060118125158.GN28365@pasky.or.cz> <20060118140917.GA15438@mythryan2.michonline.com>
 <Pine.LNX.4.64.0601180813170.3240@g5.osdl.org> <7vbqy9xx2r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 19:22:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzHwi-0002sB-IW
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 19:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWARSWJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 13:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbWARSWJ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 13:22:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19675 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964903AbWARSWH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 13:22:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0IIM3DZ017971
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Jan 2006 10:22:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0IIM29A015669;
	Wed, 18 Jan 2006 10:22:03 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqy9xx2r.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.66__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14852>



On Wed, 18 Jan 2006, Junio C Hamano wrote:
> 
> Tracking history across renames is something we have only half
> of the needed support.  We can notice rename points but there is
> no way to tell our usability tools to automatically follow it.
> IOW "whatchanged r1/hello.c" will stop at the point the
> original project renamed hello.c

Note that "whatchanged" really really _really_ must not follow renames.

Why? The whole _point_ of whatchanged is that it takes a path limiter. A 
path limiter is much more useful (to me) that following files. A path 
limiter works even when the file doesn't _currently_ exist, and you don't 
know what happened to it. A path limiter also fundamentally works for 
directories and for multiple files.

If you want "git annotate", then do a "git annotate". Don't change what 
"git whatchanged" does. The "pathname only" behaviour is in my opinion THE 
MOST SINGLE BIGGEST FEATURE of git.

I _much_ more often use a directory to "git-whatchanged" than I look at an 
individual file. Maybe other people don't do that, because they don't tend 
to look at the "big picture", or because they are stuck in the "single 
file only" mentality, but trust me, especially for maintaining big things, 
the "track directories" is a lot more important than single-file tracking. 

A _LOT_ more.

I realize that this is heresy to people who are used to "annotate" and 
want to follow not the path, but the "conceptual inode", but the thing is, 
paths really really are a lot more important to a maintainer. Following an 
individual file is a secondary issue.

Now, the fact that we still don't have an efficient "git annotate" is not 
because we don't have the capability. It _should_ be perfectly easy to do 
(and efficient) by just parsing the output of

	git-rev-list HEAD -- <filename>

and when you see a "delete" event, you'd look if it was really a rename.

I think qgit does this, but we don't have the textual version in core git.

So the reason core git tracks PATHNAMES and not files is:

 - it's fundamentally a much more powerful operation

 - it's possible (and not that much harder) to track renames efficiently 
   using it anyway, so you can emulate the "track file" behaviour using 
   "track pathname", but you can NOT emulate it the other way around.

In other words, tracking pathnames is really _fundamentally_ a more 
powerful operation.

Git does this right. It is - together with multiple branches - the thing 
that makes git work better than BK did for me.

> > suggest just something like
> >
> > 	git clone oldrepo r1
> > 	cd r1
> > 	git checkout -b join-branch
> > 	cd ..
> > 	git add r1/.git/refs/heads/join-branch
> > 	git commit -m "Join repo 'oldrepo' at 'r1'"
> >
> > which should actually work except for the fact that we don't like the 
> > ".git" component even as part of a sub-component (ie small hack to git 
> > required to make it not ignore that path).
> 
> Sorry you lost me with this.  The "join-branch" is a file with
> commit object name in it, so is this "recording the revision of
> the other project this particular version of the project is
> linked to" idea?

Yes. It also means that if you update the other project (commit, pull, 
whatever), "git diff" in the top level will do the right thing: it won't 
be readable, but you'll always have the SHA1 visible, and you can "commit" 
the fact that you updated the sub-project in the top project. It's 
basically a poor mans "gitlink".

		Linus
