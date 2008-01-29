From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-revert is a memory hog
Date: Wed, 30 Jan 2008 08:51:09 +1100 (EST)
Message-ID: <alpine.LFD.1.00.0801300844170.28476@www.l.google.com>
References: <20080127172748.GD2558@does.not.exist> <20080128055933.GA13521@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Adrian Bunk <bunk@kernel.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 29 22:52:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJyNJ-000843-MJ
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 22:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbYA2Vvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 16:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752466AbYA2Vvl
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 16:51:41 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36343 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750850AbYA2Vvk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jan 2008 16:51:40 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0TLpCVh014955
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Jan 2008 13:51:13 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0TLpAtA006171;
	Tue, 29 Jan 2008 13:51:11 -0800
X-X-Sender: torvalds@www.l.google.com
In-Reply-To: <20080128055933.GA13521@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.421 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_63
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72001>



On Mon, 28 Jan 2008, Jeff King wrote:
> 
> I tried to reproduce this, but my peak heap allocation was only around
> 20MB. Is your repository fully packed? Not packed at all? Can you use
> valgrind/massif to figure out where the memory is going?

I definitely can reproduce it, it's horrid.

This is from "top" fairly late in the game, but with the thing not even 
done yet. Current git, pretty much fully (and fairly aggressively) packed 
current kernel repo, and using "diff.renamelmit=0".

	4751 torvalds  20   0  852m 446m  47m R   72 22.4   2:46.58 git-merge-recur

It finally finished with time reporting:

	208.15user 3.50system 4:01.50elapsed 87%CPU (0avgtext+0avgdata 0maxresident)k
	238736inputs+4544outputs (8261major+280971minor)pagefaults 0swaps

where those 280971 minor page faults are what largely indicates how much 
memory it used (the technical term for that number is "metric buttload of 
memory").

But I'm in Melbourne right now on my laptop,and probably won't be able to 
debug this much. 

> In your case, the patch doesn't apply cleanly, so we end up doing a
> 3-way merge (in my tests, it is git-merge-recursive which ends up taking
> up the memory).

It is indeed git-merge-recursive. It just shouldn't take that much memory.

		Linus
