From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Sat, 17 Mar 2007 16:24:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703171619440.4964@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703160920030.13402@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
 <Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
 <7vabybqxaj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 00:24:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSiGV-0006NY-Vb
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 00:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbXCQXYk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 19:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbXCQXYk
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 19:24:40 -0400
Received: from smtp.osdl.org ([65.172.181.24]:49092 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752138AbXCQXYj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 19:24:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2HNOOcD014426
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 17 Mar 2007 16:24:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2HNONfv011716;
	Sat, 17 Mar 2007 15:24:24 -0800
In-Reply-To: <7vabybqxaj.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.978 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42459>



On Sat, 17 Mar 2007, Junio C Hamano wrote:
> 
> This largely would depend on the project, but if a blob that is
> cached is 20kB each, a 1024-entry cache would grow to 20MB.  We
> may need to introduce early eviction of cached objects with
> total cache size limit, configurable per repository.

One thing that I considered was to limit the delta-base cache to just tree 
entries. Those tend to be the really performance-sensitive ones - by the 
time you actually unpack blob entries, you're going to do something with 
that *single* entry anyway (like compare it to another blob), and the cost 
of unpacking the entry is likely to not be really all that noticeable.

That said, it was just simpler to do it unconditionally, and it obviously 
*works* fine regardless of the object type, so limiting it to trees is a 
bit sad. And since the intensive tree operations tend to be in a separate 
phase (ie the commit simplification phase) from the the blob operations 
(say, doing "git log -p <pathspec>"), I suspect that the cache locality 
would still remain good.

So I didn't do anything along the lines of "only cache for case Xyzzy".

But yes, especially if a project has big blobs, it might make sense to 
limit by full size of the cached entries some way.

			Linus
