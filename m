From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Does GIT has vc keywords like CVS/Subversion?
Date: Tue, 10 Oct 2006 10:14:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610101005420.3952@g5.osdl.org>
References: <4b3406f0610081825y1d066579yba305b6540c8d0e9@mail.gmail.com>
 <4529B77A.707@gmail.com> <Pine.LNX.4.64.0610090904360.3952@g5.osdl.org>
 <46a038f90610091408y29f60a12gea7040b5412331c6@mail.gmail.com>
 <20061010164927.GC16412@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 19:16:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXLC8-0005qP-MG
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 19:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWJJRPE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 13:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWJJRPD
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 13:15:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1710 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964794AbWJJRPA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 13:15:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9AHEtaX003626
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Oct 2006 10:14:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9AHEsoT015549;
	Tue, 10 Oct 2006 10:14:54 -0700
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061010164927.GC16412@spearce.org>
X-Spam-Status: No, hits=-0.467 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28637>



On Tue, 10 Oct 2006, Shawn Pearce wrote:
> 
> Now I'd like to take these snapshots every so often, load them
> into Git on a special branch just for the snapshots, then generate
> a merge commit on that branch which merges the real commit that
> corresponds as closely as possible to to this snapshot into the
> snapshot branch.  Part of the reason for doing this is to look
> for unexpected differences between what Git has and what the file
> revision storage tool has.
> 
> But doing that is nearly impossible, so I don't.

Well, it probably wouldn't be too nasty to try to have a "find nearest 
commit" kind of thing. It's not quite as simple as bisection, but you 
could probably use a bisection-like algorithm to do something like a 
binary search to try to guess which tree is the closest. 

In other words, if you just give git a "range" of commits to look at, and 
let a bisection-line thing pick a mid-way point, you can then compare the 
mid-way point and the end-points (more than two) against the target tree, 
and then pick the range that looks "closer".

I wouldn't guarantee that it finds the best candidate (since the "closer" 
choice will inevitably not guarantee a monotonic sequence), but I think 
you could probably most of the time find something that is reasonably 
close.

If you do a lot of branching, you'd have to be a lot smarter about it 
(since you'd not have _one_ commit for beginning/end), but in a 
straight-line tree it should be really trivial, and in a branchy one I 
think it should still be quite doable. 

I dunno. It might be useful even if it's just a heuristic, in a "try to 
find a commit in the range X..Y that generates the smallest diff when 
compared against this tree". If it finds something sucky, you can try to 
look at the history of one of the files that generates a big diff, and try 
to give a better range - the automation should hopefully have given you 
_some_ clues.

		Linus
