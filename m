From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: rev-list --parents --full-history + path: something's fishy
Date: Sun, 25 May 2008 14:30:28 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805251424040.3081@woody.linux-foundation.org>
References: <e1dab3980805230808s59798351r9ed702c7d0dedd2a@mail.gmail.com> <1211660214.483877b69a107@webmail.nextra.at> <alpine.LFD.1.10.0805241817500.3081@woody.linux-foundation.org> <200805252158.22514.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, David Tweed <david.tweed@gmail.com>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun May 25 23:31:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0NoN-00037t-GP
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 23:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbYEYVag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 17:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbYEYVag
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 17:30:36 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59601 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751281AbYEYVag (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 May 2008 17:30:36 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4PLUTSi016454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 25 May 2008 14:30:30 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4PLUSll009355;
	Sun, 25 May 2008 14:30:28 -0700
In-Reply-To: <200805252158.22514.johannes.sixt@telecom.at>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.408 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82881>



On Sun, 25 May 2008, Johannes Sixt wrote:
> 
> But why does this:
> 
> $ git rev-list --full-history HEAD -- a
> B
> A
> 
> not list M (note the lack of --parents)?

Because when we don't ask for --parents, the whole problem is *much* 
simpler. The parent rewriting means that the history has to all "fit 
together". But when you don't need parenthood, then suddenly that doesn't 
matter at all - who cares if it fits together or not, when you can't *see* 
that it doesn't fit together anyway?

In this case, it's "simplify_commit()", and this piece of code in 
particular (note how it's even commented!):

		...
                /* Commit without changes? */
                if (commit->object.flags & TREESAME) {
                        /* drop merges unless we want parenthood */
                        if (!revs->rewrite_parents)
                                return commit_ignore;
		...

ie if we're looking at a commit that doesn't actually introduce any 
changes of its own (it took all the changes from at least _one_ of its 
parents - ie it got TREESAME set because the tree was identical to one of 
the parents), then if we don't have 'rewrite_parents' set, we just drop 
that commit, because it is uninteresting.

IOW, we dropped 'M' because there was no point in showing it: we know 
nobody refers to it (because no other commit will list it as a parent!), 
and the commit itself didn't actually introduce any changes (because all 
the changes came from 'B').

But we can *not* drop that merge commit when we do the parenthood 
tracking, because if we did so, we'd just have an "empty spot" in history 
(we have other commits that point to that emrge and list it as a parent).

Of course, in your trivial example, that didn't actually happen (because 
'M' was the top commit), but try it with something more complex.

			Linus
