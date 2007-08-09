From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git and larger trees, not so fast?
Date: Thu, 9 Aug 2007 11:06:27 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708091056180.25146@woody.linux-foundation.org>
References: <20070809163026.GD568@mbox.bz>
 <alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: moe <moe-git@mbox.bz>
X-From: git-owner@vger.kernel.org Thu Aug 09 20:06:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJCPF-0003g5-2V
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 20:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbXHISGl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 14:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbXHISGl
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 14:06:41 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47566 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750955AbXHISGk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Aug 2007 14:06:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l79I6X5k011907
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Aug 2007 11:06:34 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l79I6RGP011912;
	Thu, 9 Aug 2007 11:06:27 -0700
In-Reply-To: <alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.725 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55465>



On Thu, 9 Aug 2007, Linus Torvalds wrote:
> 
> Gaah. This shouldn't be *that* hard to fix, but I'm not entirely sure I'll 
> have time today.

In fact, I'm almost sure I will *not* have time today.

Anyway, the really trivial (and ugly) fix is to handle the cases of adding 
_independent_ stages to the index (which is the case for both "git 
diff-index" and "git read-tree -m") differently: instead of using the 
standard "add_index_entry()", which does all the complex sorting and 
checks that there aren't duplicates, we could do a much simpler one that 
just unconditionally appends to the end of the index.

This works, because when the stages are independent, there can be no index 
clashes (by definition).

Then, after adding all the stages, we could just do a "qsort()" on the 
result, and rather than having an expensive O(n**2) thing, we'd have a 
much nicer and well-behaved (with a smaller constant too) O(n*logn) thing.

I bet it's just ~50 lines of code, it really shouldn't be that hard to do. 
I just won't be able to do it and test it until late tonight or tomorrow, 
I suspect.

Sadly, this is an area that is almost exclusively mine and Junio's. I'd 
love for somebody else to get their feet wet, but doing a

	gitk read-cache.c

shows that few enough people have done anythign really fundamental in this 
file..

			Linus
