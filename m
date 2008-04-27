From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: my git problem
Date: Sun, 27 Apr 2008 13:24:08 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804271315010.3119@woody.linux-foundation.org>
References: <20080427112938.4dbe8e2a.akpm@linux-foundation.org> <alpine.LFD.1.10.0804271204510.3119@woody.linux-foundation.org> <20080427124454.6a606305.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 22:25:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqDQj-0006qx-1K
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 22:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758064AbYD0UYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 16:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755581AbYD0UYM
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 16:24:12 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57306 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752775AbYD0UYL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Apr 2008 16:24:11 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3RKO9mR013515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 27 Apr 2008 13:24:11 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3RKO8rl023224;
	Sun, 27 Apr 2008 13:24:09 -0700
In-Reply-To: <20080427124454.6a606305.akpm@linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.457 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80483>



On Sun, 27 Apr 2008, Andrew Morton wrote:
> 
> But I'm pretty sure that the simple solutions were found wanting, but I
> don't recall why.  I think it was because of a problem when
> git-netdev-all is based on git-net which is based on origin.  I want to
> extract the git-net -> git-netdev-all diff, but doing that generates
> patches which reapply things which are already applied.

Well, if a tree has patches that are already applied up-stream, then yes, 
you do actually have to do the merge in order to see that. Because 
obviously the diff is in two places, and if they merge cleanly, one of 
them has to be made to not count.

So it depends on what you want.

	git diff a...b

says literally "what has been added to 'b' since it diverged from 'a'". 

That is a useful and valid thing to ask, but it is very fundamentally also 
*not* the same thing as actually doing the merge, and asking what the 
merge added. Doing

	git merge --no-commit otherbranch
	git diff HEAD > diff
	git reset --hard

will do that: it will do the merge (which obviously squashes any diffs 
that existed in the other tree as different commits), and then diffs the 
HEAD against that resulting state.

So they are two fundamentally different things to do.

In some sense, the "git diff a...b" is closer to your "series of quilt 
patches" model, in that it just generates a patch - which may obviously 
conflict with the *other* patches you are also generating. It would then 
expect your quilt logic to do some sane patch merging.

Of course, we know that quilt doesn't do sane patch merging, so you are 
probably better off with the second version: letting git merge for you, 
and taking the resulting diff.

> But I don't presently have any trees which are based on other non-origin
> trees so I can't test that.

Yes, in that case you'll only get issues when somebody commits the same 
patch I have already applied. Which does happen, of course.

			Linus
