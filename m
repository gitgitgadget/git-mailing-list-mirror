From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 14:24:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704031413200.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
 <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704031322490.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704031657130.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Lee <clee@kde.org>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:26:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYqW7-0006zH-6d
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 23:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945961AbXDCVZu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 17:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945967AbXDCVZu
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 17:25:50 -0400
Received: from smtp.osdl.org ([65.172.181.24]:44749 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945961AbXDCVZt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 17:25:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l33LOkPD023377
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 Apr 2007 14:24:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l33LOjDd003687;
	Tue, 3 Apr 2007 14:24:46 -0700
In-Reply-To: <alpine.LFD.0.98.0704031657130.28181@xanadu.home>
X-Spam-Status: No, hits=-0.455 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43669>



On Tue, 3 Apr 2007, Nicolas Pitre wrote:
>
> I don't see where that might be.  The only thing that the paranoia check 
> triggers is:
> 
> 	foo = read_sha1_file(blah);
> 	memcmp(foo with bar);
> 	free(foo);
> 
> So where is that commit ID information actually stored when using 
> read_sha1_file()?

I've got the numbers: it uses much more memory when doing even failing 
lookups, ie:

	With --paranoid: 5583 minor pagefaults (21MB)
	Without --paranoid: 2957 minor pagefaults (11MB)

(remember, this was *just* the git pack, not the kernel pack)

It could be as simple as just the index file itself. That's 11MB for the 
kernel. Imagine if the index file was 20 times bigger - 200MB of memory 
paged in with bad access patterns just for unnecessary lookups.

Running valgrind shows no leak at all without --paranoid. With --paranoid, 
there's some really trivial stuff (the "packed_git" structure etc, so I 
think it's really just the index itself).

> Not if you consider that it is performed _while_ receiving (and waiting 
> for) the pack data over the net in the normal case.

..which is why I think it makes sense for "pull" to be paranoid. I just 
don't think it makes sense to be paranoid *all* the time, since it's 
clearly expensive.

		Linus
