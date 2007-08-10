From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fix "git commit directory/" performance anomaly
Date: Fri, 10 Aug 2007 10:14:25 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708101008230.30176@woody.linux-foundation.org>
References: <20070809163026.GD568@mbox.bz>
 <alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091056180.25146@woody.linux-foundation.org>
 <7vmyx0y3vp.fsf@assigned-by-dhcp.cox.net> <7v7io4xwvp.fsf@assigned-by-dhcp.cox.net>
 <20070809165218.9b76ebf7.seanlkml@sympatico.ca>
 <alpine.LFD.0.999.0708091426050.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091444550.25146@woody.linux-foundation.org>
 <7vtzr8wemb.fsf@assigned-by-dhcp.cox.net> <7vps1wwa5w.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0708091734210.25146@woody.linux-foundation.org>
 <7vhcn8w6sw.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0708091754150.25146@woody.linux-foundation.org>
 <7v643ovyli.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0708100852540.30176@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708100924570.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, moe <moe-git@mbox.bz>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 19:20:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJYA9-0007Ef-O1
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 19:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbXHJRUe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 13:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753789AbXHJRUe
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 13:20:34 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35403 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751028AbXHJRUd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Aug 2007 13:20:33 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7AHEZv1027208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 10 Aug 2007 10:14:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7AHEP3h032186;
	Fri, 10 Aug 2007 10:14:30 -0700
In-Reply-To: <alpine.LFD.0.999.0708100924570.30176@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.21__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55558>



On Fri, 10 Aug 2007, Linus Torvalds wrote:
>
> This improves the cold-cache case immensely, since we don't need to bring 
> in all the file contents, just the index and any files dirty in the index.

The extreme - but not necessarily unusual - case of this is when the index 
and stat information is hot-cache (which is quite normal, in case you've 
done a "git diff" or something like that), but the whole source tree is 
otherwise not. Then the numbers look like this:

Before:
	[torvalds@woody linux]$ time git commit .
	real    1m33.751s
	user    0m3.864s
	sys     0m2.160s


After:
	[torvalds@woody linux]$ time git commit .
	real    0m1.415s
	user    0m1.176s
	sys     0m0.260s

The all-hot-cache numbers are better too, of course, just not nearly as 
noticeable:

Before:
	[torvalds@woody linux]$ time git commit .
	real    0m3.960s
	user    0m3.304s
	sys     0m0.672s

(and the after case is that 1.415s above, of course, so it's still more 
than twice as fast - it's just no longer a 60x performance difference!).

(Honesty in advertising: the "after" numbers also contain the "runstatus" 
speedup, which is the 0.5s -> 0.3s improvement)

			Linus
