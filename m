From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Fix random fast-import errors when compiled with
 NO_MMAP
Date: Thu, 17 Jan 2008 20:27:08 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801172013270.2957@woody.linux-foundation.org>
References: <20080118035700.GA3458@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>,
	Charles Bailey <charles@hashpling.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 05:28:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFiq4-00081y-Rk
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 05:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbYARE1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 23:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbYARE1w
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 23:27:52 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60721 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750946AbYARE1v (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 23:27:51 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0I4R8Xn017033
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Jan 2008 20:27:10 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0I4R8jK031210;
	Thu, 17 Jan 2008 20:27:08 -0800
In-Reply-To: <20080118035700.GA3458@spearce.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.717 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70964>



On Thu, 17 Jan 2008, Shawn O. Pearce wrote:
>
> fast-import was relying on the fact that on most systems mmap() and
> write() are synchronized by the filesystem's buffer cache.  We were
> relying on the ability to mmap() 20 bytes beyond the current end
> of the file, then later fill in those bytes with a future write()
> call, then read them through the previously obtained mmap() address.
> 
> This isn't always true with some implementations of NFS, but it is
> especially not true with our NO_MMAP=YesPlease build time option used
> on some platforms.

In fact, even with mmap(), it's not guaranteed. There are really crappy 
mmap implementations out there, partly due to bad CPU design (virtual CPU 
caches without coherency), but more often due to total crap OS.

(Yeah, Linux did count in that area at some point. Long ago. Early 90's. 
Maybe)

I think HP-UX used to have non-coherent mmap for the longest time, due to 
carrying around some totally crap memory management based on some ancient 
BSD version that everybody else (including the BSD's) had long since 
jettisoned.

That said, I suspect any unix you can run today (without calling it a 
retro setup) probably has coherent-enough mmap. The possible virtual cache 
coherency issue is unlikely to be able to trigger this (and not relevant 
on any sane hardware anyway).

				Linus
