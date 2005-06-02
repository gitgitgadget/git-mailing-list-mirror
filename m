From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [SCRIPT] cg-rpush & locking
Date: Wed, 1 Jun 2005 19:58:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506011951150.1876@ppc970.osdl.org>
References: <20050531190005.GE18723@atomide.com>
 <Pine.LNX.4.63.0505311914550.6500@localhost.localdomain>
 <20050601065123.GA23358@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Tony Lindgren <tony@atomide.com>,
	git@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Thu Jun 02 04:55:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdfrC-0001Dc-2S
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 04:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVFBC5r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 22:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbVFBC5r
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 22:57:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:47840 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261578AbVFBC5l (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2005 22:57:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j522utjA028102
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Jun 2005 19:56:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j522usEN003043;
	Wed, 1 Jun 2005 19:56:54 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050601065123.GA23358@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 1 Jun 2005, Thomas Glanzmann wrote:
> 
> 	1. acquire remote lock
> 	2. get remote HEAD
> 	3. if remote HEAD is ahead (not included in our history) abort
> 	   and free lock.
> 	4. push objects
> 	5. update remote HEAD with local
> 	6. free remote lock.

You really need a specialized client at the other end, because regardless 
of locking, you want to write the objects atomically (ie download them 
into a temp-file, and then do the "rename" thing to make them show up 
all-or-nothing).

Also, I'd suggest a slight modification to avoid keeping the lock for a 
long time, namely to have the lock protect just a quick "compare and 
exchange". So the algorithm would become:

	1. read remote HEAD
	2. if remote HEAD isn't in our history, abort with "remote is 
	   ahead"
	3. calculate the objects needed to push locally
	4. push them (but accept the possibility that the remote may
	   already have them, so have the protocol able to say "got that
	   one already"). Make this use the atomic write on the other end.
	5. do an atomic compare-and-exchange of the remote head with the 
	   new one (ie only switch the remote HEAD if it still matches 
	   what we were expecting it to be)

Hmm?

		Linus
