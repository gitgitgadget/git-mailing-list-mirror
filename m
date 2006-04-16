From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: path limiting broken
Date: Sun, 16 Apr 2006 10:51:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604161034290.3701@g5.osdl.org>
References: <Pine.LNX.4.63.0604161411120.15345@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604160850230.3701@g5.osdl.org>
 <Pine.LNX.4.63.0604161905010.18184@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 19:52:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVBPi-0003xO-Fn
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 19:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWDPRvz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 13:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWDPRvz
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 13:51:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38786 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750786AbWDPRvy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 13:51:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3GHpptH006902
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 16 Apr 2006 10:51:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3GHpoqd011299;
	Sun, 16 Apr 2006 10:51:50 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0604161905010.18184@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18796>



On Sun, 16 Apr 2006, Johannes Schindelin wrote:
> 
> just to make it clearer what I want:
> 
> 	git-whatchanged -p next | grep parse_whatchanged
> 
> as well as
> 
> 	git log -p next | grep parse_whatchanged
> 
> do not find that any line like
> 
> 	int parse_whatchanged_opt(int ac, [...]
> 
> was removed, but they find that this line was added. However, in the 
> working tree (which has a fresh checkout of next), there is no such line 
> in log-tree.c. So I really would like to know where it vanished!

It was removed by merge 43f934aa: "Merge branch 'lt/logopt' into next".

The "parse_whatchanged_opt()" function never existed in that lt/logopt 
branch, and merging it (manually, I assume) it doesn't exist in the result 
either.

General hint: if you don't find it in "--cc", then that means that it's 
almost certainly a merge. "--cc" will only find things that _clash_, ie 
the end result is different from either of the branches (and in this case, 
it wasn't different, since parse_whatchanged_opt() simply didn't exist in 
the branch that was merged).

Now, finding things in merges can be a bit painful, but the sure-fire safe 
way is the old one: use "-m -p" to show _all_ sides of a merge as a diff. 
That's a really inconvenient format for reading, but it literally shows 
all changes to all parents.

Again, "git log log-tree.c" actually does do the right thing: the current 
state of "log-tree.c" really has _all_ of its history coming from the 
lt/logopt branch, which is why when you do

	git log -m -p log-tree.c | grep int parse_whatchanged_opt

you won't get any result at all: the _current_ state of log-tree.c really 
has no history what-so-ever that involved parse_whatchanged_opt. That may 
sound strange, but it really is very true. Doing a "gitk log-tree.c" shows 
what the real history of the contents of that file is.

And this actually comes back to a very fundamental git issue: git tracks 
_contents_. It doesn't care one whit if there was another branch that had 
some other history for that file: if that other branch didn't affect the 
contents of the file, then that other branch simply doesn't exist as far 
as that particular file history is concerned. It only exists as a "bigger" 
issue.

But that "-m -p" thing can be useful when you do want to see the bigger 
issue. As might "--no-prune-merges".

		Linus
