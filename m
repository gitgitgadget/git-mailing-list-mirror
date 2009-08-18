From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Tue, 18 Aug 2009 14:56:56 -0500
Message-ID: <XJM0H8pTiCJpryS-arPltHCHwsm0djqVixaH1NwBqT2pci2MA9karw@cipher.nrlssc.navy.mil>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com> <4A8AA511.1060205@gmail.com> <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com> <7v4os5gs0p.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.0908181147510.6044@xanadu.home> <alpine.LFD.2.00.0908181240400.6044@xanadu.home> <7v1vn9f4mz.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.0908181357330.6044@xanadu.home> <7vk511dk11.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 21:59:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdUq9-0007x1-8U
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 21:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbZHRT7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 15:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbZHRT7U
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 15:59:20 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48608 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbZHRT7T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 15:59:19 -0400
Received: by mail.nrlssc.navy.mil id n7IJuvSW021966; Tue, 18 Aug 2009 14:56:57 -0500
In-Reply-To: <7vk511dk11.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 18 Aug 2009 19:56:56.0813 (UTC) FILETIME=[0A6801D0:01CA203E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126445>

Junio C Hamano wrote:

> Another issue, especially with your "openssl sha1 removal" patch, is if we
> can assume gcc everywhere.  As far as I can tell, block-sha1/sha1.c will
> be the first unconditional use of inline asm or statement expression on
> i386/amd64.  Are folks on Solaris and other platforms Ok with this?

The SUNWspro compiler doesn't set __i386__.  Instead it sets __i386, and
I think __x86_64 and __amd64 where appropriate.  So, compilation with
the SUNWspro compiler on x86 is currently unaffected by these changes and
falls back to the generic routines.

It seems that v5.10 of the compiler can grok both the __asm__ statements
and the ({...}) naked block notation and passes all of the tests when the
block_sha1 code is modified to add defined(__i386) to each of the macro
statements.

The 5.8 version cannot grok the naked block, and requires spelling __asm__
as __asm for inline assembly.  Even then it appears that there is a bug in
the assembly that is produced (a google search told me so), so the assembly
code does not successfully compile.

I haven't had much time to think about how or whether to address this.

Adding something like the following would get ugly real quick:

   (defined(__i386) && defined(__SUNPRO_C) && (__SUNPRO_C >= 0x5100))

For now, the code compiles fine using the SUNWspro compiler on x86 even if
it is suboptimal compared to gcc.  It is still an improvement over the
mozilla code.

-brandon
