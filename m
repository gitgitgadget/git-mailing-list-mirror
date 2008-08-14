From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: pack operation is thrashing my server
Date: Thu, 14 Aug 2008 10:21:35 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808141014410.3324@nehalem.linux-foundation.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <20080811030444.GC27195@spearce.org> <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com> <87vdy71i6w.fsf@basil.nowhere.org> <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
 <alpine.LFD.1.10.0808131024460.4352@xanadu.home> <20080813145944.GB3782@spearce.org> <alpine.LFD.1.10.0808131123221.4352@xanadu.home> <20080813155016.GD3782@spearce.org> <alpine.LFD.1.10.0808131228270.4352@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 14 19:23:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTgXI-0003tR-Ek
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 19:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbYHNRVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 13:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbYHNRVx
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 13:21:53 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33282 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750753AbYHNRVx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2008 13:21:53 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7EHLb8C028534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Aug 2008 10:21:38 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7EHLZBH019990;
	Thu, 14 Aug 2008 10:21:36 -0700
In-Reply-To: <alpine.LFD.1.10.0808131228270.4352@xanadu.home>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.414 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92374>



On Wed, 13 Aug 2008, Nicolas Pitre wrote:
> 
> A much better solution would consist of finding just _why_ object 
> enumeration is so slow.  This is indeed my biggest grip with git 
> performance at the moment.
> 
> |nico@xanadu:linux-2.6> time git rev-list --objects --all > /dev/null
> |
> |real    0m21.742s
> |user    0m21.379s
> |sys     0m0.360s
> 
> That's way too long for 1030198 objects (roughly 48k objects/sec).

Why do you think that's horribly slow?

Doing a rev-list of all objects is a fairly rare operation, but even if 
you want to clone/repack all of your archives the whole time, please 
realize that listing objects is _not_ a simple operation. It opens up and 
parses every single tree in the whole history. That's a _lot_ of data to 
unpack.

And trees also pack very efficiently (because they delta so well), so 
there's a lot of complex ops there.

> And it gets even worse with the gcc repository:

I bet it's because gcc has a different directory structure. I don't have 
the gcc sources in front of me, but I'd suspect something like a single 
large directory or other.

> Clearly something is not scaling here.

I don't agree. There's no "clearly" about it. Different data sets.

		Linus
