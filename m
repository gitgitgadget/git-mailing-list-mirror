From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Convert emailing part of hooks--update to hooks--post-receive
Date: Sat, 24 Mar 2007 09:12:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703240858370.6730@woody.linux-foundation.org>
References: <200703231023.58911.andyparkins@gmail.com>
 <7vlkhmg6c3.fsf@assigned-by-dhcp.cox.net> <200703241550.05590.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 17:12:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HV8rD-0007ri-9W
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 17:12:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152AbXCXQMg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 12:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753160AbXCXQMg
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 12:12:36 -0400
Received: from smtp.osdl.org ([65.172.181.24]:43317 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753152AbXCXQMf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 12:12:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2OGCT1o031921
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 24 Mar 2007 09:12:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2OGCSwN009163;
	Sat, 24 Mar 2007 09:12:29 -0700
In-Reply-To: <200703241550.05590.andyparkins@gmail.com>
X-Spam-Status: No, hits=-2.473 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43009>



On Sat, 24 Mar 2007, Andy Parkins wrote:
> 
> Oh dear; I had no idea that packed refs made the ref file itself 
> disappear.

Everybody should do

	git pack-refs --all --prune

occasionally to see this. In fact, I think we should probably make that 
part of "git gc" (which currently doesn't pack branches at all, just tags, 
since it omits the "--all").

> Would
> 
>  git-rev-parse $refname
> 
> Be a better way of getting the revision?

That's always the correct way to get a revision, although you should use

	git-rev-parse --verify "$refname"^0

to make sure that you get a commit (of course, if you don't want a 
commit, but any random ref-SHA1, remove the "^0" from the end!).

HOWEVER. "git-rev-parse" will take any arbitrary SHA1-expression, which 
may or may not be what you want. If you actually also want to verify that 
it's strictly a branch name (or other ref-name), rather than just a random 
SHA1 expression, you should do

	git show-ref [--verify] refname

where the "--verify" again enables strict checking. HOWEVER, it will not 
check that it's a commit, so if you need the resulting SHA1 to be of a 
specific type, you need to do that separately.

Side note: those two "--verify" calls do two different kinds of strict 
checking, because "show-ref" and "rev-parse" are different things. In 
"git-rev-parse" it checks that the argument is exactly *one* SHA1 value, 
and not some flag or a SHA1 range. Because "git rev-parse" can take a lot 
of different input formats. In contrast, in "git show-ref", the stricter 
checking enabled by "--verify" will just force it to not do any "pattern" 
for the ref, but it wants an *exact* refname.

		Linus
