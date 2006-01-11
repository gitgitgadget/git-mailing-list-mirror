From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: Subprojects
Date: Wed, 11 Jan 2006 09:42:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601110928350.5073@g5.osdl.org>
References: <43C52B1F.8020706@hogyros.de>
 <Pine.LNX.4.63.0601111740220.17966@wbgn013.biozentrum.uni-wuerzburg.de>
 <43C537C9.4090206@hogyros.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 18:43:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewjzx-0005Gg-NJ
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 18:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbWAKRmz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 12:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbWAKRmz
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 12:42:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36232 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751536AbWAKRmx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2006 12:42:53 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0BHgkDZ026093
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 11 Jan 2006 09:42:46 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0BHgi01029949;
	Wed, 11 Jan 2006 09:42:45 -0800
To: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <43C537C9.4090206@hogyros.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14492>



On Wed, 11 Jan 2006, Simon Richter wrote:
> 
> The important thing for me is that I need to be able to transfer them easily,
> or turn a subdirectory into a subproject or vice versa.

Turning a _snapshot_ of a subproject into a subdirectory is easy: you can 
literally just create a subdirectory, copy it there, and it will re-use 
all the objects that the subproject uses (ie the top-level project will 
have a "tree" entry that just points to the same tree entry as the 
top-level commit in the sub-project).

However, while that works as a way to import snapshots, it doesn't work in 
any other way. It allows you to share objects with the "real project", and 
it's space-efficient etc, but there's no shared history, and you cannot 
merge back-and-forth, which is probably what you really want to do.

Quite frankly, you really probably want more of a "git-aware symlink" kind 
of thing. I'd really hesitate (in fact, I'd object) to re-use the existing 
"tree" type for it, but you're not the only one to have asked for 
subproject support, so this is clearly not a odd request.

> > Sorry, we discussed similar things already. It is not necessary to change
> > the structure. Even more: it makes no sense. Why would you want to have two
> > or more commit messages for the same revision?
> 
> Because the commit affects both the subproject and the master project.

What we _could_ do is for you to first do a commit in the "independent" 
subproject (it really would be a totally independent git repository in all 
ways: you could continue to merge it with other subprojects of the same 
type), and then you could commit a new pointer to that subproject in the 
master project. 

The two would really be fundamentally independent: they'd be two different 
git projects, one would just have a strange kind of "symlink" to the 
other, which would include a name and the top commit SHA1 of the other 
project.

Getting everything to work reasonably seamlessly would be potentially 
painful (getting "git diff" to recurse into the subdirectory correctly is 
non-trivial: you'd have a separate ".git/index" file for it), but it 
sounds doable.

I'd suggest adding a new kind of object ("gitlink") which has some 
well-specified format (20-byte SHA1 + ASCII C string "name" - the name 
translation to external repository would be done in the .git/config file 
of the "outer" project). Then a special file mode to indicate that in the 
"struct tree", and support for "git-update-cache" to understand how such 
an object is really tied into the "<pathname>/.git/HEAD" file rather than 
the rest of the directory contents.

Then a "git fetch" would have to be taught to recursively fetch the other 
subproject when the "gitlink" changes.

It should be doable: somebody could try to implement a rough first draft 
(maybe not very seamless at first).

		Linus
