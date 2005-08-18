From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Teach applymbox to keep the Subject: line.
Date: Thu, 18 Aug 2005 13:07:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508181257320.3412@g5.osdl.org>
References: <20050816214707.6842.qmail@web26302.mail.ukl.yahoo.com>
 <7vek8t7bva.fsf@assigned-by-dhcp.cox.net> <7vk6il2jz8.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0508170830050.3553@g5.osdl.org> <20050818172646.GA18459@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 22:09:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5qgL-0004r7-FI
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 22:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbVHRUIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 16:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVHRUIG
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 16:08:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58603 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932409AbVHRUIF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2005 16:08:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7IK7pjA003516
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 18 Aug 2005 13:07:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7IK7gjT005023;
	Thu, 18 Aug 2005 13:07:47 -0700
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20050818172646.GA18459@mars.ravnborg.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 18 Aug 2005, Sam Ravnborg wrote:
> 
> I almost always handedit my mails and I find myself forgetting to add
> "Signed-off-by" from time to time.
> Is there a simple way to implment a trigger that can check that _I_
> signed off the patch before applying it?

Well, Junio has been talking about adding commit hooks. I don't think
that's been done. The idea being that you could verify that the thing 
you're committing follows certain rules (no bad whitespace added in the 
diff, sign-offs in the messages, whatever).

That said, git-applypatch (which is what git-applymbox ends up calling) 
does not use the general "git commit" script. So it would have to have its 
own hook. The script is pretty easy to read, though: just look at 
git-applypatch, and notice that the last stages are:

	...
	git-apply --index $PATCHFILE || exit 1
	tree=$(git-write-tree) || exit 1
	echo Wrote tree $tree
	commit=$(git-commit-tree $tree -p $(cat .git/HEAD) < $final) || exit 1
	echo Committed: $commit
	echo $commit > .git/HEAD

and that just before this thing you could easily add some sanity checking 
by hand. The commit message at that point is in the "$final" file, and the 
patch is obviously in $PATCHFILE, so you can verify either of those to 
your hearts content.

The only question is what the hook/trigger should look like. just put
something like

	[ -x .git/hooks/applypatch-hook ] &&
	     .git/hooks/applypatch-hook "$tree" "$PATCHFILE" || exit

at the line before that "git-apply" perhaps? Then, you could install your 
own applypatch hook which looks at the message or the patch?

		Linus
