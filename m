From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] block-sha1: more good unaligned memory access
 candidates
Date: Thu, 13 Aug 2009 12:54:06 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908131246300.28882@localhost.localdomain>
References: <alpine.LFD.2.00.0908130017080.10633@xanadu.home> <alpine.LFD.2.01.0908130934400.28882@localhost.localdomain> <alpine.LFD.2.00.0908131304520.10633@xanadu.home> <7v63crbja2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 21:57:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbgQN-0004wH-5f
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 21:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544AbZHMTyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 15:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755518AbZHMTyu
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 15:54:50 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:32877 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754262AbZHMTyt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Aug 2009 15:54:49 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7DJs6ii023017
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Aug 2009 12:54:07 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7DJs6Q3007642;
	Thu, 13 Aug 2009 12:54:06 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7v63crbja2.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-5.463 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125862>



On Thu, 13 Aug 2009, Junio C Hamano wrote:
> 
> Wow.  Is it now faster than the arm/ and ppc/ hand-tweaked assembly?

For the good cases, yes.

For POWER, with gcc-4.4, the C code apparently outperforms the asm code on 
POWER6. The asm code is scheduled for POWER4, and I think outperforms the 
C code there. Also, when compiling in 64-bit mode (with "-m64"), at least 
some versions of gcc seem to do some stupid things and add extra zero 
extension stuff, and that performed suboptimally at least on a PPC G5.

So it's certainly not a clear case of "the C code outperforms the asm 
code", but in BenH's tests, the best numbers really did come from the C 
version. With some silly cases of at least some versions gcc screwing up 
(not reload, but zero extension), and making it noticeably slower.

IOW, the PPC situation really isn't that different from x86. 

			Linus
