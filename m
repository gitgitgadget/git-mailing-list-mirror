From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] block-sha1: more good unaligned memory access
 candidates
Date: Thu, 13 Aug 2009 09:45:54 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908130934400.28882@localhost.localdomain>
References: <alpine.LFD.2.00.0908130017080.10633@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 18:46:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbdRZ-0007sO-VN
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 18:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160AbZHMQqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 12:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753918AbZHMQqS
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 12:46:18 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54140 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753359AbZHMQqR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Aug 2009 12:46:17 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7DGjtLa004023
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Aug 2009 09:45:56 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7DGjsw4007592;
	Thu, 13 Aug 2009 09:45:55 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0908130017080.10633@xanadu.home>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-5.463 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125833>



On Thu, 13 Aug 2009, Nicolas Pitre wrote:
>
> In addition to X86, PowerPC and S390 are capable of unaligned memory 
> accesses.
> 
> Signed-off-by: Nicolas Pitre <nico@cam.org>

Ack on all your patches (1-3 + this). Looks fine to me.

I do wonder if we should try to do basically "per-architecture hack 
header-files", and then have for each architecture a small trivial 
'hack-x86.h' kind of thing that just does

	/* x86 hacks */
	#define get_be32(p)	ntohl(*(unsigned int *)(p))
	#define put_be32(p, v)	do { *(unsigned int *)(p) = htonl(v); } while (0)
	#define setW(x, val)	(*(volatile unsigned int *)&W(x) = (val))

	#define SHA_ASM(op, x, n) ({ unsigned int __res; __asm__(op " %1,%0":"=r" (__res):"i" (n), "0" (x)); __res; })
	#define SHA_ROL(x,n)   SHA_ASM("rol", x, n)
	#define SHA_ROR(x,n)   SHA_ASM("ror", x, n)

and then we'd have each architecture separated out. Add a few 
"generic helpers":

 - be32-generic.h:

	#define get_be32(p)    ( \
		(*((unsigned char *)(p) + 0) << 24) | \
		(*((unsigned char *)(p) + 1) << 16) | \
		(*((unsigned char *)(p) + 2) <<  8) | \
		(*((unsigned char *)(p) + 3) <<  0) )

	#define put_be32(p, v) do { \
		unsigned int __v = (v); \
		*((unsigned char *)(p) + 0) = __v >> 24; \
		*((unsigned char *)(p) + 1) = __v >> 16; \
		*((unsigned char *)(p) + 2) = __v >>  8; \
		*((unsigned char *)(p) + 3) = __v >>  0; } while (0)

 - rotate-generic.h:

	#define SHA_ROT(X,l,r)  (((X) << (l)) | ((X) >> (r)))
	#define SHA_ROL(X,n)    SHA_ROT(X,n,32-(n))
	#define SHA_ROR(X,n)    SHA_ROT(X,32-(n),n)

that architectures could use when they want to use some particular
portable version.  Then, add a final "hack-generic.h" with the fallback
cases that just does

	#include "be32-generic.h"
	#include "rotate-generic.h"
	#define setW(x,val) (W(x) = (val))

and you'd have all the hacks separated out and fairly easily used by
different architectures.. (ie the ARM version would just look like

 - hack-arm.h:

	#include "be32-generic.h"  
	#include "rotate-generic.h"
	#define setW(x, val) do { W(x) = (val); __asm__("":::"memory"); } while (0)

and you'd be all done.

Hmm? I don't know if this kind of generalization is strictly needed, so 
I'm just throwing it out as an idea.

		Linus
