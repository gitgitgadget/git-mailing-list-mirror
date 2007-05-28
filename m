From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] Lazily open pack index files on demand
Date: Mon, 28 May 2007 09:22:02 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705280907290.26602@woody.linux-foundation.org>
References: <20070526052419.GA11957@spearce.org> <7vabvsm1h8.fsf@assigned-by-dhcp.cox.net>
 <56b7f5510705261031o311b89bapd730374cbc063931@mail.gmail.com>
 <20070527033429.GY28023@spearce.org> <alpine.LFD.0.99.0705271110550.3366@xanadu.home>
 <20070527215245.GD28023@spearce.org>
 <alpine.LFD.0.99.0705271929480.3366@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Dana How <danahow@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon May 28 18:22:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hshzg-0004PQ-7S
	for gcvg-git@gmane.org; Mon, 28 May 2007 18:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbXE1QWm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 12:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbXE1QWm
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 12:22:42 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:39491 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750826AbXE1QWl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 May 2007 12:22:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4SGM4Ic006092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 May 2007 09:22:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4SGM204016645;
	Mon, 28 May 2007 09:22:03 -0700
In-Reply-To: <alpine.LFD.0.99.0705271929480.3366@xanadu.home>
X-Spam-Status: No, hits=-3.016 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48620>



On Sun, 27 May 2007, Nicolas Pitre wrote:
> 
> It helps irrespective of the number of pack files.  With the current 
> binary search the lookup cost is O(log n).  With a Newton method this 
> cost is almost O(1).

This is not true.

First off, when comparing O(logn) to O(1), with "n" being less than a 
billion, they are pretty much exactly the same. Think of it this way: 
O(logn) == O(9) == O(1), if you know that n < 10**9.

Secondly, the cost of Newton isn't "almost O(1)". I don't know _what_ it 
is (the rule of thumb with Newton-Raphson should be that the number of 
significant correct digits in the answer doubles with each iteration: I 
think that probably means that it should approximate O(loglog(n)), but I 
haven't thought deeply about it.

But regardless, we end up testing "a few" values. Both for the binary 
search and for Newton-Raphson.

So every time you talk about O-notation, you should also consider the 
constant costs, especially if the function in question is a slow-changing 
one (ie when we start talking O(N**3) we can start ignoring the constants. 
With O(logn), you sure as hell cannot!)

And the thing is, Newton-Raphson didn't actually speed anything up in my 
tests. Sometimes it was better, sometimes it was worse, most of the time 
it was in the noise.

Now, I'm sure the thing could be tweaked. Maybe I didn't do a very good 
job at my initial implementation. It was a quick hack. But before somebody 
makes a better one and actually shows better performance, I'd say that the 
jury is still out.

		Linus
