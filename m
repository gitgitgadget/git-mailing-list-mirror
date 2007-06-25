From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-rev-list: give better diagnostic for failed write
Date: Mon, 25 Jun 2007 13:59:21 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706251349540.8675@woody.linux-foundation.org>
References: <87r6nzu666.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon Jun 25 23:00:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2vfD-0007Sj-6Q
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 22:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbXFYU75 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 16:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbXFYU75
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 16:59:57 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46806 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751215AbXFYU75 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2007 16:59:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5PKxQ0Q013703
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Jun 2007 13:59:27 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5PKxLmE010562;
	Mon, 25 Jun 2007 13:59:21 -0700
In-Reply-To: <87r6nzu666.fsf@rho.meyering.net>
X-Spam-Status: No, hits=-3.836 required=5 tests=AWL,BAYES_00,INFO_TLD,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50919>



On Mon, 25 Jun 2007, Jim Meyering wrote:
>
> [this patch depends on the one I posted here:
>  http://marc.info/?l=git&m=118280134031923&w=2 ]
> 
> Without this patch, git-rev-list unnecessarily omits strerror(errno)
> from its diagnostic, upon write failure:

And this is a perfect example of what's wrong with the whole thing.

Dammit, how many times do I need to say this:

 - If you want reliable errors, don't use stdio!

That fflush is there FOR A REASON. You removed it FOR A MUCH LESS 
IMPORTANT REASON!

That fflush is there exactly because WE DO NOT WANT TO BUFFER the list of 
commits, because that thing is meant very much to be used for pipelines, 
and it's quite common that the receiving end is going to do something 
asynchronous with the result, and can - and does - want the results as 
soon as possible.

IOW, things like "gitk" use git-rev-list exactly to get the list of 
commits, and they want that list *incrementally*. They don't want to wait 
for git-rev-list to have filled up some 8kB buffer of commits. Especially 
since generating those commits can be slow if we're talking about a big 
tree and some path-limited stuff.

So for example, do something like

	git rev-list HEAD -- drivers/char/drm/Makefile

and if you don't see the result scroll a line at a time on a slower 
machine, there's something *wrong*. 

Junio, I'm NAK'ing this very forcefully!

Jim: I don't know what I'm doing wrong, but I'm apparently not reaching 
you. So let me try one more time:

 - stdio really isn't very good with error handling

 - if you use stdio, YOU HAD BETTER ACCEPT THAT

 - don't screw up basic functionality in your *insane* quest to get stdio 
   to give you ENOSPC. It's not going to happen. Not that way. Just face 
   the fact that stdio *will* throw error numbers away.

The whole notion of "buffered IO" and "reliable errors" is simply not 
something that goes well together.

			Linus
