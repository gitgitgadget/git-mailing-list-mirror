From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: question concerning branches
Date: Wed, 19 Aug 2009 14:51:17 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908191441070.3158@localhost.localdomain>
References: <4a8c51f5@wupperonline.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Ingo Brueckl <ib@wupperonline.de>
X-From: git-owner@vger.kernel.org Wed Aug 19 23:51:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdt44-0001Np-NG
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 23:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbZHSVvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 17:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbZHSVvT
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 17:51:19 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59133 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751009AbZHSVvS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Aug 2009 17:51:18 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7JLpInU022559
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 19 Aug 2009 14:51:19 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7JLpHJX019395;
	Wed, 19 Aug 2009 14:51:18 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4a8c51f5@wupperonline.de>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.464 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126584>



On Wed, 19 Aug 2009, Ingo Brueckl wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > You finish old work (or stash it away), _then_ you begin new work.
> 
> Ok, this helps me a little bit to understand.
> 
> The branches aren't designed to split my work, but rather something to
> collect the different parts of my work.

Hmm. Yes. That's one way of looking at it.

At the same time, thinking about it another way may explain the git 
choices in this area. There's two issues:

 - if we _don't_ carry the edits around across branch switches, then what 
   would we do?

   Basically, since you haven't committed things, it's kind of floating 
   around. You switch to another branch, what should we do? There are 
   really only two choices: either we'd need to 'stash' the state with the 
   branch we switch away from (which is apparently what you expected), or 
   we need to just move the changes to the new branch (which is what git 
   does, or complains if it cannot).

   Now, 'stashing' the changes is actually very much against the whole git 
   philosophy. Git was built up around the index and the database, and 
   branches have always been pointers to the top-of-commit, so there 
   literally isn't any way to stash things that makes sense. Sure, later 
   on we ended up having the 'stash' command, but that's totally separate 
   from branches, and is an independently useful thing.

 - One of the big reasons to act like git does is that the way at least 
   _I_ work is to actually create a new branch with the explicit intention 
   of committing work I have already done!

   IOW, your example was

	git branch test
	git checkout test
	# edit foo.bar
	git checkout master

   and you were surprised that the edit followed you back to the "master" 
   branch, but what is actualyl a much more natural way of working is

	# edit foo.bar
	# realize that this was actually the start of a new feature
	git branch new-feature
	git checkout new-feature
	# maybe continue to edit foo.bar until it's all good
	git commit -a

   ie the git behavior explicitly _encourages_ you to not have to decide 
   before-the-fact to create a branch - it may be that only after you've 
   done the changes do you realize that "oops, these changes were _way_ 
   more intrusive than I originally anticipated, and I don't want to 
   commit them on the master branch, I want to commit them on an 
   experimental topic branch instead"

So there are two different reasons why git works the way it does: a pure 
implementation reason ("working any other way would not fit the git 
model") and a practical workflow reason ("you are _expected_ to move dirty 
state around with your branches, because one common case is to create a 
branch _for_ that dirty state").

			Linus
