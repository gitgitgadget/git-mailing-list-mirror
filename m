From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 10:03:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604200954440.3701@g5.osdl.org>
References: <20060420133640.GA31198@spearce.org> <Pine.LNX.4.64.0604200745550.3701@g5.osdl.org>
 <20060420150315.GB31198@spearce.org> <Pine.LNX.4.64.0604200857460.3701@g5.osdl.org>
 <20060420164351.GB31738@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Apr 20 19:04:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWcZb-0006Vq-Lx
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 19:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWDTRED (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 13:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWDTRED
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 13:04:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48306 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751126AbWDTREB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Apr 2006 13:04:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3KH3WtH021767
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 20 Apr 2006 10:03:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3KH3V3r000700;
	Thu, 20 Apr 2006 10:03:31 -0700
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060420164351.GB31738@spearce.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18980>



On Thu, 20 Apr 2006, Shawn Pearce wrote:
> 
> Oddly enough repacking the v1.2.3 pack using 1.3.0.g56c1 created an
> even smaller pack ("git-repack -a -d"):

That's "normal". Repacking without -f will always pack _more_, never less. 
So a different packing algorithm can only improve (of course, usually not 
by a huge margin, and it quickly diminishes).

> but then adding -f definately gives us the 2x explosion again:
> 
>   Total 46391, written 46391 (delta 6649), reused 37894 (delta 0)
>   129M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack

Right. Doing the -f will discard any old packing info, so if the new 
packing algorithm has problems (and it obviously does), then using -f will 
show them.

> > You could try to revert that change:
> > 
> > 	git revert eeef7135fed9b8784627c4c96e125241c06c65e1
> 
> Whoa.  I did that revert and fixup on top of 'next'.  The pack
> from "git-repack -a -d -f" is now even larger due to even less
> delta reuse:

Ok, so that wasn't it, and the new sort order is superior.

That means that it probably _is_ the delta changes themselves (probably 
commit c13c6bf7 "diff-delta: bound hash list length to avoid O(m*n) 
behavior". You can try

	git revert c13c6bf7

to see if that's it. Although Nico already showed interest, and if you 
make the archive available to him, he's sure to figure it out.

> With --window=50 on 'next' (without the revert'):
> 
>   Total 46391, written 46391 (delta 6666), reused 39723 (delta 0)
>   129M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack

Yeah, that didn't do much. Slightly more deltas than without, but not a 
lot, and it didn't matter much size-wise.

You can try "--depth=50" (slogan: more "hot delta on delta action"), but 
it's looking less and less like a delta selection issue, and more and more 
like the deltas themselves are deproved.

			Linus
