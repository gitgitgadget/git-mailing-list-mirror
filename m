From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-mailinfo doesn't get installed any more
Date: Fri, 24 Feb 2006 12:42:04 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602241224130.22647@g5.osdl.org>
References: <12c511ca0602241206jaea9f75pce4ca687f5b2fd3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 24 21:42:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCjlU-0001zh-5n
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 21:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWBXUmJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 15:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWBXUmI
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 15:42:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8141 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751086AbWBXUmH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 15:42:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1OKg4DZ013983
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 24 Feb 2006 12:42:05 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1OKg4Km006593;
	Fri, 24 Feb 2006 12:42:04 -0800
To: Tony Luck <tony.luck@intel.com>
In-Reply-To: <12c511ca0602241206jaea9f75pce4ca687f5b2fd3c@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16737>



On Fri, 24 Feb 2006, Tony Luck wrote:
> 
> 2) What's the cute 1-line git way to see when this was broken. I'm
> guessing that it involves using a --pickaxe.

You've actually found an interesting misfeature in git. There's a merge 
error, and you can't see it in the diffs by default because it wasn't due 
to a _clashing_ content thing, but two edits that were far enough away 
from each other.

That "git-mailinfo" thing is there in rev 2a3763ef, but it's not there in 
the current Makefile. And doing a

	git-whatchanged -p 2a3763ef.. | grep git-mailinfo

results in nothing. Which is not good.

Anyway, the way to handle that is to do "git bisect" (and use "grep 
git-mailinfo Makefile" in between bisection points to see if git-mailinfo 
is still part of the list of programs):

	git-bisect start
	# bad: [20d23f554d6cd40ffa0d41ccc9416bca867667e0] gitview: Bump the rev
	git-bisect bad 20d23f554d6cd40ffa0d41ccc9416bca867667e0
	# good: [2a3763ef3d26eb38c0a47997b8e5fd2a7c5214cc] avoid makefile override warning
	git-bisect good 2a3763ef3d26eb38c0a47997b8e5fd2a7c5214cc
	# bad: [ee072260dbff6914c24d956bcc2d46882831f1a0] Merge branch 'jc/nostat'
	git-bisect bad ee072260dbff6914c24d956bcc2d46882831f1a0
	# good: [551ce28fe1f2777eee7dd9c02bd44f55f4b32361] git-svn: 0.9.1: add --version and copyright/license (GPL v2+) information
	git-bisect good 551ce28fe1f2777eee7dd9c02bd44f55f4b32361
	# good: [5508a616631fb41531b638f744bd92c701727014] New test to verify that when git-clone fails it cleans up the new directory.
	git-bisect good 5508a616631fb41531b638f744bd92c701727014
	# bad: [712b1dd389ad5bcdbaab0279641f0970702fc1f1] Merge branch 'js/portable'
	git-bisect bad 712b1dd389ad5bcdbaab0279641f0970702fc1f1
	# good: [d800795613a710fb18353af53730e75185861f41] gitview: Use monospace font to draw the branch and tag name
	git-bisect good d800795613a710fb18353af53730e75185861f41
	# good: [b992933853ccffac85f7e40310167ef7b8f0432e] Fix "gmake -j"
	git-bisect good b992933853ccffac85f7e40310167ef7b8f0432e

resulting in:

	712b1dd389ad5bcdbaab0279641f0970702fc1f1 is first bad commit

which shows that there was a bad merge by Junio.

You can use

	git show -c -p 712b1dd389ad5bcdbaab0279641f0970702fc1f1

to see why. It merged the thing perfectly fine, but sadly, incorrectly. 

Somebody should probably look at whether we could have done things better, 
but I suspect that merge errors are inevitable with any automated process.

Anyway, it might be worth remembering that 712b1dd3 merge for future 
testing. Make a test-case out of it.

		Linus
