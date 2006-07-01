From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Enable tree (directory) history display
Date: Fri, 30 Jun 2006 20:45:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606302029310.12404@g5.osdl.org>
References: <20060701024309.63001.qmail@web31805.mail.mud.yahoo.com>
 <Pine.LNX.4.64.0606301954140.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 01 05:45:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwWQb-0000XL-IS
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 05:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWGADpt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 23:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWGADpt
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 23:45:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9449 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964867AbWGADps (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 23:45:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k613jinW025014
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 30 Jun 2006 20:45:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k613jhra009277;
	Fri, 30 Jun 2006 20:45:43 -0700
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <Pine.LNX.4.64.0606301954140.12404@g5.osdl.org>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23038>



On Fri, 30 Jun 2006, Linus Torvalds wrote:
> 
> BTW! Junio, I think this patch actually fixes a real bug.
> 
> Without this patch, the "--parents --full-history" combination (which 
> you'd get if you do something like
> 
> 	gitk --full-history Makefile
> 
> or similar) will actually _drop_ merges where all children are identical. 
> That's wrong in the --full-history case, because it measn that the graph 
> ends up missing lots of entries.

Here's some real numbers.

Before this patch

	git-rev-list --full-history HEAD -- Makefile | wc -l
	git-rev-list --parents --full-history HEAD -- Makefile | wc -l

both returned 971 commits on my current kernel tree, while

	git-rev-list --parents HEAD -- Makefile | wc -l

returned 145 commits, and

	git-rev-list --parents --no-merges HEAD -- Makefile | wc -l

returns 136.

That count of 145 is the number of commits that actually _change_ Makefile 
some way - and some of them really are merges, because they have a content 
merge, and the merge result is thus different from any of the children. So 
that's a real number. So is 136, in some sense - it just says that we 
don't care about commits, even if those commits _do_ end up changing the 
file.

But the important part to realize is that the "971" number is always 
wrong. It's never a really valid number. It contains a lot of extra 
merges, but it does _not_ contain enough of them to connect all the dots, 
and it's thus never correct. Either you should drop merges that don't 
change things (in which case you cannot have full connectivity, and 
"--parents" doesn't make sense), or you should keep them all (or at least 
enough to get full connectivity).

Now, AFTER this patch

	git-rev-list --full-history HEAD -- Makefile | wc -l

returns 145 commits (the same 145 commits that really change Makefile, but 
we've now properly decided that because we don't have "--parents" and 
don't need to keep connectivity we drop _all_ of the merges that have a 
child that is identical), while

	git-rev-list --parents --full-history HEAD -- Makefile | wc -l

returns 2323 commits, and now really has _all_ the merges (because it 
needs to include every single merge in the tree - otherwise the 
connectivity doesn't make sense).

Now, that 2323 is a bit unnecessary - we end up having merges to merges 
that don't actually have any changes at all in between, and it might be 
nice to simplify the merge history to create a minimal tree that still has 
all potential changes in it, but that's a much harder problem.

Anyway, the patch definitely makes a difference, and I think it's correct. 
The effects might be a bit easier to visualize on a smaller tree than the 
kernel ;)

We could still potentially improve on the "--parents --full-history" case, 
but --full-history currently means always walking all possible chains, and 
that will be shown in the output (ie we will have all possible paths in 
the result if "--parents" is used, even if those paths end up being 
totally uninteresting)

  "Hey - you asked for full history, you got it. Don't blame me if you got 
   a lot of totally uninteresting crud"

				Linus
