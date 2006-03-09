From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add git-imap-send.
Date: Thu, 9 Mar 2006 08:41:16 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603090836030.18022@g5.osdl.org>
References: <440C3499.9080000@codeweavers.com> <7vacbz7vod.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0603091227560.20277@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Mike McCormack <mike@codeweavers.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 09 17:42:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHOCg-0003sl-BN
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 17:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWCIQl1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 11:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWCIQl1
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 11:41:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20416 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750762AbWCIQl0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 11:41:26 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k29GfHDZ013840
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 9 Mar 2006 08:41:18 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k29GfGJO003941;
	Thu, 9 Mar 2006 08:41:17 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0603091227560.20277@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17425>



On Thu, 9 Mar 2006, Johannes Schindelin wrote:
> > 
> > > +		if (!memcmp( "imaps:", val, 6 )) {
> > > +			if (!memcmp( "imap:", val, 5 ))
> > 
> > Is val always longer than 5 or 6 bytes here?
> 
> That does not matter, since they are strings, and the memcmp should not 
> look further if they are shorter (because the comparison to '\0' failed 
> already).

No.

It's true that any sane memcmp() will stop when it notices a difference, 
and it's also true that the return value semantics of memcmp() means that 
it has to walk beginning-to-end.

HOWEVER. The key phrase is "_when_ it notices a difference".

It's quite common for optimized memcmp()'s to do things like loading 
several words from both the source and the destinations, and testing them 
together, and only start doing the byte-by-byte comparison when the "big" 
comparison has failed.

So when you do a

	if (!memcmp(string, mystring, mystringlength))
		...

it's entirely possible that it will load bytes from "string" _past_ the 
end of the string because of an unrolled inner loop that does things 
multiple bytes at a time. They won't be used in the eventual result, but 
just the fact that they are loaded from memory can mean that your program 
takes a SIGSEGV, for example, becaue it turns out "string" was just a 
single NUL byte at the end of a page, and there's nothing after it.

IOW, it's a bad optimization.

Use "strncmp()" instead. Yes, it can be slower, exactly because it has to 
check more, but it checks more exactly because memcmp() can cause 
undefined behaviour by running off the end of a string.

		Linus
