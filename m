From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/6] Initial subproject support (RFC?)
Date: Tue, 10 Apr 2007 08:13:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704100758430.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0704092133550.6730@woody.linux-foundation.org>
 <81b0412b0704100604x2841d96aq194d3dedd303c588@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 02:11:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbI35-0004PJ-FA
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 17:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030735AbXDJPOG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 11:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030795AbXDJPOG
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 11:14:06 -0400
Received: from smtp.osdl.org ([65.172.181.24]:60500 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030735AbXDJPOE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 11:14:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3AFDxPD013133
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Apr 2007 08:13:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3AFDwns010311;
	Tue, 10 Apr 2007 08:13:58 -0700
In-Reply-To: <81b0412b0704100604x2841d96aq194d3dedd303c588@mail.gmail.com>
X-Spam-Status: No, hits=-0.958 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44153>



On Tue, 10 Apr 2007, Alex Riesen wrote:
> 
> The other thing which will be missed a lot (I miss it that much)
> is a subproject-recursive git-commit and git-status.

Note that I was definitely planning on adding them too, but they are at a 
higher level. 

So the long-term plan is/was to add a flag to "git diff" (and "git 
ls-tree" etc) to say "recurse into subprojects".

You cound perhaps even make that flag the default with some .git/config 
option, if your superproject is small enough.

But this series of 6 (and the seventh ugly hack) is literally meant for 
just the really core object-handling stuff, and even there it's not really 
complete.

For example, you cannot even clone a superproject yet, simply because 
git-upload-pack doesn't know that it's not supposed to follow the gitlink 
things etc. So there's a lot of details left even for the really *core* 
stuff, but I wanted to post the series of six patches because those six 
patches are actually enough to reach the point where you can start looking 
at individual problems (like "git upload-pack") and fix them 
incrementally.

So I'd like this to be merged somewhere, not because "it works" or "it's 
complete", but because it's in a shape where I think a lot of people can 
start fixing small details. 

For example, with just two smallish updates:
 - teach "git upload-pack" not to try to follow gitlinks
 - teach "git read-tree" to check out a git-link as just an empty 
   subdirectory
you should already be pretty close to being able to clone a superproject. 
You'd still have to clone the subprojects one-by-one manually, and that 
would be more of a porcelain'ish issue to teach git clone to fetch 
submodules too (with some ".gitmodules" file that contains the rules for 
that!)

But no, I didn't do any of that. I literally did just the "tree object 
format change" to support the *notion* of gitlinks - not all the pieces to 
then actually *implement* the notion are done by a long shot.

I think everybody agrees that we need some kind of subproject support, and 
the KDE repository certainly shows that subprojects need to be truly 
independent (because if they aren't, you end up with all the scaling 
issues that we see now - including something as simple as just "fsck" 
taking way way too long unless you have 4GB of RAM or more), and this sets 
the basic rules for that.

But they really are pretty low-level rules. For example, to go back to the 
KDE thing: we'd also need to teach *importers* to import certain 
subdirectories as submodules (or have a git->git translator that turns a 
subdirectory into a separate submodule).

So those are examples of things that obviously need to be done, and that 
my patches do not address in *any* way. They are really low-level plumbing 
support, kind of like the old original days when you had to run 

	git-update-index ...
	tree=$(git-write-tree)
	commit=$(git-commit-tree -p $parent $tree <$msgfile)

by hand. A few monts later it was "git commit -a", but it started out 
with just fairly low-level plumbing..

		Linus
