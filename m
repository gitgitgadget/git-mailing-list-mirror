From: "Tjernlund" <tjernlund@tjernlund.se>
Subject: RE: error: wrong index file size in /usr/local/src/jffs2_mtd_patches/.git/objects/pack/pack-da39a3ee5e6b4b0d32 55bfef95601890afd80709.idx
Date: Tue, 26 Jun 2007 23:14:47 +0200
Message-ID: <001601c7b837$067d1040$0e67a8c0@Jocke>
References: <alpine.LFD.0.98.0706261341190.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Linus Torvalds'" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 26 23:14:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3IN9-0001vJ-91
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 23:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758308AbXFZVOt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 17:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758294AbXFZVOt
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 17:14:49 -0400
Received: from csmtp.b-one.net ([195.47.247.21]:41468 "EHLO csmtp1.b-one.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758270AbXFZVOs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 17:14:48 -0400
Received: from Jocke (84-217-10-122.tn.glocalnet.net [84.217.10.122])
	by csmtp1.b-one.net (Postfix) with ESMTP id 839F419115179;
	Tue, 26 Jun 2007 23:14:47 +0200 (CEST)
X-Mailer: Microsoft Office Outlook 11
thread-index: Ace4NKWh4lrloy+OQHGfNqCwVChD8gAAixFg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
In-Reply-To: <alpine.LFD.0.98.0706261341190.8675@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50976>

 

> -----Original Message-----
> From: Linus Torvalds [mailto:torvalds@linux-foundation.org] 
> Sent: den 26 juni 2007 22:45
> To: Tjernlund
> Cc: git@vger.kernel.org
> Subject: Re: error: wrong index file size in 
> /usr/local/src/jffs2_mtd_patches/.git/objects/pack/pack-da39a3
> ee5e6b4b0d32 55bfef95601890afd80709.idx
> 
> 
> 
> On Tue, 26 Jun 2007, Tjernlund wrote:
> >
> > Did this and got a small error that I don't think should be there:
> 
> Heh. I think I see what's wrong..
> 
> > Indexing 0 objects...
> > remote: Total 0 (delta 0), reused 0 (delta 0)
> 
> Ok, there were no objects that weren't in the reference repo. 
> So far so 
> good.
> 
> But:
> 
> > error: wrong index file size in 
> /usr/local/src/jffs2_mtd_patches/.git/objects/pack/pack-da39a3
ee5e6b4b0d3255bfef95601890afd80709.idx
> 
> I think this is because of that zero size:
> 
>                 /*
>                  * Minimum size:
>                  *  - 8 bytes of header
>                  *  - 256 index entries 4 bytes each
>                  *  - 20-byte sha1 entry * nr
>                  *  - 4-byte crc entry * nr
>                  *  - 4-byte offset entry * nr
>                  *  - 20-byte SHA1 of the packfile
>                  *  - 20-byte SHA1 file checksum
>                  * And after the 4-byte offset table might be a
>                  * variable sized table containing 8-byte entries
>                  * for offsets larger than 2^31.
>                  */
>                 unsigned long min_size = 8 + 4*256 + nr*(20 + 
> 4 + 4) + 20 + 20;
>                 if (idx_size < min_size || idx_size > 
> min_size + (nr - 1)*8) {
> 
> Notice the "(nr - 1)*8" thing. And notice how "nr-1" 
> underflows when nr is 
> zero..
> 
> I bet it goes away if you remove the "-1", or if you do 
> something like 
> this (totally untested!) patch.
> 
> 		Linus

[SNIP patch]

Tested your patch and the error went away, many thanks

 Jocke 
