From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 13:56:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
 <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704031625050.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Lee <clee@kde.org>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 22:58:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYq4n-0007TY-3K
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 22:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610AbXDCU55 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 16:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753626AbXDCU55
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 16:57:57 -0400
Received: from smtp.osdl.org ([65.172.181.24]:43659 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753610AbXDCU55 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 16:57:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l33KupPD022616
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 Apr 2007 13:56:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l33KuoKP002984;
	Tue, 3 Apr 2007 13:56:50 -0700
In-Reply-To: <alpine.LFD.0.98.0704031625050.28181@xanadu.home>
X-Spam-Status: No, hits=-0.457 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43661>



On Tue, 3 Apr 2007, Nicolas Pitre wrote:
> > 
> > Yeah. What happens is that inside the repo, because we do all the 
> > duplicate object checks (verifying that there are no evil hash collisions) 
> > even after fixing the memory leak, we end up keeping *track* of all those 
> > objects.
> 
> What do you mean?

Look at what we have to do to look up a SHA1 object.. We create all the 
lookup infrastructure, we don't *just* read the object. The delta base 
cache is the most obvious one. 

> I'm of the opinion that this patch is unnecessary.  It only helps in 
> bogus workflows to start with, and it makes the default behavior unsafe 
> (unsafe from a paranoid pov, but still).  And in the _normal_ workflow 
> it should never trigger.

Actually, even in the normal workflow it will do all the extra unnecessary 
work, if only because the lookup costs of *not* finding the entry.

Lookie here:

 - git index-pack of the *git* pack-file in the v2.6/linux directory (zero 
   overlap of objects)

   With --paranoid:

	2.75user 0.37system 0:03.13elapsed 99%CPU
	0major+5583minor pagefaults

   Without --paranoid:

	2.55user 0.12system 0:02.68elapsed 99%CPU
	0major+2957minor pagefaults

See? That's the *normal* workflow. Zero objects found. 7% CPU overhead 
from just the unnecessary work, and almost twice as much memory used. Just 
from the index file lookup etc for a decent-sized project.

Now, in the KDE situation, the *unnecessary* lookups will be about ten 
times more expensive, both on memory and CPU, just because the repository 
is about 20x the size. Even with no actual hits.

		Linus
