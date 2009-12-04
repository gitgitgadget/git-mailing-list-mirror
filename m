From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Wrong damage counting in diffcore_count_changes?
Date: Fri, 4 Dec 2009 15:20:47 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912041504380.24579@localhost.localdomain>
References: <alpine.LFD.2.00.0912041200120.24579@localhost.localdomain> <7vljhio4a3.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.0912041419540.24579@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 00:20:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGhSL-0006Gu-SP
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 00:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757419AbZLDXUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 18:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755236AbZLDXUq
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 18:20:46 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46033 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755156AbZLDXUp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Dec 2009 18:20:45 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id nB4NKm3K025973
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 4 Dec 2009 15:20:49 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id nB4NKmoB001694;
	Fri, 4 Dec 2009 15:20:48 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0912041419540.24579@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.458 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134588>



On Fri, 4 Dec 2009, Linus Torvalds wrote:
> 
> It also looks a bit like diffcore-break actually worked around this whole 
> thing, and does
> 
>         /* sanity */
>         if (src->size < src_copied)
>                 src_copied = src->size;
>         if (dst->size < literal_added + src_copied) {
>                 if (src_copied < dst->size)
>                         literal_added = dst->size - src_copied;   
>                 else
>                         literal_added = 0;
>         } 
>         src_removed = src->size - src_copied;
> 
> so this _may_ change what -B does, but I get the feeling that it should 
> improve that too. I'm running a before-and-after "git log -M -B --summary" 
> on the kernel now, but it's a pretty expensive operation, so it hasn't 
> finished yet.

Ok, somewhat confirmed. Before-and-after changes:

 - commit 2def7b8bcd4c49ca71a950611c9d456fd35282d2

	- 2 files changed, 187 insertions(+), 218 deletions(-)
	- delete mode 100644 drivers/staging/hv/include/ChannelMessages.h
	+ 1 files changed, 109 insertions(+), 4 deletions(-)
	+ rename drivers/staging/hv/{include/ChannelMessages.h => ChannelMgmt.h} (70%)

   ie it _used_ to get broken up, now it shows up as a rename, presumably 
   due to better scoring.

 - commit 64a1403d797d38c0bd18ba43bda5653c012c0d58. Similar.

 - commit 3ce0a23d2d253185df24e22e3d5f89800bb3dd1c

	- 34 files changed, 8316 insertions(+), 633 deletions(-)
	- create mode 100644 drivers/gpu/drm/radeon/avivod.h
	+ 34 files changed, 8287 insertions(+), 643 deletions(-)
	+ copy drivers/gpu/drm/radeon/{radeon_share.h => avivod.h} (50%)

   that looks like a smaller diff, judging by the line counts

 - commit 9f77da9f40045253e91f55c12d4481254b513d2d

	- 4 files changed, 358 insertions(+), 328 deletions(-)
	+ 4 files changed, 132 insertions(+), 420 deletions(-)
	  rewrite include/linux/rcutree.h (73%)
	+ rename {include/linux => kernel}/rcutree.h (80%)

 - commit d15dd3e5d74186a3b0a4db271b440bbdc0f6da36

	- 6 files changed, 75 insertions(+), 41 deletions(-)
	- create mode 100644 drivers/net/wireless/ath/ath.h
	+ 6 files changed, 59 insertions(+), 47 deletions(-)
	+ copy drivers/net/wireless/ath/{main.c => ath.h} (73%)

 - commit cf4f1e76c49dacfde0680b170b9a9b6a42f296bb

	- 2 files changed, 716 insertions(+), 714 deletions(-)
	+ 2 files changed, 371 insertions(+), 1034 deletions(-)
	  rewrite drivers/usb/host/r8a66597.h (62%)
	+ rename {drivers/usb/host => include/linux/usb}/r8a66597.h (65%)

 - commit d69864158e24f323e818403c6b89ad4871aea6f6

	- 4 files changed, 172 insertions(+), 238 deletions(-)
	+ 3 files changed, 90 insertions(+), 106 deletions(-)
	+ rename arch/sparc/include/asm/{dma-mapping_64.h => dma-mapping.h} (71%)
	  delete mode 100644 arch/sparc/include/asm/dma-mapping_32.h
	- delete mode 100644 arch/sparc/include/asm/dma-mapping_64.h

etc. From what I can see, it looks like in general it picked better things 
with the new diffcore_count_changes() implementation, Looking at just the 
"files changed" summaries, it tends to look like this:

	- 21 files changed, 5659 insertions(+), 3227 deletions(-)
	+ 19 files changed, 5723 insertions(+), 2285 deletions(-)

	- 3 files changed, 645 insertions(+), 654 deletions(-)
	+ 3 files changed, 387 insertions(+), 820 deletions(-)

	- 11 files changed, 187 insertions(+), 177 deletions(-)
	+ 10 files changed, 166 insertions(+), 109 deletions(-)

	- 100 files changed, 1114 insertions(+), 3388 deletions(-)
	+ 99 files changed, 1102 insertions(+), 3337 deletions(-)

	- 2 files changed, 127 insertions(+), 106 deletions(-)
	+ 2 files changed, 113 insertions(+), 92 deletions(-)

	- 7 files changed, 128 insertions(+), 59 deletions(-)
	+ 7 fileas changed, 87 insertions(+), 69 deletions(-)

	- 154 files changed, 3641 insertions(+), 4232 deletions(-)
	+ 154 files changed, 3635 insertions(+), 4233 deletions(-)

	- 24 files changed, 162 insertions(+), 226 deletions(-)
	+ 23 files changed, 61 insertions(+), 77 deletions(-)

	- 4 files changed, 1995 insertions(+), 2114 deletions(-)
	+ 3 files changed, 796 insertions(+), 814 deletions(-)

	- 3 files changed, 1104 insertions(+), 1114 deletions(-)
	+ 3 files changed, 886 insertions(+), 1038 deletions(-)

	- 46 files changed, 17743 insertions(+), 5986 deletions(-)
	+ 46 files changed, 16239 insertions(+), 6636 deletions(-)

	- 9 files changed, 295 insertions(+), 284 deletions(-)
	+ 9 files changed, 203 insertions(+), 291 deletions(-)

ie I can see several cases where the new break choice resulted in fewer 
files changed and/or fewer over-all lines changed (due to better rename 
choices), and I haven't seen any going the other way. There's probably 
some, but it does seem that in general the patch results in better picks 
(when it makes any difference in the first place - there seems to be only 
71 commits in the kernel git tree that are affected at all)

			Linus
