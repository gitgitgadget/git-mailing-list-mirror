From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How to pull only a few files from one branch to another?
Date: Tue, 23 Jan 2007 20:18:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701232012450.3606@woody.linux-foundation.org>
References: <17846.53626.895660.762096@lisa.zopyra.com>
 <Pine.LNX.4.64.0701231937310.3606@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 05:19:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9ZbO-0001nI-Da
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 05:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965645AbXAXETF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 23:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965641AbXAXETF
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 23:19:05 -0500
Received: from smtp.osdl.org ([65.172.181.24]:50509 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965645AbXAXETE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 23:19:04 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0O4Ixpa029625
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 Jan 2007 20:18:59 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0O4Iwkh008158;
	Tue, 23 Jan 2007 20:18:58 -0800
In-Reply-To: <Pine.LNX.4.64.0701231937310.3606@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.724 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.171 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37602>



On Tue, 23 Jan 2007, Linus Torvalds wrote:
> 
>      If you have just one simple merge-base, you'd do something like
> 
> 	git merge-one-file \
> 		$(git merge-base HEAD other):filename \
> 		HEAD:filename \
> 		other:filename \
> 		filename
> 
>      (where those last three things are just the file mode)

That comment made no sense. I removed the file modes entirely, and forgot 
to remove the comment. It turns out that you can just drop the file modes 
entirely from the invocation of least the current "git-merge-one-file", so 
I did that, to keep it cleaner and simpler.

Anyway, the way "git merge-one-file" works, you pass it:

 - the SHA1 of the "base object"

	$(git merge-base HEAD other):filename

 - the SHA1 of the "current branch version of the file"

	HEAD:filename

 - the SHA1 of the "other branch version of the file"

	other:filename

 - the filename as you want the end result to be in the index

	filename

 - normally, you'd pass the file modes for the three cases too

	0644 0644 0644

   but those are the ones I skipped because the shell script actually only 
   uses them to see if they are different (so dropping them means that it 
   all works fine - the empty arguments are all the same).

but additionally, since "git merge-one-file" expects to be in the middle 
of a real merge (and not just some faked-out single-file merging thing) it 
also expects the index to be populated in stage2 with the current branch 
version of the file - which it won't be outside of a merge. Which is why 
it ends up complaining.

It would be kind of cool to have the whole "merge-recursive" logic (which 
can handle multiple ancestors etc - unlike the above) able to do this, but 
that's a whole 'nother kettle of fish.

			Linus
