From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Something wrong with pickaxe?
Date: Wed, 18 Jan 2006 15:55:13 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601181541150.3240@g5.osdl.org>
References: <Pine.LNX.4.63.0601190004130.15298@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 00:55:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzN98-0002dC-CA
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 00:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030466AbWARXzT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 18:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030467AbWARXzS
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 18:55:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12755 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030466AbWARXzR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 18:55:17 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0INtEDZ004827
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Jan 2006 15:55:14 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0INtDNB006988;
	Wed, 18 Jan 2006 15:55:14 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0601190004130.15298@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.66__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14871>


On Thu, 19 Jan 2006, Johannes Schindelin wrote:
> 
> it is a fact that I'm stupid, but in this case it might be a bug, too. 
> When I call
> 
> 	git-whatchanged -Sget_remote_heads 1baaae5e fetch-pack.c
> 
> the first shown commit is d1c133f5. However, if I substitute the 
> "-Sget_remote_heads" by "-p" I see that the diff of commit 1baaae5e *does* 
> change a line containing that text.
> 
> What am I doing wrong?

Nothing. But pickaxe really has very strange semantics, which imho makes 
it much less useful than it could be.

What pickaxe ends up doing is to literally see if the original has that 
string, and the result does not. I think it _counts_ the number of 
occurrences of a string in the before/after situation, and if the count 
differs, it's considered interesting.

So yes, there's a commit that has "get_remote_heads" as part of the 
change, but that particular string did not actually change in that commit: 
_other_ stuff on the same line did change. That particular string existed 
both before and after.

So when you use pickaxe, you really want to match the whole line you're 
looking for - otherwise you'll only see when people add or remove a 
particular string, not when they change things around it. Even then, if 
that particular line gets _moved_ (but otherwise is unchanged) pickaxe 
won't pick it up.

So you could have done a more exact search:

    git-whatchanged -p \
	-S"get_remote_heads(fd[0], &ref, nr_match, match, 1);" \
	1baaae5e fetch-pack.c

would have found where that particular line was introduced (and deleted).

Me, I find the pickaxe semantics so non-intuitive that I never use it 
(that said, the counting begaviour is better than what it _used_ to be, 
which, if I recall correctly, was just "it existed before, doesn't exist 
now").

I at one point suggested to Junio that the semantics be something else 
("mark the source and destination within 'x' characters of an occurrence 
of that string, and then if the _delta_ touches any of the marked areas, 
consider it to be a hit") but I think the problem was simply that it's 
more complex. You have to look at the ranges that the delta actually 
touches, which is more work than just looking at the original and final 
file contents themselves.

I suspect (but can't speak for him, obviously) that Junio would be open to 
more friendly pickaxe semantics if the suggested semantics change was 
accompanied by an actual diff to implement them.

In the meantime, you really need to think carefully about what you're 
doing when you use "-S". 

		Linus
