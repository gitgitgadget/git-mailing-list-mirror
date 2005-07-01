From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] pack-objects: emit base before delta.
Date: Fri, 1 Jul 2005 08:28:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507010821140.14331@ppc970.osdl.org>
References: <7vbr5nxe38.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 17:19:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoNIB-0001aH-RY
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 17:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263367AbVGAP0c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 11:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263368AbVGAP0c
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 11:26:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6575 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263367AbVGAP02 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jul 2005 11:26:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j61FQ5jA008878
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 1 Jul 2005 08:26:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j61FQ2uu011902;
	Fri, 1 Jul 2005 08:26:04 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr5nxe38.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 30 Jun 2005, Junio C Hamano wrote:
>
> This micro-optimizes the order of objects in a pack.  By
> emitting base objects before deltified ones, unpack-objects do
> not keep items on delta_list.

So I like this from an unpacking standpoint, but at the same time I don't 
actually think it's correct from an access pattern standpoint.

When using a pack file as a run-time object store, the current packing 
order means that we generally traverse the pack-file in a nice forward 
direction. We don't jump backwards in the file very much, which should be 
good both for CPU and disk caches (both of them tend to have prefetch 
logic that often works better for nice access patterns). So I was actually 
pretty happy with the fact that we packed "optimally" in this sense: if 
the object was an important delta (ie an early one), we'd basically end up 
always walking forward until we hit the object it was a delta against.

I dunno. Maybe it doesn't matter. Our other heuristics to pack recent 
objects before later one might mean that we tend to have mainly 
backwards-going deltas (both in history _and_ in pack file layout).

The expense of keeping track of delta objects isn't that high, and the 
"pending delta" logic in unpack-objects isn't that complicated, so ..

Do you have some other reason you want to do this?

		Linus
