From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] diff-cache/tree compatible output for show-diff (take
 2).
Date: Tue, 26 Apr 2005 18:09:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504261805070.18901@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504232202340.19877@ppc970.osdl.org>
 <7v1x8zsamn.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504251832480.18901@ppc970.osdl.org>
 <7vy8b5mawy.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504261534590.18901@ppc970.osdl.org>
 <7vd5shm94l.fsf@assigned-by-dhcp.cox.net> <7vy8b5ksqi.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504261719230.18901@ppc970.osdl.org>
 <Pine.LNX.4.58.0504261725470.18901@ppc970.osdl.org>
 <Pine.LNX.4.58.0504261750030.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 03:03:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQaxB-0001tk-Mm
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 03:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVD0BIM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 21:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbVD0BIL
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 21:08:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:60315 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261876AbVD0BID (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 21:08:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3R17ws4012521
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 18:07:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3R17veC021866;
	Tue, 26 Apr 2005 18:07:58 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0504261750030.18901@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 26 Apr 2005, Linus Torvalds wrote:
> 
> I'll need to fix that up, because right now it does the wrong thing (which
> it has always done): since we _remove_ all the merge entries, we'll first
> warn about them, but then we'll show the original file going away if there
> was one. Which is bogus.

Fixed. I think. My solution is clever, but untested.

What I do is that instead of _removing_ the unmerged entries (which we 
can't do, or we'd later think that the file has gone away if we see that 
same name in the tree we're comparing against), I make all unmerged 
entries be in "stage 3".

Then, when we read in the tree to compare against into stage 1, we have a 
few cases:

 - stage 0 only: new file
 - stage 0 and 1: modified file
 - stage 1 only: deleted file
 - stage 1 and 3: unmerged
 - stage 3 only: unmerged

See any problems with this? (a mix of 0 and 3 cannot happen - a file is
either unmerged or it is ok, since inserting a stage 0 entry always
removes all unmerged entires).

		Linus
