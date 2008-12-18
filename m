From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] Add support for multi threaded checkout
Date: Thu, 18 Dec 2008 13:41:48 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812181333150.14014@localhost.localdomain>
References: <3BA20DF9B35F384F8B7395B001EC3FB3265B2A01@azsmsx507.amr.corp.intel.com> <1229633811-3877-1-git-send-email-james.e.pickens@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: James Pickens <james.e.pickens@intel.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 22:44:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDQei-00030E-Qf
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 22:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbYLRVmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 16:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbYLRVmV
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 16:42:21 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34780 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751960AbYLRVmU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Dec 2008 16:42:20 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBILfn9b026775
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Dec 2008 13:41:50 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBILfmAK010791;
	Thu, 18 Dec 2008 13:41:48 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1229633811-3877-1-git-send-email-james.e.pickens@intel.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.923 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103499>



On Thu, 18 Dec 2008, James Pickens wrote:
>
> This speeds up operations like 'git clone' on NFS drives tremendously, but
> slows down the same operations on local disks.
> 
> Partitioning the work and launching threads is done in unpack-trees.c.  The code
> is mostly copied from preload_index.c.  The maximum number of threads is set to
> 8, which seemed to give a reasonable tradeoff between performance improvement on
> NFS and degradation on local disks.

Hmm. I don't really like this very much.

Why? Because as your locking shows, we can really only parallelise the 
actual write-out anyway, and rather than do any locking there, wouldn't it 
be better to have a notion of "queued work" (which would be just the 
write-out) to be done in parallel?

So instead of doing all the unpacking etc in parallel (with locking around 
it to serialize it), I'd suggest doing ll the unpacking serially since 
that isn't the problem anyway (and since you have to protect it with a 
lock anyway), and just have a "write out and free the buffer" phase that 
is done in the threads.

The alternative would be to actually do what your patch suggests, but 
actually try to make the code git SHA1 object handling be thread-safe. At 
that point, the ugly locking in write_entry() would go away, and you might 
actually improve performance on SMP thanks to doing the CPU part in 
parallel.

But as-is, I think the patch is a bit ugly. The reason I liked the index 
pre-reading was that it could be done entirely locklessly, so it really 
did parallelize it _fully_ (even if the IO latency part was the much 
bigger issue), and that was also why it actually ended up helping even on 
a local disk (only if you have multiple cores, of course).

		Linus
