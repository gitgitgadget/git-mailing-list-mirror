From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] block-sha1: guard gcc extensions with __GNUC__
Date: Tue, 18 Aug 2009 15:37:22 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908181534130.6044@xanadu.home>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com>
 <4A8AA511.1060205@gmail.com>
 <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com>
 <7v4os5gs0p.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0908181147510.6044@xanadu.home>
 <alpine.LFD.2.00.0908181240400.6044@xanadu.home>
 <7v1vn9f4mz.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0908181357330.6044@xanadu.home>
 <7vk511dk11.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0908181516510.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 21:37:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdUVF-0005H8-KL
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 21:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbZHRThp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 15:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbZHRThp
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 15:37:45 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57288 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbZHRTho (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 15:37:44 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOL000IS7BM3880@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 18 Aug 2009 15:26:11 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.00.0908181516510.6044@xanadu.home>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126442>

With this, the code should now be portable to any C compiler.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

On Tue, 18 Aug 2009, Nicolas Pitre wrote:

> On Tue, 18 Aug 2009, Junio C Hamano wrote:
> 
> > Another issue, especially with your "openssl sha1 removal" patch, is if we
> > can assume gcc everywhere.  As far as I can tell, block-sha1/sha1.c will
> > be the first unconditional use of inline asm or statement expression on
> > i386/amd64.  Are folks on Solaris and other platforms Ok with this?
> 
> I guess we can guard the first with ifdef(__GNUC__) which should help 
> people with MSVC.  That should take care of x86 at least.

Here it is.

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index d31f2e3..92d9121 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -9,7 +9,7 @@
 
 #include "sha1.h"
 
-#if defined(__i386__) || defined(__x86_64__)
+#if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
 
 /*
  * Force usage of rol or ror by selecting the one with the smaller constant.
@@ -54,7 +54,7 @@
 
 #if defined(__i386__) || defined(__x86_64__)
   #define setW(x, val) (*(volatile unsigned int *)&W(x) = (val))
-#elif defined(__arm__)
+#elif defined(__GNUC__) && defined(__arm__)
   #define setW(x, val) do { W(x) = (val); __asm__("":::"memory"); } while (0)
 #else
   #define setW(x, val) (W(x) = (val))
