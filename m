From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree -M performance regression in 'next'
Date: Sun, 12 Mar 2006 17:39:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603121733350.3618@g5.osdl.org>
References: <20060311172818.GB32609@c165.ib.student.liu.se>
 <7voe0bdeyr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603120858230.3618@g5.osdl.org>
 <7vk6azcv9y.fsf@assigned-by-dhcp.cox.net> <7vwtezw4ye.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0603121700410.3618@g5.osdl.org> <7vhd63w33n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 02:39:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIc21-00039H-8r
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 02:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWCMBja (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 20:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbWCMBja
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 20:39:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3980 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751395AbWCMBja (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Mar 2006 20:39:30 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2D1dLDZ005646
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Mar 2006 17:39:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2D1dK2X021255;
	Sun, 12 Mar 2006 17:39:21 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd63w33n.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17536>



On Sun, 12 Mar 2006, Junio C Hamano wrote:
> 
> The code uses close to 16-bit hash and I had 65k flat array as a
> hashtable.  That one was what you commented as "4-times as many
> page misses".

Ahh. That explains the limited bits in the hash function too. I only 
looked at the current sources, not at the historic ones.

Btw, the page misses may come from the fact that you allocated and 
re-allocated the flat array all the time. That can be very expensive for 
big allocations, since most libraries may decide that it's a big enough 
area that it should be map/unmap'ed in order to give memory back to the 
system (without realizing that there's another allocation coming soon 
afterwards of the same size).

If you map/unmap, the kernel will end up having to not just use new pages, 
but obviously also clear them for security reasons. So it ends up sucking 
on many levels. In contrast, if you just have a 64k-entry array of "int", 
and allocate it _once_ (instead of once per file-pair) you'll still have 
to clear it in between file-pairs, but at least you won't have the 
overhead of mapping/unmapping it.

The clearing can still be pretty expensive (64k "int" entries is 256kB, 
and since most _files_ are just in the ~4-8kB range, you're spending a 
_lot_ of time just memset'ing). Which is why it's probably a good idea to 
instead default to having just "filesize / 8" entries, but then you can 
obviously not use the hash as the index any more.

		Linus
