X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Mon, 11 Dec 2006 10:15:27 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612111003140.12500@woody.osdl.org>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com> 
 <e5bfff550612101405h507cc877k87491264d11b0aa8@mail.gmail.com> 
 <Pine.LNX.4.64.0612101410220.12500@woody.osdl.org> 
 <e5bfff550612101435o6bc938acmac28ad6adf0c8844@mail.gmail.com> 
 <Pine.LNX.4.64.0612101439540.12500@woody.osdl.org> 
 <e5bfff550612101615u5f588513n499e3b88ce14a6f6@mail.gmail.com> 
 <Pine.LNX.4.64.0612101647310.12500@woody.osdl.org> 
 <e5bfff550612102317w331f3b0fyc3c6b095ff21191a@mail.gmail.com> 
 <Pine.LNX.4.64.0612110855550.12500@woody.osdl.org> 
 <Pine.LNX.4.64.0612110905180.12500@woody.osdl.org>
 <e5bfff550612110939r58df1a73ud28983633c12e487@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 11 Dec 2006 18:16:06 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <e5bfff550612110939r58df1a73ud28983633c12e487@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34024>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtph5-0005oO-ON for gcvg-git@gmane.org; Mon, 11 Dec
 2006 19:16:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937052AbWLKSP7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 13:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937007AbWLKSP7
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 13:15:59 -0500
Received: from smtp.osdl.org ([65.172.181.25]:50867 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937052AbWLKSP6
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 13:15:58 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBBIFUID025613
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 11
 Dec 2006 10:15:51 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBBIFRIH001909; Mon, 11 Dec
 2006 10:15:28 -0800
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org



On Mon, 11 Dec 2006, Marco Costalba wrote:
> 
> Regarding the _normal_  solution we have one more hipotesys to take
> advantage of: git-rev-list when has nothing more to read..exits.

Yes. You can just wait for the child exit signal.

However, you seem to continually ignore the thing I've asked you to do 
several times: try with a cold-cache situation.

The thing is, using pipes and poll()/select()/epoll()/whatever will not 
only be efficient, but it will also WORK CORRECTLY in the presense of a 
writer that is _slower_ than the reader.

Right now, you're testing the exact opposite. You're testing the case 
where the reader is slower than the writer, which is actually not that 
interesting - because if "git-rev-list" is instantaneous, then the fastest 
thing to do is to simply _always_ just read the result buffer directly 
into memory without any select() loop etc what-so-ever.

So just by testing that case (and you've slowed down the reader 
artificially even _apart_ from the fact that qgit will probably always be 
slower than git-rev-list off a packed and hot-cache environment), you're 
always going to skew your results into the "do everything in one go" 
direction.

But the point of the pipe and the poll() is that it works nicely even when 
the data trickles in slowly.

[ Of course, as long as you ask for "--topo-order", you'll never see a lot 
  of trickling, and you'll never be able to do really well for the 
  cold-cache case. To see the _real_ advantage of pipes, you should void 
  "--topo-order" entirely, and do it dynamically within qgit, repainting 
  the graph as needed.

  At that point, you'd actually do something that gitk can't do at all, 
  namely work well for the cold-cache not-very-packed large-repository 
  case. ]

To see this in practice (even with hot-caches), do something like the 
following on the full historic Linux archive:

	time sh -c "git rev-list HEAD | head"
	time sh -c "git rev-list --topo-order HEAD | head"

where for me, the firstone takes 0.002s, and the second one takes 0.878s.

Now THAT is an optimization. Not just "10%" or even "ten times", but "four 
HUNDRED times" faster.

And why is that? Simply because it only needed to look at _part_ of the 
data. For the exact same reason, if you were to do the topological sort 
only on the part that you had _looked_ at first, you'd be able to do these 
kinds of several-orders-of-magnitude improvements.

