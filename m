From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mozilla .git tree
Date: Fri, 1 Sep 2006 11:35:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609011129270.27779@g5.osdl.org>
References: <20060829165811.GB21729@spearce.org>
 <9e4733910608291037k2d9fb791v18abc19bdddf5e89@mail.gmail.com>
 <20060829175819.GE21729@spearce.org> <9e4733910608291155g782953bbv5df1b74878f4fcf1@mail.gmail.com>
 <20060829190548.GK21729@spearce.org> <9e4733910608291252q130fc723r945e6ab906ca6969@mail.gmail.com>
 <20060829232007.GC22935@spearce.org> <9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com>
 <20060830015122.GE22935@spearce.org> <9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
 <20060830031029.GA23967@spearce.org> <Pine.LNX.4.64.0608300124550.9796@xanadu.home>
 <7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <44F871BA.3070303@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 01 20:35:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJDrh-0007Kv-Sx
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 20:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWIASfi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Sep 2006 14:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWIASfi
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Sep 2006 14:35:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61095 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750738AbWIASfh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Sep 2006 14:35:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k81IZOnW013194
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 1 Sep 2006 11:35:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k81IZNVZ029428;
	Fri, 1 Sep 2006 11:35:23 -0700
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <44F871BA.3070303@gmail.com>
X-Spam-Status: No, hits=-0.453 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26304>



On Fri, 1 Sep 2006, A Large Angry SCM wrote:
> 
> Unfortunately, the zlib CRC is of the _uncompressed_ data [1], so
> inflating the stream is still necessary to check for corruption.

I don't think that is unfortunate.

We really should inflate the stream anyway, since not only inflating it, 
but also applying any deltas to the base object is really the only way to 
verify its correctness for a delta thing. Otherwise, the SHA1 of the base 
could be totally corrupt.

And once you inflate it and apply all deltas, you obviously also get the 
full SHA1 check, so you're _really_ safe.

So let's do the really safe thing first, and see if it actually results in 
any problems.

NOTE NOTE NOTE! We might well choose to do this checking _only_ when we 
write the index file (ie we have "!pack_to_stdout" set). Why? Because if 
we pack to stdout, and don't generate an index file, then by _definition_ 
the other end has to do the index generation, which means that the other 
end will be doing all the SHA1 re-calculation and sanity checking (and 
thus inflation and CRC checking).

So this means that if we only do this for the "!pack_to_stdout" case, we 
won't be adding any overhead to the git network protocol server, only to 
"git repack". Which is exactly what we want to do.

			Linus
