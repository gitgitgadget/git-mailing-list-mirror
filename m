From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 13:33:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704031322490.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
 <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Chris Lee <clee@kde.org>, Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 03 22:44:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYprg-00086P-Dc
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 22:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945898AbXDCUoZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 16:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945934AbXDCUoZ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 16:44:25 -0400
Received: from smtp.osdl.org ([65.172.181.24]:42979 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945898AbXDCUoY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 16:44:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l33KXRPD022076
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 Apr 2007 13:33:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l33KXOTA002544;
	Tue, 3 Apr 2007 13:33:25 -0700
In-Reply-To: <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.457 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43659>



On Tue, 3 Apr 2007, Linus Torvalds wrote:
> 
> So how about this updated patch? We could certainly make "git pull" imply 
> "--paranoid" if we want to, but even that is likely pretty unnecessary. 
> It's not like anybody has ever shown a SHA1 collision, and if the *local* 
> repository is corrupt (and has an object with the wrong SHA1 - that's what 
> the testsuite checks for), then it's probably good to get the valid object 
> from the remote..

Some trivial timings for indexing just the kernel pack..

Without --paranoid:

	24.61user 2.16system 0:27.04elapsed 99%CPU
	0major+14120minor pagefaults

With --paranoid:

	42.74user 3.04system 0:46.36elapsed 98%CPU
	0major+72768minor pagefaults

so it's a noticeable CPU issue, but it's even more noticeable in memory 
usage (55MB vs 284MB - pagefaults give a good way to look at how much 
memory really got allocated for the process).

All that extra memory is just for SHA1 commit ID information. 

Now, clearly the usage scenario here is a big odd (ie the case where we 
have all the objects already), so in that sense this is very much a 
worst-case situation, and you simply shouldn't *do* something like this, 
but at the same time, I'm just not convinced a very theoretical SHA1 
collision check is worth it. 

Btw, even if we don't have any of the objects, if you have tons and tons 
of objects and do a "git pull", just the *lookup* of the nonexistent 
objects will be expensive: first we won't find it in any pack, then we'll 
look at the loose objects, and then we'll look int he pack *again* due to 
the race avoidance. So looking up nonexistent objects is actually pretty 
expensive.

In fact, "--paranoid" takes one second more for me even totally outside of 
a git repository, just because we waste so much time trying to look up 
non-existent object files ;)

			Linus
