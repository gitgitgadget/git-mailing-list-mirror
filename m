From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: If you would write git from scratch now, what would you
 change?
Date: Tue, 27 Nov 2007 08:33:43 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711270821280.5869@woody.linux-foundation.org>
References: <200711252248.27904.jnareb@gmail.com> <20071127014804.GJ14735@spearce.org> <alpine.LFD.0.99999.0711262346410.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 17:34:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix3OX-0005Sy-Cu
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 17:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757765AbXK0QeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 11:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757456AbXK0QeH
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 11:34:07 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48459 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757094AbXK0QeF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2007 11:34:05 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lARGXhBk003181
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 27 Nov 2007 08:33:44 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lARGXhQd020270;
	Tue, 27 Nov 2007 08:33:43 -0800
In-Reply-To: <alpine.LFD.0.99999.0711262346410.9605@xanadu.home>
X-Spam-Status: No, hits=-2.728 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66236>



On Mon, 26 Nov 2007, Nicolas Pitre wrote:

> On Mon, 26 Nov 2007, Shawn O. Pearce wrote:
> 
> > - Loose objects storage is difficult to work with
> > 
> >   The standard loose object format of DEFLATE("$type $size\0$data")
> >   makes it harder to work with as you need to inflate at least
> >   part of the object just to see what the hell it is or how big
> >   its final output buffer needs to be.
> 
> It is a bit cumbersome indeed, but I'm afraid we're really stuck with it 
> since every object SHA1 depends on that format.

No. 

The SHA1 itself just depends on "$type $size\0$data" (no deflate phase), 
and that one is easy and cheap to calculate. How we then *encode* the data 
on disk is totally immaterial.

In fact, pack-files obviously do not encode it in that form at all, they 
in fact use two different forms of "$binaryhdr$DEFLATE($data)" or 
"$binaryhdr$basesha$DEFLATE($delta)" (that's from memory, so don't rely on 
that).

So we could easily change the on-disk format, and we obviously have - the 
alternate (but deprecated) format for unpacked objects already did. In 
fact, we could - and probably should - add some kind of "back end 
interface" for alternate encoding formats, in case somebody wants to do 
something really crazy like use a database for object tracking.

(Side note: using an actual database would really be insane. There is 
absoluely zero point. But what *could* be interesting would be to have a 
"cluster back-end" for the git object store, where objects get hashed to 
different nodes. If you have a really fast network, it may actually be 
beneficial to spread the objects out, and get better disk throughput by 
that kind of strange "git object RAID-0 striping" setup)

		Linus

(*) Honesty in advertising: the really *original* format did the SHA1 
after the deflate, but that was quickly fixed and was a really stupid 
choice. The main point for doing that was that it meant that loose objects 
could be verified by just running "sha1sum" on them, and comparing the 
result with their name.
