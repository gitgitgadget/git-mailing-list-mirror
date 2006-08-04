From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Creating objects manually and repack
Date: Thu, 3 Aug 2006 22:01:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608032150510.4168@g5.osdl.org>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com> 
 <Pine.LNX.4.64.0608032052210.4168@g5.osdl.org>
 <9e4733910608032124o5b5b69b5hda2eb8cb1e0ac959@mail.gmail.com>
 <Pine.LNX.4.64.0608032138330.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 04 07:01:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8roV-0000q2-8v
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 07:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWHDFBU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 01:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWHDFBU
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 01:01:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18662 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751380AbWHDFBT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 01:01:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7451EnW026875
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 3 Aug 2006 22:01:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7451Dpa020790;
	Thu, 3 Aug 2006 22:01:13 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0608032138330.4168@g5.osdl.org>
X-Spam-Status: No, hits=-0.455 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.142 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24775>



On Thu, 3 Aug 2006, Linus Torvalds wrote:
> 
> Sure. In that case, just list the object ID's in the exact same order you 
> created them.

Btw, you still want to give a filename for each object you've created, so 
that the delta sorter does the right thing for the packing. It doesn't 
have to be a _real_ filename - just make sure that each revision that 
comes from the same file has a filename that matches all the other 
revisions from that file.

What the filename actually _is_ doesn't much matter, and it doesn't have 
to be the "real" filename that was associated with that set of revisions, 
since we'll just end up hashing it anyway. So it could be some "SVN inode 
number" for that set of revisions or something, for all git-pack-object 
cares.

So you could just go through each SVN file in whatever the SVN database is 
(I don't know how SVN organizes it), generate every revisions for that 
file, and pass in the SVN _database_ filename, rather than necessarily the 
filename that that revision is actually associated with when checked out.

So for example, if SVN were to use the same kind of "Attic/filename,v" 
format that CVS uses, there's no reason to worry what the real filename 
was in any particular checked out tree, you could just pass 
git-pack-objects a series of lines in the form of

	..
	<sha1-object-name-of-rev1> Attic/filename,v
	<sha1-object-name-of-rev2> Attic/filename,v
	<sha1-object-name-of-rev3> Attic/filename,v
	..

as input on its stdin, and it will create a pack-file of all the objects 
you name, and use the "Attic/filename,v" info as the deltifier hint to 
know to do all the deltas of those revs against each other rather than 
against random other objects.

The fact that the file was actually checked out as "src/filename" (and, 
since SVN supports renaming, it might have been checked out under any 
number of _other_ names over the history of the project) doesn't matter, 
and you don't need to even try to figure that out. git-pack-objects 
wouldn't care anyway.

			Linus
