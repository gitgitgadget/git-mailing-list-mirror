From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] introduce GIT_WORK_DIR environment variable
Date: Sun, 11 Mar 2007 13:37:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703111326170.9690@woody.linux-foundation.org>
References: <20070311043250.GA21331@moooo.ath.cx> <7vabykxs15.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Lederhofer <matled@gmx.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 21:37:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQUnO-0001lt-OF
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 21:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbXCKUhb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 16:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752382AbXCKUhb
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 16:37:31 -0400
Received: from smtp.osdl.org ([65.172.181.24]:57609 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261AbXCKUha (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 16:37:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2BKbOo4011062
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Mar 2007 13:37:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2BKbNng019209;
	Sun, 11 Mar 2007 12:37:23 -0800
In-Reply-To: <7vabykxs15.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.987 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41978>



On Sat, 10 Mar 2007, Junio C Hamano wrote:
> Matthias Lederhofer <matled@gmx.net> writes:
> > Idea:
> > Add some way to configure tho working directory for one repository
> > and set GIT_WORK_DIR automatically when GIT_DIR is used.  I think of:
> >  * a subdirectory in the repository directory
> >    e.g. .git/work_dir which is supposed to be a symlink (or a textfile
> >    containing the path for windows compatibility?)
> > or
> >  * a configuration variable
> 
> I am not sure why you bother.  Obviously I am missing a few
> useful use cases you and Nguyen have in mind.

I actually like this feature. Let me explain why I think it's a great 
feature:

> But either .git/work_dir or a configuration means you are
> linking a repository with a _single_ working tree, permanently.
> If you are permanently linking one repository with a _single_
> working tree, is it too much bother to have that repository at
> the usual $GIT_TOP_DIR/.git like everybody else?

I'll tell you why: it makes tons of sense to have the git repository 
linked to exactly one working tree, *but the reverse is not necessarily 
always true*!

In other words, it can be a 1:n relationship.

You can have one working tree that is related to *multiple* git 
repositories.

That sounds insane, but I actually think it works, and makes tons of 
sense. Think something as simple as your own home directory.

It's possible that you want to track your music collection with git, but 
say that your music collection is a few different subdirectories or files 
in your home directory: maybe you track your "Music" directory (which 
contains the actual mp3 files or whatever), but maybe you'd like the same 
repository to *also* track things like your configuration file for 
whatever mp3-player you're using (".xmms"? Whatever).

So let's say that you have a git repository for tracking all that. The 
"working tree" for that git repository would be your home directory.

Now, imagine that you *also* want to track something else in git, that you 
*also* have in your home directory. Say your ".bashrc" files etc. They 
have nothing to do with your music tracking setup, so you don't want to 
track it in the same git repository, and you want to have a totally 
different .git/index file for those. But again, the *working*tree* is 
actually your home directory.

So allowing you to set the working tree associated with a particular git 
repository actually solves that problem. They can both share the same 
working tree (you'd want to track disjunct parts of the working tree, of 
course), which means that the working tree obviously does *not* want to 
have a .git/ directory in it. And to track your music changes, you'd just 
do

	cd music-repository
	git add music/
	git commit

to add any new files, and you'd be all set (or something like this).

There are other cases than just your home directory where you might want 
to track disjoint filesets in different git repositories. Things like /etc 
fall under the same "many unrelated things in the same working tree" 
setup.

So I actually think it makes tons of sense to allow a way to set the 
working tree for a git repository, and go the other way.

		Linus
