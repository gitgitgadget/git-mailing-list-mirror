From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: tree corrupted on disk quota full
Date: Thu, 11 Jan 2007 13:59:39 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701111353030.3594@woody.osdl.org>
References: <20070111125726.GJ1759@mellanox.co.il>
 <Pine.LNX.4.64.0701111023090.3594@woody.osdl.org>
 <Pine.LNX.4.64.0701111109070.3594@woody.osdl.org> <45A6A97F.5080008@shadowen.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 23:00:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H57yN-0007a0-Tm
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 23:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbXAKWAd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 17:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbXAKWAd
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 17:00:33 -0500
Received: from smtp.osdl.org ([65.172.181.24]:38002 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932094AbXAKWAc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 17:00:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0BLxhWi007156
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 11 Jan 2007 13:59:46 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0BLxem2004214;
	Thu, 11 Jan 2007 13:59:42 -0800
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <45A6A97F.5080008@shadowen.org>
X-Spam-Status: No, hits=-0.663 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36620>



On Thu, 11 Jan 2007, Andy Whitcroft wrote:
> 
> The call was intended to replace a common idiom:
> 
> if (xwrite(fd, buf, size) != size)
> 	error

I really don't agree.

You should use "write_or_die()" for this idiom.

There really is two cases:
 - the complex and robust one: "we will keep writing even in the presense 
   of partial writes".

   This is "xwrite()". 

 - the simple case: "write everything", anything else is an error. This is 
   "write_or_die()", or "write_in_full()".

And I claim, that for the "write_in_full()" case, if you EVER get anything 
but the full length back, that's an error.

And it should be treated as such. There is NO POINT in write_in_full() 
ever returning a partial result. It's unrecoverable by design - and if it 
wasn't, you wouldn't use "write_in_full()" in the first place, you'd just 
use "xwrite()".

And returning a partial result in that case is just a recipe for disaster. 
I already pointed to one real bug due to this: write_buffer() was (and 
currently is) simply buggy. And it's buggy EXACTLY becaue 
"write_in_full()" was doing the wrong thing, and just made it easy to 
write buggy code - it was no easier to use than xwrite(), and thus there 
was no point to it. Might as well have just used xwrite() in the first 
place.

So I repeat: either you use "xwrite()" (and handle the partial case), or 
you use "write_in_full()" (and the partial case is an *ERROR*). There is 
no sane middle ground in between those cases.

			Linus
