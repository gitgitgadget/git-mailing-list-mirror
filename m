From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] prune: --expire=time
Date: Sun, 21 Jan 2007 18:23:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701211813410.14248@woody.osdl.org>
References: <7vy7o0klt1.fsf@assigned-by-dhcp.cox.net> <20070119034404.GA17521@spearce.org>
 <20070119104935.GA5189@moooo.ath.cx> <7vfya6hll3.fsf@assigned-by-dhcp.cox.net>
 <20070120111832.GA30368@moooo.ath.cx> <7vlkjw50nl.fsf@assigned-by-dhcp.cox.net>
 <20070121103724.GA23256@moooo.ath.cx> <7vejpo39zg.fsf@assigned-by-dhcp.cox.net>
 <20070121220114.GA24729@coredump.intra.peff.net> <45B415B1.30407@midwinter.com>
 <20070122015252.GA26934@coredump.intra.peff.net> <7vwt3fx1am.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 03:23:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8oqU-0002Ok-NK
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 03:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbXAVCXe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 21:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751879AbXAVCXe
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 21:23:34 -0500
Received: from smtp.osdl.org ([65.172.181.24]:51010 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876AbXAVCXe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 21:23:34 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0M2NUhB011027
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 21 Jan 2007 18:23:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0M2NTNR014829;
	Sun, 21 Jan 2007 18:23:30 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwt3fx1am.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.66 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37386>



On Sun, 21 Jan 2007, Junio C Hamano wrote:
> 
> This case does not need any locking, as blobs reachable from
> index are considered as "reachable" for the purpose of pruning.

Well, strictly speaking, there's a race there. The new index gets written 
out _after_ the blob has been created. Also, in many cases, we end up 
using completely temporary indexes ("git commit filename") that "git 
prune" doesn't know or understand.

All of which is really nothing new. "git prune" has always been dangerous. 
You cannot, and must not, run it concurrently with other git operations.

Also, in the absense of undo operations, there is really nothing to ever 
prune. Of course, the git.git archive itself has effectively taughth 
people bad habits, since "pu" ends up continually rebasing itself. 

However, now that rebasing ends up being visible in the branch reflog, 
we're back to the "normally nothing to ever prune" situation, and as such, 
the only object pruning that _should_ take place is basically as part of 
"git repack -a -d" (which unlike a prune is actually safe, since it only 
prunes objects that are reachable from a pack).

So to recap: "git prune" simply isn't a safe thing to do. Don't do it 
without thinking. I'm not at all sure it's a good idea that "git gc" does 
it for you, since it just encourages mindless pruning that probably 
shouldn't happen in the first place.

Needing to prune is generally to be taken as a sign of something being 
wrong.

(And yeah, the grace period makes it "safe". Assuming everybody involved 
has even half-way reliable clocks. So IN PRACTICE it is all fine, and I 
doubt you can lose anything except by really doing something insane. If 
you want to kill your archive, it's easier to do "rm .git/objects/*/*a*" 
than it is to try to do it with strange "git prune" setups, but still..)

		Linus
