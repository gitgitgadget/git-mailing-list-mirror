From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] Add support for multi threaded checkout
Date: Thu, 18 Dec 2008 16:13:13 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812181606250.14014@localhost.localdomain>
References: <3BA20DF9B35F384F8B7395B001EC3FB3265B2A01@azsmsx507.amr.corp.intel.com>  <1229633811-3877-1-git-send-email-james.e.pickens@intel.com>  <alpine.LFD.2.00.0812181333150.14014@localhost.localdomain>
 <885649360812181535h36d24b0gb31acddded452a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 01:14:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDT0n-0006IR-Bp
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 01:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbYLSANR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 19:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbYLSANR
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 19:13:17 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47452 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751571AbYLSANQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Dec 2008 19:13:16 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBJ0DEnZ002151
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Dec 2008 16:13:15 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBJ0DD9Q016331;
	Thu, 18 Dec 2008 16:13:14 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <885649360812181535h36d24b0gb31acddded452a0@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.924 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103515>



On Thu, 18 Dec 2008, James Pickens wrote:

> On Thu, Dec 18, 2008, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > So instead of doing all the unpacking etc in parallel (with locking around
> > it to serialize it), I'd suggest doing ll the unpacking serially since
> > that isn't the problem anyway (and since you have to protect it with a
> > lock anyway), and just have a "write out and free the buffer" phase that
> > is done in the threads.
> 
> That's certainly a more elegant way to do it, but unless I'm missing
> something, it requires rewriting a good bit of code.  The main reason I
> went with the locking was to keep the patch as simple and non-intrusive
> as possible.

Yeah, I looked a bit more at it, and one problem is that we don't just 
write out the file, we also refresh the cache with the stat information 
after writing it out. If we just write the thing out, it would be simpler: 
we'd just make the thread locklessly write things out and free the data 
from a simple set of lockless threads - no need for any access to git data 
structures.

Ho humm. I'll think about it a bit more.

		Linus
