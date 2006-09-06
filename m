From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/7] gitweb: Trying to improve history view speed
Date: Wed, 6 Sep 2006 11:30:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609061125000.27779@g5.osdl.org>
References: <200609061504.40725.jnareb@gmail.com> <Pine.LNX.4.64.0609060847521.27779@g5.osdl.org>
 <edmv57$lt7$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 20:31:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL2B3-0001Km-Ea
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 20:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWIFSbG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 14:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWIFSbG
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 14:31:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2733 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751263AbWIFSbC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 14:31:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k86IV0nW015419
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 6 Sep 2006 11:31:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k86IUxkT019630;
	Wed, 6 Sep 2006 11:30:59 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <edmv57$lt7$1@sea.gmane.org>
X-Spam-Status: No, hits=-0.995 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26547>



On Wed, 6 Sep 2006, Jakub Narebski wrote:

> Linus Torvalds wrote:
> 
> > So the rule is:
> > 
> >  - using "--full-history" + "--parents" means that you want (surprise 
> >    surprise) full history with parenthood, which means that you get all 
> >    the connecting merges too. And since you asked for the _full_ history, 
> >    that means EVERY SINGLE MERGE.
> 
> I just don't quite understand where <pathspec> filtering takes place 
> in this case.

Well, since you asked for full history, by definition it doesn't take 
place for merges, since you'll be wanting to follow both sides of the 
merge (to see the full history) regardless of whether the parents of that 
merge seem interesting or not.

> Every single merge is for parents to be connected, or what?

Well, "--parents" on its own means that we want a connected graph. It's 
just that if you don't ask for full history, then the connected graph 
result is obviously much smaller.

Think "graphical visualizer", and you'll see what's going on. Do a

	gitk git.c
	gitk --full-history git.c

and see the difference, and you'll understand (gitk already asks for 
"--parents" on its own).

Basically, "--full-history" means that we traverse every parent of a 
merge, whether it looks interesting or not.

> When I though about it, git_history needs not parents of a commit; from
> parsed commit it needs only date, author and title/summary (and of course
> commit sha1), so we can skip '--parents' option to git-rev-list, and have
> nice _history of a file_, using only one call to git-rev-list to make it.

Yes. Once you get rid of "--parents", git-rev-list should indeed do 
exactly what you want (because it no longer tries to keep things 
connected, and thus happily drops uninteresting merges).

Of course, there could well be a bug _there_, since "--full-history" isn't 
used very much (but "git whatchanged" uses it, so it should have gotten 
_some_ testing).

			Linus
