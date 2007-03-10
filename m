From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Errors cloning large repo
Date: Fri, 9 Mar 2007 18:03:39 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703091800110.10832@woody.linux-foundation.org>
References: <20070309234846.7641.qmail@web52613.mail.yahoo.com>
 <Pine.LNX.4.64.0703091641460.10832@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Anton Tropashko <atropashko@yahoo.com>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 10 03:03:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPqw2-00036s-1n
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 03:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767719AbXCJCDp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 21:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767721AbXCJCDp
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 21:03:45 -0500
Received: from smtp.osdl.org ([65.172.181.24]:57004 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767719AbXCJCDo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 21:03:44 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2A23fo4024648
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Mar 2007 18:03:41 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2A23eDi008854;
	Fri, 9 Mar 2007 18:03:40 -0800
In-Reply-To: <Pine.LNX.4.64.0703091641460.10832@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.492 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41837>



On Fri, 9 Mar 2007, Linus Torvalds wrote:
> >
> > For some reason git add . swallowed the whole thing
> > but git commit did not and I had to split it up. I trimmed the tree a bit
> > since then by removing c & c++ files ;-)
> 
> Ok, that's a bit surprising, since "git commit" actually should do less 
> than "git add .", but it's entirely possible that just the status message 
> generation ends up doing strange things for a repository with that many 
> files in it.

Ahhh. Found it.

It's indeed "git commit" that takes tons of memory, but for all the wrong 
reasons. It does a "git diff-tree" to generate the diffstat, and *that* is 
extremely expensive:

	git-diff-tree --shortstat --summary --root --no-commit-id HEAD --

I suspect we shouldn't bother with the diffstat for the initial commit. 
Just removing "--root" migth be sufficient.

		Linus
