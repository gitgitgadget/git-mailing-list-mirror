From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] multi item packed files
Date: Thu, 21 Apr 2005 08:41:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504210832490.2344@ppc970.osdl.org>
References: <200504211113.13630.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 17:36:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOdi6-0004uq-E0
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 17:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVDUPjl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 11:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVDUPja
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 11:39:30 -0400
Received: from fire.osdl.org ([65.172.181.4]:61070 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261457AbVDUPjS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 11:39:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3LFdDs4031462
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 21 Apr 2005 08:39:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3LFdC0B007066;
	Thu, 21 Apr 2005 08:39:13 -0700
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504211113.13630.mason@suse.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 21 Apr 2005, Chris Mason wrote:
> 
> There have been a few threads on making git more space efficient, and 
> eventually someone mentions tiny files and space fragmentation.  Now that git 
> object names are decoupled from their compression, it's easier to consider a 
> a variety of compression algorithms.  I whipped up a really silly "pack files 
> together" compression.

Careful.

This is something that needs history to tell whether it's effective. In
particular, if one file changes and another one does not, your packed
archive now ends up being a new blob, so while you "saved space" by having
just one blob for the object, in reality you didn't save any space at all
because with the <x> files changing, you just guaranteed that the packed
blob changes <x> times more often.

See? Your "packing in space" ends up also resulting in "packing in time", 
and you didn't actually win anything.

(If you did a good job of packing, you hopefully didn't _lose_ anything
either - you needed 1:<x> number of objects that took 1:<x> the space if
the packing ended up perfect - but since you needed <x> times more of
these objects unless they all change together, you end up with exactly the
same space usage).

So the argument is: you can't lose with the method, and you _can_ win. 
Right?

Wrong. You most definitely _can_ lose: you end up having to optimize for
one particular filesystem blocking size, and you'll lose on any other
filesystem. And you'll lose on the special filesystem of "network
traffic", which is byte-granular.

I don't want to pee on peoples parades, and I'm all for gathering numbers, 
but the thing is, the current git isn't actually all that bad, and I 
guarantee that it's hard to make it better without using delta 
representation. And the current thing is really really simple.

		Linus
