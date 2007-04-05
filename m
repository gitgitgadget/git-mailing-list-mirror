From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-{repack,pack-objects} accept --{pack,blob}-limit to control pack size
Date: Thu, 5 Apr 2007 11:53:06 -0400
Message-ID: <20070405155306.GI5436@spearce.org>
References: <56b7f5510704041340l5997b04dp853e8270a644ab28@mail.gmail.com> <alpine.LFD.0.98.0704041750030.28181@xanadu.home> <56b7f5510704041555q4e735961ra9ee8008be0d33db@mail.gmail.com> <20070405065433.GD5436@spearce.org> <Pine.LNX.4.64.0704050831520.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dana How <danahow@gmail.com>, Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 17:53:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZUH1-00080H-NB
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 17:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767118AbXDEPxR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 11:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767117AbXDEPxQ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 11:53:16 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39462 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767118AbXDEPxP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 11:53:15 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HZUGk-0005x0-8W; Thu, 05 Apr 2007 11:53:02 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 828A720FBAE; Thu,  5 Apr 2007 11:53:06 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704050831520.6730@woody.linux-foundation.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43838>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> On Thu, 5 Apr 2007, Shawn O. Pearce wrote:
> > 
> > For glibc we do try to set _FILE_OFFSET_BITS to 64
> 
> I repeat: that's _broken_.
> 
> It's in no way portable. It's a glibc horror. It should not be used.
> 
> It was a quick hack, but the real way to do it is to use "loff_t" and 
> "llseek".

Sure, OK, but that libc function doesn't exist on Mac OS X:

man llseek:

  This function is Linux-specific, and should not be used in programs
  intended to be portable.

So we'd need our own horror to wrap llseek as an lseek fake-alike
anyway.  That's what that glibc horror does, and we didn't have to
write that code.  :-)
 
> But there simply isn't any way to do mmap() or pread() portably outside 
> the 32-bit area. So there are good reasons why we should just limit 
> pack-files to 32-bits on 32-bit architectures.

Not unless your off_t is 64 bits, no.  If it is 64 bits then you
should be able to do a pread or mmap starting past the first 2 GiB.
You just might not be able to ask for a mmap that exceeds 2 GiB in
size, as your size_t may not be that large.  E.g., Darwin/Mac OS X.
Hence the sliding window mmap.

> So I think that Dana's approach is just fundamentally correct. Yeah, we 
> should probably have a 64-bit index as a *possibility*, but it simply 
> isn't a replacement for "keep packs under 2GB in size".

I'm not disagreeing.  Some filesystems (FAT on a USB stick, Dana's
example) just don't want files larger than 2 GiB.  So keeping them
small has a number of advantages.  Plus they are easier to burn on
DVD: 2 packs per DVD.  ;-)

I was simply trying to point out that the mmap code isn't broken
if the off_t is able to handle a file of that size; and if it can't
then other things are broken, like a simple lseek.

-- 
Shawn.
