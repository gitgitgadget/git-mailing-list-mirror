From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: tree corrupted on disk quota full
Date: Thu, 11 Jan 2007 21:17:51 +0000
Message-ID: <45A6A97F.5080008@shadowen.org>
References: <20070111125726.GJ1759@mellanox.co.il> <Pine.LNX.4.64.0701111023090.3594@woody.osdl.org> <Pine.LNX.4.64.0701111109070.3594@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 22:18:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H57JP-0004Sk-6J
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 22:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbXAKVSM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 16:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbXAKVSM
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 16:18:12 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:3387 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbXAKVSL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 16:18:11 -0500
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1H57IC-0007GC-0G; Thu, 11 Jan 2007 21:17:00 +0000
User-Agent: Icedove 1.5.0.9 (X11/20061220)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701111109070.3594@woody.osdl.org>
X-Enigmail-Version: 0.94.1.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36611>

Linus Torvalds wrote:
> 
> On Thu, 11 Jan 2007, Linus Torvalds wrote:
>> That said, clearly something didn't check the error return of a write() 
>> call. Some of that got fixed up recently, so it might even be fixed in 
>> current git already.
> 
> I'm not convinced.
> 
> The "write_in_full()" logic is supposed to help people avoid problems, but 
> it *still* returns a success for a partial write.
> 
> Example of extreme breakage:
> 
> 	static int write_buffer(int fd, const void *buf, size_t len)
> 	{
> 	        ssize_t size;
> 	
> 	        size = write_in_full(fd, buf, len);
> 	        if (!size)
> 	                return error("file write: disk full");
> 	        if (size < 0)
> 	                return error("file write error (%s)", strerror(errno));
> 	        return 0;
> 	}
> 
> which is TOTAL GARBAGE, because the disk-full event might have happened in 
> the middle of the write, so "write_in_full()" might have returned 4096, 
> for example, even though the buffer length was much bigger.
> 
> I personally think write_in_full() is totally mis-designed. If you are 
> ready to handle partial writes, you should use "xwrite()". If you're not 
> ready to handle partial writes, you should either use "write_or_die()", 
> _or_ you should expect a partial write to at least return an error code 
> (which is how "write_buffer()" works).
> 
> But that's not how write_in_full() actually works. Write-in-full does not 
> return an error for a partial write, it returns the partial size.
> 
> Which is idiotic. It makes the function pointless. Just use xwrite() for 
> that.

The call was intended to replace a common idiom:

if (xwrite(fd, buf, size) != size)
	error

write_in_full() is intended as a drop in replacement for that.  On a
short write we will return a short count and that will fail such a test.
 The call basically implements the standard write() call semantic with
maximum attempts to complete.

That said returning -1 would have the same effect.

-apw
