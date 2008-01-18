From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Fix random fast-import errors when compiled with
 NO_MMAP
Date: Fri, 18 Jan 2008 09:08:23 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801180842350.2957@woody.linux-foundation.org>
References: <20080118035700.GA3458@spearce.org> <alpine.LFD.1.00.0801172013270.2957@woody.linux-foundation.org> <20080118084201.GA14763@hashpling.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 18:09:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFuiz-0005fE-Vu
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 18:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759044AbYARRJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 12:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758104AbYARRJU
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 12:09:20 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55867 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754534AbYARRJT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jan 2008 12:09:19 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0IH8Pha023242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 18 Jan 2008 09:08:26 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0IH8NB6027312;
	Fri, 18 Jan 2008 09:08:24 -0800
In-Reply-To: <20080118084201.GA14763@hashpling.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.717 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71038>



On Fri, 18 Jan 2008, Charles Bailey wrote:
> 
> I've just checked the Mac OS X build and it looks like there is a mmap
> and git is indeed using it, so this is obviously an example of a
> "really crappy" mmap implementation.

Looking closer, this is not necessarily the case here.

Git uses MAP_PRIVATE, because that whole pack-file mapping was really 
*meant* to map an existing read-only pack-file, and fast-import seems to 
really be screwing with it.

It so happens that Linux has a particularly clean and streamlined VM, and 
if you do only reads to a MAP_PRIVATE mapping on a normal filesystem, 
you'll always be as coherent as with MAP_SHARED because Linux will simply 
map in the page cache pages directly.

But this is definitely not portable, and the git fast-import mmap window 
usage before Shawn's patch it was simply wrong.

So in this case, it really was git that was crap.

It just happened to work because the Linux mmap handling is just generally 
pretty sane. It probably also worked fine on pretty much any other modern 
UNIX (ie Solaris).

I'm not quite sure what OS X does to MAP_PRIVATE mappings, but if OS X is 
still based on Mach (with FreeBSD just as a single-server on top), I 
suspect that may be why it broke on OS X. The Mach VM is insanely complex 
and does really odd things.

But the fact is, without MAP_SHARED, you shouldn't expect things to be 
coherent, even if they often will be (especially for PROT_READ).

Btw, even with Shawn's patch, I wonder if the index_data usage is correct.

			Linus
