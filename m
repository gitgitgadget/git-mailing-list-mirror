From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: tree corrupted on disk quota full
Date: Thu, 11 Jan 2007 14:32:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701111428420.3594@woody.osdl.org>
References: <20070111125726.GJ1759@mellanox.co.il>
 <Pine.LNX.4.64.0701111023090.3594@woody.osdl.org>
 <Pine.LNX.4.64.0701111109070.3594@woody.osdl.org> <45A6A97F.5080008@shadowen.org>
 <Pine.LNX.4.64.0701111353030.3594@woody.osdl.org> <45A6B5E4.3050007@shadowen.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 23:33:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H58U1-000859-MP
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 23:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbXAKWdP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 17:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbXAKWdP
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 17:33:15 -0500
Received: from smtp.osdl.org ([65.172.181.24]:39733 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932651AbXAKWdO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 17:33:14 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0BMWvWi008160
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 11 Jan 2007 14:32:57 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0BMWtxR005232;
	Thu, 11 Jan 2007 14:32:55 -0800
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <45A6B5E4.3050007@shadowen.org>
X-Spam-Status: No, hits=-0.663 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36628>



On Thu, 11 Jan 2007, Andy Whitcroft wrote:
>
> > So I repeat: either you use "xwrite()" (and handle the partial case), or 
> > you use "write_in_full()" (and the partial case is an *ERROR*). There is 
> > no sane middle ground in between those cases.
> 
> Things should be safe in general with the code as it is as we are
> checking the write length.

NO WE ARE NOT.

I already pointed you to write_buffer(). It used to do the right thing. It 
doesn't any more. And it doesn't, exactly because you converted it away 
from a loop that did it right, to doing "write_in_full()" and NOT checking 
the return value properly.

The thing is, if you support partial writes (ie xwrite()), you need to do 
it in a loop, and then the correct thing to check for is "zero or error".

Once you don't do a loop (ie "write_in_full()" - the whole _point_ is to 
not do the loop, after all), you need to either expand that check to "zero 
or error or partial" (which just makes the code _more_ complex), or you 
need to make "write_in_full()" just return an error for the partial case.

Which is why I'm harping on this issue: either we use "xwrite()", or we 
fix "write_in_full()" to return errors on partials. Because the "middle 
ground", where write_in_full() emulates the partial case of "xwrite()" is 
actually MORE complex than "xwrite()" itself.

		Linus
