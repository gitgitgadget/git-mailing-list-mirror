From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Wed, 19 Aug 2009 22:26:37 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908192201180.6044@xanadu.home>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com>
 <4A8AA511.1060205@gmail.com>
 <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com>
 <7v4os5gs0p.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0908181147510.6044@xanadu.home>
 <alpine.LFD.2.00.0908181240400.6044@xanadu.home>
 <7v1vn9f4mz.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0908181357330.6044@xanadu.home>
 <7vk511dk11.fsf@alter.siamese.dyndns.org>
 <XJM0H8pTiCJpryS-arPltHCHwsm0djqVixaH1NwBqT2pci2MA9karw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Aug 20 04:26:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdxMY-0004SP-Fb
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 04:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308AbZHTC0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 22:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752994AbZHTC0m
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 22:26:42 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9078 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbZHTC0l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 22:26:41 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KON0043VLGDLO20@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 19 Aug 2009 22:26:38 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <XJM0H8pTiCJpryS-arPltHCHwsm0djqVixaH1NwBqT2pci2MA9karw@cipher.nrlssc.navy.mil>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126603>

On Tue, 18 Aug 2009, Brandon Casey wrote:

> The SUNWspro compiler doesn't set __i386__.  Instead it sets __i386, and
> I think __x86_64 and __amd64 where appropriate.  So, compilation with
> the SUNWspro compiler on x86 is currently unaffected by these changes and
> falls back to the generic routines.
> 
> It seems that v5.10 of the compiler can grok both the __asm__ statements
> and the ({...}) naked block notation and passes all of the tests when the
> block_sha1 code is modified to add defined(__i386) to each of the macro
> statements.
> 
> The 5.8 version cannot grok the naked block, and requires spelling __asm__
> as __asm for inline assembly.  Even then it appears that there is a bug in
> the assembly that is produced (a google search told me so), so the assembly
> code does not successfully compile.
> 
> I haven't had much time to think about how or whether to address this.
> 
> Adding something like the following would get ugly real quick:
> 
>    (defined(__i386) && defined(__SUNPRO_C) && (__SUNPRO_C >= 0x5100))

I think the best solution in this case might simply be to add something 
like this somewhere at the top of git-compat-util.h after the system 
includes:

/*
 * The SUNWspro compiler uses different symbols than gcc.
 * Let's standardize on the gcc flavor.
 */
#if defined(__i386) && !defined(__i386__)
#define __i386__
#endif
#if (defined(__x86_64) || defined(__amd64)) && !defined(__x86_64__)
#define __x86_64__
#endif
/*
 * SUNWspro from version 5.10 supports gcc extensions such as gcc's 
 * statement expressions and extended inline asm, so let's pretend...
 */
#if defined(__SUNPRO_C) && (__SUNPRO_C >= 0x5100))
#define __GNUC__
#endif


Nicolas
