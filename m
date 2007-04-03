From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 08:15:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 17:15:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYkja-0005j8-1r
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 17:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbXDCPPn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 11:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030317AbXDCPPn
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 11:15:43 -0400
Received: from smtp.osdl.org ([65.172.181.24]:56168 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030307AbXDCPPm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 11:15:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l33FFDPD012711
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 Apr 2007 08:15:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l33FFCve028122;
	Tue, 3 Apr 2007 08:15:13 -0700
X-Spam-Status: No, hits=-0.459 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43623>


Junio, Nico,
 I think we need to do something about it.

CLee was complaining about git-index-pack on #irc with the partial KDE 
repo, and while I don't have the KDE repo, I decided to investigate a bit.

Even with just the kernel repo (with a single 170MB pack-file), I can do

	git index-pack --stdin --fix-thin new.pack < .git/objects/pack/pack-*.pack

and it uses 52s of CPU-time, and on my 4GB machine it actually started 
doing IO and swapping, because git-index-pack grew to 4.8GB in size. So 
while I initially thought I'd want a bigger test-case to see the problem, 
I sure as heck don't.

The 52s of CPU time exploded into almost three minutes of actual 
real-time:

	47.33user 5.79system 2:41.65elapsed 32%CPU
	2117major+1245763minor

And that's on a good system with a powerful CPU, "enough memory" for any 
reasonable development, and good disks! Very much ungood-plus-plus.

I haven't looked into exactly why yet, but I bet it's just that we keep 
every single object expanded in memory. We do need to keep the objects 
around, so that we can resolve delta's, but we can certainly do it other 
ways. 

Two suggestion for other ways:

 - simple one: don't keep unexploded objects around, just keep the deltas, 
   and spend tons of CPU-time just re-expanding them if required.

   We *should* be able to do it with just keeping the original 170MB 
   pack-file in memory, not expanding it to 3.8GB! 

   Still, even this will be painful once you have a big pack-file, and the 
   CPU waste is nasty (although a delta-base cache like we do in 
   sha1_file.c would probably fix it 99% - at that point it's getting 
   less simple, and the "best" solution below looks more palatable)

 - best one: when writing out the pack-file, we incrementally keep a 
   "struct packed_git" around, and update the index for it dynamically, 
   and totally get rid of all objects that we've written out, because we 
   can re-create them.

   This means that we should have _zero_ memory footprint except for the 
   one object that we're working on right then and there, and any 
   unresolved deltas where we've not seen the base at all (and the latter 
   generally shouldn't happen any more with most pack-files)

The "best one" wouldn't seem to be *that* painful, but as mentioned, I 
haven't even started looking at the code yet, I thought I'd try to rope 
Nico into looking at this first ;)

		Linus
