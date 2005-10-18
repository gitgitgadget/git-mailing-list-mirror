From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [CORRECTED PATCH] git-fetch-pack: avoid unnecessary zero packing
Date: Tue, 18 Oct 2005 13:38:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510181333380.3369@g5.osdl.org>
References: <Pine.LNX.4.64.0510181049050.17201@g5.osdl.org>
 <7vmzl6r78e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 18 22:42:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERyEX-0003VV-Hq
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 22:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbVJRUij (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 16:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbVJRUij
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 16:38:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25252 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751489AbVJRUii (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2005 16:38:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9IKcWFC009019
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Oct 2005 13:38:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9IKcV1D029819;
	Tue, 18 Oct 2005 13:38:31 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzl6r78e.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10228>



On Tue, 18 Oct 2005, Junio C Hamano wrote:
> 
> It strikes me that we could walk from our refs, depth reasonably
> limited to say 20 or so commit chain and/or last 5 days of
> commit time, to see if any of the remotes are reachable from our
> refs and omit issuing "want" quite cheaply.  Do you think that
> would be a worthy change to make things more efficient?

Probably doesn't make a huge difference, but it might be worth trying.

There's a cheap test you can do _before_ you even start walking: check if 
you have the object that is pointed to by the remote ref at all. If you 
don't have it, then you know it can't be reachable from any of the local 
refs. And if you do have it, the likelihood that it _is_ reachable is 
likely pretty high. 

(I didn't do that for the current fetch-pack optimization, since just 
doing the read_ref() is likely faster than even bothering with the object 
lookup. But if you start traversing commit lists, it suddenly becomes 
more worthwhile).

You'd need to look up the object anyway in order to figure out that it's a 
commit (or points to a commit).

So it might be wasting a bit of time, but the good news is that it wastes 
time on the _client_ side, where we've got plenty.

I'll see if I can come up with a good patch.

		Linus
