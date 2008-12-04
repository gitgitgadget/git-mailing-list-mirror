From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Add 'sane' mode to 'git reset'
Date: Wed, 3 Dec 2008 16:39:49 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812031634520.3256@nehalem.linux-foundation.org>
References: <alpine.LFD.2.00.0812010908120.3256@nehalem.linux-foundation.org> <7vr64oc30p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 01:41:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L82HH-0005DO-Vv
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 01:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbYLDAjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 19:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbYLDAjy
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 19:39:54 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39373 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752002AbYLDAjy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2008 19:39:54 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mB40dnWk014705
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Dec 2008 16:39:50 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mB40dnK0007684;
	Wed, 3 Dec 2008 16:39:49 -0800
In-Reply-To: <7vr64oc30p.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.435 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102311>



On Wed, 3 Dec 2008, Junio C Hamano wrote:
> 
> I think a bit more explicit description with an example command sequence
> in the documentation is in order.  Here is what I managed to reconstruct
> from your description.
> 
>     Let's say you have a small change in the Makefile and some other local
>     changes that you would want to keep uncommitted.  Then you receive a
>     pull request that you would want to respond to.  So you do this:
> 
> 	$ git pull $URL $branch
> 
>     knowing that your own local changes will be safe because pull will
>     refuse to clobber them if the changes in the other person did overlaps
>     with it.  Let's further say that the changes did not overlap, the
>     merge succeeded and you still have your own local changes.
> 
>     But after inspecting the result, you realize that you do not want this
>     change after all.  That means rewinding the HEAD back to the previous
>     point (i.e. ORIG_HEAD), match the index to that commit, *and* rewind
>     the work tree back to the state before the merge (i.e. mostly matching
>     the index except for the local changes to Makefile and a handful other
>     files).  "git reset" is the command to move the HEAD.  What mode
>     should you use?
> 
>     Unfortunately, the only two modes that touch the index and/or the work
>     tree are --mixed and --hard.
> 
>     You do not want to use --hard, because it will discard your local
>     changes.  You do not want to use --mixed either, because it will keep
>     not just your local changes but also the changes the merge brought
>     into your work tree.  That's when you would want to use --merge mode.
> 
> 	$ git reset --merge ORIG_HEAD

Exactly.

> The recovery procedure I would use in such a case (and I rarely pull while
> managing git.git even though I do so in my day job) would be:
> 
> 	$ git checkout -b this-needs-more-work
>         $ git checkout master

No, that won't work. The second 'git checkout' does nothing, since 
'master' still has all the broken code in it.

It would have worked had you started the new branch _before_ the pull, but 
if you had that, then you wouldn't have had anything to reset anyway, 
you'd just switch back to master and get rid of the new temp-branch.

But you could probably do something like this:

	git checkout -b temp-branch ORIG_HEAD
	git branch -M master

which depends on that checkout doing the right thing.

			Linus
