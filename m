From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: fix git-pack-redundant crashing sometimes
Date: Tue, 15 Nov 2005 15:58:02 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511151552400.11232@g5.osdl.org>
References: <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com>
 <20051115213442.GA4256@steel.home> <437A560E.8020500@etek.chalmers.se>
 <20051115223340.GA3951@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>,
	git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Nov 16 01:00:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcAgr-0003aa-PK
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 00:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbVKOX6O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 18:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965093AbVKOX6O
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 18:58:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20402 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965092AbVKOX6O (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 18:58:14 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAFNw4nO008725
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 15 Nov 2005 15:58:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAFNw2Ux027603;
	Tue, 15 Nov 2005 15:58:03 -0800
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20051115223340.GA3951@steel.home>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11974>



On Tue, 15 Nov 2005, Alex Riesen wrote:
> 
> Sorry, it doesn't. The code loops here:
> 
> 401             /* find the permutations which contain all missing objects */
> 402             perm_all = perm = get_all_permutations(non_unique);

Looks like the whole thing is exponential.

A good way to do sane pack handling is to keep a _sorted_ list of all 
objects each pack has. At that point it becomes much easier to see which 
objects only exist in one particular pack.

The sorting itself is O(nlogn), and the "does this pack have any unique 
objects" (or "is this pack a superset of all other packs") question should 
then be O(n).

This is how the packs are generated in the first place - by sorting the 
objects and limiting the diff generation to the "neighbors" of the 
objects, you can generate pack-files in O(n logn) rather than O(n**2). 
Which is pretty important when there are currently 140,000+ objects in the 
kernel tree.

		Linus
