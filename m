From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: finding earliest tags descended from a given commit
Date: Fri, 26 Jan 2007 20:34:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701262022230.25027@woody.linux-foundation.org>
References: <20070127040618.GA14205@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sat Jan 27 05:34:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAfGs-00031E-Oo
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 05:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbXA0Ee2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 23:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbXA0Ee2
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 23:34:28 -0500
Received: from smtp.osdl.org ([65.172.181.24]:39715 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751714AbXA0Ee2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 23:34:28 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0R4YG1m028514
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 26 Jan 2007 20:34:16 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0R4YFhR002202;
	Fri, 26 Jan 2007 20:34:15 -0800
In-Reply-To: <20070127040618.GA14205@fieldses.org>
X-Spam-Status: No, hits=-0.528 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37917>



On Fri, 26 Jan 2007, J. Bruce Fields wrote:
>
> Just curious: every now and then somebody will ask me what kernel
> version they need to upgrade to to get some given fix.  I can find the
> commit with the given fix easily enough.  How do I then find the
> earliest tagged version containing that fix?

You can name any revision based on the set of tags you have with:

	git name-rev --tags <sha1-of-commit>

which will try to find the "simplest" way to name something by following 
one of your tags.

If no tag can be found that reaches that commit, it will say

	<sha1> undefined

but otherwise you will get something like this:

	[torvalds@woody linux]$ git name-rev --tags 7658cc28
	7658cc28 tags/v2.6.20-rc3^0~58

(That's the "VM: Fix nasty and subtle race in shared mmap'ed page 
writeback commit").

So that basically tells you that it's the 58'th parent of v2.6.20-rc3, ie 
it was in -rc3, but not in -rc2.

> I usually just do
> 
> 	git-describe <commit>
> 
> to make a guess, then
> 
> 	git log <tag>..<commit>

Yeah. That mostly works too, and kind of for the right reason: it's a 
related operation. But as you can tell, git-describe tells you which 
version somethign is *based* on, not when it was merged, so while it gives 
you a starting point for your search, it's not what you want.

Basically 'git descibe' goes the "other way": it walks backwards from the 
commit to the nearest tag that can be found, while 'git name-rev --tags' 
walks the history backwards from the tags, and tries to find the commit. 

NOTE! 'git name-rev' can in theory be quite expensive, although if you 
have a packed repository you'll probably never even notice it.

		Linus
