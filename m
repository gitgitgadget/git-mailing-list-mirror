From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git merge performance problem..
Date: Sat, 15 Jul 2006 21:26:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607152119510.2438@evo.osdl.org>
References: <Pine.LNX.4.64.0607151445270.5623@g5.osdl.org>
 <7v7j2eme3u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 16 06:25:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1yCE-00035H-5V
	for gcvg-git@gmane.org; Sun, 16 Jul 2006 06:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161067AbWGPEZV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Jul 2006 00:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWGPEZV
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Jul 2006 00:25:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18645 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030320AbWGPEZU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Jul 2006 00:25:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6G4PEnW006802
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 15 Jul 2006 21:25:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6G4PD9a018267;
	Sat, 15 Jul 2006 21:25:14 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j2eme3u.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.651 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23944>



On Sat, 15 Jul 2006, Junio C Hamano wrote:
> 
> The code is to cull redundant parents primarily in octopus and
> is not strictly necessary.  Can I have the $head and $@ (the
> other merge parents, but in your case you never do an octopus so
> that would be the other branch head) to see what is going on
> please?

I think it was commit b20e481 that I reacted to this time, merging b5032a5 
and 48ce8b0.

Ie, lookie here:

	[torvalds@evo linux]$ time git merge-base --all b5032a5 48ce8b0
	672c6108a51bf559d19595d9f8193dfd81f0f752
	
	real    0m1.426s
	user    0m1.404s
	sys     0m0.016s

so it can find a merge-base in 1.4 seconds, which should certainly 
guarantee that they are independent. Then:

	[torvalds@evo linux]$ time git-show-branch --independent b5032a5 48ce8b0
	b5032a50aea76b6230db74b1d171a7f56b204bb7
	48ce8b056c88920c8ac187781048f5dae33c81b9
	
	real    0m30.657s
	user    0m30.414s
	sys     0m0.076s

Whee. Half a minute. Ok, so this is on my laptop (I'm oat the airport 
right now), so it was probably twice as fast on my desktop, but that is 
still not acceptable.

I really don't know what it's doing, because

	[torvalds@evo linux]$ time git-rev-list b5032a5 48ce8b0 > /dev/null 
	
	real    0m3.248s
	user    0m2.588s
	sys     0m0.036s

so it's really doing something very expensive - more so than just parsing 
the commits.

		Linus
