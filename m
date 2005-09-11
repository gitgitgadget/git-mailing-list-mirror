From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's up with the GIT archive on www.kernel.org?
Date: Sun, 11 Sep 2005 12:06:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>
References: <m3mzmjvbh7.fsf@telia.com> <Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
 <20050911185711.GA22556@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Osterlund <petero2@telia.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750740AbVIKTHI@vger.kernel.org Sun Sep 11 21:08:16 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750740AbVIKTHI@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEXB4-0004d6-Uw
	for glk-linux-kernel-3@gmane.org; Sun, 11 Sep 2005 21:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbVIKTHI (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 11 Sep 2005 15:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVIKTHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 15:07:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43653 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750740AbVIKTHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 15:07:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8BJ6oBo018554
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Sep 2005 12:06:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8BJ6j2X017599;
	Sun, 11 Sep 2005 12:06:47 -0700
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20050911185711.GA22556@mars.ravnborg.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8322>



On Sun, 11 Sep 2005, Sam Ravnborg wrote:
> > 
> > Absolutely. The mirroring has been slow again lately. I've packed my 
> > archive, but I suspect others should much more aggressively now be using 
> > the "objects/info/alternates" information to point to my tree, so that 
> > they don't even need to have their objects at all (no packing 
> > even necessary - just running "git prune-packed" on peoples archives 
> > would get rid of any duplicate objects when I pack mine).
> 
> Can you post a small description how to utilize this method?

Just do

	echo /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects > objects/info/alternates

in your tree, and that will tell git that your tree can use my object 
directory as an "alternate" source of objects. At that point, you can 
remove all objects that I have.

However, that only works with a local directory - you can't say that the
alternate object directory is over the network (unless you use NFS or
similar, of course ;).

Another potential problem is that while the above makes git understand to
pick the objects from my directory, it can in theory cause problems for
mirrors etc - since they mirror things to a different location and/or may
not mirror all of it anyway.

Anyway, modulo those caveats, you can then just do

	git prune-packed

and it will remove all unpacked objects in your git archive that can be 
reached through a pack-file - including any packfiles in _my_ directory. 

Then you never need to pack your own objects any more. Just leave
everything unpacked, and rely on me packing every once in a while, and
just do "git prune-packed" when I do.

That allows a site like kernel.org to effectively share 99% of all 
objects, and do it efficiently.

		Linus
