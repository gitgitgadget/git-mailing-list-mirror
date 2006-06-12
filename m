From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: svn to git, N-squared?
Date: Mon, 12 Jun 2006 10:08:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606120958230.5498@g5.osdl.org>
References: <20060612043949.20992.qmail@science.horizon.com> 
 <9e4733910606120832xaf74e77pad7f70df864541fc@mail.gmail.com> 
 <Pine.LNX.4.64.0606120843340.5498@g5.osdl.org> 
 <9e4733910606120855p1cec9acfy62dadb89c11756b4@mail.gmail.com> 
 <Pine.LNX.4.64.0606120906210.5498@g5.osdl.org> 
 <9e4733910606120922g181a5aaal623fd3f29b839f4c@mail.gmail.com> 
 <Pine.LNX.4.64.0606120938490.5498@g5.osdl.org>
 <9e4733910606120944p4deb170ejc2863846685917f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux@horizon.com" <linux@horizon.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 19:08:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fpptf-0007Jm-LW
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 19:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWFLRIM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 13:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWFLRIM
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 13:08:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64973 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751103AbWFLRIK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jun 2006 13:08:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5CH86gt021003
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Jun 2006 10:08:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5CH851s028218;
	Mon, 12 Jun 2006 10:08:06 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606120944p4deb170ejc2863846685917f6@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21718>



On Mon, 12 Jun 2006, Jon Smirl wrote:
> 
> The svn repository was built by cvs2svn, none of the git tools were involved.

Ok, so that part is purely a SVN issue.

Having that many files in a single directory (or two) is a total disaster. 
That said, it works well enough if you don't create new files very often 
(and _preferably_ don't look them up either, although that is effectively 
helped by indexing). I _suspect_ that 

 - the "cvs->svn" import process was probably optimized so that it did one 
   file at a time (your "eight stages" description certainly sounds as if 
   it could do it), and in that case it's entirely possible that that can 
   be done efficiently (ie you still do file creates and lookups in an 
   increasingly big directory, but you do it only _once_ per file, rather 
   than look up old files all the time). So your lookup ratio would be 1:1 
   with the files.

   Doing a git-cvsimport would then do basically random lookups in that 
   _huge_ directory, and instead of reading the files one at a time (and 
   fully) and never again, I assume it opens them, reads one revision, 
   closes it, and then goes on to the next revision, so it will have a 
   much higher lookup ratio (you'd look up every file several times).

 - I suspect the SVN people must be hurting for performance themselves. I 
   guess they don't expect to be able to do 5-10 commits per second, the 
   way git was designed to do. So they optimized the cvs import part, but 
   their actual regular live usage is probably hitting this same directory 
   inefficiency.

Of course, the old SVN Berkeley DB usage was probably even worse (not in 
system time, but I'd expect the access patterns within the BDB file to be 
pretty nasty, and probably a lot of user time spent seeking around it). 
But in this particular case, it might even have been better.

Maybe we could teach the SVN people about pack-files? ;)

			Linus
