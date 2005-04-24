From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git.git object database at kernel.org?
Date: Sun, 24 Apr 2005 16:08:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504241553580.18901@ppc970.osdl.org>
References: <7vhdhvstb2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Apr 25 01:01:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPq6W-0001Rb-Dz
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 01:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbVDXXG0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 19:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262475AbVDXXG0
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 19:06:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:31184 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262474AbVDXXGT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 19:06:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3ON6Ds4027016
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 24 Apr 2005 16:06:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3ON6CK7022494;
	Sun, 24 Apr 2005 16:06:13 -0700
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhdhvstb2.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Junio just pointed out that "convert-cache" didn't actually handle some of 
the old-style commits that git itself has (notably, the date changes).

I fixed that, and converted git, so that the dates are now correct in "git
log" for the early commit entries too.

This means that all the commit objects in my git tree ended up being
re-generated: the data itself doesn't change, and none of the tree or blob
objects are any different, but since the first "commit" changed (the first
several ones, in fact - it was about a week until the date format got
fixed), the whole chain of commits ends up being different.

That has almost zero impact _except_ for anybody who merges directly with 
my tree using git itself. You now have two choices:

 - convert your own git tree (probably a good thing, otherwise your old 
   commit entries will always be bogus), at which point it should just 
   merge fine with mine automatically.

   NOTE! The fact that "mktime()" seems to depend on the timezone in which 
   it is made seems to make this questionable. I had always assumed that 
   mktime would take the timezone from the "struct tm", and thus be 
   reliable, but somebody seems to have shown that that is not the case at 
   all!

   It's entirely possible that you need to do something stupid like

	TZ=US/Pacific

   before you convert your tree. I wonder if this might also explain the 
   problems some people (notably Russell) had at around the conversion..

   Anyway, _if_ your conversion was successful and matches mine, you
   should now have a root "e83c5163316f89bfbde7d9ab23ca2e25604af290", that
   is reachable from the result of the conversion (check with "git log
   <result>"). You should also have as a top (unless you have made changes 
   of your own):

	commit 3f053897b3445988309d0ae7378944783c34d152
	tree f5c350ae39f61486622c84597a507611e62fa6af
	parent c6e007b0942a373bbf87fa3e4e11e2d90907de8c
	author Linus Torvalds <torvalds@ppc970.osdl.org> Sun Apr 24 22:49:09  2005
	committer Linus Torvalds <torvalds@ppc970.osdl.org> Sun Apr 24 22:49:09  2005
	
	  Update "convert-cache" to handle git itself.
	  
	  The git archives have some old-date-format commits with timezones
	  that the converter didn't recognize. Also, make it be quiet about
	  already-converted dates.

   If it doesn't match that, you can run "convert-cache" (with the
   _original_ head) several times. When you are happy that it's all ok,
   you can "commit" the result by writing it to your .git/HEAD file.

 - alternatively, if you don't want to convert your thing, you can give a 
   "base commit" by hand when merging, and select one where the "tree"  
   object matches in both mine and yours. This isn't something I would 
   recommend, but it should work and "meld" the two commit chains together 
   even though their root entries differ.

Sorry about all this, I had totally forgotten that we had old-style dates 
in our git commit history.

			Linus
