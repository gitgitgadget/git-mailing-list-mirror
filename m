From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all entries
Date: Thu, 11 Jan 2007 23:10:53 +0100
Message-ID: <20070111221053.GD6058@steel.home>
References: <81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com> <7v8xgileza.fsf@assigned-by-dhcp.cox.net> <81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com> <20070107163112.GA9336@steel.home> <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net> <81b0412b0701101507n764aed73p31c7533e743283f0@mail.gmail.com> <Pine.LNX.4.64.0701101521410.3594@woody.osdl.org> <81b0412b0701110102m5264696dg68a573e9d5f2a17c@mail.gmail.com> <Pine.LNX.4.64.0701110823300.3594@woody.osdl.org> <7vfyah48j2.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 23:11:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H588b-0001x1-Qn
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 23:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbXAKWLI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 17:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbXAKWLH
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 17:11:07 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:33728 "EHLO
	mailout02.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932137AbXAKWLF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Jan 2007 17:11:05 -0500
Received: from fwd26.aul.t-online.de 
	by mailout02.sul.t-online.com with smtp 
	id 1H588Q-0007qF-06; Thu, 11 Jan 2007 23:10:58 +0100
Received: from tigra.home (GW57DMZV8eICsN6VwFMDhGw9nB58NolggiXb1iEczIhnpMo8d1DwsJ@[84.163.96.128]) by fwd26.sul.t-online.de
	with esmtp id 1H588M-0LyoNs0; Thu, 11 Jan 2007 23:10:54 +0100
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 921CD277B6;
	Thu, 11 Jan 2007 23:10:53 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 4FA8FC166; Thu, 11 Jan 2007 23:10:53 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyah48j2.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-ID: GW57DMZV8eICsN6VwFMDhGw9nB58NolggiXb1iEczIhnpMo8d1DwsJ
X-TOI-MSGID: 5c16776b-9dba-4fc9-b856-25ba1f711187
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36621>

Junio C Hamano, Thu, Jan 11, 2007 21:23:45 +0100:
> > That said, I think we actually have another problem entirely:
> >
> > Look at "write_cache()", Junio: isn't it leaking memory like mad?
> >
> > Shouldn't we have something like this?
> >
> > It's entirely possible that the _real_ problem with the "flush the index 
> > all the time" was that it just caused this bug: tons and tons of lost 
> > memory, causing git-merge-recursive to grow explosively (~6MB per 
> > cache flush, and a _lot_ of cache flushes), which on a 384MB machine 
> > quickly uses up memory and causes totally unnecessary swapping.
> 
> You are right -- there is absolutely no reason to retain this
> memory.  It is a serialized representation of cache-tree data
> only to be stored in the index, and no other user of this data
> exists.  Thanks for spotting this.
> 
> Writing out 6MB per every path changed in a merge would still be
> an unnecessary overhead over the one in 'next', so there is no
> reason to replace 'next' with this single liner of yours, but I
> am interested in seeing how much of the 20-minute vs 1-minute
> difference is attributable to this leak, just out of curiosity.
> 
> Alex, if you have a chance, could you apply Linus's single-liner
> on top of 'master', without either of the merge-recursive
> patches in 'next', and see what kind of numbers you would get?

With regard to speed: not noticable on the cygwin machine. The
384Mb-laptop liked it: moved into 40-50 sec range (it had real
problems (minutes) doing that merge without at least my first patch.
Because of the leak, as we now understand).

It must have been large leak, as I really have seen the memory usage
dropping down significantly.
