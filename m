From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: tree corrupted on disk quota full
Date: Thu, 11 Jan 2007 22:10:44 +0000
Message-ID: <45A6B5E4.3050007@shadowen.org>
References: <20070111125726.GJ1759@mellanox.co.il> <Pine.LNX.4.64.0701111023090.3594@woody.osdl.org> <Pine.LNX.4.64.0701111109070.3594@woody.osdl.org> <45A6A97F.5080008@shadowen.org> <Pine.LNX.4.64.0701111353030.3594@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 23:11:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H588b-0001x1-9r
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 23:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbXAKWLG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 17:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbXAKWLG
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 17:11:06 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:3435 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108AbXAKWLE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 17:11:04 -0500
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1H587M-0007Mn-SN; Thu, 11 Jan 2007 22:09:53 +0000
User-Agent: Icedove 1.5.0.9 (X11/20061220)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701111353030.3594@woody.osdl.org>
X-Enigmail-Version: 0.94.1.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36622>

Linus Torvalds wrote:
> 
> On Thu, 11 Jan 2007, Andy Whitcroft wrote:
>> The call was intended to replace a common idiom:
>>
>> if (xwrite(fd, buf, size) != size)
>> 	error
> 
> I really don't agree.
> 
> You should use "write_or_die()" for this idiom.
> 
> There really is two cases:
>  - the complex and robust one: "we will keep writing even in the presense 
>    of partial writes".
> 
>    This is "xwrite()". 
> 
>  - the simple case: "write everything", anything else is an error. This is 
>    "write_or_die()", or "write_in_full()".
> 
> And I claim, that for the "write_in_full()" case, if you EVER get anything 
> but the full length back, that's an error.
> 
> And it should be treated as such. There is NO POINT in write_in_full() 
> ever returning a partial result. It's unrecoverable by design - and if it 
> wasn't, you wouldn't use "write_in_full()" in the first place, you'd just 
> use "xwrite()".
> 
> And returning a partial result in that case is just a recipe for disaster. 
> I already pointed to one real bug due to this: write_buffer() was (and 
> currently is) simply buggy. And it's buggy EXACTLY becaue 
> "write_in_full()" was doing the wrong thing, and just made it easy to 
> write buggy code - it was no easier to use than xwrite(), and thus there 
> was no point to it. Might as well have just used xwrite() in the first 
> place.
> 
> So I repeat: either you use "xwrite()" (and handle the partial case), or 
> you use "write_in_full()" (and the partial case is an *ERROR*). There is 
> no sane middle ground in between those cases.

Things should be safe in general with the code as it is as we are
checking the write length.  But it is clear that converting to an error
would simplify and clean up the code.  Should have done that the first
time.

If its not done in the morning, I'll fix it up.

-apw
