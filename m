From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5/6] Do linear-time/space rename logic for exact
 renames
Date: Thu, 25 Oct 2007 13:25:34 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710251317020.30120@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.or
 g> <alpine.LFD.0.999.0710251120590.30120@woody.linux-foundation.org>
 <Pine.LNX.4.64.0710251522190.7345@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 22:26:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il9Hf-0003Hx-Ae
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 22:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448AbXJYU0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 16:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbXJYU0N
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 16:26:13 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58742 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751116AbXJYU0M (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2007 16:26:12 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9PKPZQN017345
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Oct 2007 13:25:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9PKPYC6021763;
	Thu, 25 Oct 2007 13:25:34 -0700
In-Reply-To: <Pine.LNX.4.64.0710251522190.7345@iabervon.org>
X-Spam-Status: No, hits=-3.221 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62370>



On Thu, 25 Oct 2007, Daniel Barkalow wrote:
> 
> Creating a list of the pointers doesn't work correctly with the grow 
> implementation, because growing the hash may turn a collision into a 
> non-collision, at which point items other than the first cannot be found 
> (since they're listed inside a bucket that's now wrong for them). AFAIK, 
> resizing a hash table requires being able to figure out what happened with 
> collisions.

Nope. 

The hash algorithm is much smarter than that.

I *always* uses a full 32-bit hash, and no amount of resizing is ever 
going to change that. The index into the hash-table is in fact entirely 
unused.

This has several good properties:

 - it means that hash-table resizing is a non-event

 - it means that you always have the full 32-bit hash, and a collision in 
   the hash size never causes unnecessary work apart from the fact that 
   the code walks the hash table a bit more.

 - because the hash is embedded in the table itself, it has relatively 
   good cache behaviour when compared to something that needs to actually 
   follow the pointer to validate the full data. So assuming that the full 
   32-bit hash is good enough to effectively never have any collisions 
   (or, assuming you don't even *care* about the collisions, which is the 
   case when you're just generating content fingerprints for lines when 
   comparing the data in two files), you never end up with unnecessarily 
   following pointers to cachelines that you are not interested in.

The last point at least somewhat mitigates the (inevitably) bad cache 
behaviour that hash tables tend to have. It's not like it's going to be 
wonderful in the cache, but at least it's less horrid than the more common 
implementation that needs to follow the pointer to validate each hash 
entry that may or may not be a collision.

but the important part is #1, which is what allows the code to be a 
generic hash algorithm that resizes the hash table without even 
understanding or caring what is behind the pointer.

		Linus
