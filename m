From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: More problems...
Date: Mon, 2 May 2005 15:19:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505021509530.3594@ppc970.osdl.org>
References: <20050429170127.A30010@flint.arm.linux.org.uk>
 <20050429182708.GB14202@pasky.ji.cz> <20050429195055.GE1233@mythryan2.michonline.com>
 <Pine.LNX.4.58.0504291311320.18901@ppc970.osdl.org> <7vhdhp47hq.fsf@assigned-by-dhcp.cox.net>
 <20050429221903.F30010@flint.arm.linux.org.uk>
 <Pine.LNX.4.60.0504292254430.25700@hermes-1.csi.cam.ac.uk>
 <20050502193327.GB20818@pasky.ji.cz> <Pine.LNX.4.60.0505022258150.27741@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Russell King <rmk@arm.linux.org.uk>,
	Junio C Hamano <junkio@cox.net>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 00:17:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSjD6-0002B7-8M
	for gcvg-git@gmane.org; Tue, 03 May 2005 00:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVEBWRg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 18:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVEBWRg
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 18:17:36 -0400
Received: from fire.osdl.org ([65.172.181.4]:47338 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261175AbVEBWRd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 18:17:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j42MHGs4012723
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 2 May 2005 15:17:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j42MHFwT023418;
	Mon, 2 May 2005 15:17:15 -0700
To: Anton Altaparmakov <aia21@cam.ac.uk>
In-Reply-To: <Pine.LNX.4.60.0505022258150.27741@hermes-1.csi.cam.ac.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 2 May 2005, Anton Altaparmakov wrote:
> 
> Yes, yes, I know all tools are perfect and never have bugs but I am
> paranoid.  (-;

I do agree.

I think hardlinks are wonderful for

 - "git farms" (ie something like what kernel.org does, but in a more 
   controlled manner - right now kernel.org is really just a standard
   location for different people putting their own files in).

   In this environment, doing hard-linking should also imply 

	- mounting the filesystem "noatime"
	- using a different UID for the hardlinked objects

   ie the "farm administrator" does the hardlinking automatically, and 
   chown()'s them to himself, so that different git trees cannot screw 
   each other up. The "noatime" thing is there because having different 
   users means that git's internal "O_NOATIME" optimization no longer 
   works, and you really want to avoi dgetting lots of write-backs just 
   for "atime".

 - people who have lots of trees. I think Jeff Garzik has something like
   20+ BK trees. At that point, hardlinking just makes sense, and your 
   work patterns are likely to be aware of the different trees anyway.

But for "normal" situations, where you have a tree or two, the hardlinking 
win might not be big enough to warrant the maintenance headache. With 
hardlinking, you _do_ need to "trust" the other trees to some degree.

		Linus
